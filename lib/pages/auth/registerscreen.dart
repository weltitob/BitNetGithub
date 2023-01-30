import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/components/buttons/longbutton.dart';
import 'package:nexus_wallet/components/textfield/formtextfield.dart';
import 'package:nexus_wallet/theme.dart';

class RegisterScreen extends StatefulWidget {
  Function() toggleView;
  RegisterScreen({required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? errorMessage = '';
  String? email = '';
  String? password = '';

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPasswordconfirm =
      TextEditingController();

  bool _visible = false;
  bool _isLoading = false;

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        print(errorMessage);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    AppTheme.colorBackground,
                    Color(0xFF522F77),
                  ])),
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
                          .headline1!
                          .copyWith(color: AppTheme.white90),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Gestiftet von der Bundesregierung",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: AppTheme.white70),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 40,
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
                          _form.currentState?.validate();
                          createUserWithEmailAndPassword();
                        },
                        state:
                            _isLoading ? ButtonState.loading : ButtonState.idle,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
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
