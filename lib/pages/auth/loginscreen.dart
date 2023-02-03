import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/components/buttons/longbutton.dart';
import 'package:nexus_wallet/components/textfield/formtextfield.dart';
import '../../theme.dart';
import 'dart:math';

Random random = new Random();

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  Function() toggleView;
  Function() toggleResetPassword;

  LoginScreen({
    required this.toggleView,
    required this.toggleResetPassword,
  });

  @override
  _SignupScreenState createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  String? lottiefile = '';
  String? errorMessage = null;
  String? email = '';
  String? password = '';

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _visible = false;
  bool _isLoading = false;

  void chooseLottieFile() async {
    int randomNumber = random.nextInt(lottiebackgrounds.length);
    lottiefile = lottiebackgrounds[randomNumber];
    await lottiefile; //that picture is already loaded can also use timedelay
    setState(() {
      _visible = !_visible;
    });
  }

  List<String> lottiebackgrounds = [
    "https://assets8.lottiefiles.com/packages/lf20_flhqgevg.json", //astronaut
  ];

  @override
  void initState() {
    super.initState();
    chooseLottieFile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = 'Hmm. Hier stimmt etwas nicht!';
        print(e.message);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: lottiefile == ''
                  ? Container()
                  : FittedBox(
                      fit: BoxFit.fitHeight,
                      child: AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 7000),
                        //lottieflie wird wahrscheinlich erst fertig geladen wenn animation schon angefangen
                        //hat daher geht es auf falsches lottiefile und funktioniert nicht
                        child: LottieBuilder.network(lottiefile!),
                      ),
                    ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.80),
            ),
            Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 2,
                    top: AppTheme.cardPadding * 6),
                physics: BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Text(
                      "Willkommen zurück!",
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
                        "Gestiftet von der Bundesregierung",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
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
                        controller: _controllerEmail,
                        isObscure: false,
                        validator: (val) => val!.isEmpty
                            ? 'Bitte geben Sie eine gültige Email an'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppTheme.cardPadding),
                        child: FormTextField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Bitte geben Sie ihr Passwort ein";
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
                          title: "Passwort",
                          controller: _controllerPassword,
                          isObscure: true,
                        ),
                      ),
                      LongButtonWidget(
                        title: 'Anmelden',
                        onTap: () {
                          print('Sign up pressed');
                          if (_form.currentState!.validate()) {
                            signInWithEmailAndPassword();
                          }
                        },
                        state:
                            _isLoading ? ButtonState.loading : ButtonState.idle,
                      ),
                      errorMessage == null
                          ? Container()
                          : Padding(
                            padding: const EdgeInsets.only(top: AppTheme.cardPadding),
                            child: Text(
                                errorMessage!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppTheme.errorColor),
                              ),
                          ),
                      SizedBox(height: AppTheme.cardPadding,),
                      GestureDetector(
                        onTap: () {
                          //sollte resetpasswordscreen switchen
                          print('switch to reset password in authtree');
                          widget.toggleResetPassword();
                        },
                        child: Text(
                          'Passwort vergessen',
                          style: GoogleFonts.manrope(
                            color: AppTheme.colorBitcoin,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
                        child: Text(
                          "Du hast noch kein Konto?",
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
                            'Registieren',
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
