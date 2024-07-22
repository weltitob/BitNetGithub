import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/futurelottie.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:lottie/lottie.dart';

class OtherDeviceScreen extends StatefulWidget {
  const OtherDeviceScreen({Key? key}) : super(key: key);

  @override
  State<OtherDeviceScreen> createState() => _OtherDeviceScreenState();
}

class _OtherDeviceScreenState extends State<OtherDeviceScreen> {
  late final Future<LottieComposition> device_morph_composition;
  late final Future<LottieComposition> scan_qr_composition;
  late final Future<LottieComposition> verify_user_composition;

  @override
  void initState() {
    super.initState();
    device_morph_composition =
        loadComposition('assets/lottiefiles/device_morph.json');
    verify_user_composition =
        loadComposition('assets/lottiefiles/verify_user.json');
    scan_qr_composition = loadComposition('assets/lottiefiles/scan_qr.json');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
            text: L10n.of(context)!.connectWithOtherDevices,
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            },
            actions: [PopUpLangPickerWidget()]),
        body: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1.5.ws),
              child: ListView(
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 1.5.h,
                  ),
                  Text(
                    L10n.of(context)!.scanQrStepOne,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          L10n.of(context)!.launchBitnetApp,
                          textAlign: TextAlign.left,
                          maxLines: 50,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        height: AppTheme.cardPadding * 7.h,
                        width: AppTheme.cardPadding * 7.ws,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppTheme.cardRadiusMid,
                            color: Colors.orange.withAlpha(2),
                          ),
                          child: buildFutureLottie(device_morph_composition, true),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 1.h,
                  ),
                  Text(
                    L10n.of(context)!.scanQrStepTwo,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: AppTheme.cardPadding * 6.h,
                          width: AppTheme.cardPadding * 6.ws,
                          color: Colors.transparent,
                          child: buildFutureLottie(verify_user_composition, true)),
                      SizedBox(
                        width: AppTheme.cardPadding.ws,
                      ),
                      Expanded(
                        child: Text(
                          L10n.of(context)!.navQrRecovery,
                          textAlign: TextAlign.left,
                          maxLines: 50,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 2.25.h,
                  ),
                  Text(
                    L10n.of(context)!.scanQrStepThree,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          L10n.of(context)!.pressBtnScanQr,
                          textAlign: TextAlign.left,
                          maxLines: 50,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                          height: AppTheme.cardPadding * 7.h,
                          width: AppTheme.cardPadding * 7.ws,
                          color: Colors.transparent,
                          child: buildFutureLottie(scan_qr_composition, true)),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 3.h,
                  )
                ],
              ),
            ),
            BottomCenterButton(
              buttonTitle: L10n.of(context)!.scanQr,
              onButtonTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QrScanner(
                      //isBottomButtonVisible: true,
                    ),
                  ),
                );
              },
              buttonState: ButtonState.idle,
            ),
          ],
        ),
      );
    });
  }
}
