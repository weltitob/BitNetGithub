import 'dart:async';
import 'package:BitNet/components/resultlist/transactions.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/profile/actions/receivescreen.dart';
import 'package:BitNet/pages/profile/actions/sendscreen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/cloudfunctions/getbalance.dart';
import 'package:BitNet/backbone/cloudfunctions/gettransactions.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/components/cards/balancecard.dart';
import 'package:BitNet/models/user/userwallet.dart';
import 'package:BitNet/components/items/cryptoitem.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with AutomaticKeepAliveClientMixin{
  late final Future<LottieComposition> _compositionRocket;
  late final Future<LottieComposition> _compositionSend;
  late final Future<LottieComposition> _compositionReceive;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _compositionRocket = loadComposition('assets/lottiefiles/rocket.json');
    _compositionSend = loadComposition('assets/lottiefiles/senden.json');
    _compositionReceive = loadComposition('assets/lottiefiles/erhalten.json');
    updatevisibility();
  }

  void updatevisibility() async {
    await _compositionRocket;
    await _compositionSend;
    await _compositionReceive;
    var timer = Timer(Duration(milliseconds: 50),
            () {
          setState(() {
            _visible = true;
          });
        }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController _controller = PageController();

  Future<void> _handleRefresh() async {
    final userData = Provider.of<UserData>(context, listen: false);
    final userWallet = userData.mainWallet;
    await getBalance(userWallet);
    await getTransactions(userWallet);
  }

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LiquidPullToRefresh(
        color: lighten(AppTheme.colorBackground, 10),
        showChildOpacityTransition: false,
        height: 200,
        backgroundColor: lighten(AppTheme.colorBackground, 20),
        onRefresh: _handleRefresh,
        child: ListView(
          children: [
            const SizedBox(height: AppTheme.cardPadding * 2),
            SizedBox(
              height: 200,
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          const BalanceBackground2(),
                          Positioned(
                            right: -AppTheme.elementSpacing,
                            bottom: -AppTheme.elementSpacing,
                            child: SizedBox(
                              height: AppTheme.cardPadding * 8,
                              width: AppTheme.cardPadding * 8,
                              child: FutureBuilder(
                                future: _compositionRocket,
                                builder: (context, snapshot) {
                                  var composition = snapshot.data;
                                  if (composition != null) {
                                    return FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: AnimatedOpacity(
                                        opacity: _visible ? 1.0 : 0.0,
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
                          Padding(
                            padding: const EdgeInsets.all(28),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Willkommen bei',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "NexusWallet",
                                  // NumberFormat.simpleCurrency().format(MockBalance.data.last),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    color: Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                        AppTheme.elementSpacing,
                                        vertical:
                                        AppTheme.elementSpacing / 2),
                                    child: Text(
                                      "Simpel & Schnell",
                                      // NumberFormat.simpleCurrency().format(MockBalance.data.last),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BalanceCardBtc(),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
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
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SendBTCScreen(bitcoinSenderAdress: userData.mainWallet.walletAddress,),
                      ),
                    ),
                    child: circButtonWidget("Senden", _compositionSend,
                        const BackgroundGradientPurple()),
                  ),
                  GestureDetector(
                    onTap: () {
                      //getTransactions(userWallet);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ReceiveScreen(),
                        ));
                    },
                    child: circButtonWidget(
                        "Erhalten",
                        _compositionReceive,
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

  Widget circButtonWidget(String text, dynamic comp, Widget background) {
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
                        opacity: _visible ? 1.0 : 0.0,
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