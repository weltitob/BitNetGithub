import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';

class MnemonicGen extends StatefulWidget {
  const MnemonicGen({super.key});

  @override
  State<MnemonicGen> createState() => MnemonicController();
}

class MnemonicController extends State<MnemonicGen> {

  String profileimageurl = "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.735520172.1711238400&semt=ais";

  late String code;
  late String issuer;
  late String username;

  bool hasWrittenDown = false;

  bool isLoadingSignUp = false;

  late Mnemonic mnemonic;
  late String mnemonicString;
  TextEditingController mnemonicTextController = TextEditingController();

  void initState() {
    super.initState();
    generateMnemonic();
  }

  void processParameters(BuildContext context) {
    Logs().w("Process parameters for mnemonicgen called");
    final Map<String, String> parameters = VRouter.of(context).queryParameters;

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if(parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
    if (parameters.containsKey('username')) {
      username = parameters['username']!;
    }

  }

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  void generateMnemonic() {
    setState(() {
      mnemonic = Mnemonic.generate(
        Language.english,
        entropyLength: 256, // this will be a 24-word-long mnemonic
      );
      mnemonicString = mnemonic.sentence;
      mnemonicTextController.text = mnemonicString;
    });
  }

  void confirmMnemonic(String typedMnemonic) {
    if (mnemonicString == typedMnemonic) {
      showOverlay(context, "Your mnemonic is correct! Please keep it safe.", color: AppTheme.successColor);
      signUp();
    } else {
      //implement error throw
      showOverlay(context, "Your mnemonic does not match. Please try again.", color: AppTheme.errorColor);
      Logs().e("Mnemonic does not match");
      changeWrittenDown();
    }
  }


  void signUp() async {
    setState(() {
      isLoadingSignUp = true;
    });
    try{
      Auth().loginMatrix(context, "weltitob@proton.me", "Bear123Fliederbaum");
      Logs().w("Making firebase auth now...");

      final userdata = UserData(
        backgroundImageUrl: profileimageurl,
        isPrivate: false,
        showFollowers: false,
        did: "",
        displayName: username,
        bio: "Hey there Bitcoiners! I joined the revolution!",
        customToken: "customToken",
        username: username,
        profileImageUrl: profileimageurl,
        createdAt: timestamp,
        updatedAt: timestamp,
        isActive: true,
        dob: 0,
      );

      VerificationCode verificationCode = VerificationCode(
          used: false,
          code: code,
          issuer: issuer,
          receiver: username);

      final UserData? currentuserwallet = await firebaseAuthentication(
          userdata,
          verificationCode
      );

      Logs().w("Navigating to homescreen now...");
      VRouter.of(context).to('/');

    } on MatrixException catch(e){
      print("Matrix Exception: $e");
      throw Exception(e);
    }
    on FirebaseException catch (e) {
      Logs().e("Firebase Exception calling signUp in mnemonicgen.dart: $e");
      throw Exception("We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.");
    } catch (e) {
      //implement error throw
      Logs().e("Error trying to call signUp in mnemonicgen.dart: $e");
    }
    setState(() {
      isLoadingSignUp = false;
    });
  }

  Future<UserData?> firebaseAuthentication(
      UserData userData, VerificationCode code) async {
    try {
      //blablabla
      Logs().w("Creating firebase user now...");

      final UserData currentuserwallet = await Auth().createUserFake(
        user: userData,
        code: code,
      );

      return currentuserwallet;
    }on FirebaseException catch (e) {
      Logs().e("Firebase Exception: $e");
      setState(() {
        throw Exception("Error: $e");
      });
    }
    catch (e) {
      throw Exception("Error: $e");
    }
    return null;
  }

  void changeWrittenDown() {
    setState(() {
      hasWrittenDown = !hasWrittenDown;
    });
  }



  @override
  Widget build(BuildContext context) {
    processParameters(context);

    if (hasWrittenDown) {
      return MnemonicGenConfirm(mnemonicController: this,);
    } else {
      return MnemonicGenScreen(mnemonicController: this);
    }
  }
}
