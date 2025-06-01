import 'dart:async';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

/// Controller responsible for managing the image picker functionality
class ImagePickerController extends GetxController {
  // Albums and Photos
  final Rx<List<AssetPathEntity>> albums = Rx<List<AssetPathEntity>>([]);
  final Rx<AssetPathEntity?> currentAlbum = Rx<AssetPathEntity?>(null);
  final RxList<AssetEntity> currentPhotos = RxList<AssetEntity>([]);
  final RxList<AssetEntity> selectedPhotos = RxList<AssetEntity>([]);
  final RxList<AssetEntity> albumThumbnails = RxList<AssetEntity>([]);
  
  // State tracking
  final RxBool selectingPhotos = true.obs;
  final RxBool loading = true.obs;
  final RxBool loadedThumbnails = false.obs;
  final RxBool loadingMoreImages = false.obs;
  
  // NFT-specific variables
  final RxInt currentView = 0.obs; // 0 for mixed view, -1 for NFT-only, 1 for album view
  final RxList<MediaDatePair> currentNFTs = RxList<MediaDatePair>([]);
  final RxList<dynamic> mixedList = RxList<dynamic>([]);
  final RxBool loadedFullList = false.obs;
  final RxInt loads = 0.obs;
  
  // Scroll controller for pagination
  late ScrollController imgScrollController;
  ProfileController? profileController;
  
  // Performance tracking
  final Stopwatch _loadTimer = Stopwatch();
  
  // Options
  bool includeNFTs = false;
  Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap;
  Function(List<AssetEntity> selectedPhotos)? onPop;
  
  @override
  void onInit() {
    super.onInit();
    imgScrollController = ScrollController();
    imgScrollController.addListener(_scrollListener);
  }
  
  @override
  void onClose() {
    imgScrollController.removeListener(_scrollListener);
    imgScrollController.dispose();
    super.onClose();
  }
  
  /// Initialize the controller with specific options
  void initialize({
    required bool includeNFTs,
    Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap,
    Function(List<AssetEntity> selectedPhotos)? onPop,
  }) {
    this.includeNFTs = includeNFTs;
    this.onImageTap = onImageTap;
    this.onPop = onPop;
    
    // Safe ProfileController access - only get it if available
    if (includeNFTs) {
      try {
        profileController = Get.find<ProfileController>();
        final logger = Get.find<LoggerService>();
        logger.i("✅ ProfileController found for NFT functionality");
        print("✅ ProfileController found for NFT functionality");
      } catch (e) {
        final logger = Get.find<LoggerService>();
        logger.w("⚠️ ProfileController not available during registration, NFT features will be disabled");
        print("⚠️ ProfileController not available during registration, NFT features will be disabled");
        profileController = null;
        // This allows the UI to work without crashing during registration
        // NFT features will be gracefully disabled
      }
    }
    
    loadData();
  }
  
  void _scrollListener() async {
    if (imgScrollController.position.pixels >=
        imgScrollController.position.maxScrollExtent &&
        !loadingMoreImages.value) {
      loadingMoreImages.value = true;
      await loadMoreImages();
      loadingMoreImages.value = false;
    }
  }
  
  /// Loads albums and initial photos in an optimized way.
  /// If NFTs are enabled, it loads them after photos are displayed.
  void loadData() async {
    final logger = Get.find<LoggerService>();
    _loadTimer.start();
    
    // Always load albums and photos first for better initial performance
    final loadedAlbums = await BitnetPhotoManager.loadAlbums();
    albums.value = loadedAlbums;
    logger.i("Album loading took: ${_loadTimer.elapsedMilliseconds}ms");
    
    currentAlbum.value = albums.value.first;
    currentPhotos.value = await BitnetPhotoManager.loadImages(currentAlbum.value!, 0, 50);
    logger.i("Photo loading took: ${_loadTimer.elapsedMilliseconds}ms");
    
    // Update UI with photos first before loading NFTs
    loading.value = false;
    
    // If NFTs are needed, load them separately after photos are displayed
    if (includeNFTs && profileController != null) {
      _loadNFTs();
    }
  }
  
