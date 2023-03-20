import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/getbalance.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/gettransactions.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/backbone/security/biometrics/biometric_helper.dart';
import 'package:nexus_wallet/backbone/security/security.dart';
import 'package:nexus_wallet/backbone/theme.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/routetrees/authtree.dart';
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
    isBiometricsAvailable();
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if(isSecurityChecked == true) {
      hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        isBioAuthenticated = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated == false;
      }
      setState(() {});
    } else{
      hasBiometrics = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //hier schon das erste mal aufrufen aber noch mit Fragezeichen >> daruch kann noch nicht null sein
    final userWallet = Provider.of<UserWallet?>(context);

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (userWallet == null) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
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
          );
        } else {
          return AuthTree();
        }
      },
    );
  }
}
