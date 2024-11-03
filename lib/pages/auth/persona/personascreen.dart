import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PersonaScreen extends StatefulWidget {
  const PersonaScreen({super.key});

  @override
  State<PersonaScreen> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends State<PersonaScreen> {

  late String code;
  late String issuer;
  late String username;
  late String mnemonicString;


  void processParameters(BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
    if (parameters.containsKey('username')) {
      username = parameters['username']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Persona Screen"),
              SizedBox(height: AppTheme.cardPadding * 2),
              LongButtonWidget(title: "Forward to next screen", onTap: () {
                context.go(
                  Uri(path: '/authhome/pinverification/reg_loading', queryParameters: {
                    'code': code,
                    'issuer': issuer,
                    'username': username,
                  }).toString(),
                );

              })
            ],
          ),
        ),
        context: context);
  }
}
