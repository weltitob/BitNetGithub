import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/models/settings/settingsmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/emergency_recovery/email_recovery/email_recovery_view.dart';
import 'package:bitnet/pages/settings/emergency_recovery/social_recovery/social_recovery_view.dart';
import 'package:bitnet/pages/settings/emergency_recovery/word_recovery/word_recovery_view.dart';
import 'package:bitnet/pages/settings/security/recoverwithqrpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class EmergencyRecoveryView extends StatefulWidget {
  const EmergencyRecoveryView({super.key});

  @override
  State<EmergencyRecoveryView> createState() => _EmergencyRecoveryViewState();
}

class _EmergencyRecoveryViewState extends State<EmergencyRecoveryView> {
  Offset offset = Offset.zero;

  int currentview = 0;
  late List<SettingsPageModel> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      SettingsPageModel(
        widget: EmergencyRecoveryWidget(
          stateSetter: (p0) {
            setState(() {
              currentview = p0;
            });
          },
        ),
        goBack: false,
        iconData: Icons.settings,
        title: "Plain Key and DID",
      ),
      SettingsPageModel(
          widget: const RecoverWithQRPage(),
          goBack: true,
          iconData: Icons.verified_user,
          title: "Recover with QR Code"),
      SettingsPageModel(
        widget: WordRecoveryView(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: "Recovery phrases",
      ),
      SettingsPageModel(
        widget: SocialRecoveryView(),
        goBack: true,
        iconData: Icons.live_help_rounded,
        title: "Social Recovery",
        backHandler: () {
          final controller = Get.find<SettingsController>();

          if (controller.pageControllerSocialRecovery.page != null &&
              controller.pageControllerSocialRecovery.page != 0) {
            controller.pageControllerSocialRecovery.previousPage(
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          } else {
            currentview = 0;
            setState(() {});
          }
        },
        actions: [SocialRecoveryInfoAction()],
      ),
      SettingsPageModel(
        widget: EmailRecoveryView(),
        goBack: true,
        backHandler: () {
          final controller = Get.find<SettingsController>();
          if (currentview != 0) {
            currentview = 0;
            setState(() {});
          }
        },
        iconData: Icons.email_rounded,
        title: "Email Recovery",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      body: PopScope(
          canPop: currentview == 0,
          // on: (b, d) {
          //   if (currentview != 0) {
          //     currentview = 0;
          //     setState(() {});
          //   }
          // },
          child: pages[currentview].widget),
      context: context,
      appBar: bitnetAppBar(
          text:
              currentview != 0 ? pages[currentview].title : "Recovery Options",
          context: context,
          buttonType: ButtonType.transparent,
          actions: pages[currentview].actions,
          onTap: () {
            if (pages[currentview].backHandler != null) {
              pages[currentview].backHandler!();
            } else {
              final controller = Get.find<SettingsController>();
              if (currentview != 0) {
                setState(() {
                  currentview = 0;
                });
              } else {
                controller.switchTab('main');
              }
            }
          }),
    );
  }
}

class EmergencyRecoveryWidget extends StatelessWidget {
  const EmergencyRecoveryWidget({super.key, required this.stateSetter});
  final Function(int) stateSetter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      SettingsController settingsController = Get.find<SettingsController>();
      bool emailRecoverySet = settingsController.emailRecoveryState.value == 2;
      bool socialRecoverySet =
          settingsController.initiateSocialRecovery.value == 2;
      bool qrCodeRecoverySet =
          Get.find<ProfileController>().userData.value.setupQrCodeRecovery;
      bool wordRecoverySet =
          Get.find<ProfileController>().userData.value.setupWordRecovery;
      int currentStep = [
        emailRecoverySet,
        socialRecoverySet,
        qrCodeRecoverySet,
        wordRecoverySet
      ].where((b) => b).length;
      return Container(
        margin: const EdgeInsets.only(top: AppTheme.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Security Progress',
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(
                    height: 8,
                  ),
                  LinearProgressBar(
                    maxSteps: 4,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: currentStep,
                    progressColor: currentStep > 2
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    backgroundColor: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (currentStep < 3)
                    Text(
                      'For your own security, please setup as many recovery options as possible.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.errorColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                      maxLines: 4,
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BitNetListTile(
              leading: Stack(
                children: [
                  RoundedButtonWidget(
                    iconData: FontAwesomeIcons.book,
                    onTap: () {
                      stateSetter(2);
                    },
                    size: AppTheme.iconSize * 1.5,
                    buttonType: ButtonType.transparent,
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: wordRecoverySet
                                ? AppTheme.successColor
                                : AppTheme.errorColor),
                      ))
                ],
              ),
              text: "Word recovery",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                stateSetter(2);
              },
            ),
            BitNetListTile(
              leading: Stack(
                children: [
                  RoundedButtonWidget(
                    iconData: FontAwesomeIcons.qrcode,
                    onTap: () {
                      stateSetter(1);
                    },
                    size: AppTheme.iconSize * 1.5,
                    buttonType: ButtonType.transparent,
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: qrCodeRecoverySet
                                ? AppTheme.successColor
                                : AppTheme.errorColor),
                      ))
                ],
              ),
              text: "Recover with QR Code",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                stateSetter(1);
              },
            ),
            BitNetListTile(
              leading: Stack(
                children: [
                  RoundedButtonWidget(
                    iconData: FontAwesomeIcons.person,
                    onTap: () {
                      stateSetter(3);
                    },
                    size: AppTheme.iconSize * 1.5,
                    buttonType: ButtonType.transparent,
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: socialRecoverySet
                                ? AppTheme.successColor
                                : AppTheme.errorColor),
                      ))
                ],
              ),
              text: "Social recovery",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                stateSetter(3);
              },
            ),
            BitNetListTile(
              leading: Stack(
                children: [
                  RoundedButtonWidget(
                    iconData: Icons.email_rounded,
                    onTap: () {
                      stateSetter(4);
                    },
                    size: AppTheme.iconSize * 1.5,
                    buttonType: ButtonType.transparent,
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: emailRecoverySet
                                ? AppTheme.successColor
                                : AppTheme.errorColor),
                      ))
                ],
              ),
              text: "Email Recovery",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                stateSetter(4);
              },
            ),
          ],
        ),
      );
    });
  }
}
