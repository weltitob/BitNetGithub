
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MxcImage extends StatefulWidget {
  final Uri? uri;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool animated;
  final Duration retryDuration;
  final Duration animationDuration;
  final Curve animationCurve;
  final Widget Function(BuildContext context)? placeholder;
  final String? cacheKey;

  const MxcImage({
    this.uri,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.animated = false,
    this.animationDuration = AppTheme.animationDuration,
    this.retryDuration = const Duration(seconds: 2),
    this.animationCurve = AppTheme.animationCurve,
    this.cacheKey,
    Key? key,
  }) : super(key: key);

  @override
  State<MxcImage> createState() => _MxcImageState();
}

class _MxcImageState extends State<MxcImage> {


  @override
  void initState() {
    super.initState();
  }

  Widget placeholder(BuildContext context) =>
      widget.placeholder?.call(context) ??
      const Center(
        child: CircularProgressIndicator.adaptive(),
      );

  @override
  Widget build(BuildContext context) {

    return 
          CachedNetworkImage(
              imageUrl: widget.uri!.toString(),
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              filterQuality: FilterQuality.medium,
              errorWidget: (context, __, ___) {
                return placeholder(context);
              },
            
          );
  }
}
