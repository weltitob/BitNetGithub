import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:matrix/matrix.dart';

import 'package:bitnet/backbone/helper/matrix_helpers/string_color.dart';
import 'package:bitnet/pages/matrix/widgets/mxc_image.dart';

enum profilePictureType { none, lightning, onchain }

class Avatar extends StatelessWidget {
  final profilePictureType? type;
  final String? profileId;
  final Uri? mxContent;
  final String? name;
  final double size;
  final void Function()? onTap;
  static const double defaultSize = AppTheme.cardPadding * 2;
  final Client? client;
  final double fontSize;

  const Avatar({
    this.type = profilePictureType.none,
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
    final noPic = mxContent == null ||
        mxContent.toString().isEmpty ||
        mxContent.toString() == 'null';

    final textWidget = Center(
      child:
        Icon(Icons.person_2_rounded, size: size / 2, color: Colors.white,),
    );
    final borderRadius = BorderRadius.circular(size / 2.5);

    // Apply the orange gradient when profilePictureType is either onchain or lightning
    final isSpecialType = type == profilePictureType.onchain || type == profilePictureType.lightning;
    //final containerColor = isSpecialType ? Colors.orange : (noPic ? name?.lightColorAvatar : Theme.of(context).secondaryHeaderColor);
    final borderPadding =  isSpecialType ?  size / 30 : 0.0;

    final container = ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        borderRadius: borderRadius,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
           gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isSpecialType ? AppTheme.colorBitcoin : Theme.of(context).secondaryHeaderColor,
                isSpecialType ? AppTheme.colorPrimaryGradient : Theme.of(context).secondaryHeaderColor,
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(borderPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular((size - borderPadding * 2) / 2.5,)),
              color: Theme.of(context).secondaryHeaderColor,
            ),
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
    if (onTap == null) return container;
    return InkWell(
      onTap: onTap ?? () => context.go("/showprofile/:$profileId"),
      borderRadius: borderRadius,
      child: container,
    );
  }
}
