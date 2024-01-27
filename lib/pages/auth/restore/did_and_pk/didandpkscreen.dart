import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/recoverkey.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:matrix/matrix.dart';
import 'dart:math';

import 'package:vrouter/vrouter.dart';

Random random = new Random();

// ignore: must_be_immutable
class DidAndPrivateKeyScreen extends StatefulWidget {
  // function to toggle between login and register screens

  @override
  _SignupScreenState createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<DidAndPrivateKeyScreen>
    with TickerProviderStateMixin {
  // error message if sign in fails
  String? errorMessage = null;
  // user's email
  String? username = '';
  // user's password
  String? password = '';

  // key for the form validation
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  // controllers for email and password fields
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // loading status
  bool _isLoading = false;

  // function to sign in with email and password
  Future<void> signIn() async {
    Logs().w("signIn pressed...");
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    try {
      final bool isDID = isStringaDID(_controllerUsername.text);
      late String did;
      late String myusername;
      if (isDID) {
        did = _controllerUsername.text;
        myusername = await Auth().getUserUsername(_controllerUsername.text);
      } else {
        did = await Auth().getUserDID(_controllerUsername.text);
        myusername = _controllerUsername.text;
      }
      //call login with signed message and then store the iondata in the privatestorage of new device!
      //Auth().signIn(did, _controllerPassword.text, myusername);

      Logs().w(
          "didandpkscreen.dart: recover privatekey from user (broken if no real did) for user $did");

      final recoveredprivatkey = await recoverKey(
          "did:ion:EiDzohpJZiOLnibQRpC0mcvh6S6mBBTAGJJcanIY2_-jxg",
          _controllerPassword.text);
      // final recoveredprivatkey = await recoverKey(did, _controllerPassword.text);

      final signedMessage =
          await Auth().signMessageAuth(did, recoveredprivatkey);
      await Auth().signIn(did, signedMessage, context);
    } catch (e) {
      setState(() {
        errorMessage = L10n.of(context)!.errorSomethingWrong;
        print(e);
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
        margin: isSuperSmallScreen
            ? EdgeInsets.symmetric(horizontal: 0)
            : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250),
        extendBodyBehindAppBar: true,
        context: context,
        gradientColor: Colors.black,
        appBar: bitnetAppBar(
            text: "DID and Private Key Login",
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            }),
        body: BackgroundWithContent(
          backgroundType: BackgroundType.asset,
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
                        L10n.of(context)!.welcomeBack,
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
                      L10n.of(context)!.poweredByDIDs,
                      style: Theme.of(context).textTheme.bodyMedium,
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
                    Container(
                      width: AppTheme.cardPadding * 12,
                      child: FormTextField(
                        hintText: L10n.of(context)!.usernameOrDID,
                        controller: _controllerUsername,
                        isObscure: false,
                        //das muss eh noch geändert werden gibt ja keine email
                        validator: (val) =>
                            val!.isEmpty ? "Iwas geht nicht" : null,
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppTheme.cardPadding),
                      child: Container(
                        width: AppTheme.cardPadding * 12,
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
                          hintText: L10n.of(context)!.privateKey,
                          controller: _controllerPassword,
                          isObscure: true,
                        ),
                      ),
                    ),
                    LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 12,
                      title: L10n.of(context)!.restoreAccount,
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
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding * 2),
                      child: Text(
                        L10n.of(context)!.noAccountYet,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.white60,
                          width: 2,
                        ),
                        borderRadius: AppTheme.cardRadiusCircular,
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppTheme.cardPadding,
                          bottom: AppTheme.cardPadding),
                      child: GestureDetector(
                        onTap: () {
                          VRouter.of(context).to("/pinverification");
                        },
                        child: Text(
                          L10n.of(context)!.register,
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
      );
    });
  }
}
