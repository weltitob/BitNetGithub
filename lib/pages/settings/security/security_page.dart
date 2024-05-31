import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/models/settings/settingsmodel.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/security/recoverwithqrpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
        title: L10n.of(context)!.plainKeyDID,
      ),
      SettingsPageModel(
        widget: RecoverWithQRPage(),
        goBack: true,
        iconData: Icons.verified_user,
        title: L10n.of(context)!.recoverQrCode,
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: L10n.of(context)!.recoveryPhrases,
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.live_help_rounded,
        title: L10n.of(context)!.socialRecovery,
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.key_rounded,
        title: L10n.of(context)!.humanIdentity,
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: L10n.of(context)!.recoveryPhrases,
      ),
      SettingsPageModel(
        widget: Container(), //context.go('/settings/security'),
        goBack: true,
        iconData: Icons.security,
        title: L10n.of(context)!.extendedSec,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      body: isVerified
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: AppTheme.cardPadding * 1.5,
                ),
                pages[currentview].widget,
              ],
            )
          : Container(
              child: Expanded(
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
                      Text(L10n.of(context)!.verifyYourIdentity),
                    ],
                  ),
                ),
              ),
            ),
      context: context,
      appBar: bitnetAppBar(
          text: L10n.of(context)!.security,
          context: context,
          buttonType: ButtonType.transparent,
          onTap: () {
            final controller = Get.find<SettingsController>();
            controller.switchTab('main');
          }),
    );
  }

  Widget buildSettings() {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BitNetListTile(
            leading: Icon(FontAwesomeIcons.buildingLock),
            text: L10n.of(context)!.diDprivateKey,
            onTap: () {
              setState(() {
                currentview = 2;
              });
            },
          ),
          BitNetListTile(
            leading: Icon(FontAwesomeIcons.book),
            text: L10n.of(context)!.wordRecovery,
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          BitNetListTile(
              leading: Icon(FontAwesomeIcons.qrcode),
              text: L10n.of(context)!.recoverQrCode,
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              }),
          BitNetListTile(
            leading: Icon(FontAwesomeIcons.person),
            text: L10n.of(context)!.socialRecovery,
            onTap: () {
              setState(() {
                currentview = 4;
              });
              // Navigator.of(context).push(_createSettingsRoute());
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => InvitationSettingsPage()));
            },
          ),
          BitNetListTile(
            leading: Icon(Icons.shield_outlined),
            text: L10n.of(context)!.extendedSec, //L10n.of(context)!.security
            trailing: Icon(
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
            leading: Icon(FontAwesomeIcons.trash),
            text: L10n.of(context)!.deleteAccount,
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppTheme.iconSize * 0.75,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
