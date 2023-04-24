import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/pages/homescreen.dart';
import 'package:BitNet/pages/qrscreen.dart';
import 'package:BitNet/pages/settingsscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _index = 0;
  final userdid = Auth().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const QRScreen(isBottomButtonVisible: false,),
      SettingsScreen(),
      SettingsScreen(),
      const WalletScreen(),
      Profile(profileId: userdid)
    ];

    final navItems = [
      FontAwesomeIcons.fire,
      FontAwesomeIcons.rocketchat,
      FontAwesomeIcons.upload,
      FontAwesomeIcons.wallet,
      FontAwesomeIcons.userAstronaut,
    ];

    void onTabTapped(int index) {
      setState(() {
        _index = index;
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          screens[_index],
          Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppTheme.cardPadding * 28),
                    child: Container(
                      height: MediaQuery.of(context).size.height - AppTheme.cardPadding * 28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, AppTheme.colorBackground],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
          Positioned(
            bottom: AppTheme.cardPadding,
            left: AppTheme.cardPadding * 1.5,
            right: AppTheme.cardPadding * 1.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.purple.shade800,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.25, vertical: AppTheme.elementSpacing * 1.25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < navItems.length; i++)
                      InkWell(
                        onTap: () => onTabTapped(i),
                        child: Column(
                          children: [
                            Icon(
                              navItems[i],
                              color: _index == i ? Colors.orange : Colors.white.withOpacity(0.4),
                              size: AppTheme.cardPadding,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
