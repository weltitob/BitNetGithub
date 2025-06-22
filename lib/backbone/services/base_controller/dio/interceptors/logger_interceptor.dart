import 'dart:convert';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
 
class LoggerInterceptor extends Interceptor {
  LoggerService logger = Get.find();
  
  // Track request frequency for loop detection
  static final Map<String, List<DateTime>> _requestHistory = {};
  static const int _maxHistorySize = 50;
  static const Duration _timeWindow = Duration(minutes: 1);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    
    // Enhanced logging for rate limits and API loops
    if (err.response?.statusCode == 429) {
      final retryAfter = err.response?.headers.value('retry-after');
      logger.w('🚫 API RATE LIMIT HIT: $requestPath');
      logger.w('⏰ Retry after: ${retryAfter ?? 'unknown'} seconds');
      logger.w('🔄 This may indicate loop-in-loop API calls - investigate request pattern');
    }
    
    // Log request frequency for potential loop detection
    final now = DateTime.now();
    final requestKey = '${options.method}_${options.path}';
    logger.d('📊 Request timing: $requestKey at ${now.toIso8601String()}');
    
    logger.d(
        'Error: ${err.error}, Message: ${err.message}, Data: ${err.response?.data}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    final requestKey = '${options.method}_${options.path}';
    final now = DateTime.now();
    
    // Track request frequency for loop detection
    _requestHistory.putIfAbsent(requestKey, () => []);
    _requestHistory[requestKey]!.add(now);
    
    // Remove old entries outside time window
    _requestHistory[requestKey]!.removeWhere(
      (time) => now.difference(time) > _timeWindow,
    );
    
    // Keep history size manageable
    if (_requestHistory[requestKey]!.length > _maxHistorySize) {
      _requestHistory[requestKey]!.removeRange(0, 
        _requestHistory[requestKey]!.length - _maxHistorySize);
    }
    
    final requestCount = _requestHistory[requestKey]!.length;
    
    logger.i('${options.method} request => $requestPath');
    
    // Log potential loop-in-loop scenarios
    if (requestCount > 10) {
      logger.w('⚠️  HIGH FREQUENCY DETECTED: $requestCount requests to $requestPath in last minute');
      logger.w('🔁 Potential loop-in-loop API calls detected - consider rate limiting');
    } else if (requestCount > 5) {
      logger.d('📈 Frequent requests: $requestCount to $requestPath in last minute');
    }
    
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