  /// Separate function to load NFTs to prevent blocking the UI
  Future<void> _loadNFTs() async {
    final logger = Get.find<LoggerService>();
    Stopwatch nftTimer = Stopwatch()..start();
    
    // Safe check for ProfileController availability
    if (profileController == null) {
      logger.w("ProfileController not available, skipping NFT loading");
      return;
    }
    
    if (profileController!.assets.isEmpty) {
      await profileController!.fetchTaprootAssetsAsync();
    }
    logger.i("NFT asset fetching took: ${nftTimer.elapsedMilliseconds}ms");
    
    List<Asset> metaList = profileController!.assets.value as List<Asset>;
    List<MediaDatePair> nfts = [];
    
    for (int i = 0; i < metaList.length && i < 50; i++) {
      if (i == metaList.length - 1) {
        loadedFullList.value = true;
      }
      MediaDatePair pair = MediaDatePair(
        assetId: metaList[i].assetGenesis!.assetId ?? '',
        date: profileController!.originalBlockDate.add(
          Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0))),
        ),
      );
      nfts.add(pair);
    }
    
    currentNFTs.value = nfts;
    mixedList.clear();
    mixedList.addAll(currentPhotos);
    mixedList.addAll(currentNFTs);
    
    // Sort only what's needed initially (memoize the sorting)
    mixedList.sort(compareMixedList);
    if (!loadedFullList.value && mixedList.length > 50) {
      mixedList.removeRange(50, mixedList.length);
    }
    
    loads.value++;
    logger.i("NFT processing took: ${nftTimer.elapsedMilliseconds}ms");
  }
  
  /// Compares AssetEntity and MediaDatePair items by their date.
  int compareMixedList(dynamic a, dynamic b) {
    DateTime dateA = a is AssetEntity ? a.modifiedDateTime : (a as MediaDatePair).date;
    DateTime dateB = b is AssetEntity ? b.modifiedDateTime : (b as MediaDatePair).date;
    return dateB.compareTo(dateA); // newest first
  }
  
  /// Loads more images (and NFT data if applicable), optimized to minimize UI blocking.
  Future<void> loadMoreImages() async {
    final logger = Get.find<LoggerService>();
    Stopwatch loadMoreTimer = Stopwatch()..start();
    
    if (!includeNFTs || profileController == null) {
      // Standard photo loading path - faster without NFTs
      int albumAssetCount = await currentAlbum.value!.assetCountAsync;
      int start = currentPhotos.length;
      int end = (currentPhotos.length + 50) > albumAssetCount
          ? albumAssetCount
          : currentPhotos.length + 50;
      
      if (currentPhotos.length == albumAssetCount) return;
      
      List<AssetEntity> photos = await BitnetPhotoManager.loadImages(currentAlbum.value!, start, end);
      currentPhotos.addAll(photos);
      logger.i("Loaded more photos in: ${loadMoreTimer.elapsedMilliseconds}ms");
    } else {
      // NFT mode with optimization based on current view
      await _loadMoreBasedOnView();
      logger.i("Loaded more mixed content in: ${loadMoreTimer.elapsedMilliseconds}ms");
    }
  }
  
  /// Helper method to load more content based on current view mode
  Future<void> _loadMoreBasedOnView() async {
    final logger = Get.find<LoggerService>();
    
    if (currentView.value > 0) {
      // Album view - load only photos
      int albumAssetCount = await currentAlbum.value!.assetCountAsync;
      int start = currentPhotos.length;
      int end = (currentPhotos.length + 50) > albumAssetCount
          ? albumAssetCount
          : currentPhotos.length + 50;
      
      if (currentPhotos.length == albumAssetCount) return;
      
      List<AssetEntity> photos = await BitnetPhotoManager.loadImages(currentAlbum.value!, start, end);
      currentPhotos.addAll(photos);
    } else if (currentView.value == 0) {
      // Mixed view - load both photos and NFTs efficiently
      await _loadMoreMixedContent();
    } else {
      // NFT-only view
      await _loadMoreNFTs();
    }
  }
  
  /// Helper method to load more mixed content (photos + NFTs)
  Future<void> _loadMoreMixedContent() async {
    final logger = Get.find<LoggerService>();
    
    // Load more photos
    int albumAssetCount = await currentAlbum.value!.assetCountAsync;
    int start = loads.value * 50;
    int end = ((loads.value * 50) + 50) > albumAssetCount
        ? albumAssetCount
        : ((loads.value * 50) + 50);
    
    if (end == albumAssetCount) {
      loadedFullList.value = true;
    }
    
    List<AssetEntity> photos = [];
    if (currentPhotos.length != albumAssetCount) {
      photos = await BitnetPhotoManager.loadImages(currentAlbum.value!, start, end);
    }
    
    // Load more NFTs
    List<MediaDatePair> nfts = await _fetchMoreNFTs(loads.value * 50, (loads.value * 50) + 50);
    
    // Update all collections
    currentNFTs.addAll(nfts);
    currentPhotos.addAll(photos);
    
    // Rebuild mixed list efficiently
    mixedList.clear();
    mixedList.addAll(currentPhotos);
    mixedList.addAll(currentNFTs);
    mixedList.sort(compareMixedList);
    
    if (!loadedFullList.value) {
      int removeIndex = currentPhotos.length > currentNFTs.length
          ? currentNFTs.length
          : currentPhotos.length;
      
      if (mixedList.length > removeIndex) {
        mixedList.removeRange(removeIndex, mixedList.length);
      }
    }
    
    loads.value++;
  }
  
  /// Helper method to load more NFTs only
  Future<void> _loadMoreNFTs() async {
    List<MediaDatePair> nfts = await _fetchMoreNFTs(loads.value * 50, (loads.value + 1) * 50);
    currentNFTs.addAll(nfts);
    loads.value++;
  }
  
  /// Helper method to fetch NFT data in a specific range
  Future<List<MediaDatePair>> _fetchMoreNFTs(int start, int end) async {
    // Safe check for ProfileController availability
    if (profileController == null) {
      print("ProfileController not available, returning empty NFT list");
      return [];
    }
    
    List<Asset> metaList = profileController!.assets.value as List<Asset>;
    List<MediaDatePair> nfts = [];
    
    for (int i = start; i < metaList.length && i < end; i++) {
      if (i == metaList.length - 1) {
        loadedFullList.value = true;
      }
      
      MediaDatePair pair = MediaDatePair(
        assetId: metaList[i].assetGenesis!.assetId ?? '',
        date: profileController!.originalBlockDate.add(
          Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0))),
        ),
      );
      
      nfts.add(pair);
    }
    
    return nfts;
  }
  
  /// Lazy loads NFT meta data with optimized state management.
  Future<void> loadMetaLazy(String assetId, MediaDatePair pair) async {
    // Safe check for ProfileController availability
    if (profileController == null) {
      print("ProfileController not available, skipping meta loading for asset: $assetId");
      return;
    }
    
    // Check if metadata already exists in cache
    if (profileController!.assetMetaMap[assetId] != null) {
      await _applyExistingMetaData(assetId, pair);
    } else {
      await _fetchAndApplyMetaData(assetId, pair);
    }
  }
  
  /// Helper to apply metadata that already exists in cache
  Future<void> _applyExistingMetaData(String assetId, MediaDatePair pair) async {
    // Safe check for ProfileController availability
    if (profileController == null) {
      print("ProfileController not available, skipping existing meta data apply");
      return;
    }
    
    Media? media = profileController!.assetMetaMap[assetId]!
        .toMedias()
        .where((test) =>
    test.type == "image" ||
        test.type == "image_data" ||
        test.type == "camera")
        .firstOrNull;
    
    if (media != null) {
      // Apply media to both collections without redundant searches
      _applyMediaToPair(pair, media);
    } else if (_needToLoadMoreItems()) {
      await _triggerLoadMore();
    }
  }
  
  /// Helper to fetch and apply new metadata
  Future<void> _fetchAndApplyMetaData(String assetId, MediaDatePair pair) async {
    // Safe check for ProfileController availability
    if (profileController == null) {
      print("ProfileController not available, skipping meta data fetch");
      return;
    }
    
    AssetMetaResponse? meta = await profileController!.loadMetaAsset(assetId);
    
    if (meta == null) {
      if (_needToLoadMoreItems()) {
        await _triggerLoadMore();
      }
      return;
    }
    
    Media? media = meta
        .toMedias()
        .where((test) =>
    test.type == "image" ||
        test.type == "image_data" ||
        test.type == "camera")
        .firstOrNull;
    
    if (media != null) {
      _applyMediaToPair(pair, media);
    } else if (_needToLoadMoreItems()) {
      await _triggerLoadMore();
    }
  }
  
  /// Helper to apply media to a pair in both collections
  void _applyMediaToPair(MediaDatePair pair, Media media) {
    // Find in mixed list only once
    int index = -1;
    if (mixedList.isNotEmpty) {
      index = mixedList.indexWhere((test) =>
      (test is MediaDatePair &&
          test.media == null &&
          test.assetId == pair.assetId));
      
      if (index != -1) {
        (mixedList[index] as MediaDatePair).setMedia(media);
      }
    }
    
    // Find in NFTs list only once
    int indexNft = -1;
    if (currentNFTs.isNotEmpty) {
      indexNft = currentNFTs.indexWhere((test) =>
      (test.media == null && test.assetId == pair.assetId));
      
      if (indexNft != -1) {
        currentNFTs[indexNft].setMedia(media);
      }
    }
  }
  
  /// Helper to check if we need to load more items
  bool _needToLoadMoreItems() {
    if (currentView.value == 0) {
      return mixedList.isNotEmpty && mixedList.length < 9;
    } else {
      return currentNFTs.isNotEmpty && currentNFTs.length < 9;
    }
  }
  
  /// Helper to trigger loading more items
  Future<void> _triggerLoadMore() async {
    loadingMoreImages.value = true;
    await loadMoreImages();
    loadingMoreImages.value = false;
  }
  
  /// Helper method to load album thumbnails
  Future<void> loadAlbumThumbnails() async {
    if (loadedThumbnails.value || albums.value.isEmpty) return;
    
    albumThumbnails.value = await BitnetPhotoManager.loadAlbumThumbnails(albums.value);
    loadedThumbnails.value = true;
  }
  
  /// Switch to album selection view
  void switchToAlbumView() {
    // Force immediate state change
    selectingPhotos.value = false;
    
    // Reset thumbnail loading state and load them
    loadedThumbnails.value = false;
    
    // Load the thumbnails if they're not already loaded
    if (albumThumbnails.isEmpty) {
      // Make sure we have albums loaded
      if (albums.value.isEmpty) {
        // This shouldn't happen but just in case
        loadData();
      } else {
        loadAlbumThumbnails();
      }
    } else {
      // If thumbnails are already loaded, just mark them as loaded
      loadedThumbnails.value = true;
    }
    
    if (includeNFTs) {
      loads.value = 0;
    }
  }
  
  /// Switch to photo selection view
  void switchToPhotoView() {
    selectingPhotos.value = true;
  }
  
  /// Select an album and load its images
  Future<void> selectAlbum(AssetPathEntity album) async {
    currentAlbum.value = album;
    selectingPhotos.value = true;
    currentPhotos.clear();
    
    if (includeNFTs) {
      currentNFTs.clear();
      mixedList.clear();
      currentView.value = 1;
    }
    
    loading.value = true;
    await loadMoreImages();
    loading.value = false;
  }
  
  /// Switch to NFT view
  Future<void> switchToNftView() async {
    selectingPhotos.value = true;
    currentPhotos.clear();
    currentNFTs.clear();
    mixedList.clear();
    loading.value = true;
    currentView.value = -1;
    await loadMoreImages();
    loading.value = false;
  }
  
  /// Toggle photo selection
  void togglePhotoSelection(AssetEntity photo) {
    if (selectedPhotos.contains(photo)) {
      selectedPhotos.remove(photo);
    } else {
      selectedPhotos.add(photo);
    }
  }
  
  /// Helper to remove an NFT from the lists
  void removeNftFromLists(MediaDatePair pair) {
    int removeIndex = mixedList.indexWhere((test) =>
    (test is MediaDatePair &&
        test.media == null &&
        test.assetId == pair.assetId));
        
    if (removeIndex != -1) {
      mixedList.removeAt(removeIndex);
    }
    
    int removeIndexNft = currentNFTs.indexWhere((test) =>
    (test.media == null && test.assetId == pair.assetId));
    
    if (removeIndexNft != -1) {
      currentNFTs.removeAt(removeIndexNft);
      Get.find<LoggerService>().i(
          "${pair.assetId} was removed from currentNFTs at $removeIndexNft");
    } else {
      Get.find<LoggerService>()
          .i("${pair.assetId} could not be removed from currentNFTs");
    }
  }
}

