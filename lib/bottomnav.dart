import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/pages/homescreen.dart';
import 'package:nexus_wallet/pages/qrscreen.dart';
import 'package:nexus_wallet/pages/settingsscreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const QRScreen(),
      SettingsScreen(),
      //BitcoinScreen(),
    ];

    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor,
          color: Colors.purple.shade800,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index){
            setState(() {
              _index = index;
            });
          },
          items: const [
            Icon(
              Icons.currency_bitcoin,
              color: Colors.white,
            ),
            Icon(
              Icons.qr_code_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ]),
    );
  }
}
