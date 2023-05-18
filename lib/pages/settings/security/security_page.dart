import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/models/settingsmodel.dart';
import 'package:BitNet/pages/settings/security/recoverwithqrpage.dart';
import 'package:BitNet/pages/settings/settings.dart';
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


  @override
  void initState() {
    pages = [
      SettingsPageModel(
        widget: buildSettings(),
        goBack: false,
        iconData: Icons.settings,
        title: 'Settings',
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
        title: 'Theme',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.live_help_rounded,
        title: 'Help & Support',
      ),
      SettingsPageModel(
        widget: Container(),
        goBack: true,
        iconData: Icons.key_rounded,
        title: 'Invitation Keys',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            margin: EdgeInsets.only(
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding,
                top: AppTheme.elementSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pages[currentview].goBack
                    ? GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    onTap: () => setState(() {
                      currentview = 0;
                    }))
                    : Container(
                  width: 18,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: AppTheme.elementSpacing * 0.5),
                      child: Icon(
                        pages[currentview].iconData,
                        size: 18,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    Text(
                      pages[currentview].title,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                GestureDetector(
                  child: Icon(
                    Icons.clear_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            ),
          ),
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
            text: 'ION information',
            onTap: () {
              setState(() {
                currentview = 2;
              });
            },
          ),
          SettingsListItem(
            icon: FontAwesomeIcons.book,
            text: '12 Word recovery sentence',
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          SettingsListItem(
              icon: FontAwesomeIcons.qrcode,
              text: 'Scan QR-Code for recovery',
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              }),
          SettingsListItem(
            icon: FontAwesomeIcons.wallet,
            text: 'Wallet...',
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
            icon: FontAwesomeIcons.trash,
            text: 'Delete account & all data',
            hasNavigation: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
