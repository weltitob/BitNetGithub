import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiCacheService extends GetxService {
  late Dio dio;
  late CacheStore cacheStore;
  late GetStorage localStorage;

  @override
  void onInit() {
    super.onInit();

    // Initialize GetStorage for persistent cache
    localStorage = GetStorage('api_cache');

    // Setup memory + disk cache
    cacheStore = MemCacheStore(maxSize: 10485760); // 10MB

    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache, // or CachePolicy.request
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    dio = Dio()..interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  // Helper method to build cache options
  Options buildCacheOptions(Duration maxAge, {bool forceRefresh = false}) {
    return Options(
      extra: {
        'dio_cache_interceptor_options': CacheOptions(
          store: cacheStore,
          policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
          hitCacheOnErrorExcept: [401, 403],
          maxStale: maxAge,
        ).toExtra(),
      },
    );
  }

  // Example: Cached API call
  Future<Map<String, dynamic>> getCachedData(
    String url, {
    Duration? maxAge,
    bool forceRefresh = false,
  }) async {
    final options = buildCacheOptions(
      Duration(minutes: maxAge?.inMinutes ?? 15),
      forceRefresh: forceRefresh,
    );

    final response = await dio.get(url, options: options);
    return response.data;
  }

  // For BitNet specific caching
  Future<double> getBitcoinPrice({bool forceRefresh = false}) async {
    final cacheKey = 'bitcoin_price';

    // Check GetStorage first for quick access
    if (!forceRefresh && localStorage.hasData(cacheKey)) {
      final cached = localStorage.read(cacheKey);
      final timestamp = localStorage.read('${cacheKey}_timestamp') ?? 0;

      // Cache valid for 1 minute
      if (DateTime.now().millisecondsSinceEpoch - timestamp < 60000) {
        return cached;
      }
    }

    // Fetch from API with dio cache
    final data = await getCachedData(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd',
      maxAge: Duration(minutes: 1),
      forceRefresh: forceRefresh,
    );

    final price = data['bitcoin']['usd'].toDouble();

    // Store in GetStorage for next app launch
    localStorage.write(cacheKey, price);
    localStorage.write(
        '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

    return price;
  }

  // Clear all caches
  Future<void> clearCache() async {
    await cacheStore.clean();
    await localStorage.erase();
  }
}
