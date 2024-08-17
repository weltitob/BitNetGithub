import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedirectToApp extends StatefulWidget {
  const RedirectToApp({super.key});

  @override
  State<RedirectToApp> createState() => _RedirectToAppState();
}

class _RedirectToAppState extends State<RedirectToApp> {

  //using deeplinkage back to the app
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          text: "Redirecting to the app",
          context: context,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppTheme.cardPadding * 4),
                dotProgress(context),
                SizedBox(height: AppTheme.cardPadding),
                Text("Redirecting to the app..."),
                SizedBox(height: AppTheme.cardPadding * 4),
              ],
            ),
          ),
        ),
        context: context);
  }
}
