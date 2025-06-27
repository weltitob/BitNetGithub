import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/batch.dart';
import 'package:bitnet/models/tapd/fetchbatchresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<Batch?> fetchMintBatch(String batchKey) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();

  // Try the port version since that worked for mint
  String restHost =
      remoteConfigController.baseUrlLightningTerminalWithPort.value;
  String restHostNoPort = remoteConfigController.baseUrlLightningTerminal.value;

  print("🔍🔍🔍 FETCH BATCH: Using host with port: $restHost 🔍🔍🔍");
  print(
      "🔍🔍🔍 FETCH BATCH: Alternative host without port: $restHostNoPort 🔍🔍🔍");

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url =
      'https://$restHost/v1/taproot-assets/assets/mint/batches/$batchKey';

  print("🔍🔍🔍 FETCH BATCH: Attempting URL: $url 🔍🔍🔍");

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  try {
    print("🔍🔍🔍 FETCH BATCH: Sending GET request... 🔍🔍🔍");
    logger.i("Requesting batch with key: $batchKey from URL: $url");

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(
        "🔍🔍🔍 FETCH BATCH: Response status code: ${response.statusCode} 🔍🔍🔍");

    if (response.statusCode == 200) {
      print("🔍🔍🔍 FETCH BATCH: RESPONSE SUCCESSFUL! 🔍🔍🔍");
      logger.i("RESPONSE SUCCESSFUL!");
      Map<String, dynamic> responseData = json.decode(response.body);
      logger.i("Raw Response: ${response.body}");

      // Parse the response data into FetchBatchResponse
      FetchBatchResponse fetchBatchResponse =
          FetchBatchResponse.fromJson(responseData);

      // Check if batches exists and is not empty
      if (fetchBatchResponse.batches.isNotEmpty) {
        try {
          // Find the batch with the specified batchKey
          for (var batch in fetchBatchResponse.batches) {
            if (batch.batchKey == batchKey) {
              print("🔍🔍🔍 FETCH BATCH: Found matching batch! 🔍🔍🔍");
              return batch;
            }
          }

          // If no matching batch found
          print("🔍🔍🔍 FETCH BATCH: No batch found with key $batchKey 🔍🔍🔍");
          logger.e("No batch found with key $batchKey");
          return null;
        } catch (e) {
          print(
              "🔍🔍🔍 FETCH BATCH: Error finding batch with key $batchKey: $e 🔍🔍🔍");
          logger.e("Error finding batch with key $batchKey: $e");
          return null;
        }
      } else {
        print("🔍🔍🔍 FETCH BATCH: No batches found in the response 🔍🔍🔍");
        logger.e("No batches found in the response for key: $batchKey");
        return null;
      }
    } else {
      print(
          "🔍🔍🔍 FETCH BATCH: Request failed. Status code: ${response.statusCode} 🔍🔍🔍");
      logger.e(
          "Failed to fetch data. Status code: ${response.statusCode} ${response.body}");

      // Try alternative URLs if the first one fails
      print("🔍🔍🔍 FETCH BATCH: Trying alternative URL format... 🔍🔍🔍");

      // First try without port
      String alternativeUrl =
          'https://$restHostNoPort/v1/taproot-assets/assets/mint/batches/$batchKey';
      print("🔍🔍🔍 FETCH BATCH: Alternative URL 1: $alternativeUrl 🔍🔍🔍");

      try {
        var altResponse = await http.get(
          Uri.parse(alternativeUrl),
          headers: headers,
        );

        print(
            "🔍🔍🔍 FETCH BATCH: Alternative response status: ${altResponse.statusCode} 🔍🔍🔍");

        if (altResponse.statusCode == 200) {
          print("🔍🔍🔍 FETCH BATCH: ALTERNATIVE 1 SUCCESSFUL! 🔍🔍🔍");
          Map<String, dynamic> altResponseData = json.decode(altResponse.body);

          // Parse the response data into FetchBatchResponse
          FetchBatchResponse altFetchBatchResponse =
              FetchBatchResponse.fromJson(altResponseData);

          // Check if batches exists and is not empty
          if (altFetchBatchResponse.batches.isNotEmpty) {
            // Find the batch with the specified batchKey
            for (var batch in altFetchBatchResponse.batches) {
              if (batch.batchKey == batchKey) {
                print(
                    "🔍🔍🔍 FETCH BATCH: Found matching batch in alternative! 🔍🔍🔍");
                return batch;
              }
            }
          }
        }

        // Try another format without 'assets' in path
        String alternativeUrl2 =
            'https://$restHost/v1/taproot-assets/mint/batches/$batchKey';
        print("🔍🔍🔍 FETCH BATCH: Alternative URL 2: $alternativeUrl2 🔍🔍🔍");

        var altResponse2 = await http.get(
          Uri.parse(alternativeUrl2),
          headers: headers,
        );

        print(
            "🔍🔍🔍 FETCH BATCH: Alternative 2 response status: ${altResponse2.statusCode} 🔍🔍🔍");

        if (altResponse2.statusCode == 200) {
          print("🔍🔍🔍 FETCH BATCH: ALTERNATIVE 2 SUCCESSFUL! 🔍🔍🔍");
          Map<String, dynamic> altResponseData2 =
              json.decode(altResponse2.body);

          // Parse the response data into FetchBatchResponse
          FetchBatchResponse altFetchBatchResponse2 =
              FetchBatchResponse.fromJson(altResponseData2);

          // Check if batches exists and is not empty
          if (altFetchBatchResponse2.batches.isNotEmpty) {
            // Find the batch with the specified batchKey
            for (var batch in altFetchBatchResponse2.batches) {
              if (batch.batchKey == batchKey) {
                print(
                    "🔍🔍🔍 FETCH BATCH: Found matching batch in alternative 2! 🔍🔍🔍");
                return batch;
              }
            }
          }
        }
      } catch (altError) {
        print(
            "🔍🔍🔍 FETCH BATCH: Error in alternative URLs: $altError 🔍🔍🔍");
      }

      return null;
    }
  } catch (e) {
    print("🔍🔍🔍 FETCH BATCH: Error requesting mint batch: $e 🔍🔍🔍");
    logger.e("Error requesting mint batch: $e");
    return null;
  }
}
