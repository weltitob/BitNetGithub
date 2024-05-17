//import 'package:bitnet/l10n/l10n.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';


class GetStartedScreen extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

      double spacingMultiplier = isMidScreen
          ? isSmallScreen
              ? 0.5
              : 0.75
          : 1;
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
            top: AppTheme.cardPadding * 5.h,
            bottom: AppTheme.cardPadding * 2.h,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            // even space distribution
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                width: AppTheme.cardPadding * 20 * spacingMultiplier.w,
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
                        height: AppTheme.cardPadding.h,
                        width: AppTheme.cardPadding.w,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 4.h,
              ),
              LongButtonWidget(
                customWidth: AppTheme.cardPadding * 14.h,
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
              SizedBox(height: AppTheme.cardPadding * 3.h),
              Container(
                margin: EdgeInsets.only(
                    top: AppTheme.cardPadding, bottom: AppTheme.cardPadding),
                child: GestureDetector(
                  onTap: () {
                    Logs().w("AGBS and Impressum was clicked");
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

