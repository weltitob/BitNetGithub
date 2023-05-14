import 'dart:async';

import 'package:BitNet/generated/l10n.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/backgrounds/backgroundwithcontent.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/textfield/formtextfield.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'dart:math';

Random random = new Random();

// ignore: must_be_immutable
class DidAndPrivateKeyScreen extends StatefulWidget {
  // function to toggle between login and register screens
  Function() toggleView;
  Function() toggleGetStarted;
  // function to toggle between login and reset password screens
  Function() toggleResetPassword;

  DidAndPrivateKeyScreen({
    required this.toggleView,
    required this.toggleGetStarted,
    required this.toggleResetPassword,
  });

  @override
  _SignupScreenState createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<DidAndPrivateKeyScreen>
    with TickerProviderStateMixin {
  // composition of the lottie animation
  late final Future<LottieComposition> _composition;
  // error message if sign in fails
  String? errorMessage = null;
  // user's email
  String? email = '';
  // user's password
  String? password = '';

  // key for the form validation
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  // controllers for email and password fields
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // loading status
  bool _isLoading = false;

  // function to load the lottie animation
  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottiefiles/background.json');
    dynamic mycomposition = await LottieComposition.fromByteData(assetData);
    return mycomposition;
  }

  // function to sign in with email and password
  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    try {
      await Auth().signInWithToken(
        customToken: ''
      );
    } catch (e) {
      setState(() {
        errorMessage = S.of(context).errorSomethingWrong;
        print(e);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      context: context,
      gradientColor: Colors.black,
      appBar: BitNetAppBar(text: S.of(context).restoreAccount, context: context,
      onTap: (){
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
                top: AppTheme.cardPadding * 6),
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: AppTheme.cardPadding * 4.5,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                    S.of(context).welcomeBack,
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
                    title: S.of(context).usernameOrDID,
                    controller: _controllerEmail,
                    isObscure: false,
                    //das muss eh noch geändert werden gibt ja keine email
                    validator: (val) => val!.isEmpty
                        ? "Iwas geht nicht"
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
                      title: S.of(context).privateKey,
                      controller: _controllerPassword,
                      isObscure: true,
                    ),
                  ),
                  LongButtonWidget(
                    title: S.of(context).restoreAccount,
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        signIn();
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
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppTheme.errorColor),
                          ),
                        ),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  GestureDetector(
                    onTap: () {
                      // switch to passwordscreen
                      print('switch to reset password in authtree');
                      widget.toggleResetPassword();
                    },
                    child: Text(
                      S.of(context).restoreWithSocialRecovery,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppTheme.colorBitcoin
                      )
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: AppTheme.cardPadding * 1.5),
                    child: Text(
                      S.of(context).noAccountYet,
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
                        S.of(context).register,
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
