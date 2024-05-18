import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/matrix_models/identityprovider_matrix.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount_view.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
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
    LoggerService logger = Get.find();
    logger.i("Process parameters for createAccount called");
    final Map<String, String> parameters =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;
    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
  }

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? errorMessage = null;
  String? username = '';
  late String localpart;

  final TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;

  

  bool isDefaultPlatform =
      (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);


  void login() => context.go('/authhome/login');


 

  createAccountPressed() async {
    LoggerService logger = Get.find();
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    localpart =
        controllerUsername.text.trim().toLowerCase().replaceAll(' ', '_');
    if (localpart.isEmpty) {
      setState(() {
        errorMessage = L10n.of(context)!.pleaseChooseAUsername;
      });
      print("Failed signup Matrix");
      throw Exception(L10n.of(context)!.pleaseChooseAUsername);
    }

    try {
      bool usernameExists = await Auth().doesUsernameExist(localpart);

      if (!usernameExists) {
        // You can create the user here since they don't exist yet.
        logger.i("Username is still available");

        //VRouter.of(context).queryParameters.clear();

        logger.i(
            "Queryparameters that will be passed: $code, $issuer, $localpart");

        context.go(
          Uri(path: '/authhome/pinverification/mnemonicgen', queryParameters: {
            'code': code,
            'issuer': issuer,
            'username': localpart,
          }).toString(),
        );

        //await createUserLocal();
      } else {
        logger.e("Username already exists.");
        errorMessage = "This username is already taken.";
        // The username already exists.
      }
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    processParameters(context);

    return CreateAccountView(
      controller: this,
    );
  }
}
