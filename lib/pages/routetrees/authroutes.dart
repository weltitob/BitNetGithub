import 'package:BitNet/pages/auth/ionloadingscreen.dart';
import 'package:BitNet/pages/routetrees/getstartedtree.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/pages/auth/createaccountscreen.dart';
import 'package:flutter/material.dart';


void navigateToIONLoadingScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const IONLoadingScreen(loadingText:
      "Patience, please. We're validating your account on the blockchain...",)
    ),
  );
}

void onPinVerificationSuccess({
  required VerificationCode code,
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateAccountScreen(
        code: code,
      ),
    ),
  );
}

void navigateToGetStartedTree(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => GetStartedTree()),
        (Route<dynamic> route) => false,
  );
}

void navigateToLogin(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => GetStartedTree(
          showSignIn: true,
          getStarted: false,
        )),
        (Route<dynamic> route) => false,
  );
}

void navigateToHomeScreenAfterLogin(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WidgetTree()),
        (Route<dynamic> route) => false,
  );
}
