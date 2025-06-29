import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FaviconCacheService extends GetxService {
  late Dio dio;
  late CacheStore cacheStore;
  late GetStorage localStorage;

  // In-memory cache for quick access during session
  final Map<String, Uint8List> _memoryCache = {};

  // Timer for periodic cache cleanup
  Timer? _cleanupTimer;

  // Cache expiration duration (30 days)
  static const Duration cacheExpiration = Duration(days: 30);

  // Maximum memory cache size in bytes (2MB)
  static const int maxMemoryCacheSize = 2097152;

  @override
  void onInit() {
    super.onInit();

    // Initialize GetStorage for persistent cache
    localStorage = GetStorage('favicon_cache');

    // Setup memory cache store with 5MB limit for favicons
    cacheStore = MemCacheStore(maxSize: 5242880); // 5MB

    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorCodes: [401, 403],
      maxStale: const Duration(days: 30), // Favicons don't change often
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    dio = Dio()..interceptors.add(DioCacheInterceptor(options: cacheOptions));

    // Start periodic cleanup timer (runs every hour)
    _startCleanupTimer();

    // Clean expired cache on startup
    _cleanExpiredCache();
  }

  Future<Uint8List?> getFavicon(String url, {bool forceRefresh = false}) async {
    try {
      // Extract domain from URL
      final Uri uri = Uri.parse(url);
      final domain = uri.host.isEmpty ? url : uri.host;
      final cacheKey = 'favicon_$domain';

      // Check memory cache first
      if (!forceRefresh && _memoryCache.containsKey(domain)) {
        return _memoryCache[domain];
      }

      // Check persistent storage
      if (!forceRefresh && localStorage.hasData(cacheKey)) {
        final cached = localStorage.read(cacheKey);
        final timestamp = localStorage.read('${cacheKey}_timestamp') ?? 0;

        // Cache valid for 30 days
        if (DateTime.now().millisecondsSinceEpoch - timestamp < 2592000000) {
          final bytes = Uint8List.fromList(List<int>.from(cached));
          _memoryCache[domain] = bytes;
          return bytes;
        }
      }

      // Fetch from Google's favicon service
      final faviconUrl =
          'https://www.google.com/s2/favicons?domain=$domain&sz=64';

      final options = Options(
        responseType: ResponseType.bytes,
        extra: {
          'dio_cache_interceptor_options': CacheOptions(
            store: cacheStore,
            policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
            hitCacheOnErrorCodes: [401, 403],
            maxStale: const Duration(days: 30),
          ).toExtra(),
        },
      );

      final response = await dio.get(faviconUrl, options: options);

      if (response.statusCode == 200 && response.data != null) {
        final bytes = Uint8List.fromList(response.data);

        // Store in memory cache
        _memoryCache[domain] = bytes;

        // Store in persistent storage
        localStorage.write(cacheKey, bytes.toList());
        localStorage.write(
            '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

        return bytes;
      }

      return null;
    } catch (e) {
      print('Error fetching favicon for $url: $e');
      return null;
    }
  }

  // Preload multiple favicons
  Future<void> preloadFavicons(List<String> urls) async {
    final futures = urls.map((url) => getFavicon(url));
    await Future.wait(futures, eagerError: false);
  }

  // Clear specific favicon from cache
  Future<void> clearFavicon(String url) async {
    final Uri uri = Uri.parse(url);
    final domain = uri.host.isEmpty ? url : uri.host;
    final cacheKey = 'favicon_$domain';

    _memoryCache.remove(domain);
    localStorage.remove(cacheKey);
    localStorage.remove('${cacheKey}_timestamp');
  }

  // Clear all favicon caches
  Future<void> clearAllCache() async {
    _memoryCache.clear();
    await localStorage.erase();
    await cacheStore.clean();
  }

  // Get cache statistics
  Map<String, dynamic> getCacheStats() {
    final persistentKeys = localStorage
        .getKeys()
        .whereType<String>()
        .where(
            (key) => key.startsWith('favicon_') && !key.endsWith('_timestamp'))
        .length;

    return {
      'memoryCount': _memoryCache.length,
      'persistentCount': persistentKeys,
      'memorySizeBytes':
          _memoryCache.values.fold(0, (sum, bytes) => sum + bytes.length),
    };
  }

  // Start periodic cleanup timer
  void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(hours: 1), (_) {
      _cleanExpiredCache();
      _trimMemoryCache();
    });
  }

  // Clean expired cache entries
  void _cleanExpiredCache() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final keysToRemove = <String>[];

    // Check all favicon entries
    for (final key in localStorage.getKeys().whereType<String>()) {
      if (key.startsWith('favicon_') && !key.endsWith('_timestamp')) {
        final timestampKey = '${key}_timestamp';
        final timestamp = localStorage.read(timestampKey) ?? 0;

        // Remove if expired
        if (now - timestamp > cacheExpiration.inMilliseconds) {
          keysToRemove.add(key);
          keysToRemove.add(timestampKey);

          // Also remove from memory cache
          final domain = key.replaceFirst('favicon_', '');
          _memoryCache.remove(domain);
        }
      }
    }

    // Remove expired entries
    for (final key in keysToRemove) {
      localStorage.remove(key);
    }

    if (keysToRemove.isNotEmpty) {
      print('Cleaned ${keysToRemove.length ~/ 2} expired favicon entries');
    }
  }

  // Trim memory cache if it exceeds size limit
  void _trimMemoryCache() {
    final currentSize =
        _memoryCache.values.fold(0, (sum, bytes) => sum + bytes.length);

    if (currentSize > maxMemoryCacheSize) {
      // Remove oldest entries (simple FIFO approach)
      final entriesToRemove = _memoryCache.length ~/ 4; // Remove 25%
      final keysToRemove = _memoryCache.keys.take(entriesToRemove).toList();

      for (final key in keysToRemove) {
        _memoryCache.remove(key);
      }

      print('Trimmed memory cache: removed $entriesToRemove entries');
    }
  }

  @override
  void onClose() {
    _cleanupTimer?.cancel();
    super.onClose();
  }
}
