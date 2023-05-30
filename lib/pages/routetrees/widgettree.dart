import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';
import 'package:BitNet/backbone/security/security.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/pages/bottomnav.dart';
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

  //add applinks later on to make transactions even easier where all qrs are involved
  //send and receive bitcoin applinks (deeplinks)
  //also restore account applinks
  late final AppLinks _appLinks;

  @override
  initState() {
    super.initState();
    isBiometricsAvailable();
    _appLinks = AppLinks(
      onAppLink: (Uri uri, String string) {
        // Handle the deep link here. You can push to a new page, or perform
        // some action based on the data in the URI.
        print('Got deep link: $uri');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
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
            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 20)),
              builder: (context, snapshot) {
                // If Future is still running, show the loading progress
                //while retriving userData
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).colorScheme.background,
                    child: Center(
                      child: dotProgress(context),
                    ),
                  );
                }
                // If Future is completed, show the error message and a log out button
                //this is when the user is somehow logged in in the firebaseauth but we cant retrive the UserData correctly
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(AppTheme.cardPadding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Something went wrong, please check your connection and try again later.",
                          style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
                          SizedBox(height: AppTheme.cardPadding,),
                          LongButtonWidgetTransparent(title: "Sign out", onTap:
                          (){
                            Auth().signOut();}
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
