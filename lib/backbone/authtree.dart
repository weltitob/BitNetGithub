import 'package:flutter/material.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
import 'package:nexus_wallet/pages/auth/registerscreen.dart';


class AuthTree extends StatefulWidget {
  const AuthTree ({Key? key}) : super(key: key);

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  GlobalKey<_AuthTreeState> _myKey = GlobalKey();
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      if(showSignIn == true)
        showSignIn = false;
      else {
        showSignIn = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(toggleView: toggleView);
    }
    else {
      return RegisterScreen(toggleView: toggleView,);
    }
  }
}