import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/components/container/buildroundedbox.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
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
          buildChart(),
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
          ))
        ],
      ),
    );
  }
}
