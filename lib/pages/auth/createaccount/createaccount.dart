import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/cupertino.dart';


class CreateAccount extends StatefulWidget {
  const CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => CreateAccountController();
}

class CreateAccountController extends State<CreateAccount> {
  late String code;
  late String issuer;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  String? errorMessage = null;
  String? username = '';
  late String localpart;
  final TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;
  bool isDefaultPlatform = (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);
  void login() => context.go('/authhome/login');

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

  void createAccountPressed() async {
    LoggerService logger = Get.find();
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    localpart = controllerUsername.text.trim().toLowerCase().replaceAll(' ', '_');
    if (localpart.isEmpty) {
      setState(() {
        errorMessage = L10n.of(context)!.pleaseChooseAUsername;
      });
      throw Exception(L10n.of(context)!.pleaseChooseAUsername);
    }

    try {
      bool usernameExists = await Auth().doesUsernameExist(localpart);
      if (!usernameExists) {
        logger.i("Username is still available");
        logger.i("Queryparameters that will be passed: $code, $issuer, $localpart");
        // context.go("/persona)")

        final registrationController = Get.find<RegistrationController>();

        logger.i("Clling registerAndSetupUser for our backend litd node");
        registrationController.isLoading.value == true.obs;
        registrationController.registerAndSetupUser("${localpart}_uid");

        context.go(
          Uri(path: '/authhome/pinverification/persona', queryParameters: {
            'code': code,
            'issuer': issuer,
            'username': localpart,
          }).toString(),
        );
      } else {
        logger.e("Username already exists.");
        errorMessage = L10n.of(context)!.usernameTaken;
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
