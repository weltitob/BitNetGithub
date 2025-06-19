import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


// Stream<RestResponse> sendPaymentV2Stream(
//     List<String> invoiceStrings, int? amount) async* {
//
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;
//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);
//
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//
//   String url = 'https://$restHost/v2/router/send';
//
//   HttpOverrides.global = MyHttpOverrides();
//
//   final logger = Get.find<LoggerService>();
//
//   for (var invoiceString in invoiceStrings) {
//     Bolt11PaymentRequest invoiceDecoded = Bolt11PaymentRequest(invoiceString);
//     String amountInSatFromInvoice = invoiceDecoded.amount.toString();
//
//     logger.i("amountInSatFromInvoice: $amountInSatFromInvoice");
//     logger.i("Invoice sats amount: $amount");
//
//     late Map<String, dynamic> data;
//
//     if (amountInSatFromInvoice == "0") {
//       logger.i("Invoice amount is 0 so we will use custom amount");
//       data = {
//         'amt': amount,
//         'timeout_seconds': 60,
//         'fee_limit_sat': 1000,
//         'payment_request': invoiceString,
//       };
//     } else {
//       logger.i("Invoice amount is not 0 so well use the ln invoice amount");
//       data = {
//         'timeout_seconds': 60,
//         'fee_limit_sat': 100,
//         'payment_request': invoiceString,
//       };
//     }
//
//     try {
//       var request = http.Request('POST', Uri.parse(url))
//         ..headers.addAll(headers)
//         ..body = json.encode(data);
//
//       var streamedResponse = await request.send();
//       var accumulatedData = StringBuffer();
//
//       await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
//         accumulatedData.write(chunk);
//
//         logger.i("Accumulated Data: ${accumulatedData.toString()}");
//
//         if (isCompleteJson(accumulatedData.toString()))  {
//           var jsonString = accumulatedData.toString();
//           accumulatedData.clear();
//
//           Map<String, dynamic>? decoded;
//           try {
//             decoded = json.decode(jsonString) as Map<String, dynamic>;
//           } catch (jsonError) {
//             logger.e("JSON Decode Error: $jsonError");
//             yield RestResponse(
//               statusCode: "error",
//               message: "Error decoding JSON: $jsonError",
//               data: {},
//             );
//             continue;
//           }
//
//           logger.i("Decoded JSON: $decoded");
//
//           // Überprüfen, ob ein Fehler in der Antwort vorhanden ist
//           if (decoded.containsKey('error')) {
//             var error = decoded['error'];
//             if (error is Map<String, dynamic>) {
//               String errorMessage = error['message'] ?? 'Unbekannter Fehler';
//               int errorCode = error['code'] ?? -1;
//               // Spezifische Behandlung für "self-payments not allowed"
//               if (errorMessage.contains("self-payments not allowed")) {
//                 logger.i(
//                     "Error: Selfpayments not allowed (user tried sending to someone else inside app) (Code: $errorCode)");
//                 logger.i(
//                     "Invoice Decoded: $invoiceDecoded,"
//                         " ${invoiceDecoded.signature}, "
//                         "${invoiceDecoded.prefix}, "
//                         "${invoiceDecoded.tags}, "
//                         "${invoiceDecoded.timestamp}, "
//                         "${invoiceDecoded.amount}");
//
//                 invoiceDecoded.tags.forEach((TaggedField t) async {
//                   print("${t.type}: ${t.data}");
//                   if (t.type == 'fallback_address') { // Replace with actual tag name
//                     final fallbackAddress = t.data;
//                     logger.i("Fallback Address: $fallbackAddress");
//
//                     try{
//                       //firebase function aufrufen die quasie diese fallback address jetzt ausliest und firebase checked und alles andere
//                       //lnbc weitergeben
//                       //den amount weitergeben
//                       //die fallback address weitergeben
//                       //user signature and userid of person in this account
//                       logger.i("Calling internal_rebalance Cloud Function with data: $invoiceString, $fallbackAddress, ${invoiceDecoded.amount.toString()}, ${Auth().currentUser!.uid}, $restHost");
//                       dynamic response = await callInternalRebalance(
//                           invoiceString,
//                           fallbackAddress,
//                           invoiceDecoded.amount.toString(),
//                           Auth().currentUser!.uid,
//                           restHost,
//                       );
//                       logger.i("Response from internal_rebalance server: $response");
//
//                     } catch(e){
//
//                     }
//
//                   }
//                 });
//
//                 //first of all we need to identify the fallback address and then we can associate one of our users with it who the payment should have been routed to
//
//                 //call firebase funciton to rebalance the two accounts on that amount
//
//                 //save this as an invoice to firebase but we will show it in our frontend as internal app payment in the list
//
//                 //...
//
//                 yield RestResponse(
//                   statusCode: errorCode.toString(),
//                   message:
//                       "Error: Selfpayments not allowed (user tried sending to someone else inside app) (Code: $errorCode)",
//                   data: error,
//                 );
//
//                 continue;
//               } else {
//                 // Allgemeine Fehlerbehandlung
//                 logger.e("Fehler (Code: $errorCode): $errorMessage");
//                 yield RestResponse(
//                   statusCode: "error",
//                   message: errorMessage,
//                   data: error,
//                 );
//                 continue;
//               }
//             }
//           }
//
//           // Check structure: wir erwarten 'result' key und darin einen 'status' key
//           if (decoded["result"] == null ||
//               decoded["result"] is! Map<String, dynamic>) {
//             logger.e(
//                 "Kein 'result' Schlüssel in der JSON-Antwort gefunden oder es ist keine Map!");
//             yield RestResponse(
//               statusCode: "error",
//               message: "Kein 'result' Schlüssel in der JSON-Antwort",
//               data: decoded,
//             );
//             continue;
//           }
//
//           final resultMap = decoded["result"] as Map<String, dynamic>;
//           if (!resultMap.containsKey("status")) {
//             logger.e("Kein 'status' Schlüssel in der Antwort gefunden!");
//             yield RestResponse(
//               statusCode: "error",
//               message: "Kein 'status' Schlüssel in der JSON-Antwort",
//               data: decoded,
//             );
//             continue;
//           }
//
//           // Wenn wir hier angekommen sind, haben wir einen gültigen Status
//           yield RestResponse(
//             statusCode: "success",
//             message: "Payment processed",
//             data: decoded,
//           );
//         }
//       }
//     } catch (e) {
//       logger.e("Netzwerkfehler: $e");
//       yield RestResponse(
//         statusCode: "error",
//         message: "Fehler während des Netzwerkanrufs: $e",
//         data: {},
//       );
//     }
//
//     await Future.delayed(const Duration(seconds: 10));
//   }
// }

