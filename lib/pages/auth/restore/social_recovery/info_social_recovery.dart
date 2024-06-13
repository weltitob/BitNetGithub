import "package:bitnet/backbone/helper/helpers.dart";
import "package:bitnet/backbone/helper/size_extension.dart";
import "package:bitnet/backbone/helper/theme/theme.dart";
import "package:bitnet/components/appstandards/BitNetAppBar.dart";
import "package:bitnet/components/appstandards/BitNetScaffold.dart";
import "package:bitnet/components/buttons/lang_picker_widget.dart";
import "package:bitnet/components/container/futurelottie.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:lottie/lottie.dart";
import 'package:flutter_gen/gen_l10n/l10n.dart';

class InfoSocialRecoveryScreen extends StatefulWidget {
  const InfoSocialRecoveryScreen({super.key});

  @override
  State<InfoSocialRecoveryScreen> createState() =>
      _InfoSocialRecoveryScreenState();
}

class _InfoSocialRecoveryScreenState extends State<InfoSocialRecoveryScreen> {
  late final Future<LottieComposition> key_composition;
  late final Future<LottieComposition> time_composition;
  late final Future<LottieComposition> friends_composition;

  @override
  void initState() {
    super.initState();
    key_composition = loadComposition('assets/lottiefiles/btc_key.json');
    friends_composition =
        loadComposition('assets/lottiefiles/three_friends.json');
    time_composition =
        loadComposition('assets/lottiefiles/time_animation.json');
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
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
        margin: EdgeInsets.symmetric(horizontal: 0)
            ,
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.socialRecoveryInfo,
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          },
          actions: [
            PopUpLangPickerWidget(),
          ],
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1.5.ws),
          child: ListView(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 1.5.h,
              ),
              Text(
                L10n.of(context)!.stepOneSocialRecovery,
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
                      L10n.of(context)!.socialRecoveryTrustSettings,
                      textAlign: TextAlign.left,
                      maxLines: 50,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      height: AppTheme.cardPadding * 5.h,
                      width: AppTheme.cardPadding * 5.ws,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppTheme.cardRadiusMid,
                            color: Colors.orange.withAlpha(2),
                          ),
                          child: buildFutureLottie(key_composition, true))),
                ],
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2.h,
              ),
              Text(
                L10n.of(context)!.recoveryStep2,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: AppTheme.cardPadding.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: AppTheme.cardPadding * 6.h,
                      width: AppTheme.cardPadding * 6.ws,
                      color: Colors.transparent,
                      child: buildFutureLottie(friends_composition, true)),
                  SizedBox(
                    width: AppTheme.cardPadding.ws,
                  ),
                  Expanded(
                    child: Text(
                      L10n.of(context)!.askFriendsForRecovery,
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
                L10n.of(context)!.recoveryStepThree,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: AppTheme.elementSpacing.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      L10n.of(context)!.recoverySecurityIncrease,
                      textAlign: TextAlign.left,
                      maxLines: 50,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: AppTheme.cardPadding * 6.h,
                      width: AppTheme.cardPadding * 6.ws,
                      color: Colors.transparent,
                      child: buildFutureLottie(time_composition, true)),
                ],
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2.h,
              )
            ],
          ),
        ),
      );
    });
  }
}
