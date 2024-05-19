import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../components/appstandards/BitNetAppBar.dart';
import '../../components/appstandards/BitNetScaffold.dart';

import 'package:flutter/services.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/camera/textscanneroverlay.dart';

class QRScannerView extends StatelessWidget {
  final QRScannerController controller;

  const QRScannerView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // context.pop();
        return true;
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        removeGradientColor: true,
        backgroundColor: Colors.transparent,
        gradientColor: Colors.black,
        appBar: bitnetAppBar(
            text: "Scan QR",
            context: context,
            onTap: () {
              context.pop();
            }),
        body: Stack(
          children: [
            // MobileScanner(
            //   //allowDuplicates: false,
            //   controller: controller.cameraController,
            //   onDetect: (capture) {
            //     final List<Barcode> barcodes = capture.barcodes;
            //     final Uint8List? image = capture.image;
            //     for (final barcode in barcodes) {
            //       debugPrint('Barcode found! ${barcode.rawValue}');
            //       //final String code = barcode.rawValue.toString();
            //       //var encodedString = jsonDecode(codeinjson);
            //       controller.onQRCodeScanned(barcode.rawValue!, context);
            //       //check what type we scanned somehow and then call the according functions
            //       //controller.onScannedForSignIn(encodedString);
            //     }
            //   },
            // ),
            controller.isQRScanner
                ? QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
                : TextScannerOverlay(
                    overlayColour: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: AppTheme.cardPadding * 8),
                child: GlassContainer(
                  width: AppTheme.cardPadding * 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: controller.cameraController.facing ==
                                  CameraFacing.front
                              ? const Icon(Icons.camera_front)
                              : const Icon(Icons.camera_rear),
                          onTap: () =>
                              controller.cameraController.switchCamera(),
                        ),
                        GestureDetector(
                          child: !controller.cameraController.torchEnabled
                              ? Icon(
                                  Icons.flash_off,
                                  color: AppTheme.white90,
                                )
                              : Icon(
                                  Icons.flash_on,
                                  color: AppTheme.white90,
                                ),
                          onTap: () =>
                              controller.cameraController.toggleTorch(),
                        ),
                        GestureDetector(
                            onTap: () async {
                              final PermissionState ps =
                                  await PhotoManager.requestPermissionExtend();
                              if (ps.isAuth || ps.hasAccess) {
                                List<AssetPathEntity> albums =
                                    await BitnetPhotoManager.loadAlbums();
                                List<AssetEntity> photos =
                                    await BitnetPhotoManager.loadImages(
                                        albums[0]);
                                ImagePickerBottomSheet(context,
                                    albums: albums, recent_photos: photos,
                                    onImageTap: (album, img) async {
                                  String? fileUrl =
                                      (await img.loadFile())!.path;
                                  String? fileDir = (await img.loadFile())!
                                      .parent
                                      .uri
                                      .toFilePath();
                                  print(fileUrl);
                                  BarcodeCapture? capture = await controller
                                      .cameraController
                                      .analyzeImage(fileUrl!);
                                  if (capture != null) {
                                    List<Barcode> codes = capture.barcodes;
                                    for (Barcode code in codes) {
                                      debugPrint(
                                          'Barcode found! ${code.rawValue}');
                                      context.pop();
                                      controller.onQRCodeScanned(
                                          code.rawValue!, context);
                                    }
                                  } else {
                                    showOverlay(context, "No code was found.",
                                        color: AppTheme.errorColor);
                                  }
                                });
                              } else {
                                showOverlay(context,
                                    "Please give the app photo access to use this feature.");
                              }
                            },
                            child: Icon(Icons.image))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )
          ],
        ),
        context: context,
      ),
    );
  }
}

Future<T?> ImagePickerBottomSheet<T>(BuildContext context,
    {required List<AssetPathEntity> albums,
    required List<AssetEntity> recent_photos,
    required Function(AssetPathEntity album, AssetEntity image)? onImageTap}) {
  return BitNetBottomSheet<T>(
      context: context,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: ImagePicker(
        albums: albums,
        photos: recent_photos,
        onImageTap: onImageTap,
      ));
}

class ImagePicker extends StatefulWidget {
  final List<AssetPathEntity> albums;
  final List<AssetEntity> photos;
  final Function(AssetPathEntity album, AssetEntity image)? onImageTap;
  const ImagePicker({
    super.key,
    required this.albums,
    required this.photos,
    this.onImageTap,
  });

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  bool selecting_photos = true;
  AssetPathEntity? current_album = null;
  List<AssetEntity>? current_photos = null;
  List<AssetEntity>? album_thumbnails = null;
  bool loaded_thumbnails = false;
  @override
  void initState() {
    current_album = widget.albums[0];
    current_photos = widget.photos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selecting_photos == false && !loaded_thumbnails) {
      album_thumbnails = null;

      BitnetPhotoManager.loadAlbumThumbnails(widget.albums).then((value) {
        loaded_thumbnails = true;
        album_thumbnails = value;
        setState(() {});
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppTheme.cardPadding / 2,
        ),
        Center(
          child: Text("Select Image for QR Scan",
              style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: AppTheme.cardPadding,
        ),
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
                ? Center(child: CircularProgressIndicator())
                : (selecting_photos)
                    ? GridView.builder(
                        itemCount: current_photos!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (ctx, i) {
                          return Padding(
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
                              ));
                        })
                    : (loaded_thumbnails && album_thumbnails != null)
                        ? GridView.builder(
                            shrinkWrap: true,
                            itemCount: widget.albums.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (ctx, i) {
                              return Padding(
                                  padding: EdgeInsets.all(16),
                                  child: InkWell(
                                    onTap: () {
                                      current_album = widget.albums[i];
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
                                            Text(widget.albums[i].name,
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
                        : Center(child: CircularProgressIndicator()))
      ],
    );
  }
}

class BitnetPhotoManager {
  static Future<List<AssetPathEntity>> loadAlbums() async {
    List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    return albums;
  }

  static Future<List<AssetEntity>> loadImages(
      AssetPathEntity selectedAlbum) async {
    List<AssetEntity> imageList = await selectedAlbum.getAssetListRange(
        start: 0, end: await selectedAlbum.assetCountAsync);
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
