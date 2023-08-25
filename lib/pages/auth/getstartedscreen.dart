import 'dart:ui';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:vrouter/vrouter.dart';

class GetStartedScreen extends StatefulWidget {
  // function to toggle between login and reset password screens

  GetStartedScreen({Key? key}) : super(key: key);
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final Future<LottieComposition> _compostionBitcoin;

  @override
  void initState() {
    super.initState();
    _compostionBitcoin =
        loadComposition('assets/lottiefiles/bitcoinanimation.json');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      extendBodyBehindAppBar: true,
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
              color: Colors.transparent,
              width: double.infinity,
              child: FutureBuilder(
                future: _compostionBitcoin,
                builder: (context, snapshot) {
                  var composition = snapshot.data;
                  if (composition != null) {
                    return FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Lottie(
                        composition: composition,
                        repeat: false,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 6,
            ),
            LongButtonWidgetTransparent(
              title: L10n.of(context)!.restoreAccount,
              onTap: () {
                VRouter.of(context).to('/login');
              },
            ),
            // creating the signup button
            SizedBox(height: AppTheme.cardPadding),
            LongButtonWidget(
                title: L10n.of(context)!.register,
                onTap: () async {
                  VRouter.of(context).to('/pinverification');
                })
          ],
        ),
      ),
    );
  }
} //
