import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/security/biometrics/biometric_helper.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
import 'package:nexus_wallet/pages/auth/registerscreen.dart';
import 'package:nexus_wallet/pages/auth/resetpasswordscreen.dart';

class AuthTree extends StatefulWidget {
  const AuthTree({Key? key}) : super(key: key);

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  bool showSignIn = true;
  bool resetpassword = false;

  void toggleView() {
    setState(() {
      if (showSignIn == true)
        showSignIn = false;
      else {
        showSignIn = true;
      }
    });
  }

  void toggleresetpassword() {
    setState(() {
      if (resetpassword == true)
        resetpassword = false;
      else {
        resetpassword = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (resetpassword) {
      return ResetPasswordScreen(
        toggleView: toggleView,
        toggleResetPassword: toggleresetpassword,
      );
    } else {
      if (showSignIn) {
        return LoginScreen(
          toggleView: toggleView,
          toggleResetPassword: toggleresetpassword,
        );
      } else {
        return RegisterScreen(
          toggleView: toggleView,
        );
      }
    }
  }
}
