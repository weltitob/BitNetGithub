import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/helper/image_picker/lazy_image_builder.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Grid view displaying NFT assets
class NftGridView extends StatefulWidget {
  final ImagePickerController controller;

  const NftGridView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<NftGridView> createState() => _NftGridViewState();
}

class _NftGridViewState extends State<NftGridView> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          controller: widget.controller.imgScrollController,
          itemCount: widget.controller.loadingMoreImages.value
              ? ((widget.controller.currentNFTs.length % 3) == 0
                  ? widget.controller.currentNFTs.length + 3
                  : widget.controller.currentNFTs.length +
                      3 +
                      (widget.controller.currentNFTs.length % 3))
              : widget.controller.currentNFTs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (ctx, i) {
            return (i < widget.controller.currentNFTs.length)
                ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: InkWell(
                      onTap: () {
                        if (widget.controller.onImageTap != null) {
                          widget.controller.onImageTap!(
                              null, null, widget.controller.currentNFTs[i]);
                        }
                      },
                      child: LazyImageBuilder(
                        key: ValueKey(widget.controller.currentNFTs[i].assetId),
                        asset: widget.controller.currentNFTs[i],
                        controller: widget.controller,
                      ),
                    ))
                : (i ==
                        widget.controller.currentNFTs.length +
                            (((widget.controller.currentNFTs.length % 3) == 0
                                    ? 3
                                    : 3 +
                                        (widget.controller.currentNFTs.length %
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
}
