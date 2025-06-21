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
    return Obx(() {
      // Show loading indicator if still loading and no photos loaded yet
      if (controller.loading.value && controller.currentPhotos.isEmpty) {
        return Center(child: dotProgress(context));
      }
      
      // Show empty state if no photos are available
      if (controller.currentPhotos.isEmpty && !controller.loading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No photos found',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please check your photo permissions',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }
      
      // Show the photo grid
      return GridView.builder(
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
      );
    });
  }
}