import 'dart:async';
import 'package:BitNet/generated/l10n.dart';
import 'package:BitNet/pages/routetrees/authroutes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/backgrounds/backgroundwithcontent.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  Function() toggleView;
  Function() toggleGetStarted;
  PinVerificationScreen({
    required this.toggleView,
    required this.toggleGetStarted,
  });
  @override
  _PinVerificationScreenState createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool _loading = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String _error = "";
  String? _textValueClipboard = '';
  bool wanttocopy = true;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    _getClipboard();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  void _getClipboard() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text?.length == 5) {
      setState(() {
        textEditingController.text = data.text!;
      });
    } else {
      throw Exception('no code in users clipboard could be found');
    }
  }

  void checkIfCodeIsValid(String currentCode) async {
    setState(() {
      _loading = true;
    });
    try {
      formKey.currentState?.validate();

      QuerySnapshot snapshot =
          await codesCollection.where("code", isEqualTo: currentCode).get();
      VerificationCode code =
          VerificationCode.fromDocument(snapshot.docs.first);

      if (code.used == false) {
        _loading = false;
        //passing code to SignUp that it can be flagged as used later on
        onPinVerificationSuccess(
          code: code,
          context: context,
        );
      } else {
        errorController
            .add(ErrorAnimationType.shake); // Triggering error shake animation
        _error = S.of(context).codeAlreadyUsed;
        setState(() {
          _loading = false;
          hasError = true;
        });
      }
    } catch (error) {
      _error = S.of(context).codeNotValid;
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        _loading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      context: context,
      appBar: BitNetAppBar(
        onTap: () {
          widget.toggleGetStarted();
        },
        text: S.of(context).pinCodeVerification,
        context: context,
      ),
      gradientColor: Colors.black,
      key: scaffoldKey,
      body: BackgroundWithContent(
        opacity: 0.7,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: AppTheme.cardPadding * 3,
                    ),
                    Center(
                        child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding * 2),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            S.of(context).platformDemandText,
                            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                              shadows: [
                                AppTheme.boxShadowSmall,
                              ]
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 50),
                          ),
                          TypewriterAnimatedText(
                            S.of(context).platformExlusivityText,
                            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                shadows: [
                                  AppTheme.boxShadowSmall,
                                ]
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 50),
                          ),
                          TypewriterAnimatedText(
                            S.of(context).platformExpandCapacityText,
                            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                                shadows: [
                                  AppTheme.boxShadowSmall,
                                ]
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                        repeatForever: true,
                        pause: const Duration(milliseconds: 2000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            buildVerificationSpace()
          ],
        ),
      ),
    );
  }

  Widget buildVerificationSpace() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding * 2,
              vertical: AppTheme.elementSpacing,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  S.of(context).invitationCode,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Form(
                  key: formKey,
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: AppTheme.white90,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedColor: Colors.orange,
                      inactiveColor: AppTheme.white60,
                      activeColor: Colors.orange,
                      shape: PinCodeFieldShape.box,
                      borderRadius: AppTheme.cardRadiusSmall,
                      fieldHeight: AppTheme.cardPaddingBig * 2,
                      fieldWidth: AppTheme.cardPadding * 2,
                      borderWidth: 2,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: Duration(milliseconds: 300),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    backgroundColor: Colors.transparent,
                    enableActiveFill: false,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    onCompleted: (v) {
                      checkIfCodeIsValid(v);
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Center(
                  child: _loading
                      ? Container(
                          child: dotProgress(context),
                        )
                      : Text(
                          hasError ? _error : "",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppTheme.errorColor,
                                  ),
                        ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
