import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceCardLightning extends StatelessWidget {
  final WalletController controller;
  const BalanceCardLightning({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          const BalanceBackground2(),
          BalanceTextWidget(
            iconData: FontAwesomeIcons.wallet,
            balance: controller.lightningBalance.balance,
            walletAddress: "safdadasdas",
            currencyEquivalent: 'balanceInEuroOrBTC',
            cardname: 'Lightning',
          ),
          paymentNetworkPicture(context, "assets/images/lightning.png"),
        ],
      ),
    );
  }
}

class BalanceCardBtc extends StatelessWidget {
  final WalletController controller;
  const BalanceCardBtc({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          const BalanceBackground(),
          BalanceTextWidget(
            iconData: FontAwesomeIcons.piggyBank,
            balance: controller.onchainBalance.confirmedBalance,
            walletAddress: "safdadasdas",
            currencyEquivalent: 'balanceInEuroOrBTC',
            cardname: 'On-Chain',
          ),
          paymentNetworkPicture(context, 'assets/images/bitcoin.png')
        ],
      ),
    );
  }
}

class BalanceBackground2 extends StatelessWidget {
  const BalanceBackground2({Key? key}) : super(key: key);

  Widget iconLightning() {
    return Positioned(
        right: 0,
        top: 0,
        child: Icon(
          Icons.bolt,
          size: 150,
          color: Colors.white.withOpacity(0.1),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF522F77),
              Color(0xFF7127B7),
            ],
          ),
        ),
        child: Stack(
          children: [
            iconLightning(),
          ],
        ),
      ),
    );
  }
}

class BalanceBackground extends StatelessWidget {
  const BalanceBackground({Key? key}) : super(key: key);


  Widget iconOnchain() {
    return Positioned(
        right: 0,
        top: 0,
        child: Icon(
          FontAwesomeIcons.chain,
          size: 150,
          color: Colors.white.withOpacity(0.1),
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppTheme.colorBitcoin,
              AppTheme.colorPrimaryGradient,
            ],
          ),
        ),
        child: Stack(
          children: [
            iconOnchain(),
          ],
        ),
      ),
    );
  }
}

class BackgroundGradientOrange extends StatelessWidget {
  const BackgroundGradientOrange({Key? key}) : super(key: key);

  Widget circleBottomLeft() {
    return Positioned(
      left: -40,
      bottom: 0,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, -0.2),
            colors: [
              Color(0x00FFFFFF),
              Color(0x4DFFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBig,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            Color(0x99FFFFFF),
            AppTheme.colorPrimaryGradient,
            AppTheme.colorBitcoin,
            Color(0x99FFFFFF),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBig,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppTheme.colorBitcoin,
                AppTheme.colorPrimaryGradient,
              ],
            ),
          ),
          child: Stack(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundGradientPurple extends StatelessWidget {
  const BackgroundGradientPurple({Key? key}) : super(key: key);


  Widget iconLightning() {
    return Positioned(
        right: 0,
        top: 0,
        child: Icon(
          Icons.bolt,
          size: 150,
          color: Colors.white.withOpacity(0.1),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBig,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            Color(0x99FFFFFF),
            Color(0x00FFFFFF),
            Color(0x00FFFFFF),
            Color(0x99FFFFFF),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBig,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF522F77),
                Color(0xFF7127B7),
              ],
            ),
          ),
          child: Stack(
            children: [
              iconLightning(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget paymentNetworkPicture(BuildContext context, String imageUrl) {
  return Positioned(
    right: AppTheme.cardPadding * 1.25,
    bottom: AppTheme.cardPadding * 1.25,
    child: Container(
      height: AppTheme.cardPadding * 2,
      width: AppTheme.cardPadding * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2),
        color: Theme.of(context).colorScheme.background.withOpacity(0.25),
      ),
      child: Image.asset(
        imageUrl,
      ),
    ),
  );
}


class BalanceTextWidget extends StatelessWidget {
  final String balance;
  final String cardname;
  final String walletAddress;
  final IconData iconData;
  final String currencyEquivalent;

  const BalanceTextWidget({
    Key? key,
    required this.balance,
    required this.walletAddress,
    required this.iconData,
    required this.currencyEquivalent,
    required this.cardname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding * 1.25,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 24, // Replace with your AppTheme.elementSpacing * 1.75 if needed
              ),
              const SizedBox(
                width: 8, // Replace with your AppTheme.elementSpacing if needed
              ),
              Text(
                cardname,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const Spacer(), // Replace with your AppTheme.elementSpacing if needed
          Text(
            "$balance SAT",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 4, // Replace with your AppTheme.elementSpacing * 0.25 if needed
          ),
          Container(
            width: 160, // Replace with your AppTheme.cardPadding * 10 if needed
            child: Text(
              "= $currencyEquivalent€",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
