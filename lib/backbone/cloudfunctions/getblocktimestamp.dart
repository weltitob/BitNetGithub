import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:get/get.dart';

Future<DateTime> getBlockTimeStamp(Asset asset) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  dynamic blockHash = asset.chainAnchor!.anchorBlockHash;
  // Make the GET request
  String url = 'https://mempool.space/api/v1/block/$blockHash/audit-summary';
  try {
    final DioClient dioClient = Get.find<DioClient>();
    var response = await dioClient.get(url: url);

    logger.i("Raw Response: ${response}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      int timeStamp = responseData['timestamp'];
      String timeStampUrl =
          'https://mempool.space/api/v1/mining/blocks/timestamp/$timeStamp';
      var timeStampResponse = await dioClient.get(url: timeStampUrl);
      if (timeStampResponse.statusCode == 200) {
        DateTime finalDate =
            DateTime.tryParse(timeStampResponse.data['timestamp']) ??
                DateTime.now();
        logger.i(finalDate);
        return finalDate;
      } else {
        logger.e(
            'Failed to fetch DateTime: ${timeStampResponse.statusCode}, ${timeStampResponse}');
        return DateTime.now();
      }
    } else {
      logger.e('Failed to fetch DateTime: ${response.statusCode}, ${response}');
      return DateTime.now();
    }
  } catch (e) {
    logger.e('Error requesting blockhash audit-summary: $e');
    return DateTime.now();
  }
}
