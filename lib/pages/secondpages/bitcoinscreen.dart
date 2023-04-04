import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:BitNet/components/chart/chart.dart';
import 'package:BitNet/components/container/buildroundedbox.dart';
import 'package:BitNet/pages/secondpages/newsscreen.dart';
import 'package:BitNet/backbone/helper/theme.dart';

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
    print("Fetch data new");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colorBackground,
      child: LiquidPullToRefresh(
        color: lighten(AppTheme.colorBackground, 10),
        showChildOpacityTransition: false,
        height: 200,
        onRefresh: _handleRefresh,
        child: Scaffold(
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
          body: PageView(
              scrollDirection: Axis.vertical,
              controller: _controller,
              children: <Widget>[
                ChartWidget(),
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
      ),
    );
  }
}
