import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrButton extends StatelessWidget {
  const QrButton({super.key});

  void onQRButtonPressed(BuildContext context) {
    final controller = Get.find<ProfileController>();
    BitNetBottomSheet(
        context: context,
        title: "Share Profile",
        iconData: Icons.qr_code_rounded,
        child: Center(
          child: RepaintBoundary(
            key: controller.globalKeyQR,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(AppTheme.cardPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusSmall),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.elementSpacing),
                    child: PrettyQr(
                      typeNumber: 5,
                      size: AppTheme.cardPadding * 10,
                      data: 'did: ${controller.userData.did}',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppTheme.elementSpacing,
      left: AppTheme.elementSpacing,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppTheme.cardPadding, top: AppTheme.cardPadding),
          child: RoundedButtonWidget(
            iconData: Icons.qr_code_rounded,
            onTap: () {
              onQRButtonPressed(context);
            },
            buttonType: ButtonType.transparent,
          ),
        ),
      ),
    );
  }
}
