import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/settingslistitem.dart';
import 'package:bitnet/models/settingsmodel.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  final SettingsController controller;

  const SettingsPage({Key? key, required this.controller}) : super(key: key);

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
              text: 'Security',
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
            icon: Icons.chat,
            text: 'Chat',
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
        ],
      ),
    );
  }
}
