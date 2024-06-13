import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
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
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

Future<T?> ImagePickerBottomSheet<T>(BuildContext context,
    {required Function(AssetPathEntity album, AssetEntity image)? onImageTap}) {
  return BitNetBottomSheet<T>(
      context: context,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: ImagePicker(
        onImageTap: onImageTap,
      ));
}

Future<T?> ImagePickerNftMixedBottomSheet<T>(BuildContext context,
    {required Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap}) {
  return BitNetBottomSheet<T>(
      context: context,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: ImagePickerNftMixed(
        onImageTap: onImageTap,
      ));
}

class ImagePicker extends StatefulWidget {
  final Function(AssetPathEntity album, AssetEntity image)? onImageTap;
  const ImagePicker({
    super.key,
    this.onImageTap,
  });

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  bool selecting_photos = true;
  List<AssetPathEntity>? albums = null;
  AssetPathEntity? current_album = null;
  List<AssetEntity>? current_photos = List.empty(growable: true);
  List<AssetEntity>? album_thumbnails = null;
  bool loading = true;
  bool loaded_thumbnails = false;
  bool loadingMoreImages = false;
  late ScrollController imgScrollController;
  @override
  void initState() {
    imgScrollController = ScrollController(keepScrollOffset: true);
    imgScrollController.addListener(()async {
      if (imgScrollController.position.pixels >= imgScrollController.position.maxScrollExtent && !loadingMoreImages) {
      loadingMoreImages = true;
      setState((){});
      await loadMoreImages();
      loadingMoreImages = false;
      setState((){});
    }
    });
    loadData();
    super.initState();
  }

  void loadData() async {
    List<AssetPathEntity> loadedAlbums = await BitnetPhotoManager.loadAlbums();
    List<AssetEntity> photos =
        await BitnetPhotoManager.loadImages(loadedAlbums[0], 0, 24);
    albums = loadedAlbums;
    current_album = albums![0];
    current_photos = photos;
    setState(() {});
  }
  Future<void> loadMoreImages() async {
    int albumAssetCount = await current_album!.assetCountAsync;
    int start = current_photos!.length;
    int end = (current_photos!.length + 24) > albumAssetCount ? albumAssetCount : (current_photos!.length + 24);
    if(current_photos!.length == albumAssetCount){
      return;
    }
    List<AssetEntity> photos = await BitnetPhotoManager.loadImages(current_album!, start, end);
    current_photos!.addAll(photos);
  }
  @override
  Widget build(BuildContext context) {
    if (selecting_photos == false && !loaded_thumbnails && albums != null) {
      album_thumbnails = null;

      BitnetPhotoManager.loadAlbumThumbnails(albums!).then((value) {
        loaded_thumbnails = true;
        album_thumbnails = value;
        setState(() {});
      });
    }
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.selectImageQrCode,
        context: context,
        hasBackButton: false,
        onTap: () {
          context.pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppTheme.cardPadding / 2,
          ),
          if (albums == null || current_photos == null)
            Center(child: dotProgress(context)),
          if (albums != null && current_photos != null) ...[
            TextButton(
              child: Row(
                children: [
                  Text(current_album!.name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18, decoration: TextDecoration.underline)),
                  Icon(
                      selecting_photos
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      color: Colors.white)
                ],
              ),
              onPressed: () {
                if (selecting_photos) {
                  loaded_thumbnails = false;
                  selecting_photos = false;
                } else {
                  selecting_photos = true;
                }
                setState(() {});
              },
            ),
            Divider(),
            SizedBox(
              height: AppTheme.cardPadding / 2,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: (current_photos == null)
                  ? Center(child: dotProgress(context))
                  : (selecting_photos)
                      ? GridView.builder(
                        controller: imgScrollController,
                          itemCount: loadingMoreImages ? ((current_photos!.length % 3) == 0 ? current_photos!.length + 3 :current_photos!.length + 3 + (current_photos!.length % 3) ) : current_photos!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          itemBuilder: (ctx, i) {
                            return (i < current_photos!.length ) ? Padding(
                                padding: EdgeInsets.all(0),
                                child: InkWell(
                                  onTap: () {
                                    if (widget.onImageTap != null) {
                                      widget.onImageTap!(
                                          current_album!, current_photos![i]);
                                    }
                                  },
                                  child: AssetEntityImage(
                                    current_photos![i],
                                    isOriginal: false,
                                    thumbnailSize: ThumbnailSize.square(250),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stacktrace) {
                                      return const Center(
                                          child: Icon(Icons.error,
                                              color: Colors.red));
                                    },
                                  ),
                                )) 
                                : 
                                (i == current_photos!.length + (((current_photos!.length % 3) == 0 ? 3 : 3 + (current_photos!.length % 3) ) - 2)) 
                                ? Container(width: 50, height: 50, child: Center(child: CircularProgressIndicator())) 
                                : Container(width: 50, height: 50, color: Colors.transparent);
                          })
                      : (loaded_thumbnails && album_thumbnails != null)
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: albums!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, i) {
                                return Padding(
                                    padding: EdgeInsets.all(16),
                                    child: InkWell(
                                      onTap: () {
                                        current_album = albums![i];
                                        selecting_photos = true;
                                        setState(() {});
                                      },
                                      child: Flexible(
                                        child: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 180,
                                                height: 150,
                                                child: ClipRRect(
                                                  clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: AssetEntityImage(
                                                    album_thumbnails![i],
                                                    isOriginal: false,
                                                    fit: BoxFit.cover,
                                                    thumbnailSize:
                                                        ThumbnailSize.square(360),
                                                  ),
                                                ),
                                              ),
                                              Text(albums![i].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            )
                          : Center(
                              child: dotProgress(context),
                            ),
            )
          ]
        ],
      ),
    );
  }
}


