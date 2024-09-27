//import 'package:bitnet/l10n/l10n.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final Future<LottieComposition> _compostionBitcoin;
  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ProtocolController>()) {
      Get.put(ProtocolController(logIn: false));
    }

    _compostionBitcoin = loadComposition('assets/lottiefiles/bitcoinanimation.json');
  }

  @override
  Widget build(BuildContext context) {
    LoggerService logger = Get.find();
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      bool isSmallScreen = 375.w < AppTheme.isSmallScreen;
      bool isMidScreen = 375.w < AppTheme.isMidScreen;

      double spacingMultiplier = isMidScreen
          ? isSmallScreen
              ? 0.5
              : 0.75
          : 1;
      return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(context: context, hasBackButton: false, actions: [
          const PopUpLangPickerWidget(),
        ]),
        context: context,
        backgroundColor: Theme.of(context).colorScheme.surface,
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        body: Container(
          margin: EdgeInsets.only(
            top: AppTheme.cardPadding * 1.hs,
            bottom: AppTheme.cardPadding * 2.hs,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            // even space distribution
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 4.h,
              ),
              Container(
                color: Colors.transparent,
                width: (AppTheme.cardPadding * 20 * spacingMultiplier.ws),
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
                height: AppTheme.cardPadding * 6.h,
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
              const SizedBox(height: AppTheme.cardPadding),
              LongButtonWidget(
                  customWidth: AppTheme.cardPadding * 14.h,
                  title: L10n.of(context)!.register,
                  onTap: () async {
                    context.go('/authhome/pinverification');
                  }),
              SizedBox(height: AppTheme.cardPadding * 1.h),
              Container(
                margin: const EdgeInsets.only(top: AppTheme.cardPadding, bottom: 2),
                child: GestureDetector(
                  onTap: () {
                    logger.i("AGBS and Impressum was clicked");
                  },
                  child: TextButton(
                    onPressed: () => context.push("/agbs"),
                    child: Text(
                      "AGBS and Impressum",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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

