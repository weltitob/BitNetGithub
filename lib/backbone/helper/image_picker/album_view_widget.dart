import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

/// Widget for displaying albums and asset collections
class AlbumViewWidget extends StatelessWidget {
  final ImagePickerController controller;
  
  const AlbumViewWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Assets container - only shown when NFTs are enabled AND assets are available
          Obx(() {
            if (controller.includeNFTs && controller.currentNFTs.isNotEmpty) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      controller.switchToNftView();
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
                              for (int i = 0; i < min(controller.currentNFTs.length, 3); i++)
                                Expanded(
                                  child: Container(
                                    width: AppTheme.cardPadding * 4,
                                    height: AppTheme.cardPadding * 4,
                                    color: (controller.currentNFTs[i].media == null) ? Colors.grey : Colors.transparent,
                                    child: (controller.currentNFTs[i].media == null)
                                        ? null
                                        : ImageBuilder(
                                            radius: BorderRadius.zero,
                                            encodedData: controller.currentNFTs[i].media!.data,
                                          ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),

          // Albums grid
          Obx(() => GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.albums.value.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  controller.selectAlbum(controller.albums.value[i]);
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
                          child: i < controller.albumThumbnails.length && controller.albumThumbnails[i] != null
                            ? Builder(
                                builder: (context) {
                                  try {
                                    return AssetEntityImage(
                                      controller.albumThumbnails[i],
                                      isOriginal: false,
                                      fit: BoxFit.cover,
                                      thumbnailSize: const ThumbnailSize(360, 360),
                                    );
                                  } catch (e) {
                                    print("Error loading thumbnail: $e");
                                    // Fallback UI in case of error
                                    return Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: const Center(
                                        child: Icon(Icons.broken_image, color: Colors.white),
                                      ),
                                    );
                                  }
                                },
                              )
                            : Container(
                                color: Colors.grey.withOpacity(0.3),
                                child: const Center(
                                  child: Icon(Icons.photo_album, color: Colors.white),
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: AppTheme.elementSpacing / 2,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          controller.albums.value[i].name,
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
          )),
        ],
      ),
    );
  }
  
  int min(int a, int b) => a < b ? a : b;
}