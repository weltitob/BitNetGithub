import 'package:BitNet/backbone/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class BottomNav extends StatefulWidget {
  final Widget child;
  const BottomNav({Key? key, required this.child}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {


  @override
  Widget build(BuildContext context) {

    final navItems = [
      {'icon': FontAwesomeIcons.fire, 'route': '/feed'},
      {'icon': FontAwesomeIcons.rocketchat, 'route': '/rooms'},
      {'icon': FontAwesomeIcons.upload, 'route': '/create'},
      {'icon': FontAwesomeIcons.wallet, 'route': '/wallet'},
      {'icon': FontAwesomeIcons.userAstronaut, 'route': '/profile'},
    ];

    void onTabTapped(String route) {
      context.vRouter.to(route);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
      body: Stack(
        children: [
          widget.child,
          // Body content will be managed by VRouter based on the current route
          Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppTheme.cardPadding * 30),
                    child: Container(
                      height: MediaQuery.of(context).size.height - AppTheme.cardPadding * 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Use color stops to create an "exponential" effect
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                          colors: [
                            Colors.transparent,
                            Theme.of(context).colorScheme.background.withOpacity(0.45),
                            Theme.of(context).colorScheme.background.withOpacity(0.9),
                            Theme.of(context).colorScheme.background,
                            Theme.of(context).colorScheme.background,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
          Positioned(
            bottom: AppTheme.cardPadding,
            left: AppTheme.cardPadding * 1.25,
            right: AppTheme.cardPadding * 1.25,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Theme.of(context).colorScheme.secondaryContainer
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.25, vertical: AppTheme.elementSpacing * 1.25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var item in navItems)
                      InkWell(
                        onTap: () => onTabTapped(item['route'] as String),
                        child: Column(
                          children: [
                            Icon(
                              item['icon'] as IconData,  // <--- Here
                              color: context.vRouter.url.contains(item['route'] as String) ? Colors.orange : Colors.white.withOpacity(0.4),
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
