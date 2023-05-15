import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/pages/auth/qr_otherdevicescreen.dart';
import 'package:BitNet/pages/qrscreen.dart';
import 'package:flutter/material.dart';

class OtherDeviceScreen extends StatefulWidget {
  const OtherDeviceScreen({Key? key}) : super(key: key);

  @override
  State<OtherDeviceScreen> createState() => _OtherDeviceScreenState();
}

class _OtherDeviceScreenState extends State<OtherDeviceScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: ListView(
          children: [
            SizedBox(height: AppTheme.cardPadding * 2 ,),
            Text(
              "Step 1: Open the app on a different device.",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            Text(
              "Launch the BitNet application on an alternative device (such as another smartphone, tablet, or computer) where your account is already active and logged in.",
              textAlign: TextAlign.left,
              maxLines: 50,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppTheme.cardPadding * 2,),
            Text(
              "Step 2: Open the QR-Code",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            Text(
              "Profile > Settings > Security > Scan QR-Code for Recovery. You will need to verify your identity now.",
              textAlign: TextAlign.left,
              maxLines: 50,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppTheme.cardPadding * 2,),
            Text(
              "Step 3: Scan the QR-Code with this device",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            Text(
              "Pasasa.",
              textAlign: TextAlign.left,
              maxLines: 50,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: AppTheme.cardPadding * 2,),
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const QROtherDeviceScreen(
                      isBottomButtonVisible: true,
                    ),
                  ),
                ),
                child: avatarGlow(
                  context,
                  Icons.circle,
                )),
          ],
        ),
      ),
    );
  }
}
