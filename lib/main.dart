import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
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
                //FROM Ahmad remove later once we have a proper implementation
                // ChangeNotifierProvider<MyThemeProvider>(
                //     create: (context) => MyThemeProvider()),
                ChangeNotifierProvider<LocalProvider>(
                    create: (context) => LocalProvider()),
                ChangeNotifierProvider<CurrencyChangeProvider>(
                    create: (context) => CurrencyChangeProvider()),
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStream,
                  initialData: null,
                ),
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStreamForAuthChanges,
                  initialData: null,
                ),
              ],
              child: bTree.WidgetTree(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<LocalProvider>(
                  create: (context) => LocalProvider()),
              ChangeNotifierProvider<CurrencyChangeProvider>(
                  create: (context) => CurrencyChangeProvider(),
              ),
              ProxyProvider<CurrencyChangeProvider, BitcoinPriceStream>(
                update: (context, currencyChangeProvider, bitcoinPriceStream) {
                  // Check if bitcoinPriceStream is null or currency has changed
                  if (bitcoinPriceStream == null || bitcoinPriceStream.localCurrency != currencyChangeProvider.selectedCurrency) {
                    // If so, dispose the old stream and create a new one with the updated currency
                    bitcoinPriceStream?.dispose();
                    final newStream = BitcoinPriceStream();
                    newStream.updateCurrency(currencyChangeProvider.selectedCurrency ?? 'usd');
                    return newStream;
                  }
                  // If the currency hasn't changed, return the existing stream
                  return bitcoinPriceStream;
                },
                dispose: (context, bitcoinPriceStream) => bitcoinPriceStream.dispose(),
              ),
              StreamProvider<ChartLine?>(
                create: (context) => Provider.of<BitcoinPriceStream>(context, listen: false).priceStream,
                initialData: ChartLine(time: 0, price: 0),
              ),
              // StreamProvider<ChartLine?>(
              //   create: (context) => BitcoinPriceStream().priceStream,
              //   initialData: ChartLine(time: 0, price: 0),
              // ),
              StreamProvider<UserData?>(
                create: (_) => Auth().userWalletStream,
                initialData: null,
              ),
              StreamProvider<UserData?>(
                create: (_) => Auth().userWalletStreamForAuthChanges,
                initialData: null,
              ),
            ],
            child: bTree.WidgetTree(),
          );
  }
}
