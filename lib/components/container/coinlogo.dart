import 'package:bitnet/components/loaders/loaders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinLogoWidget extends StatelessWidget {
  final int coinid;
  const CoinLogoWidget({
    Key? key,
    required this.coinid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://s2.coinmarketcap.com/static/img/coins/64x64/";

    return Container(
        height: 40.0,
        width: 40.0,
        child: CachedNetworkImage(
          imageUrl: ((coinIconUrl + coinid.toString() + ".png").toLowerCase()),
          placeholder: (context, url) => avatarGlowProgressSmall(context),
          errorWidget: (context, url, error) =>
              SvgPicture.asset('assets/icons/dollar.svg'),
        ));
  }
}

class CoinLogoWidgetSmall extends StatelessWidget {
  final int coinid;
  final double width;
  final double height;

  const CoinLogoWidgetSmall({
    Key? key,
    required this.coinid,  this.width = 30.0,  this.height = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://s2.coinmarketcap.com/static/img/coins/64x64/";

    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(width * 2)),
        child: CachedNetworkImage(
          imageUrl: ((coinIconUrl + coinid.toString() + ".png").toLowerCase()),
          placeholder: (context, url) => dotProgress(context),
          errorWidget: (context, url, error) =>
              SvgPicture.asset('assets/icons/dollar.svg'),
        ));
  }
}