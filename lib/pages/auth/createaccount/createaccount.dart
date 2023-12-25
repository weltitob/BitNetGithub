import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/pb_generator/tranform_link.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/identityprovider_matrix.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/models/verificationcode.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';
import 'package:universal_html/html.dart' as html;

class CreateAccount extends StatefulWidget {
  VerificationCode code;
  CreateAccount({required this.code});

  @override
  State<CreateAccount> createState() => CreateAccountController();
}

class CreateAccountController extends State<CreateAccount> {

  @override
  void initState() {
    super.initState();
    //vllt genau hier crap iwie
  }

  final GlobalKey<FormState> form = GlobalKey<FormState>();
  String profileimageurl = "https://media.discordapp.net/attachments/1077885354608177222/1111142365340635206/weltitob_a_corud_of_people_holding_their_fist_up_recolution_str_c5102adf-bf30-4478-aacf-acdd5d618e83.png?width=548&height=548";

  String? errorMessage = null;
  String? username = '';
  late String localpart;

  final TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;

  bool _supportsFlow(String flowType) =>
      Matrix.of(context)
          .loginHomeserverSummary
          ?.loginFlows
          .any((flow) => flow.type == flowType) ??
          false;

  bool isDefaultPlatform = (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);

  bool get supportsLogin => _supportsFlow('m.login.password');

  void login() => VRouter.of(context).to('login');

  Map<String, dynamic>? _rawLoginTypes;

  List<IdentityProvider>? get identityProviders {
    final loginTypes = _rawLoginTypes;
    if (loginTypes == null) return null;
    final rawProviders = loginTypes.tryGetList('flows')!.singleWhere(
          (flow) => flow['type'] == AuthenticationTypes.sso,
    )['identity_providers'];
    final list = (rawProviders as List)
        .map((json) => IdentityProvider.fromJson(json))
        .toList();
    if (PlatformInfos.isCupertinoStyle) {
      list.sort((a, b) => a.brand == 'apple' ? -1 : 1);
    }
    return list;
  }

  createAccountPressed() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });


    localpart = controllerUsername.text.trim().toLowerCase().replaceAll(' ', '_');
    if (localpart.isEmpty) {
      setState(() {
        errorMessage = L10n.of(context)!.pleaseChooseAUsername;
      });
      print("Failed signup Matrix");
      throw Exception(L10n.of(context)!.pleaseChooseAUsername);
    }

    try{
      bool usernameExists =
      await Auth().doesUsernameExist(localpart);

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
      isLoading = false;
    });
  }

  void matrixSignUp() {

    Logs().w("!!!CHANGE NEEDED: signup matrix need to change email each time and at one point setup own matrix server without email auth");
    Logs().w("signupmatrixfirst from Auth is called...");
    Auth().signUpMatrixFirst(context, localpart);
    // Logs().w("signupmatrixsecond from Auth is called...");
    // Auth().signupMatrix(context, "testhaha@gmail.com", "i__hate..passwords!!");

    //set profilepicture
    // Logs().w("Setting profilepicture for Matrix client too...");
    // final picked = await urlToXFile(profileimageurl);
    //set matrix profilepicture too
    // Matrix.of(context).loginAvatar = picked;
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
          backgroundImageUrl: profileimageurl,
          isPrivate: false,
          showFollowers: false,
          did: "",
          mainWallet: userwalletdata,
          displayName: controllerUsername.text,
          bio: "Hey there Bitcoiners! I joined the revolution!",
          customToken: "customToken",
          username: localpart,
          profileImageUrl: profileimageurl,
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: true,
          dob: 0,
          wallets: walletlist);

      Logs().w("Signing up user for Matrix now...");
      //matrixSignUp();
      Logs().w("For now simply login in own matrix client until own sever is setup and can register there somehow.");

      //dieser call leitet uns iwie bereits weiter zur matrix page da das muss verhindert werden
      Auth().loginMatrix(context, "weltitob@proton.me", "Bear123Fliederbaum");

      Logs().w("Making firebase auth now...");

      final UserData? currentuserwallet = await firebaseAuthentication(
          userdata,
          VerificationCode(
              used: false,
              code: widget.code.code,
              issuer: widget.code.issuer,
              receiver: widget.code.receiver));


      Logs().w("Navigating to homescreen now...");
      VRouter.of(context).to('/');

    } on MatrixException catch(e){
      print("Matrix Exception: $e");
      throw Exception(e);
    }
    on FirebaseException catch (e) {
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
      Logs().w("Creating firebase user now...");
      final UserData currentuserwallet = await Auth().createUser(
        user: userData,
        code: code,
      );
      return currentuserwallet;
    }on FirebaseException catch (e) {
      Logs().e("Firebase Exception: $e");
      setState(() {
        errorMessage =
        "We currently have troubles reaching our servers which connect with the blockchain. Please try again later.";
        throw Exception("Error: $e");
      });
    }
    catch (e) {
      setState(() {
        errorMessage = "${L10n.of(context)!.errorSomethingWrong}: ${e}";
      });
      throw Exception("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateAccountView(controller: this,);
  }
}
