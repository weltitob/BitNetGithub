import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/buttons/glassbutton.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/dialogsandsheets/snackbar.dart';
import 'package:BitNet/models/user/userwallet.dart';
import 'package:BitNet/pages/settings/settingsscreen.dart';
import 'package:BitNet/backbone/helper/theme.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final User? currentuser = Auth().currentUser;
  String? email = '';
  bool _isLoading = false;

  Widget _userUid() {
    return Text(currentuser?.email ?? 'User email');
  }

  @override
  void initState() {
    email = currentuser!.email;
    setState(() {
      _emailController.text = email!;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
  }

  void _updateEmail() async {
    setState(() {
      _isLoading = true;
    });
    try {
      //update it for firebaseauth
      final user = await _auth.signInWithEmailAndPassword(
        email: currentuser!.email!,
        password: _passwordController.text,
      );
      await user.user?.updateEmail(_emailController.text);
      //update in our firestoredatabase
      usersCollection.doc(currentuser!.uid).update({
        'email': _emailController.text,
      });
      print('username updated successfully');
      //zurück gehen und bestätigen dass alles richtig gelaufen ist
      Navigator.pop(context);
      displaySnackbar(
          context,
          "Ihre E-Mail Adresse wurde aktualisiert, bitte überprüfen "
          "sie ihr Postfach!");
    } on FirebaseAuthException catch (e) {
      displaySnackbar(context,
          "Ein Fehler ist aufgetreten. E-Mail wurde nicht aktualisiert");
      print(e);
      email = currentuser!.email;
      _emailController.text = email!;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Container(
        padding: EdgeInsets.only(top: AppTheme.cardPadding * 2),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing / 2,
                ),
                Text(
                  "E-Mail Adresse ändern",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            MyDivider(),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Text(
              "Neue E-Mail Adresse",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Container(
              width: AppTheme.cardPadding * 11.5,
              child: Glassmorphism(
                blur: 20,
                opacity: 0.1,
                radius: 24.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 1.5),
                  height: AppTheme.cardPadding * 2,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: _emailController,
                    autofocus: false,
                    onSubmitted: (text) {
                      setState(() {});
                      ;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Neue E-Mail Adresse hier angeben",
                      hintStyle: TextStyle(color: AppTheme.white60),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Text(
              "Passwort",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Container(
              width: AppTheme.cardPadding * 11.5,
              child: Glassmorphism(
                blur: 20,
                opacity: 0.1,
                radius: 24.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 1.5),
                  height: AppTheme.cardPadding * 2,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    autofocus: false,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Passwort eingeben",
                      hintStyle: TextStyle(color: AppTheme.white60),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppTheme.cardPadding * 2),
            Center(
              child: glassButton(
                  text: "Speichern",
                  iconData: Icons.save,
                  onTap: () => _updateEmail()),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Zurück'),
          elevation: 500,
          icon: const Icon(Icons.arrow_back_rounded),
          backgroundColor: Colors.purple.shade800,
        ),
      ),
    );
  }
}
