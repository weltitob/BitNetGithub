import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:persona_flutter/persona_flutter.dart';

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

  late InquiryConfiguration _configuration;

  late StreamSubscription<InquiryCanceled> _streamCanceled;
  late StreamSubscription<InquiryError> _streamError;
  late StreamSubscription<InquiryComplete> _streamComplete;

  @override
  void initState() {
    super.initState();

    //E/com.bitnet(11760): Invalid resource ID 0x00000000.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _configuration = TemplateIdConfiguration(
        templateId: "itmpl_5pSqWSacZ5pZNLDaFPetpWXNurr5",
        environment: InquiryEnvironment.sandbox,
        environmentId: "env_wLzW9p11FDUsXUNNaoQBhKpnMrEg",
        // locale: "pt-DE",
        // Client theming is deprecated and will be removed in the future.
        // theme: InquiryTheme(
        //   source: InquiryThemeSource.client,
        //   accentColor: Theme.of(context).colorScheme.secondary,
        //   primaryColor: Theme.of(context).colorScheme.primary,
        //   buttonBackgroundColor: Theme.of(context).colorScheme.surface,
        //   darkPrimaryColor: Theme.of(context).colorScheme.onPrimary,
        //   buttonCornerRadius: 8,
        //   textFieldCornerRadius: 0,
        // ),
      );
    });

    _streamCanceled = PersonaInquiry.onCanceled.listen(_onCanceled);
    _streamError = PersonaInquiry.onError.listen(_onError);
    _streamComplete = PersonaInquiry.onComplete.listen(_onComplete);
  }

  void _onCanceled(InquiryCanceled event) {
    print("InquiryCanceled");
    print("- inquiryId: ${event.inquiryId}");
    print("- sessionToken: ${event.sessionToken}");
  }

  void _onError(InquiryError event) {
    print("InquiryError");
    print("- error: ${event.error}");
  }

  void _onComplete(InquiryComplete event) {
    print("InquiryComplete");
    print("- inquiryId: ${event.inquiryId}");
    print("- status: ${event.status}");

    print("- fields:");
    for (var key in event.fields.keys) {
      print("-- key: $key, value: ${event.fields[key]}");
    }
    context.go(
      Uri(path: '/authhome/pinverification/reg_loading').toString(),
    );
  }

  @override
  void dispose() {
    _streamCanceled.cancel();
    _streamError.cancel();
    _streamComplete.cancel();
    super.dispose();
  }

  void processParameters(BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

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
    processParameters(context);

    return bitnetScaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_identity_rounded,
                size: 120,
              ),
              SizedBox(height: AppTheme.cardPadding * 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                    textAlign: TextAlign.center,
                    'We need to verify your identity before proceeding, thank you for your understanding.'),
              ),
              SizedBox(height: AppTheme.cardPadding),
              LongButtonWidget(
                  title: "Begin Verification",
                  onTap: () {
                    InquiryIdConfiguration(
                      inquiryId: "inq_5pSqWSacZ5pZNLDaFPetpWXNurr5",
                      sessionToken: "sessionToken",
                    );

                    PersonaInquiry.init(
                      configuration: _configuration,
                    );
                    PersonaInquiry.start();

                    context.go(
                      Uri(path: '/authhome/pinverification/reg_loading')
                          .toString(),
                    );

                    // context.go(
                    //   Uri(path: '/authhome/pinverification/mnemonicgen', queryParameters: {
                    //     'code': code,
                    //     'issuer': issuer,
                    //     'username': username,
                    //   }).toString(),
                    // );
                  })
            ],
          ),
        ),
        context: context);
  }
}
