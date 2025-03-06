import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

/// Combined bottom sheet which shows photos and (optionally) NFTs in one widget.
Future<T?> ImagePickerCombinedBottomSheet<T>(
    BuildContext context, {
      required bool includeNFTs,
      // onImageTap receives: album, photo (AssetEntity) and nft (MediaDatePair) (if applicable)
      required Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap,
      Function(List<AssetEntity> selectedPhotos)? onPop,
    }) {
  return BitNetBottomSheet<T>(
    context: context,
    width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height * 0.7,
    child: ImagePickerCombined(
      includeNFTs: includeNFTs,
      onImageTap: onImageTap,
      onPop: onPop,
    ),
  );
}

/// The combined widget for picking images (and NFTs).
class ImagePickerCombined extends StatefulWidget {
  final bool includeNFTs;
  final Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap;
  final Function(List<AssetEntity> selectedPhotos)? onPop;
  const ImagePickerCombined({
    Key? key,
    this.includeNFTs = false,
    this.onImageTap,
    this.onPop,
  }) : super(key: key);

  @override
  State<ImagePickerCombined> createState() => _ImagePickerCombinedState();
}

class _ImagePickerCombinedState extends State<ImagePickerCombined> {
  bool selectingPhotos = true;
  List<AssetPathEntity>? albums;
  AssetPathEntity? currentAlbum;
  List<AssetEntity>? currentPhotos = List.empty(growable: true);
  List<AssetEntity>? albumThumbnails;
  List<AssetEntity> selectedPhotos = List.empty(growable: true);
  bool loading = true;
  bool loadedThumbnails = false;
  bool loadingMoreImages = false;

  // NFT-specific variables (initialized only if includeNFTs is true)
  int currentView = 0; // e.g., 0 for mixed view, -1 for NFT-only, 1 for album view
  List<MediaDatePair>? currentNFTs;
  List<dynamic>? mixedList;
  bool loadedFullList = false;
  int loads = 0;
  late ScrollController imgScrollController;
  ProfileController? profileController; // only needed when NFTs are enabled

  // Performance tracking
  final Stopwatch _loadTimer = Stopwatch();

  @override
  void initState() {
    super.initState();
    imgScrollController = ScrollController();
    imgScrollController.addListener(_scrollListener);

    if (widget.includeNFTs) {
      profileController = Get.find<ProfileController>();
      currentNFTs = List.empty(growable: true);
      mixedList = List.empty(growable: true);
    }

    loadData();
  }

  @override
  void dispose() {
    imgScrollController.removeListener(_scrollListener);
    imgScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (imgScrollController.position.pixels >=
        imgScrollController.position.maxScrollExtent &&
        !loadingMoreImages) {
      loadingMoreImages = true;
      setState(() {});
      await loadMoreImages();
      loadingMoreImages = false;
      if (mounted) setState(() {});
    }
  }

  /// Loads albums and initial photos in an optimized way.
  /// If NFTs are enabled, it loads them after photos are displayed.
  void loadData() async {
    final logger = Get.find<LoggerService>();
    _loadTimer.start();

    // Always load albums and photos first for better initial performance
    albums = await BitnetPhotoManager.loadAlbums();
    logger.i("Album loading took: ${_loadTimer.elapsedMilliseconds}ms");

    currentAlbum = albums!.first;
    currentPhotos = await BitnetPhotoManager.loadImages(currentAlbum!, 0, 50);
    logger.i("Photo loading took: ${_loadTimer.elapsedMilliseconds - _loadTimer.elapsedMilliseconds}ms");

    // Update UI with photos first before loading NFTs
    loading = false;
    setState(() {});

    // If NFTs are needed, load them separately after photos are displayed
    if (widget.includeNFTs && profileController != null) {
      _loadNFTs();
    }
  }

