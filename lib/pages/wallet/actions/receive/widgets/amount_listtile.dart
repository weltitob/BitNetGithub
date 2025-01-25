import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/widgets/createinvoicebottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AmountSpecifierListTile extends StatefulWidget {
  @override
  State<AmountSpecifierListTile> createState() => _AmountSpecifierListTileState();
}

class _AmountSpecifierListTileState extends State<AmountSpecifierListTile> {
  final overlayController = Get.find<OverlayController>();
  final controller = Get.find<ReceiveController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final receiveType = controller.receiveType.value;

      return BitNetListTile(
        onTap: () async {
          if (receiveType == ReceiveType.Lightning_b11) {
            // Lightning-specific logic
            await BitNetBottomSheet(
              context: context,
              height: MediaQuery.of(context).size.height * 0.7,
              child: bitnetScaffold(
                extendBodyBehindAppBar: true,
                appBar: bitnetAppBar(
                  hasBackButton: false,
                  buttonType: ButtonType.transparent,
                  text: L10n.of(context)!.changeAmount,
                  context: context,
                ),
                body: SingleChildScrollView(
                  child: CreateInvoice(),
                ),
                context: context,
              ),
            );
          } else if (receiveType == ReceiveType.OnChain_taproot ||
              receiveType == ReceiveType.OnChain_segwit) {
            // On-chain-specific logic
            await BitNetBottomSheet(
              context: context,
              height: MediaQuery.of(context).size.height * 0.7,
              child: bitnetScaffold(
                extendBodyBehindAppBar: true,
                appBar: bitnetAppBar(
                  hasBackButton: false,
                  buttonType: ButtonType.transparent,
                  text: "Change Amount",
                  context: context,
                ),
                body: SingleChildScrollView(
                  child: CreateInvoice(
                    onChain: true,
                  ),
                ),
                context: context,
              ),
            );

            // Update the state immediately after closing the bottom sheet
            setState(() {
              controller.btcControllerNotifier.value =
                  controller.btcControllerOnChain.text;
            });
          }

          // Update the state for Lightning logic
          setState(() {});
        },
        text: L10n.of(context)!.amount,
        trailing: Row(
          children: [
            Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.brightness == Brightness.dark
                  ? AppTheme.white60
                  : AppTheme.black80,
            ),
            const SizedBox(width: AppTheme.elementSpacing / 2),
            Text(
              receiveType == ReceiveType.Lightning_b11
                  ? (controller.satController.text == "0" ||
                  controller.satController.text.isEmpty
                  ? L10n.of(context)!.changeAmount
                  : controller.satController.text)
                  : (controller.satControllerOnChain.text == "0" ||
                  controller.satControllerOnChain.text.isEmpty
                  ? "Change Amount"
                  : controller.satControllerOnChain.text),
            ),
            if ((receiveType == ReceiveType.Lightning_b11 &&
                controller.satController.text != "0" &&
                controller.satController.text.isNotEmpty) ||
                (receiveType != ReceiveType.Lightning_b11 &&
                    controller.satControllerOnChain.text != "0" &&
                    controller.satControllerOnChain.text.isNotEmpty))
              Icon(
                getCurrencyIcon(BitcoinUnits.SAT.name),
                color: Theme.of(context).brightness == Brightness.light
                    ? AppTheme.black70
                    : AppTheme.white90,
              ),
          ],
        ),
      );
    });
  }
}
