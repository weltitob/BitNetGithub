import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// NEW: One user one node approach - Lightning payment stream for individual nodes
Stream<dynamic> sendPaymentV2Stream(
    String account, List<String> invoiceStrings, int? amount) async* {
  final logger = Get.find<LoggerService>();
  logger.i(
      "NEW sendPaymentV2Stream: Starting Lightning payment via individual user node");

  try {
    // Get user's node mapping to find their specific node
    final userId = Auth().currentUser!.uid;
    // userId is the recovery DID
    final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);

    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      yield {
        'status': 'FAILED',
        'failure_reason': 'No Lightning node assigned to user'
      };
      return;
    }

    final nodeId = nodeMapping.nodeId;
    logger.i("Using node: $nodeId for user: $userId");

    // Get the admin macaroon from node mapping (stored as base64)
    final macaroonBase64 = nodeMapping.adminMacaroon;
    if (macaroonBase64.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      yield {
        'status': 'FAILED',
        'failure_reason': 'Failed to load node credentials'
      };
      return;
    }

    // Convert base64 macaroon to hex format
    final macaroonBytes = base64Decode(macaroonBase64);
    final macaroon = bytesToHex(macaroonBytes);

    // Get Caddy URL for the user's node using LightningConfig
    final nodeUrl = '${LightningConfig.caddyBaseUrl}/$nodeId';

    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();

    // Process each invoice
    for (var invoiceString in invoiceStrings) {
      try {
        // Decode invoice to check amount
        Bolt11PaymentRequest invoiceDecoded =
            Bolt11PaymentRequest(invoiceString);
        String amountInSatFromInvoice = invoiceDecoded.amount.toString();

        logger.i("Processing invoice: ${invoiceString.substring(0, 30)}...");
        logger.i("Invoice amount: $amountInSatFromInvoice sats");
        logger.i("Custom amount: $amount sats");

        // Prepare request data
        Map<String, dynamic> data = {
          'timeout_seconds': 60,
          'fee_limit_sat': 1000,
          'payment_request': invoiceString,
        };

        // Add amount if invoice doesn't specify one
        if (amountInSatFromInvoice == "0" && amount != null) {
          logger.i("Using custom amount: $amount sats");
          data['amt'] = amount.toString();
        }

        // Make request to Lightning node's /v2/router/send endpoint
        final url = '$nodeUrl/v2/router/send';
        logger.i("Sending payment request to: $url");

        var request = http.Request('POST', Uri.parse(url))
          ..headers['Grpc-Metadata-macaroon'] = macaroon
          ..headers['Content-Type'] = 'application/json'
          ..body = json.encode(data);

        var streamedResponse = await request.send();
        var accumulatedData = StringBuffer();

        // Process streaming response
        await for (var chunk
            in streamedResponse.stream.transform(utf8.decoder)) {
          accumulatedData.write(chunk);

          // Check if we have complete JSON
          if (isCompleteJson(accumulatedData.toString())) {
            var jsonString = accumulatedData.toString();
            accumulatedData.clear();

            Map<String, dynamic>? decoded;
            try {
              decoded = json.decode(jsonString) as Map<String, dynamic>;
            } catch (jsonError) {
              logger.e("JSON Decode Error: $jsonError");
              yield {
                'status': 'FAILED',
                'failure_reason': 'Error decoding response'
              };
              continue;
            }

            logger.i("Payment response: $decoded");

            // Check for errors
            if (decoded.containsKey('error')) {
              var error = decoded['error'];
              if (error is Map<String, dynamic>) {
                String errorMessage = error['message'] ?? 'Unknown error';

                // Handle self-payment error for internal rebalancing
                if (errorMessage.contains("self-payments not allowed")) {
                  logger.i(
                      "Self-payment detected, checking for internal rebalance...");

                  // Check for fallback address to handle internal rebalance
                  for (TaggedField tag in invoiceDecoded.tags) {
                    if (tag.type == 'fallback_address') {
                      final fallbackAddress = tag.data;
                      logger.i("Found fallback address: $fallbackAddress");

                      // Call internal rebalance function
                      try {
                        dynamic rebalanceResponse = await callInternalRebalance(
                          invoiceString,
                          fallbackAddress,
                          amount?.toString() ??
                              invoiceDecoded.amount.toString(),
                          userId,
                          nodeUrl,
                        );
                        logger.i(
                            "Internal rebalance response: $rebalanceResponse");
                        yield rebalanceResponse;
                      } catch (e) {
                        logger.e("Internal rebalance failed: $e");
                        yield {
                          'status': 'FAILED',
                          'failure_reason': 'Internal rebalance failed'
                        };
                      }
                      continue;
                    }
                  }
                }

                // Other errors
                yield {'status': 'FAILED', 'failure_reason': errorMessage};
                continue;
              }
            }

            // Check for successful payment
            if (decoded.containsKey('result')) {
              final result = decoded['result'];
              if (result is Map<String, dynamic>) {
                // Map Lightning node status to expected format
                String status = 'FAILED';
                bool isStreamFinished = false;

                if (result['status'] == 'SUCCEEDED' ||
                    result['status'] == 'SUCCESSFUL' ||
                    result['status'] == 'COMPLETED' ||
                    result['status'] == 'SETTLED') {
                  status = 'SUCCEEDED';
                  isStreamFinished = true; // Definitive success - end stream
                } else if (result['status'] == 'IN_FLIGHT' ||
                    result['status'] == 'PENDING') {
                  // For IN_FLIGHT status, check if we have payment_hash - indicates successful initiation
                  if (result['payment_hash'] != null &&
                      result['payment_hash'].toString().isNotEmpty) {
                    logger.i(
                        "🟢 IN_FLIGHT payment with payment_hash detected - treating as success");
                    status = 'SUCCEEDED';
                    isStreamFinished =
                        true; // Treat as definitive success for LNURL payments
                  } else {
                    // Still in flight without payment hash - keep as original status for controller to handle
                    status = result['status'];
                  }
                } else if (result['status'] == 'FAILED') {
                  status = 'FAILED';
                  isStreamFinished = true; // Definitive failure - end stream
                }

                // Yield payment result in expected format for compatibility
                yield {
                  'status': status,
                  'payment_hash': result['payment_hash'] ?? '',
                  'payment_preimage': result['payment_preimage'] ?? '',
                  'value_sat': result['value_sat']?.toString() ??
                      result['value']?.toString() ??
                      amount?.toString() ??
                      '0',
                  'payment_request': invoiceString,
                  'fee_sat': result['fee_sat']?.toString() ??
                      result['fee']?.toString() ??
                      '0',
                  'creation_date':
                      DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  'creation_time_ns': result['creation_time_ns'] ??
                      (DateTime.now().millisecondsSinceEpoch * 1000000)
                          .toString(),
                  'htlcs': result['htlcs'] ?? [],
                  // Additional fields for LightningPayment model compatibility
                  'value_msat':
                      ((int.tryParse(result['value_sat']?.toString() ?? '0') ??
                                  0) *
                              1000)
                          .toString(),
                  'fee_msat':
                      ((int.tryParse(result['fee_sat']?.toString() ?? '0') ??
                                  0) *
                              1000)
                          .toString(),
                  'payment_index': result['payment_index']?.toString() ?? '0',
                };

                // End stream if we have a definitive result
                if (isStreamFinished) {
                  logger.i(
                      "🏁 Payment stream finished with definitive status: $status");
                  return; // Exit the stream processing loop
                }
              } else {
                // If result doesn't have expected structure, treat as failed
                yield {
                  'status': 'FAILED',
                  'failure_reason': 'Unexpected response format',
                  'raw_response': decoded
                };
              }
            } else if (decoded.containsKey('payment_error') ||
                decoded.containsKey('payment_hash')) {
              // Handle alternative success response format from some Lightning implementations
              yield {
                'status': 'SUCCEEDED',
                'payment_hash': decoded['payment_hash'] ?? '',
                'payment_preimage': decoded['payment_preimage'] ?? '',
                'value_sat': amount?.toString() ?? '0',
                'payment_request': invoiceString,
                'fee_sat': decoded['payment_fee']?.toString() ?? '0',
                'creation_date': DateTime.now().millisecondsSinceEpoch ~/ 1000,
                'value_msat': ((amount ?? 0) * 1000).toString(),
                'fee_msat':
                    ((int.tryParse(decoded['payment_fee']?.toString() ?? '0') ??
                                0) *
                            1000)
                        .toString(),
                'payment_index': '0',
              };
            } else if (decoded.containsKey('status')) {
              // Handle direct status responses (without 'result' wrapper)
              final directStatus = decoded['status'];
              String mappedStatus = 'FAILED';
              bool isStreamFinished = false;

              if (directStatus == 'SUCCEEDED' ||
                  directStatus == 'SUCCESSFUL' ||
                  directStatus == 'COMPLETED' ||
                  directStatus == 'SETTLED') {
                mappedStatus = 'SUCCEEDED';
                isStreamFinished = true;
              } else if (directStatus == 'IN_FLIGHT' ||
                  directStatus == 'PENDING') {
                // Check if we have payment_hash for IN_FLIGHT
                if (decoded['payment_hash'] != null &&
                    decoded['payment_hash'].toString().isNotEmpty) {
                  logger.i(
                      "🟢 Direct IN_FLIGHT payment with payment_hash detected - treating as success");
                  mappedStatus = 'SUCCEEDED';
                  isStreamFinished = true;
                } else {
                  mappedStatus =
                      directStatus; // Pass through for controller to handle
                }
              } else if (directStatus == 'FAILED') {
                mappedStatus = 'FAILED';
                isStreamFinished = true;
              }

              yield {
                'status': mappedStatus,
                'payment_hash': decoded['payment_hash'] ?? '',
                'payment_preimage': decoded['payment_preimage'] ?? '',
                'value_sat': decoded['value_sat']?.toString() ??
                    amount?.toString() ??
                    '0',
                'payment_request': invoiceString,
                'fee_sat': decoded['fee_sat']?.toString() ?? '0',
                'creation_date': DateTime.now().millisecondsSinceEpoch ~/ 1000,
                'creation_time_ns': decoded['creation_time_ns'] ??
                    (DateTime.now().millisecondsSinceEpoch * 1000000)
                        .toString(),
                'htlcs': decoded['htlcs'] ?? [],
                'value_msat': ((int.tryParse(decoded['value_sat']?.toString() ??
                                amount?.toString() ??
                                '0') ??
                            0) *
                        1000)
                    .toString(),
                'fee_msat':
                    ((int.tryParse(decoded['fee_sat']?.toString() ?? '0') ??
                                0) *
                            1000)
                        .toString(),
                'payment_index': decoded['payment_index']?.toString() ?? '0',
              };

              // End stream if we have a definitive result
              if (isStreamFinished) {
                logger.i(
                    "🏁 Direct status stream finished with definitive status: $mappedStatus");
                return; // Exit the stream processing loop
              }
            } else {
              // Unknown response format
              yield {
                'status': 'FAILED',
                'failure_reason': 'Unknown response format',
                'raw_response': decoded
              };
            }
          }
        }
      } catch (e) {
        logger.e("Error sending payment: $e");
        yield {'status': 'FAILED', 'failure_reason': 'Network error: $e'};
      }

      // Add delay between multiple payments
      if (invoiceStrings.length > 1) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  } catch (e) {
    logger.e("Fatal error in sendPaymentV2Stream: $e");
    yield {'status': 'FAILED', 'failure_reason': 'Fatal error: $e'};
  }
}