  /// Separate function to load NFTs to prevent blocking the UI
  Future<void> _loadNFTs() async {
    final logger = Get.find<LoggerService>();
    Stopwatch nftTimer = Stopwatch()..start();

    if (profileController!.assets.isEmpty) {
      await profileController!.fetchTaprootAssetsAsync();
    }
    logger.i("NFT asset fetching took: ${nftTimer.elapsedMilliseconds}ms");

    List<Asset> metaList = profileController!.assets.value as List<Asset>;
    List<MediaDatePair> nfts = List.empty(growable: true);

    for (int i = 0; i < metaList.length && i < 50; i++) {
      if (i == metaList.length - 1) {
        loadedFullList = true;
      }
      MediaDatePair pair = MediaDatePair(
        assetId: metaList[i].assetGenesis!.assetId ?? '',
        date: profileController!.originalBlockDate.add(
          Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0))),
        ),
      );
      nfts.add(pair);
    }

    currentNFTs = nfts;
    mixedList = [];
    mixedList!.addAll(currentPhotos!);
    mixedList!.addAll(currentNFTs!);

    // Sort only what's needed initially (memoize the sorting)
    mixedList!.sort(compareMixedList);
    if (!loadedFullList && mixedList!.length > 50) {
      mixedList!.removeRange(50, mixedList!.length);
    }

    loads++;
    logger.i("NFT processing took: ${nftTimer.elapsedMilliseconds}ms");

    if (mounted) setState(() {});
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

    if (!widget.includeNFTs || profileController == null) {
      // Standard photo loading path - faster without NFTs
      int albumAssetCount = await currentAlbum!.assetCountAsync;
      int start = currentPhotos!.length;
      int end = (currentPhotos!.length + 50) > albumAssetCount
          ? albumAssetCount
          : currentPhotos!.length + 50;

      if (currentPhotos!.length == albumAssetCount) return;

      List<AssetEntity> photos = await BitnetPhotoManager.loadImages(currentAlbum!, start, end);
      currentPhotos!.addAll(photos);
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

    if (currentView > 0) {
      // Album view - load only photos
      int albumAssetCount = await currentAlbum!.assetCountAsync;
      int start = currentPhotos!.length;
      int end = (currentPhotos!.length + 50) > albumAssetCount
          ? albumAssetCount
          : currentPhotos!.length + 50;

      if (currentPhotos!.length == albumAssetCount) return;

      List<AssetEntity> photos = await BitnetPhotoManager.loadImages(currentAlbum!, start, end);
      currentPhotos!.addAll(photos);
    } else if (currentView == 0) {
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
    int albumAssetCount = await currentAlbum!.assetCountAsync;
    int start = loads * 50;
    int end = ((loads * 50) + 50) > albumAssetCount
        ? albumAssetCount
        : ((loads * 50) + 50);

    if (end == albumAssetCount) {
      loadedFullList = true;
    }

    List<AssetEntity> photos = [];
    if (currentPhotos!.length != albumAssetCount) {
      photos = await BitnetPhotoManager.loadImages(currentAlbum!, start, end);
    }

    // Load more NFTs
    List<MediaDatePair> nfts = await _fetchMoreNFTs(loads * 50, (loads * 50) + 50);

    // Update all collections
    currentNFTs!.addAll(nfts);
    currentPhotos!.addAll(photos);

    // Rebuild mixed list efficiently
    mixedList!.clear();
    mixedList!.addAll(currentPhotos!);
    mixedList!.addAll(currentNFTs!);
    mixedList!.sort(compareMixedList);

    if (!loadedFullList) {
      int removeIndex = currentPhotos!.length > currentNFTs!.length
          ? currentNFTs!.length
          : currentPhotos!.length;

      if (mixedList!.length > removeIndex) {
        mixedList!.removeRange(removeIndex, mixedList!.length);
      }
    }

    loads++;
  }

  /// Helper method to load more NFTs only
  Future<void> _loadMoreNFTs() async {
    List<MediaDatePair> nfts = await _fetchMoreNFTs(loads * 50, (loads + 1) * 50);
    currentNFTs!.addAll(nfts);
    loads++;
  }

  /// Helper method to fetch NFT data in a specific range
  Future<List<MediaDatePair>> _fetchMoreNFTs(int start, int end) async {
    List<Asset> metaList = profileController!.assets.value as List<Asset>;
    List<MediaDatePair> nfts = List.empty(growable: true);

    for (int i = start; i < metaList.length && i < end; i++) {
      if (i == metaList.length - 1) {
        loadedFullList = true;
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
    // Check if metadata already exists in cache
    if (profileController!.assetMetaMap[assetId] != null) {
      await _applyExistingMetaData(assetId, pair);
    } else {
      await _fetchAndApplyMetaData(assetId, pair);
    }
  }

  /// Helper to apply metadata that already exists in cache
  Future<void> _applyExistingMetaData(String assetId, MediaDatePair pair) async {
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
    if (mixedList != null) {
      index = mixedList!.indexWhere((test) =>
      (test is MediaDatePair &&
          test.media == null &&
          test.assetId == pair.assetId));

      if (index != -1) {
        (mixedList![index] as MediaDatePair).setMedia(media);
      }
    }

    // Find in NFTs list only once
    int indexNft = -1;
    if (currentNFTs != null) {
      indexNft = currentNFTs!.indexWhere((test) =>
      (test.media == null && test.assetId == pair.assetId));

      if (indexNft != -1) {
        currentNFTs![indexNft].setMedia(media);
      }
    }
  }

  /// Helper to check if we need to load more items
  bool _needToLoadMoreItems() {
    if (currentView == 0) {
      return mixedList != null && mixedList!.length < 9;
    } else {
      return currentNFTs != null && currentNFTs!.length < 9;
    }
  }

  /// Helper to trigger loading more items
  Future<void> _triggerLoadMore() async {
    loadingMoreImages = true;
    if (mounted) setState(() {});
    await loadMoreImages();
    loadingMoreImages = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Optimize album thumbnail loading
    if (!selectingPhotos && !loadedThumbnails && albums != null) {
      albumThumbnails = null;
      BitnetPhotoManager.loadAlbumThumbnails(albums!).then((value) {
        loadedThumbnails = true;
        albumThumbnails = value;
        if (mounted) setState(() {});
      });
    }

    if (albums == null || currentPhotos == null) {
      return Center(child: dotProgress(context));
    }

    return PopScope(
      onPopInvoked: (bool _) {
        if (widget.onPop != null) widget.onPop!(selectedPhotos);
      },
      child: bitnetScaffold(
        context: context,
        appBar: bitnetAppBar(
          text: "Select Image",
          context: context,
          hasBackButton: false,
          onTap: () {
            context.pop();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LongButtonWidget(
              customWidth: AppTheme.cardPadding * 5.w,
              customHeight: AppTheme.cardPadding * 1.5,
              title: widget.includeNFTs && currentView < 0
                  ? "Assets"
                  : currentAlbum!.name,
              leadingIcon: Icon(
                selectingPhotos
                    ? Icons.arrow_drop_down_rounded
                    : Icons.arrow_drop_up_rounded,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              onTap: () {
                setState(() {
                  if (selectingPhotos) {
                    loadedThumbnails = false;
                    selectingPhotos = false;
                  } else {
                    selectingPhotos = true;
                  }
                  if (widget.includeNFTs) {
                    loads = 0;
                  }
                });
              },
              buttonType: ButtonType.transparent,
            ),
            SizedBox(height: AppTheme.elementSpacing),
            Expanded(
              child: widget.includeNFTs ? buildNFTGridView() : buildPhotoGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhotoGridView() {
    return GridView.builder(
      controller: imgScrollController,
      itemCount: loadingMoreImages
          ? ((currentPhotos!.length % 3) == 0
          ? currentPhotos!.length + 3
          : currentPhotos!.length + 3 + (currentPhotos!.length % 3))
          : currentPhotos!.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (ctx, i) {
        if (i < currentPhotos!.length) {
          final photo = currentPhotos![i];
          return InkWell(
            onTap: () {
              if (selectedPhotos.contains(photo)) {
                selectedPhotos.remove(photo);
              } else {
                selectedPhotos.add(photo);
              }
              if (widget.onImageTap != null) {
                widget.onImageTap!(currentAlbum, photo, null);
              }
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 4,
                    color: selectedPhotos.contains(photo)
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent),
              ),
              child: AssetEntityImage(
                photo,
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error, color: Colors.red)),
              ),
            ),
          );
        } else if (i ==
            currentPhotos!.length +
                (((currentPhotos!.length % 3) == 0
                    ? 3
                    : 3 + (currentPhotos!.length % 3)) -
                    2)) {
          return Container(width: 50, height: 50, child: Center(child: dotProgress(context)));
        } else {
          return Container(width: 50, height: 50, color: Colors.transparent);
        }
      },
    );
  }

  Widget buildNFTGridView() {
    if (currentNFTs == null || mixedList == null) {
      // Still loading NFTs
      return Center(child: dotProgress(context));
    }

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: (selectingPhotos)
          ? (currentView == 0
          ? MixedGridView(
        imgScrollController: imgScrollController,
        loadingMoreImages: loadingMoreImages,
        mixedList: mixedList!,
        widget: widget,
        current_album: currentAlbum,
        loadMetaLazyFunc: loadMetaLazy,
        forceRemove: (pair) {
          int removeIndex = mixedList!.indexWhere((test) =>
          (test is MediaDatePair &&
              test.media == null &&
              test.assetId == pair.assetId));
          if (removeIndex != -1) {
            mixedList!.removeAt(removeIndex);
          }
          int removeIndexNft = currentNFTs!.indexWhere((test) =>
          (test.media == null && test.assetId == pair.assetId));
          if (removeIndexNft != -1) {
            currentNFTs!.removeAt(removeIndexNft);
          }
          setState(() {});
        },
        onImageTap: widget.onImageTap,
      )
          : (currentView == -1
          ? NftGridView(
        imgScrollController: imgScrollController,
        onImageTap: widget.onImageTap,
        loadingMoreImages: loadingMoreImages,
        nfts: currentNFTs!,
        widget: widget,
        loadMetaLazyFunc: loadMetaLazy,
        forceRemove: (pair) {
          int removeIndex = mixedList!.indexWhere((test) =>
          (test is MediaDatePair &&
              test.media == null &&
              test.assetId == pair.assetId));
          if (removeIndex != -1) {
            mixedList!.removeAt(removeIndex);
          }
          int removeIndexNft = currentNFTs!.indexWhere((test) =>
          (test.media == null && test.assetId == pair.assetId));
          if (removeIndexNft != -1) {
            currentNFTs!.removeAt(removeIndexNft);
            Get.find<LoggerService>().i(
                "${pair.assetId} was removed from currentNFTs at $removeIndexNft");
          } else {
            Get.find<LoggerService>()
                .i("${pair.assetId} could not be removed from currentNFTs");
          }
          setState(() {});
        },
      )
          : ImgGridView(
        imgScrollController: imgScrollController,
        onImageTap: widget.onImageTap,
        loadingMoreImages: loadingMoreImages,
        current_photos: currentPhotos,
        widget: widget,
        current_album: currentAlbum,
      )))
          : (loadedThumbnails && albumThumbnails != null)
          ? buildAlbumView(context)
          : Center(child: dotProgress(context)),
    );
  }

  /// Separated album view building for cleaner code
  Widget buildAlbumView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Assets container
          GestureDetector(
            onTap: () async {
              selectingPhotos = true;
              currentPhotos = List.empty(growable: true);
              currentNFTs = List.empty(growable: true);
              mixedList = List.empty(growable: true);
              loading = true;
              currentView = -1;
              setState(() {});
              await loadMoreImages();
              loading = false;
              setState(() {});
            },
            child: GlassContainer(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.elementSpacing),
                    Text('Your Assets', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: AppTheme.elementSpacing),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Expanded(
                            child: Container(
                              width: AppTheme.cardPadding * 4,
                              height: AppTheme.cardPadding * 4,
                              color: (currentNFTs![i].media == null) ? Colors.grey : Colors.transparent,
                              child: (currentNFTs![i].media == null)
                                  ? null
                                  : ImageBuilder(
                                radius: BorderRadius.zero,
                                encodedData: currentNFTs![i].media!.data,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                )
            ),
          ),

          const SizedBox(height: AppTheme.cardPadding),

          // Albums grid
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: albums!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () async {
                  currentAlbum = albums![i];
                  selectingPhotos = true;
                  currentPhotos = List.empty(growable: true);
                  currentNFTs = List.empty(growable: true);
                  mixedList = List.empty(growable: true);
                  currentView = 1;
                  loading = true;
                  setState(() {});
                  await loadMoreImages();
                  loading = false;
                  setState(() {});
                },
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 135,
                        height: 135,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(16),
                          child: AssetEntityImage(
                            albumThumbnails![i],
                            isOriginal: false,
                            fit: BoxFit.cover,
                            thumbnailSize: const ThumbnailSize.square(360),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppTheme.elementSpacing / 2,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          albums![i].name,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// --- Sub-widgets used for grid views ---

class ImgGridView extends StatelessWidget {
  const ImgGridView({
    Key? key,
    required this.imgScrollController,
    required this.loadingMoreImages,
    required this.current_photos,
    required this.widget,
    required this.current_album,
    this.onImageTap,
  }) : super(key: key);

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List<AssetEntity>? current_photos;
  final ImagePickerCombined widget;
  final AssetPathEntity? current_album;
  final Function(AssetPathEntity? album, AssetEntity? img, MediaDatePair? pair)? onImageTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: imgScrollController,
        itemCount: loadingMoreImages
            ? ((current_photos!.length % 3) == 0
            ? current_photos!.length + 3
            : current_photos!.length + 3 + (current_photos!.length % 3))
            : current_photos!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (ctx, i) {
          return (i < current_photos!.length)
              ? Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  if (onImageTap != null) {
                    onImageTap!(current_album, current_photos![i], null);
                  }
                },
                child: AssetEntityImage(
                  current_photos![i],
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(250),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stacktrace) {
                    return const Center(child: Icon(Icons.error, color: Colors.red));
                  },
                ),
              ))
              : (i ==
              current_photos!.length +
                  (((current_photos!.length % 3) == 0 ? 3 : 3 + (current_photos!.length % 3)) - 2))
              ? Container(width: 50, height: 50, child: Center(child: dotProgress(context)))
              : Container(width: 50, height: 50, color: Colors.transparent);
        });
  }
}

class NftGridView extends StatefulWidget {
  const NftGridView(
      {Key? key,
        required this.imgScrollController,
        required this.loadingMoreImages,
        required this.nfts,
        required this.widget,
        required this.loadMetaLazyFunc,
        required this.forceRemove,
        this.onImageTap})
      : super(key: key);

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List<MediaDatePair> nfts;
  final ImagePickerCombined widget;
  final Future<void> Function(String, MediaDatePair) loadMetaLazyFunc;
  final Function(MediaDatePair) forceRemove;
  final Function(AssetPathEntity? album, AssetEntity? img, MediaDatePair? pair)? onImageTap;

  @override
  State<NftGridView> createState() => _NftGridViewState();
}

class _NftGridViewState extends State<NftGridView> {
  late List<MediaDatePair> nfts;

  @override
  void initState() {
    nfts = widget.nfts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: widget.imgScrollController,
        itemCount: widget.loadingMoreImages
            ? ((nfts.length % 3) == 0
            ? nfts.length + 3
            : nfts.length + 3 + (nfts.length % 3))
            : nfts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (ctx, i) {
          return (i < nfts.length)
              ? Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  if (widget.onImageTap != null) {
                    widget.onImageTap!(null, null, nfts[i]);
                  }
                },
                child: LazyImageBuilder(
                  asset: nfts[i],
                  loadFunc: widget.loadMetaLazyFunc,
                  forceRemove: (MediaDatePair pair) {
                    widget.forceRemove(pair);
                    setState(() {});
                  },
                ),
              ))
              : (i ==
              nfts.length +
                  (((nfts.length % 3) == 0 ? 3 : nfts.length % 3 + 3) - 2))
              ? Container(width: 50, height: 50, child: Center(child: dotProgress(context)))
              : Container(width: 50, height: 50, color: Colors.transparent);
        });
  }
}

