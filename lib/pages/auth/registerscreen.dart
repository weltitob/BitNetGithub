import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/createwallet.dart';
import 'package:nexus_wallet/components/buttons/longbutton.dart';
import 'package:nexus_wallet/components/textfield/formtextfield.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/auth/background.dart';
import 'package:nexus_wallet/backbone/theme.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  Function() toggleView;
  RegisterScreen({required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? errorMessage = null;
  String? email = '';
  String? password = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordconfirm =
      TextEditingController();
  bool _isLoading = false;

  Future<void> createUser() async {
    setState(() {
      errorMessage = null;
      _isLoading = true;
    });
    try {
      final userwalletdata = await createWallet(email: _controllerEmail.text);
      final UserWallet? currentuserwallet = await createFirebaseUserWithEmailAndPassword(userwalletdata);
      final User? currentuser = Auth().currentUser;
      final user = Auth().getCurrentUserWallet(currentuser!.uid);
      print('user registered successfully');
    } catch (e) {
      print('error trying to register user');
      print(e);
    }
    setState(() {
      //error text will also be updated
      _isLoading = false;
    });
  }

  Future<UserWallet?> createFirebaseUserWithEmailAndPassword(UserWallet userWallet) async {
    try {
      //blablabla
      final UserWallet currentuserwallet =  await Auth().createUserWithEmailAndPassword(
        user: userWallet,
        password: _controllerPassword.text,
      );
      return currentuserwallet;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = "Etwas ist schief gelaufen: ${e.message}";
        print(e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BackgroundAuth(),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.35),
            ),
            Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 2,
                    top: AppTheme.cardPadding * 5),
                physics: BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Text(
                      "Wir sind deine Nexte Wallet!",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppTheme.white90),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Sichere deine Zukunft, mit NexusWallet!",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppTheme.white70),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: AppTheme.elementSpacing / 2),
                        height: AppTheme.cardPadding * 1.5,
                        child: Image.asset("assets/images/logotransparent.png"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormTextField(
                        title: "E-Mail",
                        validator: (val) => val!.isEmpty
                            ? 'Bitte geben Sie eine gültige E-Mail an'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        controller: _controllerEmail,
                        isObscure: false,
                      ),
                      FormTextField(
                        title: "Passwort",
                        controller: _controllerPassword,
                        isObscure: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Bitte geben Sie ein Passwort an";
                          } else if (val.length < 6) {
                            return "Das Passwort muss mindestens 6 Zeichen enthalten";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppTheme.cardPadding),
                        child: FormTextField(
                            title: "Passwort wiederholen",
                            controller: _controllerPasswordconfirm,
                            isObscure: true,
                            validator: (val) {
                              if (val.isEmpty)
                                return "Bitte geben Sie ein das Passwort erneut an";
                              if (val != _controllerPassword.text)
                                return 'Das Passwort stimmt nicht überein';
                              return null;
                            }),
                      ),
                      LongButtonWidget(
                        title: 'Registieren',
                        onTap: () {
                          print('Sign up pressed');
                          if (_form.currentState!.validate()) {
                            createUser();
                          }
                        },
                        state:
                            _isLoading ? ButtonState.loading : ButtonState.idle,
                      ),
                      errorMessage == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: AppTheme.cardPadding),
                              child: Text(
                                errorMessage!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppTheme.errorColor),
                              ),
                            ),
                      Container(
                        margin:
                            EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
                        child: Text(
                          'Du hast bereits ein Konto?',
                          style: GoogleFonts.manrope(
                            color: AppTheme.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 28),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.white60,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 0,
                          width: 65,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 22, bottom: 22),
                        child: GestureDetector(
                          onTap: () {
                            print('should toggle View');
                            widget.toggleView();
                          },
                          child: Text(
                            'Anmelden',
                            style: GoogleFonts.manrope(
                              color: AppTheme.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