class ImagePickerNftMixed extends StatefulWidget {
  final Function(AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)? onImageTap;
  const ImagePickerNftMixed({
    super.key,
    this.onImageTap,
  });

  @override
  State<ImagePickerNftMixed> createState() => _ImagePickerNftMixedState();
}

class _ImagePickerNftMixedState extends State<ImagePickerNftMixed> {
  bool selecting_photos = true;
  List<AssetPathEntity>? albums = null;
  AssetPathEntity? current_album = null;
  dynamic current_view = 0;
  List<AssetEntity>? current_photos = List.empty(growable: true);
  List<MediaDatePair> current_nfts = List.empty(growable:true);
  List<dynamic> mixedList = List.empty(growable:true);
  List<AssetEntity>? album_thumbnails = null;
  bool loading = true;
  bool loaded_thumbnails = false;
  bool loadingMoreImages = false;
  bool loadedFullList = false; 
  late ScrollController imgScrollController;
  late ProfileController profileController;
  int loads = 0;
  @override
  void initState() {
    imgScrollController = ScrollController();
    profileController = Get.find<ProfileController>();
    imgScrollController.addListener(() async {
      if (imgScrollController.position.pixels >= imgScrollController.position.maxScrollExtent && !loadingMoreImages) {
      loadingMoreImages = true;
      setState((){});
      await loadMoreImages(current_view);
      loadingMoreImages = false;
      setState((){});
    }
    });
    loadData();
    super.initState();
  }
  Future<void> loadMetaLazy(String assetId,MediaDatePair pair)async {
    if(profileController.assetMetaMap[assetId] != null) {
      Media? media = profileController.assetMetaMap[assetId]!.toMedias().where((test) => 
      test.type == "image"
      || test.type == "image_data"
      || test.type == "camera" ).firstOrNull;


      if(media != null) {
      mixedList.where((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId)).firstOrNull?.setMedia(media);
      current_nfts.where((test) => ( test.media == null && test.assetId == pair.assetId)).firstOrNull?.setMedia(media);

      } else {
        // int removeIndex = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        // if(removeIndex != -1) {
        // mixedList.removeAt(removeIndex);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }
        // int removeIndexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));
        // if(removeIndexNft != -1) {
        //   current_nfts.removeAt(removeIndexNft);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }

        if(current_view == 0 ? mixedList.length < 9 :current_nfts.length < 9 ) {
loadingMoreImages = true;
      setState((){});
      await loadMoreImages(current_view);
      loadingMoreImages = false;
      setState((){});        
      }

      }
    } else {
      AssetMetaResponse? meta = await profileController.loadMetaAsset(assetId);
      if(meta == null) {
        // int removeIndex = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        // if(removeIndex != -1) {
        // mixedList.removeAt(removeIndex);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }
        // int removeIndexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));
        // if(removeIndexNft != -1) {
        //   current_nfts.removeAt(removeIndexNft);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }
         if(current_view == 0 ? mixedList.length < 9 :current_nfts.length < 9 ) {
loadingMoreImages = true;
      setState((){});
      await loadMoreImages(current_view);
      loadingMoreImages = false;
      setState((){});        
        }

      } else {
      Media? media = meta.toMedias().where((test) => 
      test.type == "image"
      || test.type == "image_data"
      || test.type == "camera" ).firstOrNull;

      if(media!= null) {
        int index = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        int indexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));

      if(index != -1) {
      mixedList[index].setMedia(media);
      Get.find<LoggerService>().i('asset at mixedList index: $index, has had its media set.');
      }
      if(indexNft != -1) {
        current_nfts[indexNft].setMedia(media);
      }

      } else {
        // int removeIndex = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        // if(removeIndex != -1) {
        // mixedList.removeAt(removeIndex);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }
        // int removeIndexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));
        // if(removeIndexNft != -1) {
        //   current_nfts.removeAt(removeIndexNft);
        // WidgetsBinding.instance.addPostFrameCallback((t) {setState((){});});

        // }
         if(current_view == 0 ? mixedList.length < 9 :current_nfts.length < 9 ) {
loadingMoreImages = true;
      setState((){});
      await loadMoreImages(current_view);
      loadingMoreImages = false;
      setState((){});        
        }

      }

      }
    }
  }
  void loadData() async {
        LoggerService logger = Get.find<LoggerService>();

    List<AssetPathEntity> loadedAlbums = await BitnetPhotoManager.loadAlbums();
        current_album = loadedAlbums[0];
    List<AssetEntity> photos =
        await BitnetPhotoManager.loadImages(loadedAlbums[0], 0, 24);
         if(24 == await current_album!.assetCountAsync) {
      loadedFullList = true;
    }
    List<MediaDatePair> nfts = List.empty(growable: true);
    //First we will load assets and check if they're loaded for NFTS
    if(profileController.assets.isEmpty) {
      await profileController.fetchTaprootAssetsAsync();

      }
    List<Asset> metaList = profileController.assets.value as List<Asset>;
    for(int i = 0; i < metaList.length && i < 24; i++) {
      if(i == metaList.length - 1) {
        loadedFullList = true;
      } 
      MediaDatePair pair = MediaDatePair(assetId: metaList[i].assetGenesis!.assetId ?? '', date: profileController.originalBlockDate.add(Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0)))));
        nfts.add(pair);
      
    }
    albums = loadedAlbums;
    current_photos = photos;
    current_nfts = nfts;
    mixedList.addAll(photos);
    mixedList.addAll(nfts);
    mixedList.sort(compareMixedList);
    logger.i("removing range");
    if(!loadedFullList)mixedList.removeRange(24, mixedList.length);
        logger.i("removed range");
    loads++;
    
    setState(() {});
  }

  int compareMixedList(dynamic a, dynamic b) {
     if(a is AssetEntity && b is AssetEntity) {
        return -a.modifiedDateTime.compareTo(b.modifiedDateTime);
        
      } else if(a is AssetEntity && b is MediaDatePair) {
        return -a.modifiedDateTime.compareTo(b.date);
      } else if(a is MediaDatePair && b is AssetEntity) {
        return -a.date.compareTo(b.modifiedDateTime);
      } else if(a is MediaDatePair && b is MediaDatePair) {
        return -a.date.compareTo(b.date);
      } else {
        return 0;
      }
  }
  Future<void> loadMoreImages(int current_view) async {
    LoggerService logger = Get.find<LoggerService>();
    if(current_view > 0) {
 int albumAssetCount = await current_album!.assetCountAsync;
    int start = current_photos!.length;
    int end = (current_photos!.length + 24) > albumAssetCount ? albumAssetCount : (current_photos!.length + 24);
    if(current_photos!.length == albumAssetCount){
      return;
    }
    List<AssetEntity> photos = await BitnetPhotoManager.loadImages(current_album!, start, end);
    current_photos!.addAll(photos);
    } else if(current_view == 0) {
          List<MediaDatePair> nfts = List.empty(growable: true);

       int albumAssetCount = await current_album!.assetCountAsync;
    int start = loads*24;
    int end = ((loads * 24) + 24) > albumAssetCount ? albumAssetCount : ((loads * 24) + 24);
    if(end == albumAssetCount) {
      loadedFullList = true;
    }
        List<AssetEntity> photos = List.empty();

    if(current_photos!.length != albumAssetCount){
    photos = await BitnetPhotoManager.loadImages(current_album!, start, end);
    logger.i("start: $start, end: $end");
    }
     List<Asset> metaList = profileController.assets.value as List<Asset>;
    for(int i = loads * 24; i < metaList.length && i < (loads*24) + 24; i++) {
      if(i == metaList.length - 1) {
        loadedFullList = true;
      }
      MediaDatePair pair = MediaDatePair(assetId: metaList[i].assetGenesis!.assetId ?? '', date: profileController.originalBlockDate.add(Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0)))));

        nfts.add(pair);
     
    }
     
   
    current_nfts.addAll(nfts);
    current_photos!.addAll(photos);

    mixedList.clear();
    mixedList.addAll(current_photos!);
    mixedList.addAll(current_nfts);
    mixedList.sort(compareMixedList);
    if(!loadedFullList)mixedList.removeRange(current_photos!.length > current_nfts.length ? current_nfts.length : current_photos!.length, mixedList.length);
    
    loads++;

    } else {
                List<MediaDatePair> nfts = List.empty(growable: true);
     List<Asset> metaList = profileController.assets.value as List<Asset>;
    for(int i = loads * 24; i < metaList.length && i <(loads + 1) *  24; i++) {
        nfts.add(MediaDatePair(assetId: metaList[i].assetGenesis!.assetId ?? '', date: profileController.originalBlockDate.add(Duration(minutes: (10 * (metaList[i].chainAnchor?.blockHeight ?? 0))))));
      
    }
    current_nfts.addAll(nfts);
    loads++;
    }

  }
  @override
  Widget build(BuildContext context) {
    if (selecting_photos == false && !loaded_thumbnails && albums != null) {
      album_thumbnails = null;

      BitnetPhotoManager.loadAlbumThumbnails(albums!).then((value) {
        if(current_nfts.length < 3) {
          loadMoreImages(-1).then((a){
        loaded_thumbnails = true;
        album_thumbnails = value;
        setState(() {});

          });
        } else {
        loaded_thumbnails = true;
        album_thumbnails = value;
        setState(() {});

        }
      });
    }
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.selectImageQrCode,
        context: context,
        hasBackButton: false,
        onTap: () {
          context.pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppTheme.cardPadding / 2,
          ),
          if (albums == null || current_photos == null)
            Center(child: dotProgress(context)),
          if (albums != null && current_photos != null) ...[
            TextButton(
              child: Row(
                children: [
                  Text(current_view < 0 ? "Assets" : current_album!.name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18, decoration: TextDecoration.underline)),
                  Icon(
                      selecting_photos
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      color: Colors.white)
                ],
              ),
              onPressed: () {
                if (selecting_photos) {
                  loaded_thumbnails = false;
                  selecting_photos = false;
                } else {
                  selecting_photos = true;
                }
                loads = 0;
                setState(() {});
              },
            ),
            Divider(),
            SizedBox(
              height: AppTheme.cardPadding / 2,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.45,
              child: (current_photos == null)
                  ? Center(child: dotProgress(context))
                  : (selecting_photos)
                      ? 
                      
                      ((current_view == 0) ?
                        MixedGridView(imgScrollController: imgScrollController, loadingMoreImages: loadingMoreImages, mixedList: mixedList, widget: widget, current_album: current_album, loadMetaLazyFunc: loadMetaLazy,forceRemove: (pair) {
 int removeIndex = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        if(removeIndex != -1) {
        mixedList.removeAt(removeIndex);
        }
        int removeIndexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));
        if(removeIndexNft != -1) {
          current_nfts.removeAt(removeIndexNft);
        }    
                setState((){});

                  }, onImageTap: widget.onImageTap) : (current_view == -1) ? 
                            NftGridView(imgScrollController: imgScrollController, onImageTap: widget.onImageTap, loadingMoreImages: loadingMoreImages, nfts: current_nfts, widget: widget, loadMetaLazyFunc: loadMetaLazy, forceRemove: (pair) {
                               int removeIndex = mixedList.indexWhere((test) => (test is MediaDatePair && test.media == null && test.assetId == pair.assetId));
        if(removeIndex != -1) {
        mixedList.removeAt(removeIndex);
        }
        int removeIndexNft = current_nfts.indexWhere((test) => (test.media == null && test.assetId == pair.assetId));
        if(removeIndexNft != -1) {
          current_nfts.removeAt(removeIndexNft);
          Get.find<LoggerService>().i("${pair.assetId} was removed from current_nfts at ${removeIndexNft}");
        } else {
                    Get.find<LoggerService>().i("${pair.assetId} could not be removed from current_nfts ");

        }
        setState((){});
      
                            }) 
                          :
                            ImgGridView(imgScrollController: imgScrollController,  onImageTap: widget.onImageTap,loadingMoreImages: loadingMoreImages, current_photos: current_photos, widget: widget, current_album: current_album) 

                      )
                      



                      : (loaded_thumbnails && album_thumbnails != null)
                          ? SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: ()async{
                                         selecting_photos = true;
                                                current_photos = List.empty(growable: true);
                                                current_nfts = List.empty(growable:true);
                                                mixedList = List.empty(growable:true);
                                                loading = true;
                                                current_view = -1;
                                                setState((){});
                                                await loadMoreImages(-1);
                                                loading = false;
                                                setState(() {});
                              
                                    },
                                    child: GlassContainer(
                                      width: MediaQuery.sizeOf(context).width * 0.7,
                                      child: 
                                      Column(
                                        children: [
                                      Text('Your Assets', style: Theme.of(context).textTheme.bodyLarge),
                                      SizedBox(height: AppTheme.cardPadding),
                                      Row(children: [
                                        Expanded(child: Container(width:100, height: 100, color:(current_nfts[0].media == null) ?  Colors.grey : Colors.transparent, child: (current_nfts[0].media == null) ? null : ImageBuilder(radius: BorderRadius.zero, encodedData: current_nfts[0].media!.data,), )),
                                        Expanded(child: Container(width:100, height: 100, color:(current_nfts[1].media == null) ?  Colors.grey : Colors.transparent, child: (current_nfts[1].media == null) ? null : ImageBuilder(radius: BorderRadius.zero, encodedData: current_nfts[1].media!.data,), )),
                                        Expanded(child: Container(width:100, height: 100, color:(current_nfts[2].media == null) ?  Colors.grey : Colors.transparent, child: (current_nfts[2].media == null) ? null : ImageBuilder(radius: BorderRadius.zero, encodedData: current_nfts[2].media!.data,), )),
                                      ],)
                                    ],)),
                                  ),
                                  SizedBox(height: AppTheme.cardPadding),
                                  GridView.builder(
                                    primary: false,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: albums!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder: (ctx, i) {
                                        return Padding(
                                            padding: EdgeInsets.all(16),
                                            child: InkWell(
                                              onTap: ()async {
                                                current_album = albums![i];
                                                selecting_photos = true;
                                                current_photos = List.empty(growable: true);
                                                current_nfts = List.empty(growable:true);
                                                mixedList = List.empty(growable:true);
                                                current_view = 1;
                                                loading = true;
                                                setState((){});
                                                await loadMoreImages(1);
                                                loading = false;
                                                setState(() {});
                                              },
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 180,
                                                      height: 150,
                                                      child: ClipRRect(
                                                        clipBehavior: Clip.hardEdge,
                                                        borderRadius:
                                                            BorderRadius.circular(16),
                                                        child: AssetEntityImage(
                                                          album_thumbnails![i],
                                                          isOriginal: false,
                                                          fit: BoxFit.cover,
                                                          thumbnailSize:
                                                              ThumbnailSize.square(360),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(albums![i].name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall)
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                ],
                              ),
                            ),
                          )
                          : Center(
                              child: dotProgress(context),
                            ),
            )
          ]
        ],
      ),
    );
  }
}

