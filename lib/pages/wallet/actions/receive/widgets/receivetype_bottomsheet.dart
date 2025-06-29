import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:get/get.dart';

class BitNetBottomSheetReceiveType extends StatefulWidget {
  const BitNetBottomSheetReceiveType({Key? key}) : super(key: key);

  @override
  State<BitNetBottomSheetReceiveType> createState() =>
      BitNetBottomSheetReceiveTypeState();
}

class BitNetBottomSheetReceiveTypeState
    extends State<BitNetBottomSheetReceiveType> {
  final ReceiveController receiveController = Get.find<ReceiveController>();

  @override
  Widget build(BuildContext context) {
    ReceiveType receiveType = receiveController.receiveType.value;

    return Obx(() {
      final receiveType = receiveController.receiveType.value;

      return BitNetListTile(
        text: "Type",
        trailing: LongButtonWidget(
          buttonType: ButtonType.transparent,
          title: getReceiveTypeLabel(receiveType),
          leadingIcon: getReceiveTypeIconWidget(receiveType),
          onTap: () {
            showReceiveTypeSheet(context);
          },
          customWidth: AppTheme.cardPadding * 6.w,
          customHeight: AppTheme.cardPadding * 1.5.h,
        ),
        onTap: () {
          showReceiveTypeSheet(context);
        },
      );
    });
  }

  String getReceiveTypeLabel(ReceiveType receiveType) {
    switch (receiveType) {
      case ReceiveType.Combined_b11_taproot:
        return 'Combined';
      case ReceiveType.Lightning_b11:
        return 'Lightning';
      case ReceiveType.OnChain_taproot:
        return 'Onchain';
      default:
        return 'Unknown Type';
    }
  }

  Widget getReceiveTypeIconWidget(ReceiveType receiveType) {
    switch (receiveType) {
      case ReceiveType.Combined_b11_taproot:
        return const Icon(FontAwesomeIcons.bitcoin,
            size: AppTheme.cardPadding * 0.75);
      case ReceiveType.Lightning_b11:
        return const Icon(FontAwesomeIcons.bolt,
            size: AppTheme.cardPadding * 0.75);
      case ReceiveType.OnChain_taproot:
        return const Icon(FontAwesomeIcons.chain,
            size: AppTheme.cardPadding * 0.75);
      default:
        return const Icon(FontAwesomeIcons.questionCircle,
            size: AppTheme.cardPadding * 0.75);
    }
  }

  Future<void> showReceiveTypeSheet(BuildContext context) async {
    final currentType = receiveController.receiveType.value;

    await BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.45,
      child: bitnetScaffold(
        appBar: bitnetAppBar(
          hasBackButton: false,
          buttonType: ButtonType.transparent,
          text: "Select Receive Type",
          context: context,
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BitNetListTile(
                text: "Combined",
                selected: currentType == ReceiveType.Combined_b11_taproot,
                trailing: Text(
                  "Bolt 11 + Taproot",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                leading: RoundedButtonWidget(
                  buttonType: ButtonType.transparent,
                  iconData: FontAwesomeIcons.bitcoin,
                  size: AppTheme.cardPadding * 1.25,
                  onTap: () {
                    receiveController
                        .setReceiveType(ReceiveType.Combined_b11_taproot);

                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  receiveController
                      .setReceiveType(ReceiveType.Combined_b11_taproot);

                  Navigator.of(context).pop();
                },
              ),
              BitNetListTile(
                text: "Lightning",
                selected: currentType == ReceiveType.Lightning_b11,
                trailing: Text(
                  "Bolt 11",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                leading: RoundedButtonWidget(
                  buttonType: ButtonType.transparent,
                  iconData: FontAwesomeIcons.bolt,
                  size: AppTheme.cardPadding * 1.25,
                  onTap: () {
                    receiveController.setReceiveType(ReceiveType.Lightning_b11);

                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  receiveController.setReceiveType(ReceiveType.Lightning_b11);

                  Navigator.of(context).pop();
                },
              ),
              BitNetListTile(
                text: "Onchain",
                selected: currentType == ReceiveType.OnChain_taproot,
                leading: RoundedButtonWidget(
                  buttonType: ButtonType.transparent,
                  size: AppTheme.cardPadding * 1.25,
                  iconData: FontAwesomeIcons.chain,
                  onTap: () {
                    receiveController
                        .setReceiveType(ReceiveType.OnChain_taproot);

                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  receiveController.setReceiveType(ReceiveType.OnChain_taproot);

                  Navigator.of(context).pop();
                },
                trailing: Text(
                  "Taproot",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              BitNetListTile(
                text: "Tokens",
                selected: currentType == ReceiveType.TokenTaprootAsset,
                leading: RoundedButtonWidget(
                  size: AppTheme.cardPadding * 1.25,
                  buttonType: ButtonType.transparent,
                  iconData: FontAwesomeIcons.coins,
                  onTap: () {
                    receiveController
                        .setReceiveType(ReceiveType.OnChain_taproot);

                    Navigator.of(context).pop();
                  },
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    size: AppTheme.cardPadding * 1),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        context: context,
      ),
    );
  }
}
