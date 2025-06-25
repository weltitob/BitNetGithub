import 'package:bitnet/backbone/helper/image_picker/album_view_widget.dart';
import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/helper/image_picker/mixed_grid_view.dart';
import 'package:bitnet/backbone/helper/image_picker/nft_grid_view.dart';
import 'package:bitnet/backbone/helper/image_picker/photo_grid_view.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';

/// Combined bottom sheet which shows photos and (optionally) NFTs in one widget.
Future<T?> ImagePickerCombinedBottomSheet<T>(
  BuildContext context, {
  required bool includeNFTs,
  // onImageTap receives: album, photo (AssetEntity) and nft (MediaDatePair) (if applicable)
  required Function(
          AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)?
      onImageTap,
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
  final Function(
          AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair)?
      onImageTap;
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
  late ImagePickerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ImagePickerController());
    controller.initialize(
      includeNFTs: widget.includeNFTs,
      onImageTap: widget.onImageTap,
      onPop: widget.onPop,
    );
  }

  @override
  void dispose() {
    Get.delete<ImagePickerController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool _) {
        if (widget.onPop != null) widget.onPop!(controller.selectedPhotos);
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
            Obx(() {
              // Get the album name or default text
              final String buttonText =
                  widget.includeNFTs && controller.currentView.value < 0
                      ? "Assets"
                      : controller.currentAlbum.value?.name ?? "Albums";

              // Calculate a more appropriate width based on text length
              // Use a minimum width and expand for longer text
              final double minWidth = AppTheme.cardPadding * 5.w;
              final double calculatedWidth = MediaQuery.of(context).size.width *
                  0.6; // 60% of screen width

              return Container(
                constraints: BoxConstraints(
                  maxWidth: calculatedWidth,
                  minWidth: minWidth,
                ),
                child: LongButtonWidget(
                  customWidth: double.infinity, // Fill the container width
                  customHeight: AppTheme.cardPadding * 1.5,
                  title: buttonText,
                  titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                  leadingIcon: Icon(
                    controller.selectingPhotos.value
                        ? Icons.arrow_drop_down_rounded
                        : Icons.arrow_drop_up_rounded,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  onTap: () {
                    print(
                        "Album button tapped, current state: ${controller.selectingPhotos.value ? 'selecting photos' : 'showing albums'}");
                    if (controller.selectingPhotos.value) {
                      print("Switching to album view");
                      controller.switchToAlbumView();
                      Future.delayed(Duration(milliseconds: 100), () {
                        print(
                            "After delay, selectingPhotos = ${controller.selectingPhotos.value}");
                      });
                    } else {
                      print("Switching to photo view");
                      controller.switchToPhotoView();
                    }
                  },
                  buttonType: ButtonType.transparent,
                ),
              );
            }),
            SizedBox(height: AppTheme.elementSpacing),
            Expanded(
              child: Obx(() {
                // Show loader while loading initial data
                if (controller.loading.value) {
                  return Center(child: dotProgress(context));
                }

                // Display the appropriate view based on state
                // First check if we should show the album selection view
                if (!controller.selectingPhotos.value) {
                  // Album view - show even if thumbnails aren't fully loaded yet
                  // The AlbumViewWidget handles empty thumbnail states
                  return AlbumViewWidget(controller: controller);
                }

                // Photo/asset selection views
                if (widget.includeNFTs) {
                  // With NFTs enabled, check the current view type
                  if (controller.currentView.value == 0) {
                    return MixedGridView(controller: controller);
                  } else if (controller.currentView.value == -1) {
                    return NftGridView(controller: controller);
                  } else {
                    return PhotoGridView(controller: controller);
                  }
                } else {
                  // Normal photo picker without NFTs
                  return PhotoGridView(controller: controller);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
