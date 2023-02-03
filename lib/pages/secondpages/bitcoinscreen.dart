import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/buildroundedbox.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _state = true;
  bool _alarm = false;
  String _selectedCategory = "Test";

  void _onCategoryButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 240,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                children: <Widget>[
                  buildListTile(Icons.analytics, 'Analytics...'),
                  buildListTile(Icons.wallet_giftcard, 'BRRRRRRR'),
                  buildListTile(Icons.wallet_giftcard, 'BRRRRRRR'),
                  buildListTile(Icons.wallet_giftcard, 'BRRRRRRR'),
                ],
              ),
            ),
          );
        });
  }

  //scrollto
  void _selectCategory(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedCategory = name;
    });
  }

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
              color: Theme.of(context).colorScheme.primary,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }
          ),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: const <Widget>[
          buildChart(),
          // BuildRoundedBoxWithText(
          //     text: "Key metrics",
          //     iconData: Icons.vpn_key_rounded,
          //     child: buildKeymetrics(
          //       coin: widget.coin,
          //     )),
          // BuildRoundedBoxWithText(
          //   text: "Analysis",
          //   iconData: Icons.analytics_outlined,
          //   child: AnalysisWidget(),
          // ),
          // BuildRoundedBoxWithText(
          //     text: "News",
          //     iconData: Icons.insert_drive_file_outlined,
          //     child: buildNews()),
          // SizedBox(
          //   height: 100,
          // )
        ],
      ),
    );
  }

  //---------------------------WIDGETS----------------------------------

  buildListTile(IconData iconData, String text) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).primaryColorDark,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onTap: () => _selectCategory('Information'),
    );
  }

  Widget childBuildAnalysisChartLegend(String text, String text2, color) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 14,
            color: color,
          ),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            text2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