// Helper function to check if a string contains complete JSON
bool isCompleteJson(String str) {
  try {
    json.decode(str);
    return true;
  } catch (e) {
    return false;
  }
}

// Function to handle internal rebalance between BitNET users
Future<dynamic> callInternalRebalance(
    String invoiceString,
    String fallbackAddress,
    String amount,
    String senderUserId,
    String nodeUrl) async {
  final logger = Get.find<LoggerService>();
  logger.i("Calling internal_rebalance Cloud Function");

  try {
    // Get Firebase Functions instance
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable('internal_rebalance');

    // Prepare data for internal rebalance
    final data = {
      'invoice': invoiceString,
      'fallback_address': fallbackAddress,
      'amount': amount,
      'sender_user_id': senderUserId,
      'node_url': nodeUrl,
    };

    // Call the function
    final response = await callable.call(data);

    // Return the response data in compatible format
    final responseData = response.data as Map<String, dynamic>?;
    return {
      'status': 'SUCCEEDED',
      'type': 'internal_rebalance',
      'payment_hash': responseData?['payment_hash'] ?? '',
      'payment_preimage': responseData?['payment_preimage'] ?? '',
      'value_sat': amount,
      'payment_request': invoiceString,
      'fee_sat': '0', // Internal rebalances have no fees
      'creation_date': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'value_msat': (int.parse(amount) * 1000).toString(),
      'fee_msat': '0',
      'payment_index': '0',
      'internal_rebalance_data': response.data,
    };
  } catch (e) {
    logger.e("Internal rebalance failed: $e");
    return {
      'status': 'FAILED',
      'failure_reason': 'Internal rebalance failed: $e'
    };
  }
}
