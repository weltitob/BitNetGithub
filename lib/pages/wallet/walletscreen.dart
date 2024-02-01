import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vrouter/vrouter.dart';

class WalletScreen extends StatelessWidget {
  final WalletController controller;
  const WalletScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final UserData userData = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LiquidPullToRefresh(
        color: lighten(AppTheme.colorBackground, 10),
        showChildOpacityTransition: false,
        height: 200,
        backgroundColor: lighten(AppTheme.colorBackground, 20),
        onRefresh: controller.handleRefresh,
        child: ListView(
          children: [
            const SizedBox(height: AppTheme.cardPadding * 2),
            SizedBox(
              height: 200,
              child: PageView(
                controller: controller.pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  BalanceCardLightning(controller: controller),
                  BalanceCardBtc(controller: controller),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppTheme.colorBitcoin,
                  dotColor: AppTheme.glassMorphColorLight,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Text(
                "Cryptos",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final currency in MockFavorites.data) ...[
                    CryptoItem(
                      currency: currency,
                      context: context,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Text(
                "Aktionen",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => VRouter.of(context).to('/wallet/send'),
                    //onTap: () => VRouter.of(context).to('/wallet/send_choose_receiver'),
                    //onTap: () => VRouter.of(context).to('/wallet/send'), //userData.mainWallet.walletAddress,
                    child: circButtonWidget(
                        context, "Senden", controller.compositionSend,
                        const BackgroundGradientPurple()),
                  ),
                  GestureDetector(
                    onTap: () {
                      VRouter.of(context).to('/wallet/receive');
                    },
                    child: circButtonWidget(
                        context,
                        "Erhalten",
                        controller.compositionReceive,
                        const BackgroundGradientOrange()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Text(
                "Transaktionen",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Transactions(),
          ],
        ),

      ),
    );
  }

  Widget circButtonWidget(BuildContext context, String text, dynamic comp, Widget background) {
    return Container(
      height: 120,
      width: 140,
      decoration: BoxDecoration(
        color: AppTheme.glassMorphColorLight,
        borderRadius: AppTheme.cardRadiusBig,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          background,
          Positioned(
            top: -12,
            right: 0,
            child: SizedBox(
              height: 120,
              width: 120,
              child: FutureBuilder(
                future: comp,
                builder: (context, snapshot) {
                  dynamic composition = snapshot.data;
                  if (composition != null) {
                    return FittedBox(
                      fit: BoxFit.fitHeight,
                      child: AnimatedOpacity(
                        opacity: controller.visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 1000),
                        child: Lottie(composition: composition),
                      ),
                    );
                  } else {
                    return Container(
                      color: Colors.transparent,
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: AppTheme.cardPadding,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700, color: AppTheme.white90),
                ),
                const SizedBox(
                  width: AppTheme.elementSpacing,
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
              AppTheme.colorPrimaryGradient,
              AppTheme.colorBitcoin,
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
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }


}

class BackgroundGradientPurple extends StatelessWidget {
  const BackgroundGradientPurple({Key? key}) : super(key: key);

  Widget circleBottomLeft() {
    return Positioned(
      right: -40,
      top: -20,
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
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }
}