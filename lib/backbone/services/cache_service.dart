import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class CacheService extends GetxService {
  static const String _cachePrefix = 'bitnet_cache_';
  late SharedPreferences _prefs;
  final Map<String, CachedData> _memoryCache = {};

  Future<CacheService> init() async {
    _prefs = await SharedPreferences.getInstance();
    _cleanExpiredCache();
    return this;
  }

  /// Get cached data or fetch fresh data
  Future<T> getCachedOrFetch<T>({
    required String key,
    required Future<T> Function() fetcher,
    required Duration cacheDuration,
    bool forceRefresh = false,
  }) async {
    // Check memory cache first
    if (!forceRefresh && _memoryCache.containsKey(key)) {
      final cached = _memoryCache[key]!;
      if (!cached.isExpired) {
        return cached.data as T;
      }
    }

    // Check persistent cache
    if (!forceRefresh) {
      final persistentData = await _getFromPersistentCache<T>(key);
      if (persistentData != null) {
        return persistentData;
      }
    }

    // Fetch fresh data
    try {
      final data = await fetcher();
      await _saveToCache(key, data, cacheDuration);
      return data;
    } catch (e) {
      // If fetch fails, try to return stale cache if available
      final staleData = _memoryCache[key]?.data as T?;
      if (staleData != null) {
        return staleData;
      }
      rethrow;
    }
  }

  /// Save data to both memory and persistent cache
  Future<void> _saveToCache<T>(String key, T data, Duration cacheDuration) async {
    final expiry = DateTime.now().add(cacheDuration);
    
    // Save to memory cache
    _memoryCache[key] = CachedData(data, expiry);
    
    // Save to persistent cache (for basic types)
    if (data is String || data is int || data is double || data is bool) {
      await _prefs.setString('$_cachePrefix$key', jsonEncode({
        'data': data,
        'expiry': expiry.millisecondsSinceEpoch,
        'type': data.runtimeType.toString(),
      }));
    } else if (data is List || data is Map) {
      // For complex types, encode to JSON
      try {
        await _prefs.setString('$_cachePrefix$key', jsonEncode({
          'data': data,
          'expiry': expiry.millisecondsSinceEpoch,
          'type': data.runtimeType.toString(),
        }));
      } catch (e) {
        // If encoding fails, just keep in memory cache
      }
    }
  }

  /// Get data from persistent cache
  Future<T?> _getFromPersistentCache<T>(String key) async {
    final jsonString = _prefs.getString('$_cachePrefix$key');
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString);
      final expiry = DateTime.fromMillisecondsSinceEpoch(json['expiry']);
      
      if (DateTime.now().isAfter(expiry)) {
        await _prefs.remove('$_cachePrefix$key');
        return null;
      }

      final data = json['data'];
      _memoryCache[key] = CachedData(data, expiry);
      return data as T;
    } catch (e) {
      await _prefs.remove('$_cachePrefix$key');
      return null;
    }
  }

  /// Clear specific cache entry
  Future<void> clearCache(String key) async {
    _memoryCache.remove(key);
    await _prefs.remove('$_cachePrefix$key');
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    _memoryCache.clear();
    final keys = _prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }

  /// Clean expired cache entries
  Future<void> _cleanExpiredCache() async {
    // Clean memory cache
    _memoryCache.removeWhere((key, value) => value.isExpired);

    // Clean persistent cache
    final keys = _prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
    for (final key in keys) {
      final jsonString = _prefs.getString(key);
      if (jsonString != null) {
        try {
          final json = jsonDecode(jsonString);
          final expiry = DateTime.fromMillisecondsSinceEpoch(json['expiry']);
          if (DateTime.now().isAfter(expiry)) {
            await _prefs.remove(key);
          }
        } catch (e) {
          await _prefs.remove(key);
        }
      }
    }
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'memoryCacheSize': _memoryCache.length,
      'totalCacheKeys': _prefs.getKeys().where((key) => key.startsWith(_cachePrefix)).length,
      'memoryItems': _memoryCache.keys.toList(),
    };
  }
}

class CachedData {
  final dynamic data;
  final DateTime expiry;

  CachedData(this.data, this.expiry);

  bool get isExpired => DateTime.now().isAfter(expiry);
}

// Extension for easy access
extension CacheServiceExt on GetInterface {
  CacheService get cache => Get.find<CacheService>();
}