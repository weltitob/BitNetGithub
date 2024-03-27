import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/pages/wallet/actions/send/lightning_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/onchain_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

// Define a stateful widget called SendBTCScreen, which allows the user to send Bitcoin
class SendBTCScreen extends StatelessWidget {
  final SendController controller;

  const SendBTCScreen(
      {Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Builds the screen scaffold
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      // Disables resizing when the keyboard is shown

      appBar: bitnetAppBar(
        onTap: (){          VRouter.of(context).to("/feed");
        },
        customTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adds a title for the screen
            Text("Bitcoin versenden",
                style: Theme.of(context).textTheme.titleLarge),
            // Displays the user's wallet balance
            // Text("${userWallet.walletBalance}BTC verfügbar",
            //     style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        context: context,
        actions: [
          // Adds a button to the appbar that navigates to the QRScanner screen
          GestureDetector(
            onTap: () {},
            child: AppBarActionButton(
                iconData: controller.sendType == SendType.Invoice ? FontAwesomeIcons.boltLightning : FontAwesomeIcons.bitcoin,
               ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.sendType == SendType.Invoice
                ? LightningSendTab(
              controller: controller,) : OnChainSendTab(
              controller: controller,
            )
          ),
        ],
      ),
    );
  }
}