class ImgGridView extends StatelessWidget {
  const ImgGridView({
    super.key,
    required this.imgScrollController,
    required this.loadingMoreImages,
    required this.current_photos,
    required this.widget,
    required this.current_album,  this.onImageTap,
  });

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List<AssetEntity>? current_photos;
  final ImagePickerNftMixed widget;
  final AssetPathEntity? current_album;
  final Function(AssetPathEntity? album, AssetEntity? img, MediaDatePair? pair)? onImageTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                            controller: imgScrollController,
                              itemCount: loadingMoreImages ? ((current_photos!.length % 3) == 0 ? current_photos!.length + 3 :current_photos!.length + 3 + (current_photos!.length % 3) ) : current_photos!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3),
                              itemBuilder: (ctx, i) {
    return (i < current_photos!.length ) ? Padding(
        padding: EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            if (onImageTap != null) {
              onImageTap!(
                  current_album!, current_photos![i], null);
            }
          },
          child: AssetEntityImage(
            current_photos![i],
            isOriginal: false,
            thumbnailSize: ThumbnailSize.square(250),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stacktrace) {
              return const Center(
                  child: Icon(Icons.error,
                      color: Colors.red));
            },
          ),
        )) 
        : 
        (i == current_photos!.length + (((current_photos!.length % 3) == 0 ? 3 : 3 + (current_photos!.length % 3) ) - 2)) 
                                ? Container(width: 50, height: 50, child: Center(child: CircularProgressIndicator())) 
                                : Container(width: 50, height: 50, color: Colors.transparent);
                              });
  }
}

