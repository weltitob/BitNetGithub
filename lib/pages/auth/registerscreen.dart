import 'dart:async';
import 'package:BitNet/generated/l10n.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/cloudfunctions/createwallet.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/backgrounds/backgroundwithcontent.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/textfield/formtextfield.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/backbone/helper/theme.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  VerificationCode code;
  Function() toggleView;
  Function() toggleGetStarted;
  RegisterScreen({
    required this.toggleGetStarted,
    required this.toggleView,
    required this.code});

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
      final UserWallet? currentuserwallet =
          await createFirebaseUserWithEmailAndPassword(userwalletdata);
    } catch (e) {
      throw Exception(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<UserWallet?> createFirebaseUserWithEmailAndPassword(
      UserWallet userWallet) async {
    try {
      //blablabla
      final UserWallet currentuserwallet =
          await Auth().createUserWithEmailAndPassword(
        user: userWallet,
        password: _controllerPassword.text,
      );
      return currentuserwallet;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = "${S.of(context).errorSomethingWrong}: ${e.message}";
        print(e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BitNetScaffold(
        gradientColor: Colors.black,
        appBar: BitNetAppBar(
            text: S.of(context).register,
            context: context,
            onTap: () {
              widget.toggleGetStarted();
            }),
        body: BackgroundWithContent(
          opacity: 0.8,
          child: Form(
            key: _form,
            child: ListView(
              padding: EdgeInsets.only(
                  left: AppTheme.cardPadding * 2,
                  right: AppTheme.cardPadding * 2,
                  top: AppTheme.cardPadding * 5),
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: AppTheme.cardPadding * 4.5,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        S.of(context).powerToThePeople,
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.left,
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: false,
                    stopPauseOnTap: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).poweredByDIDs,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(left: AppTheme.elementSpacing / 2),
                      height: AppTheme.cardPadding * 1.5,
                      child: Image.asset("assets/images/ion.png"),
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
                      title: S.of(context).register,
                      onTap: () {
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
                      margin: EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
                      child: Text(
                        S.of(context).alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                          widget.toggleView();
                        },
                        child: Text(
                          S.of(context).restoreWallet,
                          style: Theme.of(context).textTheme.bodyMedium,
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
