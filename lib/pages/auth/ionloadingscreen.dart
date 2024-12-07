import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AuthLoadingScreen extends StatefulWidget {
  final String loadingText;

  const AuthLoadingScreen({Key? key, required this.loadingText})
      : super(key: key);

  @override
  State<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends State<AuthLoadingScreen> {
  late final Future<LottieComposition> comp;


  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    comp = loadComposition('assets/lottiefiles/blockchain_loader.json');
  }

  @override
  Widget build(BuildContext context) {
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
                  LongButtonWidget(title: "title", onTap: () async {
                    print("Button pressed");

                    final litdController = Get.find<LitdController>();
                    final logger = Get.find<LoggerService>();
                    print("Second message");

                    if (litdController.isLoading.value == true.obs.value){
                      logger.i("Loading is true");
                    } else if (litdController.isLoading.value == false.obs.value){
                      logger.i("Loading is false the user is now deployed and ready to go");
                      context.go(
                        Uri(path: '/').toString(),
                      );
                    }
                  }
                  )
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
