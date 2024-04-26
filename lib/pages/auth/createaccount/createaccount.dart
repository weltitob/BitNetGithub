import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount_view.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';


class CreateAccount extends StatefulWidget {
  CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => CreateAccountController();
}

class CreateAccountController extends State<CreateAccount> {

  late String code;
  late String issuer;

  @override
  void initState() {
    super.initState();
  }

  void processParameters(BuildContext context) {
    Logs().w("Process parameters for createAccount called");
    final Map<String, String> parameters = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;
    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if(parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
  }

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? errorMessage = null;
  String? username = '';
  late String localpart;

  final TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;



  bool isDefaultPlatform = (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);


  void login() => context.go('/authhome/login');

  Map<String, dynamic>? _rawLoginTypes;

  // List<IdentityProvider>? get identityProviders {
  //   final loginTypes = _rawLoginTypes;
  //   if (loginTypes == null) return null;
  //   final rawProviders = loginTypes.tryGetList('flows')!.singleWhere(
  //         (flow) => flow['type'] == AuthenticationTypes.sso,
  //   )['identity_providers'];
  //   final list = (rawProviders as List)
  //       .map((json) => IdentityProvider.fromJson(json))
  //       .toList();
  //   if (PlatformInfos.isCupertinoStyle) {
  //     list.sort((a, b) => a.brand == 'apple' ? -1 : 1);
  //   }
  //   return list;
  // }

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
        Logs().w("Username is still available");

        //VRouter.of(context).queryParameters.clear();

        Logs().w("Queryparameters that will be passed: $code, $issuer, $localpart");

        context.go(Uri(path: '/authhome/pinverification/mnemonicgen', queryParameters: {
          'code': code,
          'issuer': issuer,
          'username': localpart,
        }).toString());

        //await createUserLocal();
      } else {
        Logs().e("Username already exists.");
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

  // void matrixSignUp() {

  //   Logs().w("!!!CHANGE NEEDED: signup matrix need to change email each time and at one point setup own matrix server without email auth");
  //   Logs().w("signupmatrixfirst from Auth is called...");
  //   Auth().signUpMatrixFirst(context, localpart);
  //   // Logs().w("signupmatrixsecond from Auth is called...");
  //   // Auth().signupMatrix(context, "testhaha@gmail.com", "i__hate..passwords!!");

  //   //set profilepicture
  //   // Logs().w("Setting profilepicture for Matrix client too...");
  //   // final picked = await urlToXFile(profileimageurl);
  //   //set matrix profilepicture too
  //   // Matrix.of(context).loginAvatar = picked;
  // }


  @override
  Widget build(BuildContext context) {
    processParameters(context);

    return CreateAccountView(controller: this,);
  }
}
