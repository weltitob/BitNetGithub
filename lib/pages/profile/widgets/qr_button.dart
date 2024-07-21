import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

class QrButton extends StatelessWidget {
  QrButton({super.key});
  final controller = Get.find<ProfileController>();

  void onQRButtonPressed(BuildContext context) {
    BitNetBottomSheet(
        width: double.infinity,
        context: context,
        child: bitnetScaffold(
          context: context,
          extendBodyBehindAppBar: true,
          appBar: bitnetAppBar(
            onTap: () {
              context.pop(context);
            },
            context: context,
            text: L10n.of(context)!.qrCode,
          ),
          body: Center(
            child: RepaintBoundary(
              key: controller.globalKeyQR,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(AppTheme.cardPadding * 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppTheme.cardRadiusSmall),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.elementSpacing),
                      child: PrettyQrView.data(
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(),
                          image: PrettyQrDecorationImage(
                            image: AssetImage('assets/logo.png'),
                            position: PrettyQrDecorationImagePosition.embedded,
                          ),
                        ),
                        // typeNumber: 5,
                        // size: AppTheme.cardPadding * 10,
                        data: 'did: ${controller.userData.value.did}',
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        // roundEdges: true,
                      ),
                    ),
                  ),
                ],
              ),
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
            left: AppTheme.cardPadding,
            top: AppTheme.cardPadding,
          ),
          child: RoundedButtonWidget(
            iconData: Icons.qr_code_rounded,
            iconColor: Theme.of(context).brightness == Brightness.light
                ? AppTheme.black70
                : AppTheme.white90,
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
