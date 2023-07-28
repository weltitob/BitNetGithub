import 'package:BitNet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  const CoinLogoWidgetSmall({
    Key? key,
    required this.coinid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://s2.coinmarketcap.com/static/img/coins/64x64/";

    return Container(
        height: 30.0,
        width: 30.0,
        child: CachedNetworkImage(
          imageUrl: ((coinIconUrl + coinid.toString() + ".png").toLowerCase()),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              SvgPicture.asset('assets/icons/dollar.svg'),
        ));
  }
}