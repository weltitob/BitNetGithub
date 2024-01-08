import 'package:flutter/material.dart';

class CardData {
  final String lottieAssetPath;
  final String mainTitle;
  final String subTitle;
  final String buttonText;
  final VoidCallback onButtonTap;

  CardData({
    required this.lottieAssetPath,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.onButtonTap,
  });
}

List<CardData> cardDataList = [
  CardData(
    lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
    mainTitle: "We fight for Bitcoinization!",
    subTitle: "We enable people to use bitcoin in a simple manner!",
    buttonText: "Send BTC",
    onButtonTap: () {},
  ),
  CardData(
    lottieAssetPath: 'assets/lottiefiles/plant.json',
    mainTitle: "We grow the Bitcoin Network!",
    subTitle: "We will grow Bitcoin to be much more than just a currency!",
    buttonText: "Get a profile",
    onButtonTap: () {},
  ),
  CardData(
    lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
    mainTitle: "We give the power back to the people!",
    subTitle: "We own our data and digital identity!",
    buttonText: "Explore BTC",
    onButtonTap: () {},
  ),
];
