//import 'package:bitnet/l10n/l10n.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:matrix/matrix.dart';

class GetStartedScreen extends StatefulWidget {
  // function to toggle between login and reset password screens

  GetStartedScreen({Key? key}) : super(key: key);
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final Future<LottieComposition> _compostionBitcoin;
  // late Locale deviceLocale;
  // late String langCode;
  // bool initLocale = false;
  @override
  void initState() {
    super.initState();
    _compostionBitcoin =
        loadComposition('assets/lottiefiles/bitcoinanimation.json');
    //  deviceLocale = PlatformDispatcher.instance.locale;// or html.window.locale
    //  langCode = deviceLocale.languageCode;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
//     if(!initLocale) {
// Provider.of<LocalProvider>(context, listen: false)
//             .setLocaleInDatabase(langCode,
//             deviceLocale, isUser: false);
//             initLocale = true;
//     }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

      double bigtextWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 24
              : AppTheme.cardPadding * 28
          : AppTheme.cardPadding * 30;
      double textWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 22
          : AppTheme.cardPadding * 24;
      double subtitleWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 14
              : AppTheme.cardPadding * 18
          : AppTheme.cardPadding * 22;
      double spacingMultiplier = isMidScreen
          ? isSmallScreen
              ? 0.5
              : 0.75
          : 1;
      double centerSpacing = isMidScreen
          ? isSmallScreen
              ? AppTheme.columnWidth * 0.15
              : AppTheme.columnWidth * 0.65
          : AppTheme.columnWidth;

      return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(context: context, hasBackButton: false, actions: [
          PopUpLangPickerWidget(),
        ]),
        context: context,
        backgroundColor: Theme.of(context).colorScheme.background,
        margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        body: Container(
          margin: EdgeInsets.only(
              top: AppTheme.cardPadding * 8,
              bottom: AppTheme.cardPadding * 2,
              left: AppTheme.cardPadding,
              right: AppTheme.cardPadding),
          height: MediaQuery.of(context).size.height,
          child: Column(
            // even space distribution
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                width: AppTheme.cardPadding * 20 * spacingMultiplier,
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
                      return Container(
                        height: AppTheme.cardPadding,
                        width: AppTheme.cardPadding,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 6,
              ),
              LongButtonWidget(
                customWidth: AppTheme.cardPadding * 14,
                buttonType: ButtonType.transparent,
                title: L10n.of(context)!.restoreAccount,
                onTap: () {
                  context.go('/authhome/login');
                },
              ),
              // creating the signup button
              SizedBox(height: AppTheme.cardPadding),
              LongButtonWidget(
                  customWidth: AppTheme.cardPadding * 14,
                  title: L10n.of(context)!.register,
                  onTap: () async {
                    context.go('/authhome/pinverification');
                  }),
              SizedBox(height: AppTheme.cardPadding * 4),
              Container(
                margin: EdgeInsets.only(
                    top: AppTheme.cardPadding, bottom: AppTheme.cardPadding),
                child: GestureDetector(
                  onTap: () {
                    Logs().w("AGBS and Impressum was clicked");
                    // context.go('/authhome/login');
                  },
                  child: Text(
                    "AGBS and Impressum",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
} //