class MixedGridView extends StatefulWidget {
  const MixedGridView({
    Key? key,
    required this.imgScrollController,
    required this.loadingMoreImages,
    required this.mixedList,
    required this.widget,
    required this.current_album,
    required this.loadMetaLazyFunc,
    required this.forceRemove,
    this.onImageTap,
  }) : super(key: key);

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List mixedList;
  final ImagePickerCombined widget;
  final AssetPathEntity? current_album;
  final Future<void> Function(String, MediaDatePair) loadMetaLazyFunc;
  final Function(MediaDatePair) forceRemove;
  final Function(AssetPathEntity? album, AssetEntity? img, MediaDatePair? pair)? onImageTap;

  @override
  State<MixedGridView> createState() => _MixedGridViewState();
}

class _MixedGridViewState extends State<MixedGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: widget.imgScrollController,
        itemCount: widget.loadingMoreImages
            ? ((widget.mixedList.length % 3) == 0
            ? widget.mixedList.length + 3
            : widget.mixedList.length + 3 + (widget.mixedList.length % 3))
            : widget.mixedList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (ctx, i) {
          return (i < widget.mixedList.length)
              ? Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  if (widget.onImageTap != null) {
                    widget.onImageTap!(
                        widget.current_album,
                        widget.mixedList[i] is AssetEntity ? widget.mixedList[i] : null,
                        widget.mixedList[i] is MediaDatePair ? widget.mixedList[i] : null);
                  }
                },
                child: widget.mixedList[i] is AssetEntity
                    ? AssetEntityImage(
                  (widget.mixedList[i] as AssetEntity),
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(250),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stacktrace) {
                    return const Center(child: Icon(Icons.error, color: Colors.red));
                  },
                )
                    : LazyImageBuilder(
                  key: ValueKey(widget.mixedList[i].assetId),
                  asset: widget.mixedList[i],
                  loadFunc: widget.loadMetaLazyFunc,
                  forceRemove: (MediaDatePair pair) {
                    widget.forceRemove(pair);
                    setState(() {});
                  },
                ),
              ))
              : (i ==
              widget.mixedList.length +
                  (((widget.mixedList.length % 3) == 0 ? 3 : 3 + (widget.mixedList.length % 3)) - 2))
              ? Container(width: 50, height: 50, child: Center(child: dotProgress(context)))
              : Container(width: 50, height: 50, color: Colors.transparent);
        });
  }
}

