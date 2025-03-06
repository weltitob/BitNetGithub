import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
          // Assets container - only shown when NFTs are enabled
          if (controller.includeNFTs)
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
                    Obx(() => Row(
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
                    )),
                  ],
                )
              ),
            ),

          if (controller.includeNFTs)
            const SizedBox(height: AppTheme.cardPadding),

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
                          child: AssetEntityImage(
                            controller.albumThumbnails[i],
                            isOriginal: false,
                            fit: BoxFit.cover,
                            thumbnailSize: const ThumbnailSize(360, 360),
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