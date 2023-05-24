import 'package:BitNet/pages/routetrees/getstartedtree.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:flutter/material.dart';

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
