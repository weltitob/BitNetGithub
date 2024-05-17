import "package:bitnet/backbone/helper/helpers.dart";
import "package:bitnet/backbone/helper/theme/theme.dart";
import "package:bitnet/components/appstandards/BitNetAppBar.dart";
import "package:bitnet/components/appstandards/BitNetScaffold.dart";
import "package:bitnet/components/buttons/lang_picker_widget.dart";
import "package:bitnet/components/container/futurelottie.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:lottie/lottie.dart";

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
    friends_composition = loadComposition('assets/lottiefiles/3_friends.json');
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
        margin: isSuperSmallScreen
            ? EdgeInsets.symmetric(horizontal: 0)
            : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250.w),
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          text: "Social Recovery Info",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          },
          actions: [
            PopUpLangPickerWidget(),
          ],
        ),
        body: Padding(
          padding:   EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding * 1.5.w),
          child: ListView(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 1.5.h,
              ),
              Text(
                "Step 1: Activate social recovery",
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
                      "Social recovery needs to activated in Settings by each user manually. You have to choose 3 friends whom you can meet in person and trust.",
                      textAlign: TextAlign.left,
                      maxLines: 50,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      height: AppTheme.cardPadding * 5.h,
                      width: AppTheme.cardPadding * 5.w,
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
                "Step 2. Contact each of your friends",
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
                      width: AppTheme.cardPadding * 6.w,
                      color: Colors.transparent,
                      child: buildFutureLottie(friends_composition, true)),
                  SizedBox(
                    width: AppTheme.cardPadding.w,
                  ),
                  Expanded(
                    child: Text(
                      "Ask your friends to open the app and navigate to Profile > Settings > Security > Social Recovery for friends.",
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
                "Step 3: Wait 24 hours and then login",
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
                      "To increase security, the recovered user will get contacted, if there is no awnser after 24 hours your account will be freed.",
                      textAlign: TextAlign.left,
                      maxLines: 50,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: AppTheme.cardPadding * 6.h,
                      width: AppTheme.cardPadding * 6.w,
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
