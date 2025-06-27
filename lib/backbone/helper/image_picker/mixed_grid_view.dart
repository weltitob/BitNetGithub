import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/helper/image_picker/lazy_image_builder.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

/// Grid view displaying mixed content (both photos and NFTs)
class MixedGridView extends StatefulWidget {
  final ImagePickerController controller;

  const MixedGridView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MixedGridView> createState() => _MixedGridViewState();
}

class _MixedGridViewState extends State<MixedGridView> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          controller: widget.controller.imgScrollController,
          itemCount: widget.controller.loadingMoreImages.value
              ? ((widget.controller.mixedList.length % 3) == 0
                  ? widget.controller.mixedList.length + 3
                  : widget.controller.mixedList.length +
                      3 +
                      (widget.controller.mixedList.length % 3))
              : widget.controller.mixedList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (ctx, i) {
            return (i < widget.controller.mixedList.length)
                ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: () {
                        if (widget.controller.onImageTap != null) {
                          widget.controller.onImageTap!(
                              widget.controller.currentAlbum.value,
                              widget.controller.mixedList[i] is AssetEntity
                                  ? widget.controller.mixedList[i]
                                  : null,
                              widget.controller.mixedList[i] is MediaDatePair
                                  ? widget.controller.mixedList[i]
                                  : null);
                        }
                      },
                      child: _buildMixedItemWidget(i),
                    ))
                : (i ==
                        widget.controller.mixedList.length +
                            (((widget.controller.mixedList.length % 3) == 0
                                    ? 3
                                    : 3 +
                                        (widget.controller.mixedList.length %
                                            3)) -
                                2))
                    ? Container(
                        width: 50,
                        height: 50,
                        child: Center(child: dotProgress(context)))
                    : Container(
                        width: 50, height: 50, color: Colors.transparent);
          },
        ));
  }

  Widget _buildMixedItemWidget(int index) {
    final item = widget.controller.mixedList[index];

    if (item is AssetEntity) {
      return AssetEntityImage(
        item,
        isOriginal: false,
        thumbnailSize: const ThumbnailSize(250, 250),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stacktrace) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        },
      );
    } else if (item is MediaDatePair) {
      return LazyImageBuilder(
        key: ValueKey(item.assetId),
        asset: item,
        controller: widget.controller,
      );
    } else {
      return Container(
        color: Colors.grey,
        child: const Center(child: Icon(Icons.error, color: Colors.white)),
      );
    }
  }
}
