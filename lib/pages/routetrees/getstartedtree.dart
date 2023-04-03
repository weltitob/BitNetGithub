import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/models/verificationcode.dart';
import 'package:nexus_wallet/pages/auth/getstartedscreen.dart';
import 'package:nexus_wallet/pages/auth/loginscreen.dart';
import 'package:nexus_wallet/pages/auth/pinverificationscreen.dart';
import 'package:nexus_wallet/pages/auth/registerscreen.dart';
import 'package:nexus_wallet/pages/auth/usephrasesscreen.dart';
import 'package:nexus_wallet/pages/routetrees/authtree.dart';

/*
 This Flutter widget displays either a login screen, a registration screen,
 or a reset password screen based on the values of two boolean variables: showSignIn and resetpassword.
 It contains two callback functions to toggle the values of these variables.
 */
class GetStartedTree extends StatefulWidget {
  const GetStartedTree({Key? key}) : super(key: key);

  @override
  State<GetStartedTree> createState() => _GetStartedTreeState();
}

class _GetStartedTreeState extends State<GetStartedTree> {
  // boolean variables to track which screen to show
  bool resetpassword = false;
  bool getStarted = true;
  bool showSignIn = false;

  void toggleView() {
    setState(() {
      showSignIn != showSignIn;
    });
  }

  void pushToRegister(){
    setState(() {
      getStarted = false;
      showSignIn = false;
    });
  }

  void pushToLogin(){
    setState(() {
      getStarted = false;
      showSignIn = true;
    });
  }

  void toggleGetStarted() {
    setState(() {
      if (getStarted == true)
        getStarted = false;
      else {
        getStarted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // show the reset password screen if the resetpassword variable is true
      if(getStarted){
        return GetStartedScreen(
          pushToLogin: pushToLogin,
          pushToRegister: pushToRegister,
        );
      } else{
        // show the sign-in screen if the showSignIn variable is true
          return AuthTree(
            showSignIn: showSignIn,
            toggleGetStarted: toggleGetStarted
          );
        }
      }
}