/// Data model for media items with dates
class MediaDatePair {
  Media? media;
  final String assetId;
  final DateTime date;
  bool isLoading = false;
  bool loaded = false;
  
  MediaDatePair({required this.assetId, this.media, required this.date});
  
  void setMedia(Media media) {
    this.media = media;
  }
}

/// Utility class for photo management operations
class BitnetPhotoManager {
  // Cache to store already requested permissions
  static bool _permissionRequested = false;
  static PermissionState? _cachedPermissionState;
  
  static Future<List<AssetPathEntity>> loadAlbums() async {
    try {
      print('Requesting permissions...');
      
      // Use cached permission if available
      PermissionState permissionState;
      if (_permissionRequested && _cachedPermissionState != null) {
        permissionState = _cachedPermissionState!;
        print('Using cached permission state: $permissionState');
      } else {
        permissionState = await PhotoManager.requestPermissionExtend(
          requestOption: const PermissionRequestOption(
            iosAccessLevel: IosAccessLevel.readWrite,
            androidPermission: AndroidPermission(
              type: RequestType.image,
              mediaLocation: true,
            ),
          ),
        );
        // Cache the permission result
        _permissionRequested = true;
        _cachedPermissionState = permissionState;
        print('Permission state: $permissionState');
      }
      
      if (permissionState.isAuth) {
        print('Permissions granted.');
        print('Fetching asset path list...');
        List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(type: RequestType.image);
        print('Number of albums loaded: ${albums.length}');
        return albums;
      } else if (permissionState == PermissionState.limited) {
        print("Limited access granted");
        return PhotoManager.getAssetPathList(type: RequestType.image);
      } else {
        print("No access granted");
        await PhotoManager.openSetting();
        return [];
      }
    } catch (e) {
      print('Error while loading albums: $e');
      throw Exception('Failed to load albums: $e');
    }
  }
  
