import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_check.dart';
import 'package:BitNet/components/items/settingslistitem.dart';
import 'package:BitNet/models/settingsmodel.dart';
import 'package:BitNet/pages/settings/security/recoverwithqrpage.dart';
import 'package:BitNet/pages/settings/bottomsheet/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      print("Biometrics unsuccessfull");
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
        title: 'Plain Key and DID',
      ),
      SettingsPageModel(
        widget: RecoverWithQRPage(),
        goBack: true,
        iconData: Icons.verified_user,
        title: 'Recover with QR Code',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: 'Recovery phrases',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.live_help_rounded,
        title: 'Social recovery',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.key_rounded,
        title: 'Human Identity',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: 'Recovery phrases',
      ),
      SettingsPageModel(
        widget: Container(), //VRouter.of(context).to('/settings/security'),
        goBack: true,
        iconData: Icons.security,
        title: 'Extended Sec',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      isVerified ?
      Container(
      height: AppTheme.cardPadding * 19,
      decoration: new BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: new BorderRadius.only(
          topLeft: AppTheme.cornerRadiusBig,
          topRight: AppTheme.cornerRadiusBig,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                  )
                      .animate(animation),
                  child: child,
                );
              },
              child: pages[currentview].widget,
            ),
          ),
        ],
      ),
    ) : Container(
        child: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.lock,
                  size: AppTheme.cardPadding * 2,
                ),
                SizedBox(height: AppTheme.elementSpacing,),
                Text("Verify your identity"),
              ],
            ),
          ),
        ),
      );
  }

  Widget buildSettings() {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SettingsListItem(
            icon: FontAwesomeIcons.buildingLock,
            text: 'DID and private key',
            onTap: () {
              setState(() {
                currentview = 2;
              });
            },
          ),
          SettingsListItem(
            icon: FontAwesomeIcons.book,
            text: '12 Word recovery',
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          SettingsListItem(
              icon: FontAwesomeIcons.qrcode,
              text: 'Recover with QR Code',
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              }),
          SettingsListItem(
            icon: FontAwesomeIcons.person,
            text: 'Social Recovery',
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
          SettingsListItem(
            icon: Icons.shield_outlined,
            text: 'Extended sec', //L10n.of(context)!.security
            hasNavigation: true,
            onTap: () {
              setState(() {
                currentview = 5;
              });
            },
          ),
          SettingsListItem(
            icon: FontAwesomeIcons.trash,
            text: 'Delete account',
            hasNavigation: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
