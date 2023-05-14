import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/pages/auth/getstartedscreen.dart';
import 'package:BitNet/pages/auth/didandpkscreen.dart';
import 'package:BitNet/pages/auth/pinverificationscreen.dart';
import 'package:BitNet/pages/auth/createaccountscreen.dart';
import 'package:BitNet/pages/auth/usephrasesscreen.dart';
import 'package:BitNet/pages/routetrees/authtree.dart';

/*
 This Flutter widget displays either a login screen, a registration screen,
 or a reset password screen based on the values of two boolean variables: showSignIn and resetpassword.
 It contains two callback functions to toggle the values of these variables.
 */

class GetStartedTree extends StatefulWidget {
  final bool getStarted;
  final bool showSignIn;

  const GetStartedTree({
    this.getStarted = true,
    this.showSignIn = false,
    Key? key,
  }) : super(key: key);

  @override
  State<GetStartedTree> createState() => _GetStartedTreeState();
}

class _GetStartedTreeState extends State<GetStartedTree> {
  late bool getStarted;
  late bool showSignIn;

  @override
  void initState() {
    super.initState();
    getStarted = widget.getStarted;
    showSignIn = widget.showSignIn;
  }

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  void pushToRegister() {
    setState(() {
      getStarted = false;
      showSignIn = false;
    });
  }

  void pushToLogin() {
    setState(() {
      getStarted = false;
      showSignIn = true;
    });
  }

  void toggleGetStarted() {
    setState(() {
      getStarted = !getStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (getStarted) {
      return GetStartedScreen(
        pushToLogin: pushToLogin,
        pushToRegister: pushToRegister,
      );
    } else {
      return AuthTree(
        showSignIn: showSignIn,
        toggleGetStarted: toggleGetStarted,
      );
    }
  }
}
