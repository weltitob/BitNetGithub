import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class IONLoadingScreen extends StatefulWidget {
  final String loadingText;

  const IONLoadingScreen({Key? key, required this.loadingText})
      : super(key: key);

  @override
  State<IONLoadingScreen> createState() => _IONLoadingScreenState();
}

class _IONLoadingScreenState extends State<IONLoadingScreen> {
  late final Future<LottieComposition> comp;

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
  void initState() {
    // TODO: implement initState
    comp = loadComposition('assets/lottiefiles/blockchain_loader.json');
  }

  @override
  Widget build(BuildContext context) {
    processParameters(context);
    return WillPopScope(
      onWillPop: () async => false, // prevent the user from going back
      child: bitnetScaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding * 2),
                    child: Text(
                      widget.loadingText,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  Container(
                    color: Colors.transparent,
                    height: AppTheme.cardPadding * 10,
                    child: FutureBuilder(
                      future: comp,
                      builder: (context, snapshot) {
                        dynamic composition = snapshot.data;
                        if (composition != null) {
                          return FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Lottie(composition: composition),
                          );
                        } else {
                          return Container(
                            color: Colors.transparent,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: AppTheme.cardPadding * 2,
              child: Container(
                width: MediaQuery.of(context).size.width, // full width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                      const EdgeInsets.only(left: AppTheme.elementSpacing / 2),
                      height: AppTheme.cardPadding * 1.25,
                      child: Image.asset("assets/images/logoclean.png"),
                    ),
                    SizedBox(width: AppTheme.elementSpacing,),
                    Text(
                      "BitNet",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
        context: context,
      ),
    );
  }
}
