import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/routetrees/authtree.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNav();
        } else {
          return AuthTree();
        }
      },
    );
  }
}