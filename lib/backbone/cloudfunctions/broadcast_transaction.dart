import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<RestResponse> broadcastTransaction(String rawTxHex) async {
  LoggerService logger = Get.find();
  String url = 'https://mempool.space/api/tx';
  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(
        url: url, headers: {'Content-Type': 'text/plain'}, data: {rawTxHex});
    logger.i('Raw Response broadcast Transaction: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully broadcasted transaction",
          data: response.data);
    } else {
      logger.e(
          'Failed to load data (broadcasttransaction.dart): ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    logger.e('Error trying to broadcast transaction: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
