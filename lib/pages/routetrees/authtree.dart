import 'package:flutter/material.dart';
import 'package:nexus_wallet/models/verificationcode.dart';
import 'package:nexus_wallet/pages/auth/getstartedscreen.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
import 'package:nexus_wallet/pages/auth/pinverificationscreen.dart';
import 'package:nexus_wallet/pages/auth/registerscreen.dart';
import 'package:nexus_wallet/pages/auth/usephrasesscreen.dart';

/*
 This Flutter widget displays either a login screen, a registration screen,
 or a reset password screen based on the values of two boolean variables: showSignIn and resetpassword.
 It contains two callback functions to toggle the values of these variables.
 */
class AuthTree extends StatefulWidget {
  Function() toggleGetStarted;
  bool showSignIn;

  AuthTree({
    required this.toggleGetStarted,
    required this.showSignIn,
    Key? key}) : super(key: key);

  @override
  State<AuthTree> createState() => _AuthTreeState();
}

class _AuthTreeState extends State<AuthTree> {
  // boolean variables to track which screen to show
  bool resetpassword = false;
  bool getStarted = true;
  bool isInvited = false;

  void toggleIsInvited(){

  }

  // callback function to switch between sign-in and registration screens
  void toggleView() {
    setState(() {
      if (widget.showSignIn == true)
        widget.showSignIn = false;
      else {
        widget.showSignIn = true;
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
    // show the reset password screen if the resetpassword variable is true else {
        if (widget.showSignIn) {
          if (resetpassword) {
            return UsePhrasesScreen(
              toggleView: toggleView,
              toggleResetPassword: toggleresetpassword,
            );
          } else {
            return LoginScreen(
              toggleGetStarted: widget.toggleGetStarted,
              toggleView: toggleView,
              toggleResetPassword: toggleresetpassword,
            );
          }
        } else {
          // show the registration screen if both variables are false
          if (isInvited) {
            return RegisterScreen(
                toggleGetStarted: widget.toggleGetStarted,
                toggleView: toggleView,
                code: VerificationCode(
                  used: false,
                  code: "ABCDE",
                  issuer: "Ich",
                  receiver: "Du",));
          } else {
            return PinVerificationScreen(
              toggleGetStarted: widget.toggleGetStarted,
              toggleView: toggleView,
            );
          }
    }
  }
}