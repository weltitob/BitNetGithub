import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class AppImageCacheService extends GetxService {
  late Dio dio;
  late CacheStore cacheStore;
  late GetStorage localStorage;

  // In-memory cache for quick access during session
  final Map<String, Uint8List> _memoryCache = {};
  final Map<String, String> _urlCache = {}; // Cache Firebase Storage URLs

  // Timer for periodic cache cleanup
  Timer? _cleanupTimer;

  // Cache expiration duration (7 days for app images)
  static const Duration cacheExpiration = Duration(days: 7);

  // Maximum memory cache size in bytes (10MB)
  static const int maxMemoryCacheSize = 10485760;

  @override
  void onInit() {
    super.onInit();

    // Initialize GetStorage for persistent cache
    localStorage = GetStorage('app_image_cache');

    // Setup memory cache store with 20MB limit
    cacheStore = MemCacheStore(maxSize: 20971520); // 20MB

    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorCodes: [401, 403],
      maxStale: cacheExpiration,
      priority: CachePriority.high,
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

  // Get image from Firebase Storage
  Future<Uint8List?> getFirebaseStorageImage(String storageName,
      {bool forceRefresh = false}) async {
    try {
      final cacheKey = 'firebase_$storageName';

      // Check memory cache first
      if (!forceRefresh && _memoryCache.containsKey(cacheKey)) {
        return _memoryCache[cacheKey];
      }

      // Check persistent storage
      if (!forceRefresh && localStorage.hasData(cacheKey)) {
        final cached = localStorage.read(cacheKey);
        final timestamp = localStorage.read('${cacheKey}_timestamp') ?? 0;

        // Cache valid for 7 days
        if (DateTime.now().millisecondsSinceEpoch - timestamp <
            cacheExpiration.inMilliseconds) {
          final bytes = Uint8List.fromList(List<int>.from(cached));
          _memoryCache[cacheKey] = bytes;
          return bytes;
        }
      }

      // Get download URL from Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("mini_app_icons/$storageName");
      final downloadUrl = await imageRef.getDownloadURL();

      // Cache the URL
      _urlCache[storageName] = downloadUrl;

      // Download the image
      final response = await dio.get(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
          extra: {
            'dio_cache_interceptor_options': CacheOptions(
              store: cacheStore,
              policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
              hitCacheOnErrorCodes: [401, 403],
              maxStale: cacheExpiration,
            ).toExtra(),
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = Uint8List.fromList(response.data);

        // Store in memory cache
        _memoryCache[cacheKey] = bytes;

        // Store in persistent storage
        localStorage.write(cacheKey, bytes.toList());
        localStorage.write(
            '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

        return bytes;
      }

      return null;
    } catch (e) {
      print('Error fetching Firebase Storage image: $e');
      return null;
    }
  }

  // Get favicon from URL
  Future<Uint8List?> getFaviconFromUrl(String websiteUrl,
      {bool forceRefresh = false}) async {
    try {
      final cacheKey = 'favicon_url_${Uri.parse(websiteUrl).host}';

      // Check memory cache first
      if (!forceRefresh && _memoryCache.containsKey(cacheKey)) {
        return _memoryCache[cacheKey];
      }

      // Check persistent storage
      if (!forceRefresh && localStorage.hasData(cacheKey)) {
        final cached = localStorage.read(cacheKey);
        final timestamp = localStorage.read('${cacheKey}_timestamp') ?? 0;

        if (DateTime.now().millisecondsSinceEpoch - timestamp <
            cacheExpiration.inMilliseconds) {
          final bytes = Uint8List.fromList(List<int>.from(cached));
          _memoryCache[cacheKey] = bytes;
          return bytes;
        }
      }

      // Fetch favicon URL
      final faviconUrl = await _findFaviconUrl(websiteUrl);
      if (faviconUrl.isEmpty) return null;

      // Download favicon
      final response = await dio.get(
        faviconUrl,
        options: Options(
          responseType: ResponseType.bytes,
          extra: {
            'dio_cache_interceptor_options': CacheOptions(
              store: cacheStore,
              policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
              hitCacheOnErrorCodes: [401, 403],
              maxStale: cacheExpiration,
            ).toExtra(),
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = Uint8List.fromList(response.data);

        // Store in caches
        _memoryCache[cacheKey] = bytes;
        localStorage.write(cacheKey, bytes.toList());
        localStorage.write(
            '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

        return bytes;
      }

      return null;
    } catch (e) {
      print('Error fetching favicon: $e');
      return null;
    }
  }

  // Find favicon URL from website
  Future<String> _findFaviconUrl(String websiteUrl) async {
    try {
      // Ensure the URL has a scheme
      if (!websiteUrl.startsWith('http')) {
        websiteUrl = 'https://$websiteUrl';
      }

      // Try to fetch the website HTML
      final response = await http.get(Uri.parse(websiteUrl)).timeout(
            const Duration(seconds: 5),
            onTimeout: () => http.Response('', 408),
          );

      if (response.statusCode == 200) {
        final document = html.parse(response.body);

        // Look for favicon tags
        final iconTags = document.querySelectorAll(
            'link[rel="icon"], link[rel="shortcut icon"], link[rel="apple-touch-icon"]');

        for (var tag in iconTags) {
          final iconUrl = tag.attributes['href'];
          if (iconUrl != null) {
            // Resolve relative URLs
            return Uri.parse(websiteUrl).resolve(iconUrl).toString();
          }
        }
      }

      // Fallback to Google's favicon service
      final domain = Uri.parse(websiteUrl).host;
      return 'https://www.google.com/s2/favicons?domain=$domain&sz=64';
    } catch (e) {
      print('Error finding favicon URL: $e');
      // Fallback to Google's favicon service
      try {
        final domain = Uri.parse(websiteUrl).host;
        return 'https://www.google.com/s2/favicons?domain=$domain&sz=64';
      } catch (_) {
        return '';
      }
    }
  }

  // Get direct network image
  Future<Uint8List?> getNetworkImage(String imageUrl,
      {bool forceRefresh = false}) async {
    try {
      final cacheKey =
          'network_${Uri.parse(imageUrl).host}_${imageUrl.hashCode}';

      // Check memory cache first
      if (!forceRefresh && _memoryCache.containsKey(cacheKey)) {
        return _memoryCache[cacheKey];
      }

      // Check persistent storage
      if (!forceRefresh && localStorage.hasData(cacheKey)) {
        final cached = localStorage.read(cacheKey);
        final timestamp = localStorage.read('${cacheKey}_timestamp') ?? 0;

        if (DateTime.now().millisecondsSinceEpoch - timestamp <
            cacheExpiration.inMilliseconds) {
          final bytes = Uint8List.fromList(List<int>.from(cached));
          _memoryCache[cacheKey] = bytes;
          return bytes;
        }
      }

      // Download image
      final response = await dio.get(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
          extra: {
            'dio_cache_interceptor_options': CacheOptions(
              store: cacheStore,
              policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
              hitCacheOnErrorCodes: [401, 403],
              maxStale: cacheExpiration,
            ).toExtra(),
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = Uint8List.fromList(response.data);

        // Store in caches
        _memoryCache[cacheKey] = bytes;
        localStorage.write(cacheKey, bytes.toList());
        localStorage.write(
            '${cacheKey}_timestamp', DateTime.now().millisecondsSinceEpoch);

        return bytes;
      }

      return null;
    } catch (e) {
      print('Error fetching network image: $e');
      return null;
    }
  }

  // Preload multiple images
  Future<void> preloadImages(
      List<String> storageNames, List<String> urls) async {
    final futures = <Future>[];

    // Preload Firebase Storage images
    for (final storageName in storageNames) {
      futures.add(getFirebaseStorageImage(storageName));
    }

    // Preload favicon URLs
    for (final url in urls) {
      futures.add(getFaviconFromUrl(url));
    }

    await Future.wait(futures, eagerError: false);
  }

  // Clear specific image from cache
  Future<void> clearImage(String key) async {
    // Remove from memory cache
    _memoryCache.removeWhere((k, v) => k.contains(key));

    // Remove from persistent storage
    final keysToRemove = localStorage
        .getKeys()
        .whereType<String>()
        .where((k) => k.contains(key))
        .toList();

    for (final k in keysToRemove) {
      localStorage.remove(k);
    }
  }

  // Clear all caches
  Future<void> clearAllCache() async {
    _memoryCache.clear();
    _urlCache.clear();
    await localStorage.erase();
    await cacheStore.clean();
  }

  // Get cache statistics
  Map<String, dynamic> getCacheStats() {
    final persistentKeys = localStorage
        .getKeys()
        .whereType<String>()
        .where((key) => !key.endsWith('_timestamp'))
        .length;

    return {
      'memoryCount': _memoryCache.length,
      'persistentCount': persistentKeys,
      'memorySizeBytes':
          _memoryCache.values.fold(0, (sum, bytes) => sum + bytes.length),
      'urlCacheCount': _urlCache.length,
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

    // Check all cache entries
    for (final key in localStorage.getKeys().whereType<String>()) {
      if (!key.endsWith('_timestamp')) {
        final timestampKey = '${key}_timestamp';
        final timestamp = localStorage.read(timestampKey) ?? 0;

        // Remove if expired
        if (now - timestamp > cacheExpiration.inMilliseconds) {
          keysToRemove.add(key);
          keysToRemove.add(timestampKey);

          // Also remove from memory cache
          _memoryCache.remove(key);
        }
      }
    }

    // Remove expired entries
    for (final key in keysToRemove) {
      localStorage.remove(key);
    }

    if (keysToRemove.isNotEmpty) {
      print('Cleaned ${keysToRemove.length ~/ 2} expired app image entries');
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

      print('Trimmed app image memory cache: removed $entriesToRemove entries');
    }
  }

  @override
  void onClose() {
    _cleanupTimer?.cancel();
    super.onClose();
  }
}
