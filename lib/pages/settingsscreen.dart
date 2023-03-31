import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/getbalance.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/gettransactions.dart';
import 'package:nexus_wallet/backbone/security/biometrics/biometric_helper.dart';
import 'package:nexus_wallet/backbone/security/security.dart';
import 'package:nexus_wallet/components/container/glassmorph.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/actions/sendscreen.dart';
import 'package:nexus_wallet/pages/secondpages/agbscreen.dart';
import 'package:nexus_wallet/pages/secondpages/changeemail.dart';
import 'package:nexus_wallet/pages/secondpages/impressumscreen.dart';
import 'package:nexus_wallet/pages/secondpages/reportissuescreen.dart';
import 'package:nexus_wallet/components/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final title;
  SettingsScreen({this.title});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final User? user = Auth().currentUser;
  bool isSecurityChecked = false;
  bool hasBiometrics = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitSecurityBool();
  }

  void awaitSecurityBool() async {
    hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
    print(hasBiometrics);
    if(hasBiometrics) {
      isSecurityChecked = await SharedPrefSecurityCheck();
      setState(() {});
    } else {
      print("doesnt have enrolled biometrics");
      toggleSecurityChecked(false);
      setState(() {});
    }
    //displaySnackbar(context, "Dein Gerät hat leider nicht die nötigen Spezifikationen für diese Funktion");
  }

  void toggleSecurityChecked(bool newSecurityChecked) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSecurityChecked = newSecurityChecked;
    });
    await prefs.setBool('isSecurityChecked', isSecurityChecked);
  }

  Future<void> signOut() async {
    print('signout pressed');
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  bool _ziehesendschkohl = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: AppTheme.colorBackground,
        child: SafeArea(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: AppTheme.cardPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing / 2,
                ),
                Text(
                  'Einstellungen',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: AppTheme.cardPadding, right: AppTheme.cardPadding),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  _userUid(),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  buildBox(),
                ],
              ))
        ])));
  }

  Widget buildBox() {

    final userWallet = Provider.of<UserWallet>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ChildBuildBoxHeader("Allgemeines"),
        Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: AppTheme.cardPadding,
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: AppTheme.elementSpacing,
                  right: AppTheme.elementSpacing,
                  bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AGBScreen(),
                          ),
                        );
                      },
                      child: ChildBuildBoxIntern(
                          Icons.article_outlined, "Allg. Geschäftsbedingungen"),
                    ),
                    MyDivider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SendBTCScreen(
                              bitcoinReceiverAdress:
                                  "bc1qefen49mdjzzkxjec4pz5gsl9fq8nk3kuyq05nl",
                              bitcoinSenderAdress: userWallet.walletAddress,
                            ),
                          ),
                        );
                      },
                      child: ChildBuildBoxIntern(
                          Icons.payment_rounded, "Spenden & uns unterstützen"),
                    ),
                  ]),
            )),
        Padding(
            padding: EdgeInsets.only(
          top: AppTheme.cardPadding,
        )),
        ChildBuildBoxHeader("Kontakt"),
        Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: AppTheme.cardPadding,
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: AppTheme.elementSpacing,
                  right: AppTheme.elementSpacing,
                  bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ImpressumScreen(),
                          ),
                        );
                      },
                      child: ChildBuildBoxIntern(
                          Icons.mail_outline_rounded, "Impressum"),
                    ),
                    MyDivider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReportIssueScreen(),
                          ),
                        );
                      },
                      child: ChildBuildBoxIntern(
                          Icons.bug_report_outlined, "Fehler melden"),
                    ),
                  ]),
            )),
        Padding(
            padding: EdgeInsets.only(
          top: AppTheme.cardPadding,
        )),
        ChildBuildBoxHeader("Authentifizierung"),
        Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: AppTheme.cardPadding,
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: AppTheme.elementSpacing,
                  right: AppTheme.elementSpacing,
                  bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChildBuildBoxInternToggleSwich(
                      Icons.fingerprint_rounded,
                      "Erhöhte Sicherheit",
                    ),
                    MyDivider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChangeEmailScreen(),
                          ),
                        );
                      },
                      child: ChildBuildBoxIntern(
                          Icons.email_rounded, "E-Mail Adresse ändern"),
                    ),
                    MyDivider(),
                    GestureDetector(
                        onTap: () {
                          //muss noch provider entfernen damit es geht vom settingssreen
                          signOut();
                        },
                        child: ChildBuildBoxIntern(
                            Icons.login_rounded, "Abmelden"))
                  ]),
            )),
      ],
    );
  }

  Widget ChildBuildBoxHeader(String header) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Text(
        header,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget ChildBuildBoxIntern(icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.grey[200],
              size: 24,
            ),
            Padding(
                padding: EdgeInsets.only(
              left: 10,
            )),
            Container(
              child: Text(text, style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[200],
              size: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget ChildBuildBoxInternToggleSwich(
    icon,
    String text,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.grey[200],
              size: 24,
            ),
            Padding(
                padding: EdgeInsets.only(
              left: 10,
            )),
            Container(
              child: Text(text, style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
        Container(
          height: 20,
          child: Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: AppTheme.colorBitcoin,
              value: isSecurityChecked,
              onChanged: (bool value) {
                if(hasBiometrics){
                  setState(() {
                    isSecurityChecked = value;
                    toggleSecurityChecked(value);
                  });
                } else {
                  isSecurityChecked = false;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget MyDivider() {
  return Divider(
    height: AppTheme.elementSpacing * 1.5,
    color: Colors.grey,
  );
}
