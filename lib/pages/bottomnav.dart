import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/pages/homescreen.dart';
import 'package:BitNet/pages/qrscreen.dart';
import 'package:BitNet/pages/settingsscreen.dart';

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
      const QRScreen(isBottomButtonVisible: false,),
      SettingsScreen(),
      SettingsScreen(),
    ];

    final navItems = [
      Icons.currency_bitcoin,
      Icons.camera,
      Icons.chat,
      Icons.account_balance,
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
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: MediaQuery.of(context).size.width / navItems.length * _index + (MediaQuery.of(context).size.width / navItems.length) / 2 - 40,
                      bottom: 0,
                      child: Container(
                        width: AppTheme.elementSpacing,
                        height: AppTheme.elementSpacing / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppTheme.elementSpacing),
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = 0; i < navItems.length; i++)
                          InkWell(
                            onTap: () => onTabTapped(i),
                            child: Column(
                              children: [
                                Icon(
                                  navItems[i],
                                  color: _index == i ? Colors.white : Colors.white.withOpacity(0.4),
                                  size: AppTheme.cardPadding,
                                ),
                              ],
                            ),
                          ),
                      ],
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