class NftGridView extends StatefulWidget {
  const NftGridView({
    super.key,
    required this.imgScrollController,
    required this.loadingMoreImages,
    required this.nfts,
    required this.widget, required this.loadMetaLazyFunc, required this.forceRemove, this.onImageTap  });

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List<MediaDatePair> nfts;
  final ImagePickerNftMixed widget;
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
    Get.find<LoggerService>().i('list nfts length : ${nfts.length}');
    return GridView.builder(
                            controller: widget.imgScrollController,
                              itemCount: widget.loadingMoreImages ? ((nfts.length % 3) == 0 ? nfts.length + 3 :nfts.length + 3 + (nfts.length % 3) ) :nfts.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3),
                              itemBuilder: (ctx, i) {
    return (i < nfts.length) ? Padding(
        padding: EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
                        

            if (widget.onImageTap != null) {
              widget.onImageTap!(
                  null, null, nfts[i]);
            }
          },
          child: LazyImageBuilder(asset: nfts[i],loadFunc: widget.loadMetaLazyFunc, forceRemove: (MediaDatePair pair){
            widget.forceRemove(pair);
            setState((){});
            
          },),
        )) : 
        (i == nfts.length + (((nfts.length % 3) == 0 ? 3 : 3 + (nfts.length % 3) ) - 2)) 
                                ? Container(width: 50, height: 50, child: Center(child: CircularProgressIndicator())) 
                                : Container(width: 50, height: 50, color: Colors.transparent);
      
                              });
  }
}

