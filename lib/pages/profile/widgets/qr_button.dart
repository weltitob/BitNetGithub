import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            hasBackButton: false,
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
                  SizedBox(
                    height: AppTheme.cardPadding * 3,
                  ),
                  Container(
                    height: AppTheme.cardPadding * 12,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: AppTheme.cardRadiusSmall),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.elementSpacing),
                      child: GestureDetector(
                        onTap: () => launchUrlString('https://${AppTheme.currentWebDomain}/#/showprofile/${controller.userData.value.did}'),
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
                          data:
                              'https://${AppTheme.currentWebDomain}/#/showprofile/${controller.userData.value.did}', //this can be used to route to the user
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          // roundEdges: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.cardPadding * 1),
                  LongButtonWidget(
                    customHeight: AppTheme.cardPadding * 2,
                    customWidth: AppTheme.cardPadding * 5,
                    title: L10n.of(context)!.share,
                    leadingIcon: const Icon(Icons.share_rounded),
                    onTap: () {
                      Share.share('https://${AppTheme.currentWebDomain}/showprofile/${controller.userData.value.did}');
                    },
                    buttonType: ButtonType.transparent,
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
            iconColor: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90,
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
