import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/theme.dart';

class SettingsScreen extends StatefulWidget {
  final title;
  SettingsScreen({this.title});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    print('signout pressed');
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  bool _lights = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: AppTheme.colorBackground,
        child: SafeArea(
            child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Einstellungen',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        IconButton(icon: const Icon(Icons.logout),
                            padding: new EdgeInsets.all(0.0),
                            iconSize: 25.0,
                            color: Colors.grey,
                            onPressed: () {
                              signOut();
                            }),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: AppTheme.cardPadding, right: AppTheme.cardPadding),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: AppTheme.cardPadding,),
                          _userUid(),
                          SizedBox(height: AppTheme.cardPadding,),
                          buildBox(),
                        ],
                      )
                  )]
            )));
  }
  Widget buildBox(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ChildBuildBoxHeader("Hallo iwas"),
        Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: AppTheme.cardPadding,
            child: Container(
              padding: EdgeInsets.only(top: 10,
                  left: AppTheme.elementSpacing,
                  right: AppTheme.elementSpacing,
                  bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChildBuildBoxInternToggleSwich(Icons.nights_stay_outlined, "Darkmode"),
                    MyDivider(),
                    ChildBuildBoxIntern(Icons.article_outlined, "Geschäftsbedingungen"),
                  ]),
            )),
        Padding(padding: EdgeInsets.only(top: AppTheme.cardPadding,)),
        ChildBuildBoxHeader("Contact"),
        Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: AppTheme.cardPadding,
            child: Container(
              padding: EdgeInsets.only(top: 10,
                  left: AppTheme.elementSpacing,
                  right: AppTheme.elementSpacing,
                  bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChildBuildBoxIntern(Icons.bug_report_outlined, "Fehler melden"),
                    MyDivider(),
                    ChildBuildBoxIntern(Icons.mail_outline_rounded, "Impressum"),
                    MyDivider(),
                    ChildBuildBoxIntern(Icons.payment_rounded, "Spenden"),
                  ]),
            )),
        Padding(padding: EdgeInsets.only(top: AppTheme.cardPadding,)),
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
                    ChildBuildBoxIntern(Icons.email_rounded, "E-Mail Adresse ändern"),
                    MyDivider(),
                    ChildBuildBoxIntern(Icons.login_rounded, "Abmelden")
                  ]),
            )),
      ],
    );
  }

  Widget ChildBuildBoxHeader(String header){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,),
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
            Icon(icon, color: Colors.grey[200], size: 24,),
            Padding(padding: EdgeInsets.only(left: 10,)),
            Container(
              child: Text(text,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[200], size: 20,),
          ],
        ),
      ],
    );
  }

  Widget ChildBuildBoxInternToggleSwich(icon, String text) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.grey[200], size: 24,),
              Padding(padding: EdgeInsets.only(left: 10,)),
              Container(
                child: Text(text,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
            ],
          ),
          Container(
            height: 20,
            child: Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: _lights,
                onChanged: (bool value) { setState(() { _lights = value; }); },
              ),
            ),
          ),
        ],
      ),
      onTap: () { setState(() { _lights = !_lights; }); },
    );
  }

  Widget MyDivider() {
    return Divider(
      height: AppTheme.elementSpacing * 1.5,
      color: Colors.grey,
    );
  }

}
