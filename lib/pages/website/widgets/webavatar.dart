import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/website/widgets/webmxcimage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



import 'package:bitnet/backbone/helper/matrix_helpers/string_color.dart';


class WebAvatar extends StatelessWidget {
  final String? profileId;
  final String? mxContent;
  final String? name;
  final double size;
  final void Function()? onTap;
  static const double defaultSize = AppTheme.cardPadding * 2;
  final Client? client;
  final double fontSize;

  const WebAvatar({
    this.mxContent,
    this.name,
    this.size = defaultSize,
    this.onTap,
    this.client,
    this.fontSize = 18,
    Key? key,
    this.profileId,
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
    final noPic =
        mxContent == null || mxContent!.isEmpty || mxContent == 'null';

    final textWidget = Center(
      child: Icon(
        Icons.person_2_rounded,
        size: size / 2,
        color: Colors.white,
      ),

      // Text(
      //   fallbackLetters,
      //   style: TextStyle(
      //     color: noPic ? Colors.white : null,
      //     fontSize: fontSize,
      //   ),
      // ),
    );
    final borderRadius = BorderRadius.circular(size / 2.5);

    final container = ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        borderRadius: borderRadius,
        child: Container(
          width: size,
          height: size,
          color: noPic
              ? name?.lightColorAvatar
              : Theme.of(context)
                  .secondaryHeaderColor, //getRandomColor(), //getRandomColor(), //Theme.of(context).secondaryHeaderColor
          child: noPic
              ? textWidget
              : WebMxcImage(
                  key: Key(mxContent.toString()),
                  ref: mxContent,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  placeholder: (_) => textWidget,
                  cacheKey: mxContent.toString(),
                ),
        ),
      ),
    );
    if (onTap == null) return container;
    return InkWell(
      onTap: onTap ?? () => context.go("/showprofile/:$profileId"),
      borderRadius: borderRadius,
      child: container,
    );
  }
}