// OLD: Multiple users one node approach - Lightning payment stream function
// This entire function is commented out because it won't work with the new one-user-one-node approach
// where each user has their own Lightning node via Caddy routing
/*
Stream<dynamic> sendPaymentV2Stream(
    String account, List<String> invoiceStrings, int? amount) async* {
  final logger = Get.put(LoggerService());

  final senderUserId = Auth().currentUser!.uid;

  // Attempt to retrieve App Check tokens for additional security.
  try {
    final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
    final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
    logger.i("App Check Token: $appCheckToken");
    logger.i("New App Check Token: $newAppCheckToken");
  } catch (e) {
    logger.e("Fehler beim Abrufen des App Check Tokens: $e");
  }

  // Initialize FirebaseFunctions and call the Cloud Function
  final functions = FirebaseFunctions.instance;
  final callable = functions.httpsCallable(
    'send_payment_v2_http',
    options: HttpsCallableOptions(
      timeout: const Duration(minutes: 10),
      limitedUseAppCheckToken: true,
    ),
  );


  logger.i("Generating challenge...");
  UserChallengeResponse? userChallengeResponse =
  await create_challenge(senderUserId, ChallengeType.send_btc_or_internal_account_rebalance);

  if (userChallengeResponse == null) {
    logger.e("Challenge konnte nicht erstellt werden.");
    throw Exception("Challenge konnte nicht erstellt werden.");
  }

  logger.d('Created challenge for user ${senderUserId}: $userChallengeResponse');

  String challengeId = userChallengeResponse.challenge.challengeId;
  logger.d('Challenge ID: $challengeId');

  String challengeData = userChallengeResponse.challenge.title;
  logger.d('Challenge Data: $challengeData');

  // Retrieve private data (DID, private key)
  PrivateData privateData = await getPrivateData(senderUserId);
  logger.d('Retrieved private data for user ${senderUserId}');
  HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
  final String publicKeyHex = hdWallet.pubkey;
  logger.d('Public Key Hex: $publicKeyHex');

  final String privateKeyHex = hdWallet.privkey;
  logger.d('Private Key Hex: $privateKeyHex');

  // Sign the challenge data
  String signatureHex =
  await signChallengeData(privateKeyHex, publicKeyHex, challengeData);
  logger.d('Generated signature hex: $signatureHex');

  // Send request
  for (String invoiceString in invoiceStrings) {
    try {
      final litdController = Get.find<LitdController>();
      final String restHost = litdController.litd_baseurl.value;

      final invoiceDecoded = Bolt11PaymentRequest(invoiceString);
      String amountInSatFromInvoice = invoiceDecoded.amount.toString();
      Map<String, dynamic> data = {};
      if (amountInSatFromInvoice == "0") {
        logger.i("Invoice amount is 0 so we will use custom amount");
        data = {
          'amt': amount,
          'sender_user_id': senderUserId,
          'account': account,
          'timeout_seconds': 60,
          'fee_limit_sat': 1000,
          'payment_request': invoiceString,
          'senderUserId': senderUserId,
          'signedMessage': signatureHex,
          'challenge_data': challengeData,
          'restHost': restHost,
        };
      } else {
        logger.i("Invoice amount is not 0 so well use the ln invoice amount");
        data = {
          'sender_user_id': Auth().currentUser!.uid,
          'account': account,
          'timeout_seconds': 60,
          'fee_limit_sat': 100,
          'payment_request': invoiceString,
          'senderUserId': senderUserId,
          'signedMessage': signatureHex,
          'challenge_data': challengeData,
          'restHost': restHost,
        };
      }
      final dynamic response = await callable.call(data);

      logger.i("Response sendPayment Cloudfunction: ${response.data}");
      Map<String, dynamic> responseData;

      if (response.data is Map) {
        responseData = Map<String, dynamic>.from(response.data as Map);
      } else {
        // If data is not a Map, wrap it in a map
        responseData = {'message': response.data};
      }

      try {
        final message = responseData;

        yield message;
      } catch (e) {
        logger.e("error sending payment: $e");
        yield null;

      }
    } catch (e) {
      final logger = Get.find<LoggerService>();
      logger.e("Failed to send payment: $e");
      yield null;
    }
    await Future.delayed(const Duration(seconds: 10));
  }
}
*/

