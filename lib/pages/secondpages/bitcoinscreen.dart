import 'package:bitnet/components/appstandards/bitnetAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/pages/secondpages/newsscreen.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

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
    return bitnetScaffold(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: bitnetAppBar(
          text: "Bitcoin chart",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 3,
              ),
              ChartWidget(),
            ],
          ),
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
    );
  }
}
