import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/routetrees/widgettree.dart' as bTree;
import 'package:bitnet/pages/secondpages/lock_screen.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

import 'backbone/auth/auth.dart';

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

//██████╗░██╗████████╗███╗░░██╗███████╗████████╗
//██╔══██╗██║╚══██╔══╝████╗░██║██╔════╝╚══██╔══╝
//██████╦╝██║░░░██║░░░██╔██╗██║█████╗░░░░░██║░░░
//██╔══██╗██║░░░██║░░░██║╚████║██╔══╝░░░░░██║░░░
//██████╦╝██║░░░██║░░░██║░╚███║███████╗░░░██║░░░
//╚═════╝░╚═╝░░░╚═╝░░░╚═╝░░╚══╝╚══════╝░░░╚═╝░░░

Future<void> main() async {
  // void onAppLink() {
  //   print("APPLINK WAS TRIGGERED");
  // }
  // Ensure that Flutter binding is initialized

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Date Formatting
  await initializeDateFormatting();
  if (!kIsWeb) {
    Stripe.publishableKey = AppTheme.stripeLiveKey;
    await Stripe.instance.applySettings();
  }
  await LocalStorage.instance.initStorage();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyAjN44otvMhSGsLOQeDHduRw6x2KQgbYQY',
      //authDomain: '...',
      //appId von firebase ist iwie für ios und android unterschiedlich
      appId: '466393582939',
      messagingSenderId: '01',
      projectId: 'bitnet-cb34f',
      storageBucket: 'bitnet-cb34f.appspot.com'
      // ... other options
    ),
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider:
        AndroidProvider.debug, //AndoroidProvider.playIntegrity nach release
    appleProvider: AppleProvider.appAttest,
  );

  Get.put(LoggerService(), permanent: true);
  Get.put(DioClient(), permanent:    true);
  Get.put(SettingsController());
  Get.put(TransactionController());

  // Run the app
  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) =>
                //matrix_chat_app.dart apply later
                  MyApp(),
            lockScreen: const LockScreen(),
            enabled: false,
          )
        : const MyApp(),
  );
}
 
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // GlobalKey _streamKey = GlobalKey(debugLabel: "");
  static bool _isHiveInitialized = false;
  static Future<void> _initializeHive() async {
    if (!_isHiveInitialized) {
      if (PlatformInfos.isLinux) {
        Hive.init((await getApplicationSupportDirectory()).path);
      } else {
        print("Initializing Hive...");
        await Hive.initFlutter();
        print("Hive initialized.");
      }
      _isHiveInitialized = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    PhotoManager.clearFileCache();
    super.initState();
    // _initializeHive();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? SeoController(
            tree: WidgetTree(context: context),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<CardChangeProvider>(
                  create: (context) => CardChangeProvider(),
                ),
                ChangeNotifierProvider<LocalProvider>(
                  create: (context) => LocalProvider(),
                ),
                ChangeNotifierProvider<CountryProvider>(
                  create: (context) => CountryProvider(),
                ),
                ChangeNotifierProvider<CurrencyChangeProvider>(
                  create: (context) => CurrencyChangeProvider(),
                ),
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStream,
                  initialData: null,
                ),
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStreamForAuthChanges,
                  initialData: null,
                ),
                // ChangeNotifierProvider<BalanceHideProvider>(
                //   create: (context) => BalanceHideProvider(),
                // ),
                              ChangeNotifierProvider<CurrencyTypeProvider>(
                  create: (context) => CurrencyTypeProvider()),
 ProxyProvider<CurrencyChangeProvider, BitcoinPriceStream>(
                update: (context, currencyChangeProvider, bitcoinPriceStream) {
                  if (bitcoinPriceStream == null ||
                      bitcoinPriceStream.localCurrency !=
                          currencyChangeProvider.selectedCurrency) {
                    bitcoinPriceStream?.dispose();
                    final newStream = BitcoinPriceStream();
                    newStream.updateCurrency(
                        currencyChangeProvider.selectedCurrency ?? 'usd');
                    newStream.priceStream.asBroadcastStream().listen((data) {
                      Get.find<WalletsController>().chartLines.value = data;
                    });
                    return newStream;
                  }
                  bitcoinPriceStream.priceStream
                      .asBroadcastStream()
                      .listen((data) {
                    Get.find<WalletsController>().chartLines.value = data;
                  });
                  return bitcoinPriceStream;
                },
                dispose: (context, bitcoinPriceStream) =>
                    bitcoinPriceStream.dispose(),
              ),
              ],
              child: bTree.WidgetTree(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<CardChangeProvider>(
                  create: (context) => CardChangeProvider()),
              ChangeNotifierProvider<CurrencyTypeProvider>(
                  create: (context) => CurrencyTypeProvider()),
              ChangeNotifierProvider<LocalProvider>(
                create: (context) => LocalProvider(),
              ),
              ChangeNotifierProvider<CountryProvider>(
                create: (context) => CountryProvider(),
              ),
              ChangeNotifierProvider<CurrencyChangeProvider>(
                create: (context) => CurrencyChangeProvider(),
              ),
              ProxyProvider<CurrencyChangeProvider, BitcoinPriceStream>(
                update: (context, currencyChangeProvider, bitcoinPriceStream) {
                  if (bitcoinPriceStream == null ||
                      bitcoinPriceStream.localCurrency !=
                          currencyChangeProvider.selectedCurrency) {
                    bitcoinPriceStream?.dispose();
                    final newStream = BitcoinPriceStream();
                    newStream.updateCurrency(
                        currencyChangeProvider.selectedCurrency ?? 'usd');
                    newStream.priceStream.asBroadcastStream().listen((data) {
                      Get.find<WalletsController>().chartLines.value = data;
                    });
                    return newStream;
                  }
                  bitcoinPriceStream.priceStream
                      .asBroadcastStream()
                      .listen((data) {
                    Get.find<WalletsController>().chartLines.value = data;
                  });
                  return bitcoinPriceStream;
                },
                dispose: (context, bitcoinPriceStream) =>
                    bitcoinPriceStream.dispose(),
              ),
              // This provider is now made redundant, use WalletsController.chartlines and
              //Obx if you need to listen for changes.
              // StreamProvider<ChartLine?>(
              //   key: _streamKey,
              //   create: (context) =>
              //       Provider.of<BitcoinPriceStream>(context,listen:false).priceStream,
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

