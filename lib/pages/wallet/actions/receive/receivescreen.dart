import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/pages/wallet/actions/receive/lightning_receive_tab.dart';
import 'package:bitnet/pages/wallet/actions/receive/onchain_receive_tab.dart';
import 'package:bitnet/pages/wallet/actions/receive/receive.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// This class is a StatefulWidget which displays a screen where a user can receive bitcoin
class ReceiveScreen extends StatelessWidget {
  final ReceiveController controller;
  const ReceiveScreen({Key? key, required this.controller}) : super(key: key);

  // This method builds the UI for the ReceiveScreen
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      //extendBodyBehindAppBar: true,
      // The screen background color
      appBar: bitnetAppBar(
        context: context,
        text: "Bitcoin empfangen",
        onTap: () {
          // Navigate back to the previous screen
          context.go("/wallet");
        },
        actions: [
          // Adds a button to the appbar that navigates to the QRScanner screen
          GestureDetector(
            onTap: () {
              controller.switchReceiveType();
            },
            child: AppBarActionButton(
              iconData: controller.receiveType == ReceiveType.Lightning ? FontAwesomeIcons.boltLightning : FontAwesomeIcons.bitcoin,
            ),
          ),
        ],
      ),
      // The screen's body
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // The screen background is a gradient
        // Padding around the screen's contents
        child: Column(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 2.5,
            ),
            Expanded(
              child: controller.receiveType == ReceiveType.Lightning ?
                  LightningReceiveTab(controller: controller,) :
                  OnChainReceiveTab(controller: controller,),
            ),
          ],
        ),
      ), context: context,
    );
  }
}
