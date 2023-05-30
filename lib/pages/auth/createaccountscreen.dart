import 'dart:async';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/generated/l10n.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/routetrees/authroutes.dart';
import 'package:BitNet/pages/routetrees/authtree.dart';
import 'package:BitNet/pages/routetrees/getstartedtree.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
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
import 'package:BitNet/models/user/userwallet.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/backbone/helper/theme.dart';

class CreateAccountScreen extends StatefulWidget {
  VerificationCode code;
  CreateAccountScreen({required this.code});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? errorMessage = null;
  String? username = '';

  final TextEditingController _controllerUsername = TextEditingController();
  bool _isLoading = false;

  createAccountPressed() async {
    setState(() {
      errorMessage = null;
      _isLoading = true;
    });
    try{
      bool usernameExists =
      await Auth().doesUsernameExist(_controllerUsername.text);

      if (!usernameExists) {
        // You can create the user here since they don't exist yet.
        print("Username is still available");
        await createUser();
      } else {
        print("Username already exists.");
        errorMessage = "This username is already taken.";
        // The username already exists.
      }
    } catch(e) {
      print("Error: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> createUser() async {
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
          backgroundImageUrl: "https://media.discordapp.net/attachments/1077885354608177222/1111142365340635206/weltitob_a_corud_of_people_holding_their_fist_up_recolution_str_c5102adf-bf30-4478-aacf-acdd5d618e83.png?width=548&height=548",
          isPrivate: false,
          showFollowers: false,
          did: "",
          mainWallet: userwalletdata,
          displayName: _controllerUsername.text,
          bio: "Hey there Bitcoiners! I joined the revolution!",
          customToken: "customToken",
          username: _controllerUsername.text,
          profileImageUrl: "https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg",
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: true,
          dob: 0,
          wallets: walletlist);

      final UserData? currentuserwallet = await firebaseAuthentication(
          userdata,
          VerificationCode(
              used: false,
              code: widget.code.code,
              issuer: widget.code.issuer,
              receiver: widget.code.receiver));

      print("Should navigate to homescreen now...");
      navigateToHomeScreenAfterLogin(context);
      setState(() {});

    } on FirebaseException catch (e) {
      print("Firebase Exception: $e");
      throw Exception(
          "We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.");
    } catch (e) {
      //implement error throw
      print("STILL NEED TO ADD ERROR TEXT IN SOME WAY");
      throw Exception(e);
    }
  }

  Future<UserData?> firebaseAuthentication(
      UserData userData, VerificationCode code) async {
    try {
      //blablabla
      final UserData currentuserwallet = await Auth().createUser(
        user: userData,
        code: code,
      );
      return currentuserwallet;
    }on FirebaseException catch (e) {
      print("Firebase Exception: $e");
      setState(() {
        errorMessage =
        "We currently have troubles reaching our servers which connect with the blockchain. Please try again later.";
        throw Exception("Error: $e");
      });
    }
    catch (e) {
      setState(() {
        errorMessage = "${S.of(context).errorSomethingWrong}: ${e}";
      });
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_isLoading) {
          navigateToGetStartedTree(context);
        }
        return false; // Prevent the system from popping the current route.
      },
      child: BitNetScaffold(
        context: context,
        gradientColor: Colors.black,
        appBar: BitNetAppBar(
            text: S.of(context).register,
            context: context,
            onTap: () {
              if (!_isLoading) {
                navigateToGetStartedTree(context);
              }
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
                SizedBox(
                  height: AppTheme.cardPadding * 4,
                ),
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
                    FormTextField(
                      title: "Username",
                      validator: (val) => val!.isEmpty
                          ? 'The username you entered is not valid'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                      controller: _controllerUsername,
                      isObscure: false,
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding,
                    ),
                    LongButtonWidget(
                      title: S.of(context).register,
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          createAccountPressed();
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
                        S.of(context).alreadyHaveAccount,
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
                          if (!_isLoading) {
                            navigateToLogin(context);
                          }
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
