import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/qrscannersperate.dart';
import 'package:nexus_wallet/components/sendappbar.dart';
import 'package:nexus_wallet/theme.dart';

class SendBTCScreen extends StatefulWidget {
  const SendBTCScreen({Key? key}) : super(key: key);

  @override
  State<SendBTCScreen> createState() => _SendBTCScreenState();
}

class _SendBTCScreenState extends State<SendBTCScreen> {
  TextEditingController listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: appBarSend(context),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
            Text(
              "Scan QR-Code",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            const Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: QRCodeScannerSeperate(),
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
            Text(
              "OR paste adress",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            Glassmorphism(
              blur: 20,
              opacity: 0.1,
              radius: 50.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.5),
                height: 50,
                width: 500,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: listController,
                  autofocus: false,
                  style: TextStyle(color: AppTheme.white90),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Bitcoin adress",
                    hintStyle: TextStyle(
                        color: AppTheme.white60),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
          ],
        ),
      ),
    );
  }
}
