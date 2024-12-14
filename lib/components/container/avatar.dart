import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/coinlogo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum profilePictureType { none, lightning, onchain }

class Avatar extends StatelessWidget {
  final profilePictureType? type;
  final String? profileId;
  final Uri? mxContent;
  final String? name;
  final double size;
  final void Function()? onTap;
  static const double defaultSize = AppTheme.cardPadding * 2;
  final double fontSize;
  final bool isNft;
  final Widget? cornerWidget;

  const Avatar({
    this.type = profilePictureType.none,
    this.mxContent,
    this.name,
    this.size = defaultSize,
    this.onTap,
    this.fontSize = 18,
    Key? key,
    this.profileId,
    required this.isNft,
    this.cornerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fallbackLetters = '@';
    final name = this.name;
    if (name != null) {
      if (name.runes.length >= 2) {
        fallbackLetters = String.fromCharCodes(name.runes, 0, 2);
      } else if (name.runes.length == 1) {
        fallbackLetters = name;
      }
    }
    final noPic = mxContent == null ||
        mxContent.toString().isEmpty ||
        mxContent.toString() == 'null';

    final textWidget = Center(
      child: Icon(
        Icons.person_2_rounded,
        size: size / 2,
        color: Colors.white,
      ),
    );

    final borderRadius = BorderRadius.circular(size / 2.5);

    // Apply the orange gradient when profilePictureType is either onchain or lightning
    final isSpecialType = type == profilePictureType.onchain ||
        type == profilePictureType.lightning;
    final borderPadding = isSpecialType ? size / 30 : 0.0;

    final container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isNft ? AppTheme.colorBitcoin : Theme.of(context).primaryColor,
            isNft
                ? AppTheme.colorPrimaryGradient
                : Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular((size - borderPadding * 2) / 2.5),
          child: Container(
            width: size - borderPadding * 1.5,
            height: size - borderPadding * 1.5,
            color: Theme.of(context).brightness == Brightness.dark ?
            lighten(Theme.of(context).primaryColor, 5) : darken(Theme.of(context).primaryColor, 5), // Default color behind image
            child: noPic
                ? textWidget
                : MxcImage(
                    key: Key(mxContent.toString()),
                    uri: mxContent,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                    placeholder: (_) => textWidget,
                    cacheKey: mxContent.toString(),
                  ),
          ),
        ),
      ),
    );

    return ClipRRect(
      child: Stack(children: [
        InkWell(
          onTap: onTap ??
              (profileId != null
                  ? () => context.go("/showprofile/:$profileId")
                  : null),
          borderRadius: borderRadius,
          child: container,
        ),
        if (cornerWidget != null || isNft)
          Positioned(
              bottom: 0,
              right: 0,
              child: cornerWidget ??
                  (isNft
                      ? CoinLogoWidgetSmall(
                          coinid: 1,
                          width: size / 4,
                          height: size / 4,
                        )
                      : Container()))
      ]),
    );
  }
}

class MxcImage extends StatefulWidget {
  final Uri? uri;
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

  const MxcImage({
    this.uri,
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
    return CachedNetworkImage(
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
