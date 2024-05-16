import 'dart:convert';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
 
class LoggerInterceptor extends Interceptor {
  LoggerService logger = Get.find();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d(
        'Error: ${err.error}, Message: ${err.message}, Data: ${err.response!.data}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');
    logger.d('Request Headers: ${options.headers}');
    if (options.data != null) {
      if (options.contentType != null &&
          options.contentType!.contains('application/json')) {
        final encodedBody = jsonEncode(options.data);
        logger.d('Request Body: $encodedBody');
      } else {
        logger.d('Request Body: ${options.data}');
      }
    }

    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}');

    final int startTime = response.requestOptions.extra['startTime'];
    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final double elapsedTimeSeconds = (endTime - startTime) / 1000;

    // Log the time
    logger.d('Request took: $elapsedTimeSeconds seconds to complete');
    return super.onResponse(response, handler);
  }
}
