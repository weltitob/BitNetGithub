import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/components/container/buildroundedbox.dart';
import 'package:nexus_wallet/components/walletstats/walletstats.dart';
import 'package:nexus_wallet/pages/secondpages/bitcoinlivepricetest.dart';
import 'package:nexus_wallet/pages/secondpages/newsscreen.dart';
import 'package:nexus_wallet/theme.dart';

class BitcoinScreen extends StatefulWidget {
  const BitcoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BitcoinScreenState createState() => _BitcoinScreenState();
}

class _BitcoinScreenState extends State<BitcoinScreen>
    with TickerProviderStateMixin {
  final _controller = PageController(viewportFraction: 0.9);

  Future<void> _handleRefresh() async {
    Navigator.pop(context); // pop current page
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const BitcoinScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.colorBackground,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: AppTheme.iconSize,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: LiquidPullToRefresh(
        color: lighten(AppTheme.colorBackground, 10),
        showChildOpacityTransition: false,
        height: 200,
        backgroundColor: lighten(AppTheme.colorBackground, 20),
        onRefresh: _handleRefresh,
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: <Widget>[
            ChartWidget(),
            BitcoinPrice(),
            RoundedContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wallet Statistik",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                WalletStats(),
              ],
            )),
            RoundedContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "News",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                buildNews(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
