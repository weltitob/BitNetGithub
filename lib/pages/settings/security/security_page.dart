import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/settings/settingsmodel.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/security/recoverwithqrpage.dart';
import 'package:bitnet/pages/settings/emergency_recovery/social_recovery/social_recovery_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({Key? key}) : super(key: key);

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  Offset offset = Offset.zero;

  int currentview = 0;
  late List<SettingsPageModel> pages;
  bool isVerified = false;

  void authenticated() async {
    dynamic whatever = await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      isVerified = true;
      setState(() {});
    } else {
      isVerified = false;
    }
  }

  @override
  void initState() {
    authenticated();
    pages = [
      SettingsPageModel(
        widget: buildSettings(),
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
        widget: Container(),
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
        widget: Container(),
        goBack: true,
        iconData: Icons.key_rounded,
        title: "Human Identity",
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: "Recovery phrases",
      ),
      SettingsPageModel(
        widget: Container(), //context.go('/settings/security'),
        goBack: true,
        iconData: Icons.security,
        title: "Extended Sec",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      body: isVerified
          ? PopScope(
              canPop: currentview == 0,
              // on: (b, d) {
              //   if (currentview != 0) {
              //     currentview = 0;
              //     setState(() {});
              //   }
              // },
              child: pages[currentview].widget)
          : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.lock,
                      size: AppTheme.cardPadding * 2,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    Text("Verify your identity"),
                  ],
                ),
              ),
            ),
      context: context,
      appBar: bitnetAppBar(
          text: currentview != 0 ? pages[currentview].title : "Security",
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

  Widget buildSettings() {
    return Container(
      margin: const EdgeInsets.only(top: AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: FontAwesomeIcons.buildingLock,
              onTap: () {
                setState(() {
                  currentview = 2;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "DID and private key",
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              setState(() {
                currentview = 2;
              });
            },
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: FontAwesomeIcons.book,
              onTap: () {
                setState(() {
                  currentview = 3;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Word recovery",
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: FontAwesomeIcons.qrcode,
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Recover with QR Code",
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              setState(() {
                currentview = 1;
              });
            },
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: FontAwesomeIcons.person,
              onTap: () {
                setState(() {
                  currentview = 3;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Social recovery",
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: Icons.shield_outlined,
              onTap: () {
                setState(() {
                  currentview = 5;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Extended Sec", //L10n.of(context)!.security
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              setState(() {
                currentview = 5;
              });
            },
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: FontAwesomeIcons.trash,
              onTap: () {
                // Handle account deletion here
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Delete account",
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {
              // Handle account deletion action here
            },
          ),
        ],
      ),
    );
  }
}
