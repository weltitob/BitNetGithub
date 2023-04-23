import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/models/settingsmodel.dart';
import 'package:BitNet/pages/settings/invitation_page.dart';
import 'package:BitNet/pages/settings/theme_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showSettingsBottomSheet({
  required BuildContext context,
}) {
  //diffrent screen states as on the search page and then switch them according to press
  //settingscreen

  IconData iconData = Icons.settings;
  bool goBack = false;
  String title = "Settings";

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SettingsPage();
            });
      });
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
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
        widget: ThemeSettingsPage(),
        goBack: true,
        iconData: Icons.privacy_tip_rounded,
        title: 'Privacy',
      ),
      SettingsPageModel(
        widget: ThemeSettingsPage(),
        goBack: true,
        iconData: Icons.color_lens_rounded,
        title: 'Theme',
      ),
      SettingsPageModel(
        widget: InvitationSettingsPage(),
        goBack: true,
        iconData: Icons.live_help_rounded,
        title: 'Help & Support',
      ),
      SettingsPageModel(
        widget: InvitationSettingsPage(),
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
              icon: Icons.verified_user,
              text: 'Privacy',
              onTap: () {
                setState(() {
                  currentview = 1;
                });
              }),
          SettingsListItem(
            icon: Icons.color_lens_rounded,
            text: 'Theme',
            onTap: () {
              setState(() {
                currentview = 2;
              });
            },
          ),
          SettingsListItem(
            icon: Icons.question_answer,
            text: 'Help & Support',
            onTap: () {
              setState(() {
                currentview = 3;
              });
            },
          ),
          SettingsListItem(
            icon: Icons.key,
            text: 'Invitation keys',
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
            icon: Icons.login_rounded,
            text: 'Logout',
            hasNavigation: false,
            onTap: () async {
              await Auth().signOut();
            },
          ),
        ],
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function() onTap;

  const SettingsListItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppTheme.cardPadding * 2,
        margin: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding * 1.5,
        ).copyWith(
          bottom: AppTheme.cardPadding,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusMid,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              size: AppTheme.iconSize,
            ),
            SizedBox(width: AppTheme.cardPadding),
            Text(this.text, style: Theme.of(context).textTheme.subtitle2),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
          ],
        ),
      ),
    );
  }
}
