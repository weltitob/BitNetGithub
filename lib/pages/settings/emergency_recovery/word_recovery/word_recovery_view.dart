import 'dart:typed_data';
import 'dart:ui';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/location.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:timezone/timezone.dart' as tz;

// Removed unnecessary empty import

class WordRecoveryView extends StatefulWidget {
  const WordRecoveryView({super.key});

  @override
  State<WordRecoveryView> createState() => WordRecoveryViewState();
}

class WordRecoveryViewState extends State<WordRecoveryView> {
  late String code;
  late String issuer;
  late String did;

  bool hasWrittenDown = false;
  bool isLoadingSignUp = false;
  bool hasFinishedGenWallet = false;
  bool loadingMnemonic = true;
  late Mnemonic mnemonic;
  String mnemonicString = "";
  TextEditingController mnemonicTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getPrivateData(Auth().currentUser!.uid).then((privData) {
      mnemonicString = privData.mnemonic;
      mnemonic = Mnemonic.fromSentence(mnemonicString, Language.english);
      loadingMnemonic = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          if (context.mounted) {
            setState(() {});
          }
        } catch (e) {}
      });
    });
  }

  void processParameters(BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    mnemonicTextController.dispose();
  }

  void confirmMnemonic(String typedMnemonic) async {
    setState(() {
      isLoadingSignUp = true;
    });
    final overlayController = Get.find<OverlayController>();
    LoggerService logger = Get.find();
    logger.i("Confirming mnemonic...");
    logger.i("Typed Mnemonic: $typedMnemonic Mnemonic: $mnemonicString");
    if (mnemonicString == typedMnemonic) {
      overlayController.showOverlay(L10n.of(context)!.mnemonicCorrect,
          color: AppTheme.successColor);
    } else {
      // Implement error throw
      overlayController.showOverlay(L10n.of(context)!.mnemonicInCorrect,
          color: AppTheme.errorColor);
      logger.e("Mnemonic does not match");
      changeWrittenDown();
    }
    setState(() {
      isLoadingSignUp = false;
    });
  }

  void changeWrittenDown() {
    setState(() {
      hasWrittenDown = !hasWrittenDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      processParameters(context);
      SettingsController settingsController = Get.find<SettingsController>();
      int page = settingsController.wordRecoveryState.value;
      mnemonicTextController.text = mnemonicString;

      if (page == 0) {
        return ShowMnemonicView(mnemonic: mnemonicTextController);
      } else if (page == 1) {
        return ShowMnemonicConfirm(mnemonic: mnemonicString);
      } else if (page == 2) {
        return MnemonicConfirmedPage();
      }
      return ShowMnemonicView(mnemonic: mnemonicTextController);
    });
  }
}

class ShowMnemonicView extends StatelessWidget {
  const ShowMnemonicView({
    super.key,
    required this.mnemonic,
  });
  final TextEditingController mnemonic;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 4.h,
              ),
              Icon(
                FontAwesomeIcons.key,
                size: AppTheme.cardPadding * 3.ws,
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2.h,
              ),
              Text(
                L10n.of(context)!.saveYourmnemonicSecurely,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: AppTheme.cardPadding.h,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.ws),
                child: Text(
                  L10n.of(context)!.saveYourmnemonicSecurelyDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              mnemonic.text == ""
                  ? dotProgress(context)
                  : Container(
                      width: AppTheme.cardPadding * 12.ws,
                      child: FormTextField(
                        readOnly: true, // This makes the text field read-only
                        isMultiline: true,
                        controller: mnemonic,
                        //height: AppTheme.cardPadding * 8,
                        //width: AppTheme.cardPadding * 10,
                        hintText: '',
                      ),
                    ),
              SizedBox(
                height: AppTheme.cardPadding * 5.h,
              ),
              // LongButtonWidget(
              //     customWidth: AppTheme.cardPadding * 14.ws,
              //     title: L10n.of(context)!.continues,
              //     onTap: () {
              //       mnemonicController.changeWrittenDown();
              //     }),
            ],
          ),
        ),
        BottomCenterButton(
            buttonTitle: L10n.of(context)!.continues,
            buttonState: ButtonState.idle,
            onButtonTap: () {
              Get.find<SettingsController>().wordRecoveryState.value = 1;
            }),
      ],
    );
  }
}

class ShowMnemonicConfirm extends StatefulWidget {
  const ShowMnemonicConfirm({super.key, required this.mnemonic});
  final String mnemonic;
  @override
  _MnemonicGenConfirm createState() => _MnemonicGenConfirm();
}

class _MnemonicGenConfirm extends State<ShowMnemonicConfirm> {
  void triggerMnemonicCheck(mCtrl, tCtrls) {
    final String mnemonic =
        tCtrls.map((controller) => controller.text).join(' ');
    if (widget.mnemonic == mnemonic) {
      Get.find<SettingsController>().wordRecoveryState.value = 2;
      Get.find<ProfileController>().setWordRecoveryConfirmed();
    }
  }

  @override
  Widget build(BuildContext context) {
    LoggerService logger = Get.find();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: AppTheme.cardPadding * 2.5.h,
          ),
          MnemonicFieldWidget(
              mnemonicController: null,
              triggerMnemonicCheck: triggerMnemonicCheck),
          Container(
            margin: EdgeInsets.only(top: AppTheme.cardPadding.h * 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white60
                    : AppTheme.black60,
                width: 2,
              ),
              borderRadius: AppTheme.cardRadiusCircular,
            ),
            child: SizedBox(
              height: 0,
              width: 65.ws,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: AppTheme.cardPadding.h, bottom: AppTheme.cardPadding.h),
            child: GestureDetector(
              onTap: () {
                logger.i("Skip at own risk pressed");
                //context.go("/pinverification");
                Get.find<SettingsController>().wordRecoveryState.value = 2;
                Get.find<ProfileController>().setWordRecoveryConfirmed();
              },
              child: Text(
                L10n.of(context)!.skipAtOwnRisk,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(height: AppTheme.cardPadding.h)
        ]),
      );
    });
  }
}

class MnemonicConfirmedPage extends StatelessWidget {
  const MnemonicConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(children: [
          SizedBox(
            height: AppTheme.cardPadding * 4,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            child: Icon(Icons.check, size: 128),
          ),
          SizedBox(height: 16),
          Text(
            'Success! You have now confirmed your mnemonic.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Make sure to keep it somewhere safe and secure.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Divider(indent: 32, endIndent: 32),
          SizedBox(height: 32),
        ]));
  }
}
