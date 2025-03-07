import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/wallet/actions/send/bip21_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/lightning_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/onchain_send_tab.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

// Define a stateful widget called SendBTCScreen, which allows the user to send Bitcoin
class SendBTCScreen extends GetWidget<SendsController> {
  const SendBTCScreen({
    Key? key,
  }) : super(key: key);

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
        onTap: () {
          controller.usersQuery.value = '';

          controller.resetValues();
          controller.handleSearch('');
        },
        customTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(L10n.of(context)!.sendBitcoin,
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        context: context,
        actions: [
          // Adds a button to the appbar that navigates to the QRScanner screen
          GestureDetector(
            onTap: () {},
            child: AppBarActionButton(
              iconData: controller.sendType == SendType.Invoice
                  ? FontAwesomeIcons.boltLightning
                  : FontAwesomeIcons.bitcoin,
            ),
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          controller.resetValues();
        },
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: controller.initializedValues.value
                    ? controller.sendType == SendType.Bip21
                        ? Bip21SendTab()
                        : (controller.sendType == SendType.Invoice ||
                                controller.sendType == SendType.LightningUrl)
                            ? LightningSendTab()
                            : OnChainSendTab()
                    : dotProgress(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