  static Future<List<AssetEntity>> loadImages(AssetPathEntity selectedAlbum, int start, int end) async {
    try {
      Stopwatch sw = Stopwatch()..start();
      print('Loading images from album: ${selectedAlbum.name}');
      print('Start index: $start, End index: $end');
      
      List<AssetEntity> imageList = await selectedAlbum.getAssetListRange(start: start, end: end);
      print('Loaded ${imageList.length} images in ${sw.elapsedMilliseconds}ms');
      
      return imageList;
    } catch (e) {
      print('Error while loading images: $e');
      throw Exception('Failed to load images from album: ${selectedAlbum.name}: $e');
    }
  }
  
  static Future<List<AssetEntity>> loadAlbumThumbnails(List<AssetPathEntity> albums) async {
    Stopwatch sw = Stopwatch()..start();
    List<AssetEntity> thumbnails = [];
    
    // Process albums in parallel for faster loading
    List<Future<void>> futures = [];
    
    for (var album in albums) {
      futures.add(
        () async {
          try {
            List<AssetEntity> assets = await album.getAssetListRange(start: 0, end: 1);
            if (assets.isNotEmpty) {
              thumbnails.add(assets[0]);
            }
          } catch (e) {
            print('Error loading thumbnail for album ${album.name}: $e');
          }
        }()
      );
    }
    
    await Future.wait(futures);
    print('Loaded ${thumbnails.length} album thumbnails in ${sw.elapsedMilliseconds}ms');
    
    return thumbnails;
  }
  
  static Future<int> getTotalAssetCount() async {
    try {
      final int count = await PhotoManager.getAssetCount();
      print('Total number of assets: $count');
      return count;
    } catch (e) {
      print('Error getting total asset count: $e');
      return 0;
    }
  }
}