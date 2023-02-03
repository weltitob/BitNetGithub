import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/pages/actions/receivescreen.dart';
import 'package:nexus_wallet/pages/actions/sendscreen.dart';
import 'package:nexus_wallet/components/balancecard.dart';
import 'package:nexus_wallet/components/cryptoitem.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<LottieComposition> _composition;
  bool _loadinglottiefiles = true;

  // Future<LottieComposition> _loadComposition() async {
  //   var assetData = await rootBundle.load('assets/LottieLogo1.json');
  //   return await LottieComposition.(assetData);
  // }


  final PageController _controller = PageController();
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    // _composition = _loadComposition();
    _loadinglottiefiles = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _loadinglottiefiles ? avatarGlow(context, Icons.currency_bitcoin_rounded) :
      LiquidPullToRefresh(
      color: lighten(AppTheme.colorBackground, 10),
      showChildOpacityTransition: false,
      height: 200,
      backgroundColor: lighten(AppTheme.colorBackground, 20),
      onRefresh: _handleRefresh,
      child: ListView(
        padding: const EdgeInsets.only(
            top: AppTheme.cardPadding * 3, bottom: AppTheme.cardPadding),
        children: [
          const SizedBox(height: 36),
          SizedBox(
            height: 200,
            child: PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              children: const [
                BalanceCardEur(), BalanceCardBtc(),
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
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text("Cryptos", style: Theme.of(context).textTheme.headline6,),
          ),
          const SizedBox(height: AppTheme.cardPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final currency in MockFavorites.data) ...[
                  CryptoItem(currency: currency, context: context,),
                  const SizedBox(height: 16),
                ],],),),
          const SizedBox(height: AppTheme.cardPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text("Actions", style: Theme.of(context).textTheme.headline6,),
          ),
          const SizedBox(height: AppTheme.cardPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               GestureDetector(
                onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                    const SendBTCScreen(),),),
                 child: circButtonWidget(
                     "Send",
                     "https://assets7.lottiefiles.com/packages/lf20_6q3x8d8e.json",
                     const BackgroundGradientPurple()),),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReceiveScreen(),),),
                  child: circButtonWidget(
                      "Receive",
                      "https://assets10.lottiefiles.com/private_files/lf30_0vn96xcf.json",
                      const BackgroundGradientOrange()),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.cardPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          //   child: Text("Latest Activity", style: Theme.of(context).textTheme.headline6,),
          // ),
          // const SizedBox(height: AppTheme.cardPadding),
        ],
      ),
    ),
    );
  }

  Widget circButtonWidget(String text, String lottieNetworkFile, Widget background){
    return Container(
      height: 120,
      width: 140,
      decoration: BoxDecoration(
        color: AppTheme.glassMorphColorLight,
        borderRadius: AppTheme.cardRadiusBig,
      ),
        child: Stack(
          children: [
            background,
            Positioned(
              top: -12,
              right: 0,
              child: SizedBox(
                height: 120,
                width: 120,
                child: LottieBuilder.network(
                  lottieNetworkFile,
                  onLoaded: (composition){
                    setState(() {
                      print('loaded lottiefile');
                      _loadinglottiefiles = false;
                    });
                  },
                  repeat: true,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: AppTheme.cardPadding,),
                  Text(text,
                    style: Theme.of(context).textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w700, color: AppTheme.white90),),
                  const SizedBox(width: AppTheme.elementSpacing,),
                  const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 18,),
                ],
              ),
            )
          ],
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
              AppTheme.colorPrimaryGradient,
              AppTheme.colorBitcoin
              ,],
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
            ],),),
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
            Color(0x99FFFFFF), Color(0x00FFFFFF),
            Color(0x00FFFFFF), Color(0x99FFFFFF),
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
              colors: [Color(0xFF522F77), Color(0xFF7127B7),],),),
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