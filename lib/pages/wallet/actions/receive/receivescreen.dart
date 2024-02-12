import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/wallet/actions/receive/lightning_receive_tab.dart';
import 'package:bitnet/pages/wallet/actions/receive/onchain_receive_tab.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

// This class is a StatefulWidget which displays a screen where a user can receive bitcoin
class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // This method builds the UI for the ReceiveScreen
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      //extendBodyBehindAppBar: true,
      // The screen background color
      backgroundColor: AppTheme.colorBackground,
      appBar: bitnetAppBar(
        text: "Bitcoin empfangen",
        onTap: () {
          // Navigate back to the previous screen
          Navigator.pop(context);
        }, context: context,
      ),
      // The screen's body
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // The screen background is a gradient
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topRight,
                colors: [
              Color(0xFF522F77),
              Theme.of(context).colorScheme.background,
                ])),
        // Padding around the screen's contents
        child: Column(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 2.5,
            ),
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: ButtonsTabBar(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.5,
                  horizontal: AppTheme.elementSpacing,
                ),
                borderWidth: 1.5,
                unselectedBorderColor: Colors.transparent,
                borderColor: Colors.white.withOpacity(0.2),
                radius: 100,
                physics: ClampingScrollPhysics(),
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                unselectedDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "Lightning",
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "On Chain",
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  LightningReceiveTab(),
                  OnChainReceiveTab(),
                ],
              ),
            ),
          ],
        ),
      ), context: context,
    );
  }
}
