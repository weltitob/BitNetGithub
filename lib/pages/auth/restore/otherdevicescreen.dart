import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/container/futurelottie.dart';
import 'package:BitNet/pages/scan_qr_screen.dart';
import 'package:flutter/material.dart';
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
    device_morph_composition = loadComposition('assets/lottiefiles/device_morph.json');
    verify_user_composition = loadComposition('assets/lottiefiles/verify_user.json');
    scan_qr_composition = loadComposition('assets/lottiefiles/scan_qr.json');
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      context: context,
      appBar: BitNetAppBar(
          text: "Connect with other device",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1.5),
        child: ListView(
          children: [
            SizedBox(height: AppTheme.cardPadding * 1.5,),
            Text(
              "Step 1: Open the app on a different device.",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Launch the BitNet app on an alternative device where your account is already active and logged in.",
                    textAlign: TextAlign.left,
                    maxLines: 50,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  height: AppTheme.cardPadding * 7,
                  width: AppTheme.cardPadding * 7,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppTheme.cardRadiusMid,
                      color: Colors.orange.withAlpha(2),
                    ),
                      child: buildFutureLottie(device_morph_composition, true))
                ),
              ],
            ),

            SizedBox(height: AppTheme.cardPadding * 1,),
            Text(
              "Step 2: Open the QR-Code",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.cardPadding,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: AppTheme.cardPadding * 6,
                    width: AppTheme.cardPadding * 6,
                    color: Colors.transparent,
                    child: buildFutureLottie(verify_user_composition, true)
                ),
                SizedBox(width: AppTheme.cardPadding,),
                Expanded(
                  child: Text(
                    "Navigate to Profile > Settings > Security > Scan QR-Code for Recovery. You will need to verify your identity now.",
                    textAlign: TextAlign.left,
                    maxLines: 50,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding * 2.25,),
            Text(
              "Step 3: Scan the QR-Code with this device",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Press the Button below and scan the QR Code. Wait until the process is finished don't leave the app.",
                    textAlign: TextAlign.left,
                    maxLines: 50,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                    height: AppTheme.cardPadding * 7,
                    width: AppTheme.cardPadding * 7,
                    color: Colors.transparent,
                    child: buildFutureLottie(scan_qr_composition, true)
                ),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding,),
            LongButtonWidget(title: "Scan QR", onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                  const QRScreen(
                    isBottomButtonVisible: true,
                  ),
                ),
              );
            }),
            SizedBox(height: AppTheme.cardPadding * 2,)
          ],
        ),
      ),
    );
  }
}