class MixedGridView extends StatefulWidget {
  const MixedGridView({
    super.key,
    required this.imgScrollController,
    required this.loadingMoreImages,
    required this.mixedList,
    required this.widget,
    required this.current_album, required this.loadMetaLazyFunc, required this.forceRemove, this.onImageTap,
  });

  final ScrollController imgScrollController;
  final bool loadingMoreImages;
  final List mixedList;
  final ImagePickerNftMixed widget;
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
      itemCount: widget.loadingMoreImages ? ((widget.mixedList.length % 3) == 0 ? widget.mixedList.length + 3 :widget.mixedList.length + 3 + (widget.mixedList.length % 3) ) :widget.mixedList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3),
      itemBuilder: (ctx, i) {
        return (i < widget.mixedList.length) ? Padding(
            padding: EdgeInsets.all(0),
            child: InkWell(
              onTap: () {
    
                if (widget.onImageTap != null) {
                  widget.onImageTap!(
                      widget.current_album, (widget.mixedList[i] is AssetEntity) ? widget.mixedList[i] : null,
                      (widget.mixedList[i] is MediaDatePair) ? widget.mixedList[i] : null);
                }
              },
              child: (widget.mixedList[i] is AssetEntity) ? AssetEntityImage(
                (widget.mixedList[i] as AssetEntity),
                isOriginal: false,
                thumbnailSize: ThumbnailSize.square(250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stacktrace) {
                  return const Center(
                      child: Icon(Icons.error,
                          color: Colors.red));
                },
              ) : LazyImageBuilder(key: ValueKey(widget.mixedList[i].assetId), asset: widget.mixedList[i], loadFunc: widget.loadMetaLazyFunc, forceRemove: (MediaDatePair pair){
                widget.forceRemove(pair);
                setState((){});
        
              },),
            )) : 
              (i == widget.mixedList.length + (((widget.mixedList.length % 3) == 0 ? 3 : 3 + (widget.mixedList.length % 3) ) - 2)) 
                                ? Container(width: 50, height: 50, child: Center(child: CircularProgressIndicator())) 
                                : Container(width: 50, height: 50, color: Colors.transparent); 
          
      });
  }
}
class LazyImageBuilder extends StatefulWidget {
  final MediaDatePair asset;
  final Future<void> Function(String, MediaDatePair) loadFunc;
  final Function(MediaDatePair pair) forceRemove;
  const LazyImageBuilder({super.key, required this.asset, required this.loadFunc, required this.forceRemove});

