import 'dart:async';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/generated/l10n.dart';
import 'package:BitNet/models/userdata.dart';
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

class CreateAccountScreen extends StatefulWidget {
  VerificationCode code;
  Function() toggleView;
  CreateAccountScreen({
    required this.toggleView,
    required this.code});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? errorMessage = null;
  String? email = '';

  final TextEditingController _controllerEmail = TextEditingController();
  bool _isLoading = false;

  Future<void> createUser() async {
    setState(() {
      errorMessage = null;
      _isLoading = true;
    });
    try {
      //final userwalletdata = await createWallet(email: _controllerEmail.text);

      //create ION wallet for the user with all abilities
      final userwalletdata = UserWallet(
          walletAddress: "abcde",
          walletType: "walletType",
          walletBalance: "0.0",
          privateKey: "privateKey",
          userdid: "userdid");

      final List<UserWallet> walletlist = [userwalletdata];

      final userdata = UserData(
          backgroundImageUrl: "backgroundImageUrl",
          isPrivate: false,
          showFollowers: false,
          did: "",
          mainWallet: userwalletdata,
          displayName: _controllerEmail.text,
          bio: "Hey there Bitcoiners! I joined the revolution!",
          customToken: "customToken",
          username: _controllerEmail.text,
          profileImageUrl: "profileImageUrl",
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: true,
          dob: 0,
          wallets: walletlist);

      final UserData? currentuserwallet =
      await firebaseAuthentication(userdata,
          VerificationCode(used: false, code: widget.code.code, issuer: widget.code.issuer, receiver: widget.code.receiver));
    } catch (e) {
      _isLoading = false;
      //implement error throw
      print("STILL NEED TO ADD ERROR TEXT IN SOME WAY");
      throw Exception(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<UserData?> firebaseAuthentication(
      UserData userData, VerificationCode code) async {
    try {
      //blablabla
      final UserData currentuserwallet =
          await Auth().createUser(
        user: userData,
        code: code,
      );
      return currentuserwallet;
    } catch (e) {
      setState(() {
        errorMessage = "${S.of(context).errorSomethingWrong}: ${e}";
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BitNetScaffold(
        context: context,
        gradientColor: Colors.black,
        appBar: BitNetAppBar(
            text: S.of(context).register,
            context: context,
            onTap: () {
              widget.toggleView();
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
                      title: "Username",
                      validator: (val) => val!.isEmpty
                          ? 'The username you entered is not valid'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      controller: _controllerEmail,
                      isObscure: false,
                    ),
                    SizedBox(height: AppTheme.cardPadding,),
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
                              textAlign: TextAlign.center,
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
                          S.of(context).restoreAccount,
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
