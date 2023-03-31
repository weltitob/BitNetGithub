import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/theme/theme.dart';

Widget currencyPicture(BuildContext context) {
  return Positioned(
    right: AppTheme.cardPaddingBig,
    top: AppTheme.cardPaddingBig,
    child: Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
      ),
      child: CachedNetworkImage(
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png',
      ),
    ),
  );
}