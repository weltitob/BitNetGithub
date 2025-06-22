import 'dart:async';
import 'dart:collection';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

class ApiRateLimiter extends GetxService {
  LoggerService logger = Get.find();
  
  final Queue<_QueuedRequest> _requestQueue = Queue();
  bool _isProcessing = false;
  final Duration _minDelay = const Duration(milliseconds: 100);
  final Duration _maxDelay = const Duration(seconds: 5);
  
  // Track request patterns for different endpoints
  final Map<String, List<DateTime>> _endpointHistory = {};
  final Map<String, int> _endpointLimits = {
    'coingecko': 50, // requests per minute
    'default': 30,   // requests per minute for other APIs
  };
  
  static ApiRateLimiter get to => Get.find();

  Future<T> enqueue<T>({
    required Future<T> Function() request,
    required String endpoint,
    String? apiProvider,
    int priority = 1,
  }) async {
    final completer = Completer<T>();
    final queuedRequest = _QueuedRequest<T>(
      request: request,
      completer: completer,
      endpoint: endpoint,
      apiProvider: apiProvider ?? 'default',
      priority: priority,
      timestamp: DateTime.now(),
    );

    _requestQueue.add(queuedRequest);
    
    logger.d('🚦 Queued request for endpoint: $endpoint (queue size: ${_requestQueue.length})');
    
    if (_requestQueue.length > 10) {
      logger.w('⚠️  Large queue detected: ${_requestQueue.length} pending requests');
      logger.w('🔁 This indicates potential loop-in-loop API calls');
    }
    
    _processQueue();
    
    return completer.future;
  }

  void _processQueue() async {
    if (_isProcessing || _requestQueue.isEmpty) return;
    
    _isProcessing = true;
    logger.d('🔄 Starting API request queue processing');
    
    while (_requestQueue.isNotEmpty) {
      final queuedRequest = _requestQueue.removeFirst();
      
      try {
        // Check rate limits for this endpoint
        final delay = _calculateDelay(queuedRequest.apiProvider, queuedRequest.endpoint);
        
        if (delay > Duration.zero) {
          logger.d('⏱️  Rate limit delay: ${delay.inMilliseconds}ms for ${queuedRequest.endpoint}');
          await Future.delayed(delay);
        }
        
        // Record request timing
        _recordRequest(queuedRequest.apiProvider, queuedRequest.endpoint);
        
        logger.d('📡 Executing queued request: ${queuedRequest.endpoint}');
        final result = await queuedRequest.request();
        queuedRequest.completer.complete(result);
        
        logger.d('✅ Completed queued request: ${queuedRequest.endpoint}');
        
      } catch (error) {
        logger.e('❌ Failed queued request: ${queuedRequest.endpoint} - $error');
        queuedRequest.completer.completeError(error);
      }
      
      // Minimum delay between any requests
      await Future.delayed(_minDelay);
    }
    
    _isProcessing = false;
    logger.d('🏁 Finished processing API request queue');
  }

  Duration _calculateDelay(String apiProvider, String endpoint) {
    final now = DateTime.now();
    final history = _endpointHistory['${apiProvider}_$endpoint'] ?? [];
    final limit = _endpointLimits[apiProvider] ?? _endpointLimits['default']!;
    
    // Remove requests older than 1 minute
    history.removeWhere((time) => now.difference(time).inMinutes >= 1);
    
    if (history.length >= limit) {
      // Calculate how long to wait
      final oldestInWindow = history.first;
      final waitTime = const Duration(minutes: 1) - now.difference(oldestInWindow);
      logger.w('🚫 Rate limit reached for $apiProvider/$endpoint. Waiting ${waitTime.inSeconds}s');
      return waitTime > _maxDelay ? _maxDelay : waitTime;
    }
    
    // If we've made recent requests, add a small delay
    if (history.isNotEmpty) {
      final lastRequest = history.last;
      final timeSinceLastRequest = now.difference(lastRequest);
      
      if (timeSinceLastRequest < _minDelay) {
        return _minDelay - timeSinceLastRequest;
      }
    }
    
    return Duration.zero;
  }

  void _recordRequest(String apiProvider, String endpoint) {
    final key = '${apiProvider}_$endpoint';
    _endpointHistory.putIfAbsent(key, () => []);
    _endpointHistory[key]!.add(DateTime.now());
    
    // Keep only last 100 requests per endpoint
    if (_endpointHistory[key]!.length > 100) {
      _endpointHistory[key]!.removeRange(0, _endpointHistory[key]!.length - 100);
    }
  }

  // Get queue status for debugging
  Map<String, dynamic> getQueueStatus() {
    return {
      'queueSize': _requestQueue.length,
      'isProcessing': _isProcessing,
      'endpointHistory': _endpointHistory.map((key, value) => 
        MapEntry(key, value.length)),
    };
  }

  // Clear queue (for testing/emergency)
  void clearQueue() {
    logger.w('🧹 Clearing API request queue (${_requestQueue.length} requests)');
    while (_requestQueue.isNotEmpty) {
      final request = _requestQueue.removeFirst();
      request.completer.completeError('Queue cleared');
    }
  }
}

class _QueuedRequest<T> {
  final Future<T> Function() request;
  final Completer<T> completer;
  final String endpoint;
  final String apiProvider;
  final int priority;
  final DateTime timestamp;

  _QueuedRequest({
    required this.request,
    required this.completer,
    required this.endpoint,
    required this.apiProvider,
    required this.priority,
    required this.timestamp,
  });
}