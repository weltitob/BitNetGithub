import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class RedirectToApp extends StatefulWidget {
  const RedirectToApp({super.key});

  @override
  State<RedirectToApp> createState() => _RedirectToAppState();
}

class _RedirectToAppState extends State<RedirectToApp> {
  late StreamSubscription<Uri?> sub;

  void _initDeepLinkListener() {
    sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // Handle the deep link, for instance by parsing the path or query
        print('Received deep link: $uri');
        // You can navigate or perform other actions based on the deep link
      }
    }, onError: (err) {
      // Handle any errors
      print('Error occurred: $err');
    });
  }

  @override
  initState() {
    super.initState();
    _initDeepLinkListener();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          hasBackButton: false,
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
                const SizedBox(height: AppTheme.cardPadding * 4),
                dotProgress(context),
                const SizedBox(height: AppTheme.cardPadding),
                const Text("Redirecting to the app..."),
                const SizedBox(height: AppTheme.cardPadding * 4),
              ],
            ),
          ),
        ),
        context: context);
  }
}
