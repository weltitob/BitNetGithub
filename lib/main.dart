import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/secondpages/lock_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bitnet/pages/routetrees/widgettree.dart' as bTree;
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';
import 'backbone/auth/auth.dart';
import 'package:intl/date_symbol_data_local.dart';
// Changed from 'dart:html'
import 'package:matrix/matrix.dart';
//import 'firebase_options.dart';

//⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⢀⣀⣤⣴⣶⣶⣶⣶⣦⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⣀⣤⣾⣿⡿⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⢠⣼⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠈⠙⠿⣿⣷⣄⠀⠀⠀⠀
// ⠀⠀⠀⣰⣿⡿⠋⠀⠀⠀⠀⠀⣿⡇⠀⢸⣿⡇⠀⠀⠀⠀  ⠀ ⠈⢿⣿⣦⡀⠀⠀
// ⠀⠀⣸⣿⡿⠀⠀⠀⠸⠿⣿⣿⣿⡿⠿⠿⣿⣿⣿⣶⣄⠀⠀ ⠀ ⠀⢹⣿⣷⠀⠀
// ⠀⢠⣿⡿⠁⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀ ⠀⠀⠈⣿⣿⣿⠀⠀⠀⠀  ⠀⢹⣿⣧⠀
// ⠀⣾⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀ ⠀⢀⣠⣿⣿⠟⠀⠀⠀⠀⠀  ⠈⣿⣿⠀
// ⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⡿⠿⠿⠿⣿⣿⣥⣄⠀⠀⠀⠀⠀ ⠀  ⣿⣿⠀
// ⠀⢿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀ ⠀⠀⢻⣿⣿⣧⠀⠀⠀⠀  ⢀⣿⣿⠀
// ⠀⠘⣿⣷⡀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀ ⠀⠀⣼⣿⣿⡿⠀⠀⠀  ⠀⣸⣿⡟⠀
// ⠀⠀⢹⣿⣷⡀⠀⠀⢰⣶⣿⣿⣿⣷⣶⣶⣾⣿⣿⠿⠛⠁⠀  ⠀⣸⣿⡿⠀⠀
// ⠀⠀⠀⠹⣿⣷⣄⠀⠀⠀⠀⠀⣿⡇⠀⢸⣿⡇⠀⠀ ⠀⠀⠀ ⢀⣾⣿⠟⠁⠀⠀
// ⠀⠀⠀⠀⠘⢻⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀ ⢀⣠⣾⣿⡿⠋⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣷⣶⣤⣤⣤⣤⣤⣤⣴⣾⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠻⠿⠿⠿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
//
//██████╗░██╗████████╗███╗░░██╗███████╗████████╗
//██╔══██╗██║╚══██╔══╝████╗░██║██╔════╝╚══██╔══╝
//██████╦╝██║░░░██║░░░██╔██╗██║█████╗░░░░░██║░░░
//██╔══██╗██║░░░██║░░░██║╚████║██╔══╝░░░░░██║░░░
//██████╦╝██║░░░██║░░░██║░╚███║███████╗░░░██║░░░
//╚═════╝░╚═╝░░░╚═╝░░░╚═╝░░╚══╝╚══════╝░░░╚═╝░░░

// Main function to start the application
Future<void> main() async {
  void onAppLink() {
    print("APPLINK WAS TRIGGERED");
  }

  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Date Formatting
  await initializeDateFormatting();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAjN44otvMhSGsLOQeDHduRw6x2KQgbYQY',
      //authDomain: '...',
      //appId von firebase ist iwie für ios und android unterschiedlich
      appId: '466393582939',
      messagingSenderId: '01',
      projectId: 'bitnet-cb34f',
      // ... other options
    ),
  );

  await FirebaseAppCheck.instance.activate(
    //web
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    //android
    androidProvider:
        AndroidProvider.debug, //AndoroidProvider.playIntegrity nach release
    //ios
    appleProvider: AppleProvider.appAttest,
  );

  Logs().nativeColors = !PlatformInfos.isIOS;

  // Run the app
  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) =>
                //matrix_chat_app.dart apply later
                const MyApp(),
            lockScreen: const LockScreen(),
            enabled: false,
          )
        : const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? SeoController(
            tree: WidgetTree(context: context),
            child: MultiProvider(
              providers: [
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStream,
                  initialData: null,
                ),
                // Provide a stream of user wallet data for authentication changes
                //this has to be below in order to overwrite the null when not authenticated yet from above stream
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStreamForAuthChanges,
                  initialData: null,
                ),
                // Provide a stream of user wallet data
              ],
              child: bTree.WidgetTree(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<LocalProvider>(
                  create: (context) => LocalProvider()),
              StreamProvider<UserData?>(
                create: (_) => Auth().userWalletStream,
                initialData: null,
              ),
              // Provide a stream of user wallet data for authentication changes
              //this has to be below in order to overwrite the null when not authenticated yet from above stream
              StreamProvider<UserData?>(
                create: (_) => Auth().userWalletStreamForAuthChanges,
                initialData: null,
              ),
              // Provide a stream of user wallet data
            ],
            child: bTree.WidgetTree(),
          );
  }
}
