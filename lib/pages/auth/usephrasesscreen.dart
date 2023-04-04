import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/backgrounds/backgroundwithcontent.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/snackbar/snackbar.dart';
import 'package:BitNet/components/textfield/formtextfield.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'dart:math';

Random random = new Random();

class UsePhrasesScreen extends StatefulWidget {
  Function() toggleView;
  Function() toggleResetPassword;

  UsePhrasesScreen({
    required this.toggleView,
    required this.toggleResetPassword,
  });

  @override
  _UsePhrasesScreenState createState() {
    return _UsePhrasesScreenState();
  }
}

class _UsePhrasesScreenState extends State<UsePhrasesScreen>
    with TickerProviderStateMixin {
  String? lottiefile = '';
  String? errorMessage = null;
  String? email = '';

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();

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

  Future<void> resetPassword() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    try {
      await Auth().sendPasswordResetEmail(
        email: _controllerEmail.text,
      );
      print('Passwort rücksetzen angefragt');
      widget.toggleResetPassword();
      displaySnackbar(context, "Wir haben dir eine Anfrage per E-Mail gesendet!");
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = 'Bitte geb eine gültige E-Mail Adresse an!';
        print(e.message);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    chooseLottieFile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BitNetScaffold(
        gradientColor: Colors.black,
        appBar: BitNetAppBar(text: "Reset Password", context: context, onTap: (){
          widget.toggleResetPassword();
        }),
        body: BackgroundWithContent(
          opacity: 0.8,
          child: Form(
            key: _form,
            child: ListView(
              padding: EdgeInsets.only(
                  left: AppTheme.cardPadding * 2,
                  right: AppTheme.cardPadding * 2,
                  top: AppTheme.cardPadding * 8),
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    "Passwort zurücksetzen",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: AppTheme.white90),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
                  child: Text(
                    "Keine Panik! Wir senden dir einen Link per E-Mail.",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppTheme.white70),
                  ),
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
                          ? 'Bitte geben Sie Ihre E-Mail Adresse an'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: AppTheme.cardPadding,),
                    LongButtonWidget(
                      title: 'Anfrage senden',
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          //passwortz zurücksetzen email versenden
                          resetPassword();
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
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
                      child: Text(
                        "Du erinnert dich an dein Passwort?",
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
                          print('should toggle back to Login');
                          widget.toggleResetPassword();
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
        ),
      ),
    );
  }
}
