import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

/// Grid view displaying photos from selected album
class PhotoGridView extends StatelessWidget {
  final ImagePickerController controller;
  
  const PhotoGridView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
      controller: controller.imgScrollController,
      itemCount: controller.loadingMoreImages.value
          ? ((controller.currentPhotos.length % 3) == 0
              ? controller.currentPhotos.length + 3
              : controller.currentPhotos.length + 3 + (controller.currentPhotos.length % 3))
          : controller.currentPhotos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (ctx, i) {
        if (i < controller.currentPhotos.length) {
          final photo = controller.currentPhotos[i];
          return InkWell(
            onTap: () {
              controller.togglePhotoSelection(photo);
              if (controller.onImageTap != null) {
                controller.onImageTap!(controller.currentAlbum.value, photo, null);
              }
            },
            child: Obx(() => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: controller.selectedPhotos.contains(photo)
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                ),
              ),
              child: AssetEntityImage(
                photo,
                isOriginal: false,
                thumbnailSize: const ThumbnailSize(250, 250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            )),
          );
        } else if (i ==
            controller.currentPhotos.length +
            (((controller.currentPhotos.length % 3) == 0
                ? 3
                : 3 + (controller.currentPhotos.length % 3)) -
                2)) {
          return Container(
            width: 50, 
            height: 50, 
            child: Center(child: dotProgress(context)),
          );
        } else {
          return Container(
            width: 50, 
            height: 50, 
            color: Colors.transparent,
          );
        }
      },
    ));
  }
}