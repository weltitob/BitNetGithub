import 'package:bitnet/backbone/helper/image_picker/image_picker_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget for lazily loading NFT image data
class LazyImageBuilder extends StatefulWidget {
  final MediaDatePair asset;
  final ImagePickerController controller;

  const LazyImageBuilder({
    Key? key,
    required this.asset,
    required this.controller,
  }) : super(key: key);

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
        await widget.controller
            .loadMetaLazy(widget.asset.assetId, widget.asset);
        widget.asset.isLoading = false;
        widget.asset.loaded = true;

        if (widget.asset.media == null) {
          widget.controller.removeNftFromLists(widget.asset);
          logger.i("${widget.asset.assetId} was queued for removal");
        } else {
          logger.i("asset: ${widget.asset.assetId} is loaded");
        }

        if (mounted) setState(() {});
      } catch (e) {
        logger.i("${widget.asset.assetId} has errored: $e");
        widget.asset.loaded = true;
        widget.asset.isLoading = false;
        widget.controller.removeNftFromLists(widget.asset);

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
              child: widget.asset.isLoading
                  ? Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )))
                  : null,
            ),
          )
        : ImageBuilder(
            encodedData: widget.asset.media!.data,
          );
  }
}