// NEW: One user one node approach - Lightning payment stream for individual nodes
Stream<dynamic> sendPaymentV2Stream(
    String account, List<String> invoiceStrings, int? amount) async* {
  final logger = Get.find<LoggerService>();
  logger.i("NEW sendPaymentV2Stream: Starting Lightning payment via individual user node");
  
  try {
    // Get user's node mapping to find their specific node
    final userId = Auth().currentUser!.uid;
    final nodeMappingService = Get.find<NodeMappingService>();
    final nodeMapping = await nodeMappingService.getUserNodeMapping(userId);
    
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
    
    // Load user's admin macaroon from secure storage
    final macaroon = await loadMacaroonAsset(nodeId);
    if (macaroon.isEmpty) {
      logger.e("Failed to load macaroon for node: $nodeId");
      yield {
        'status': 'FAILED',
        'failure_reason': 'Failed to load node credentials'
      };
      return;
    }
    
    // Get Caddy URL for the user's node
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final nodeUrl = 'https://$baseUrl/$nodeId';
    
    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();
    
    // Process each invoice
    for (var invoiceString in invoiceStrings) {
      try {
        // Decode invoice to check amount
        Bolt11PaymentRequest invoiceDecoded = Bolt11PaymentRequest(invoiceString);
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
        await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
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
                  logger.i("Self-payment detected, checking for internal rebalance...");
                  
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
                          amount?.toString() ?? invoiceDecoded.amount.toString(),
                          userId,
                          nodeUrl,
                        );
                        logger.i("Internal rebalance response: $rebalanceResponse");
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
                yield {
                  'status': 'FAILED',
                  'failure_reason': errorMessage
                };
                continue;
              }
            }
            
            // Check for successful payment
            if (decoded.containsKey('result')) {
              final result = decoded['result'];
              if (result is Map<String, dynamic>) {
                // Map Lightning node status to expected format
                String status = 'FAILED';
                if (result['status'] == 'SUCCEEDED' || 
                    result['status'] == 'SUCCESSFUL' || 
                    result['status'] == 'COMPLETED' ||
                    result['status'] == 'SETTLED') {
                  status = 'SUCCEEDED';
                }
                
                // Yield payment result in expected format for compatibility
                yield {
                  'status': status,
                  'payment_hash': result['payment_hash'] ?? '',
                  'payment_preimage': result['payment_preimage'] ?? '',
                  'value_sat': result['value_sat']?.toString() ?? result['value']?.toString() ?? amount?.toString() ?? '0',
                  'payment_request': invoiceString,
                  'fee_sat': result['fee_sat']?.toString() ?? result['fee']?.toString() ?? '0',
                  'creation_date': DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  'creation_time_ns': result['creation_time_ns'] ?? (DateTime.now().millisecondsSinceEpoch * 1000000).toString(),
                  'htlcs': result['htlcs'] ?? [],
                  // Additional fields for LightningPayment model compatibility
                  'value_msat': ((int.tryParse(result['value_sat']?.toString() ?? '0') ?? 0) * 1000).toString(),
                  'fee_msat': ((int.tryParse(result['fee_sat']?.toString() ?? '0') ?? 0) * 1000).toString(),
                  'payment_index': result['payment_index']?.toString() ?? '0',
                };
              } else {
                // If result doesn't have expected structure, treat as failed
                yield {
                  'status': 'FAILED',
                  'failure_reason': 'Unexpected response format',
                  'raw_response': decoded
                };
              }
            } else if (decoded.containsKey('payment_error') || decoded.containsKey('payment_hash')) {
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
                'fee_msat': ((int.tryParse(decoded['payment_fee']?.toString() ?? '0') ?? 0) * 1000).toString(),
                'payment_index': '0',
              };
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
        yield {
          'status': 'FAILED',
          'failure_reason': 'Network error: $e'
        };
      }
      
      // Add delay between multiple payments
      if (invoiceStrings.length > 1) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  } catch (e) {
    logger.e("Fatal error in sendPaymentV2Stream: $e");
    yield {
      'status': 'FAILED',
      'failure_reason': 'Fatal error: $e'
    };
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
