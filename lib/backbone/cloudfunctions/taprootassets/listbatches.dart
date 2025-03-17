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

  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  String restHost = remoteConfigController.baseUrlLightningTerminal.value;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url =
  //  kDebugMode
  //     ? ''
  //     :
       'https://$restHost/v1/taproot-assets/assets/mint/batches/$batchKey';


  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  try {
    logger.i("Requesting batch with key: $batchKey from URL: $url");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
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
              return batch;
            }
          }
          
          // If no matching batch found
          logger.e("No batch found with key $batchKey");
          return null;
          
        } catch (e) {
          logger.e("Error finding batch with key $batchKey: $e");
          return null;
        }
      } else {
        logger.e("No batches found in the response for key: $batchKey");
        return null;
      }
    } else {
      logger.e(
          "Failed to fetch data. Status code: ${response.statusCode} ${response.body}");
      return null;
    }
  } catch (e) {
    logger.e("Error requesting mint batch: $e");
    return null;
  }
}