  @override
  State<LazyImageBuilder> createState() => _LazyImageBuilderState();
}

class _LazyImageBuilderState extends State<LazyImageBuilder> {
  late LoggerService logger;
 
  Future<void> load() async {
     if(widget.asset.media == null) {
      try {

 await widget.loadFunc(widget.asset.assetId, widget.asset);

        widget.asset.isLoading = false;
        widget.asset.loaded = true;
        if(widget.asset.media == null) {
          widget.forceRemove(widget.asset);

          logger.i("${widget.asset.assetId} was queued for removal");

          }
        logger.i("asset: ${widget.asset.assetId} is loaded");

        WidgetsBinding.instance.addPostFrameCallback((t) {
          if(mounted)setState((){});});
      } catch (e) {
  logger.i("${widget.asset.assetId} has errored");
        //load();
        widget.asset.loaded = true;
        widget.asset.isLoading = false;
        widget.forceRemove(widget.asset);
                WidgetsBinding.instance.addPostFrameCallback((t) {if(mounted)setState((){});});
      }
    }
  }
  @override
  Widget build(BuildContext context) {
      logger = Get.find<LoggerService>();
    if(!widget.asset.isLoading && !widget.asset.loaded) {
widget.asset.isLoading = true;
 
   load();


logger.i("asset: ${widget.asset.assetId} is loading");
    } else {
      logger.i("smthn happened asset is either loading or loaded, id: ${widget.asset.assetId}");
    }
    
   
    return  (widget.asset.media == null) ? GestureDetector(onTap: ()async{
      await load();
    },child: Container(width: 50, height: 50, decoration: BoxDecoration( color: Colors.grey))): ImageBuilder(encodedData: widget.asset.media!.data,);
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
  static Future<List<AssetPathEntity>> loadAlbums() async {
    List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    return albums;
  }

  static Future<List<AssetEntity>> loadImages(
      AssetPathEntity selectedAlbum, int start, int end) async {

    List<AssetEntity> imageList = await selectedAlbum.getAssetListRange(
        start: start, end: end);
    return imageList;
  }

  static Future<List<AssetEntity>> loadAlbumThumbnails(
      List<AssetPathEntity> albums) async {
    List<AssetEntity> thumbnails = List.empty(growable: true);
    for (int i = 0; i < albums.length; i++) {
      thumbnails.add((await albums[i].getAssetListRange(start: 0, end: 1))[0]);
    }
    return thumbnails;
  }
}
