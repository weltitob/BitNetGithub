import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Example only. Use your actual imports and references.
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

// Suppose your ReceiveController has something like:


class BitNetBottomSheet_ReceiveType extends StatefulWidget {
  const BitNetBottomSheet_ReceiveType({Key? key}) : super(key: key);

  @override
  State<BitNetBottomSheet_ReceiveType> createState() =>
      _BitNetBottomSheet_ReceiveTypeState();
}

class _BitNetBottomSheet_ReceiveTypeState
    extends State<BitNetBottomSheet_ReceiveType> {

  final ReceiveController _receiveController = ReceiveController();

  @override
  Widget build(BuildContext context) {
    final receiveType = _receiveController.receiveType;

    return BitNetListTile(
      // For demonstration, the main tile opens a bottom sheet with the two "sub-tiles."
      text: "Type",
      trailing: LongButtonWidget(
        buttonType: ButtonType.transparent,
        title: receiveType == ReceiveType.Lightning_b11
            ? 'Lightning B11'
            : 'Onchain Taproot',
        leadingIcon: Icon(
          receiveType == ReceiveType.Lightning_b11
              ? FontAwesomeIcons.bolt
              : FontAwesomeIcons.chain,
          size: AppTheme.cardPadding * 0.75,
        ),
        onTap: () {
          // Show the sheet with our two receive-type options:
          showReceiveTypeSheet(context);
        },
        customWidth: receiveType == ReceiveType.Lightning_b11
            ? AppTheme.cardPadding * 6.5
            : AppTheme.cardPadding * 7,
        customHeight: AppTheme.cardPadding * 1.5,
      ),
      onTap: () {
        // If you also want tapping this list tile to open the same sheet:
        showReceiveTypeSheet(context);
      },
    );
  }

  /// Shows a bottom sheet with two `BitNetListTile`s: Lightning vs. Onchain
  Future<void> showReceiveTypeSheet(BuildContext context) async {
    final currentType = _receiveController.receiveType;

    await BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.4,
      child: bitnetScaffold(
        appBar: bitnetAppBar(
          hasBackButton: false,
          buttonType: ButtonType.transparent,
          text: "Select Receive Type",
          context: context,
        ),
        // This can be a ListView, Column, or whatever layout you prefer:
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BitNetListTile(
                text: "Lightning Bolt11",
                // Make sure your BitNetListTile supports `isSelected`.
                selected: currentType == ReceiveType.Lightning_b11,
                leading: const Icon(FontAwesomeIcons.bolt,
                    size: AppTheme.cardPadding * 0.75),
                onTap: () {
                  setState(() {
                    _receiveController.setReceiveType(ReceiveType.Lightning_b11);
                  });
                  Navigator.of(context).pop(); // Close sheet
                },
              ),
              BitNetListTile(
                text: "Onchain Taproot",
                selected: currentType == ReceiveType.OnChain_taproot,
                leading: const Icon(FontAwesomeIcons.chain,
                    size: AppTheme.cardPadding * 0.75),
                onTap: () {
                  setState(() {
                    _receiveController.setReceiveType(ReceiveType.OnChain_taproot);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        context: context,
      ),
    );

    // After the user chooses and the sheet closes, refresh this widget:
    setState(() {});
  }
}
