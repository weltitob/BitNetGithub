import 'package:BitNet/pages/auth/pinverificationscreen.dart';
import 'package:BitNet/pages/auth/restore/chooserestorescreen.dart';
import 'package:flutter/material.dart';

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
  bool getStarted = true;
  bool isInvited = false;

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


  @override
  Widget build(BuildContext context) {
    // show the reset password screen if the resetpassword variable is true else {
        if (widget.showSignIn) {
            //return ChooseRestoreScreen();
            return ChooseRestoreScreen(
              toggleGetStarted: widget.toggleGetStarted,
              toggleView: toggleView,
            );
        } else {
          return PinVerificationScreen(
            toggleGetStarted: widget.toggleGetStarted,
            toggleView: toggleView,
          );
    }
  }
}