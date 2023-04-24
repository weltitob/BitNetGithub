import 'package:BitNet/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';
import 'package:BitNet/backbone/security/security.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/pages/bottomnav.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:BitNet/pages/routetrees/authtree.dart';
import 'package:BitNet/pages/routetrees/getstartedtree.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  bool hasBiometrics = true;
  late bool isSecurityChecked;
  bool isBioAuthenticated = false;

  @override
  initState() {
    super.initState();
    isBiometricsAvailable();
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if (isSecurityChecked == true) {
      hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        isBioAuthenticated = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated == false;
      }
      setState(() {});
    } else {
      hasBiometrics = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //hier schon das erste mal aufrufen aber noch mit Fragezeichen >> daruch kann noch nicht null sein
    final userData = Provider.of<UserData?>(context);

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (userData == null) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: dotProgress(context),
              ),
            );
          } //when userdata isnt null anymore (listening to Stream)
          if (isBioAuthenticated == true || hasBiometrics == false) {
            return BottomNav();
          }
          return Container(
            color: AppTheme.colorBackground,
            child: Center(
                child: Text("There is an issue please contact the support")),
          );
        } else {
          return GetStartedTree();
        }
      },
    );
  }
}