class LazyImageBuilder extends StatefulWidget {
  final MediaDatePair asset;
  final Future<void> Function(String, MediaDatePair) loadFunc;
  final Function(MediaDatePair pair) forceRemove;
  const LazyImageBuilder({Key? key, required this.asset, required this.loadFunc, required this.forceRemove}) : super(key: key);

  @override
  State<LazyImageBuilder> createState() => _LazyImageBuilderState();
}

class _LazyImageBuilderState extends State<LazyImageBuilder> {
  late LoggerService logger;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    logger = Get.find<LoggerService>();

    // Schedule loading as soon as the widget is built
    if (!widget.asset.isLoading && !widget.asset.loaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) load();
      });
    }
  }

  Future<void> load() async {
    if (widget.asset.media == null && !_isLoading) {
      _isLoading = true;
      widget.asset.isLoading = true;
      logger.i("asset: ${widget.asset.assetId} is loading");

      try {
        await widget.loadFunc(widget.asset.assetId, widget.asset);
        widget.asset.isLoading = false;
        widget.asset.loaded = true;

        if (widget.asset.media == null) {
          widget.forceRemove(widget.asset);
          logger.i("${widget.asset.assetId} was queued for removal");
        } else {
          logger.i("asset: ${widget.asset.assetId} is loaded");
        }

        if (mounted) setState(() {});
      } catch (e) {
        logger.i("${widget.asset.assetId} has errored: $e");
        widget.asset.loaded = true;
        widget.asset.isLoading = false;
        widget.forceRemove(widget.asset);

        if (mounted) setState(() {});
      } finally {
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we need to load (but not already loading)
    if (!widget.asset.isLoading && !widget.asset.loaded && !_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) load();
      });
    }

    return (widget.asset.media == null)
        ? GestureDetector(
      onTap: () async {
        await load();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(color: Colors.grey),
        child: widget.asset.isLoading ? Center(child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
        )) : null,
      ),
    )
        : ImageBuilder(
      encodedData: widget.asset.media!.data,
    );
  }
}

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