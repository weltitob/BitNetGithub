import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class WebMxcImage extends StatefulWidget {
  final String? ref;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isThumbnail;
  final bool animated;
  final Duration retryDuration;
  final Duration animationDuration;
  final Curve animationCurve;
  final Widget Function(BuildContext context)? placeholder;
  final String? cacheKey;

  const WebMxcImage({
    this.ref,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.isThumbnail = true,
    this.animated = false,
    this.animationDuration = AppTheme.animationDuration,
    this.retryDuration = const Duration(seconds: 2),
    this.animationCurve = AppTheme.animationCurve,
    this.cacheKey,
    Key? key,
  }) : super(key: key);

  @override
  State<WebMxcImage> createState() => _MxcImageState();
}

class _MxcImageState extends State<WebMxcImage> {
  static final Map<String, Uint8List> _imageDataCache = {};
  Uint8List? _imageDataNoCache;
  Uint8List? get _imageData {
    final cacheKey = widget.cacheKey;
    return cacheKey == null ? _imageDataNoCache : _imageDataCache[cacheKey];
  }

  set _imageData(Uint8List? data) {
    if (data == null) return;
    final cacheKey = widget.cacheKey;
    cacheKey == null
        ? _imageDataNoCache = data
        : _imageDataCache[cacheKey] = data;
  }
  String? _imageUrl;
  bool? _isCached;

  Future<void> _load() async {
  

    cacheImage().then((String imageUrl) {
      setState(() {
        // Get image url
        _imageUrl = imageUrl;
        _isCached = true;
      });
    },
    onError: (e,s) {
      print("Error: $e and $s");
    });

  }

  void _tryLoad(_) async {
    if (_imageUrl != null) return;
    try {
      await _load();
    } catch (e) {
      print(e);
      if (!mounted) return;
      await Future.delayed(widget.retryDuration);
      _tryLoad(_);
    }
  }
   Future<String> cacheImage() async {
   
    String url = Uri.parse(widget.ref!).toString();
     
    await DefaultCacheManager().getSingleFile(url);
    return url;
  }

  @override
  void initState() {
    super.initState();
    print("attempting to load: ${widget.ref}");
    WidgetsBinding.instance.addPostFrameCallback(_tryLoad);
  }

  Widget placeholder(BuildContext context) =>
      widget.placeholder?.call(context) ??
      const Center(
        child: CircularProgressIndicator.adaptive(),
      );

  @override
  Widget build(BuildContext context) {
    final data = _imageUrl;

    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState:
          data == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: placeholder(context),
      secondChild: data == null || data.isEmpty
          ? const SizedBox.shrink()
          : CachedNetworkImage(
              imageUrl: data,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              filterQuality: FilterQuality.medium,
              errorWidget: (context, __, ___) {
                _isCached = false;
                _imageUrl = null;
                WidgetsBinding.instance.addPostFrameCallback(_tryLoad);
                return placeholder(context);
              },
            ),
    );
  }
}