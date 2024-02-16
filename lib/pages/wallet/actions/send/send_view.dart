import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/pages/wallet/actions/send/lightning_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

// Define a stateful widget called SendBTCScreen, which allows the user to send Bitcoin
class SendBTCScreen extends StatelessWidget {
  final SendController controller;

  const SendBTCScreen(
      {Key? key, required this.controller})
      : super(key: key);

  // Create a state object for SendBTCScreen
  // The following function builds the widget tree for the screen
  @override
  Widget build(BuildContext context) {
    // Retrieves userWallet using the Provider
    //final userWallet = Provider.of<UserWallet>(context);
    final userWallet = UserWallet(walletAddress: "fakewallet",
        walletType: "walletType", walletBalance: "0", privateKey: "privateKey", userdid: "userdid");

    // Builds the screen scaffold
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      // Disables resizing when the keyboard is shown

      appBar: bitnetAppBar(
        // Adds a back button to the appbar
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
                iconData: FontAwesomeIcons.boltLightning,
               ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LightningSendTab(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
