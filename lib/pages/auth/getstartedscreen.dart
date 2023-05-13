import 'dart:ui';
import 'package:BitNet/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/backbone/helper/theme.dart';


class GetStartedScreen extends StatefulWidget {
  // function to toggle between login and reset password screens
  Function() pushToRegister;
  Function() pushToLogin;

  GetStartedScreen({
    required this.pushToRegister,
    required this.pushToLogin,
  });


  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final Future<LottieComposition> _compostionBitcoin;

  @override
  void initState() {
    super.initState();
    _compostionBitcoin = loadComposition('assets/lottiefiles/bitcoinanimation.json');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      body: Container(
        margin: EdgeInsets.only(
            top: AppTheme.cardPadding * 6,
            bottom: AppTheme.cardPadding * 2,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding),
        height: MediaQuery.of(context).size.height,
        child: Column(
          // even space distribution
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: FutureBuilder(
                future: _compostionBitcoin,
                builder: (context, snapshot) {
                  var composition = snapshot.data;
                  if (composition != null) {
                    return FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Lottie(composition: composition,
                      repeat: false,),
                    );
                  } else {
                    return Container(
                      color: Colors.transparent,
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 6,
            ),
            LongButtonWidgetTransparent(
              title: S.of(context).restoreAccount,
              onTap: () {
                widget.pushToLogin();
              },
            ),
            // creating the signup button
            SizedBox(height: AppTheme.cardPadding),
            LongButtonWidget(
                title: S.of(context).register,
                onTap: () async {
                  //final mnemonic = await Mnemonic.create(WordCount.Words12);
                  //final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.Testnet,
                  //    mnemonic: mnemonic );
                  //print(descriptorSecretKey);
                  widget.pushToRegister();
                })
          ],
        ),
      ),
    );
  }
}//