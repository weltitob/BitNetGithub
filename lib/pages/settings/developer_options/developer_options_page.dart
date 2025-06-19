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
import 'package:bitnet/pages/settings/developer_options/mini_app_application_form.dart';
import 'package:bitnet/pages/settings/developer_options/registered_mini_apps.dart';
import 'package:bitnet/pages/settings/security/recoverwithqrpage.dart';
import 'package:bitnet/pages/settings/emergency_recovery/social_recovery/social_recovery_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class DeveloperOptionsPage extends StatefulWidget {
  const DeveloperOptionsPage({Key? key}) : super(key: key);

  @override
  State<DeveloperOptionsPage> createState() => _DeveloperOptionsPageState();
}

class _DeveloperOptionsPageState extends State<DeveloperOptionsPage> {
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
        title: "Developer Options",
      ),
      SettingsPageModel(
        widget: MiniAppApplicationForm(),
        goBack: true,
        iconData: Icons.apps_rounded,
        title: "Mini App Application",
      ),
      SettingsPageModel(
        widget: RegisteredMiniAppsPage(),
        goBack: true,
        iconData: Icons.app_registration_rounded,
        title: "Registered Mini Apps",
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
              child: const Expanded(
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
            ),
      context: context,
      appBar: bitnetAppBar(
          text:
              currentview != 0 ? pages[currentview].title : "Developer Options",
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          BitNetListTile(
            leading: RoundedButtonWidget(
              iconData: Icons.apps_rounded,
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Mini App Application Form",
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
              iconData: Icons.apps_rounded,
              onTap: () {
                setState(() {
                  currentview = 2;
                });
              },
              size: AppTheme.iconSize * 1.5,
              buttonType: ButtonType.transparent,
            ),
            text: "Registered Mini Apps",
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
        ],
      ),
    );
  }
}
