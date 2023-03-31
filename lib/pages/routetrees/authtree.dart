import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/security/biometrics/biometric_helper.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
import 'package:nexus_wallet/pages/auth/registerscreen.dart';
import 'package:nexus_wallet/pages/auth/resetpasswordscreen.dart';

/*
 This Flutter widget displays either a login screen, a registration screen,
 or a reset password screen based on the values of two boolean variables: showSignIn and resetpassword.
 It contains two callback functions to toggle the values of these variables.
 */
class AuthTree extends StatefulWidget {
  const AuthTree({Key? key}) : super(key: key);

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  // boolean variables to track which screen to show
  bool showSignIn = true;
  bool resetpassword = false;

  // callback function to switch between sign-in and registration screens
  void toggleView() {
    setState(() {
      if (showSignIn == true)
        showSignIn = false;
      else {
        showSignIn = true;
      }
    });
  }

  // callback function to switch between sign-in and reset password screens
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
    // show the reset password screen if the resetpassword variable is true
    if (resetpassword) {
      return ResetPasswordScreen(
        toggleView: toggleView,
        toggleResetPassword: toggleresetpassword,
      );
    } else {
      // show the sign-in screen if the showSignIn variable is true
      if (showSignIn) {
        return LoginScreen(
          toggleView: toggleView,
          toggleResetPassword: toggleresetpassword,
        );
      } else {
        // show the registration screen if both variables are false
        return RegisterScreen(
          toggleView: toggleView,
        );
      }
    }
  }
}