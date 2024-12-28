import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
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
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/routetrees/widgettree.dart' as bTree;
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/router.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';
import 'package:shake/shake.dart';
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

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize Date Formatting
  await initializeDateFormatting();


  await LocalStorage.instance.initStorage();
  ShakeDetector.autoStart(
    onPhoneShake: () {
      if (AppRouter.navigatorKey.currentContext != null) {
        GoRouter.of(AppRouter.navigatorKey.currentContext!).push('/report');
      }
    },
    shakeThresholdGravity: 4.5, // Increase for more vigorous shaking
    minimumShakeCount: 5, // Require two shakes
  );


  await Firebase.initializeApp(
    options: const FirebaseOptions(
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
    androidProvider: AndroidProvider.debug, //kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
  );

  // Initialize Remote Config Controller and fetch data
  final remoteConfigController = Get.put(RemoteConfigController(), permanent: true);
  await remoteConfigController.fetchRemoteConfigData();


  Get.put(LoggerService(), permanent: true);
  Get.put(DioClient(), permanent: true);
  Get.put(SettingsController());
  Get.put(TransactionController());
  Get.put(LitdController());
  Get.put(ReceiveController(), permanent: true);
  Get.put(OverlayController(), permanent: true);

  // Get.put(LoggerService(), permanent: true);
  // Get.put(DioClient(), permanent: true);
  // Get.put(SettingsController(), permanent: true);
  // Get.put(TransactionController(), permanent: true);
  // Get.put(LitdController(), permanent:  true);
  // Get.put(WalletsController(), permanent: true);
  // Get.put(ReceiveController(), permanent: true);
  // Get.put(SettingsController(), permanent: true);
  // Get.put(FeedController(), permanent: true);
  // Get.put(ProfileController(), permanent: true);


  if (!kIsWeb) {
    Stripe.publishableKey = remoteConfigController.stripeTestKey.value;
    await Stripe.instance.applySettings();
  }
  if (kIsWeb) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  // Run the app
  runApp(
    GetMaterialApp(home: const MyApp()),
  );
  if (kIsWeb) {
    FlutterNativeSplash.remove();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
    if (!kIsWeb) {
      PhotoManager.clearFileCache();
    }

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  //make sure to connect to the user aws container when he logs in
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final logger = Get.find<LoggerService>();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (state == AppLifecycleState.resumed) {
        // App wurde geöffnet
        logger.i("Resumed lifecycle");
      } else if (state == AppLifecycleState.paused) {
        // App wird geschlossen
        logger.i("Applifecycle paused");
      } else if (state == AppLifecycleState.detached) {
        //close the ECS container
        logger.i("Applicaton detached");
        //hier wird die app dann auch wirklich geschlossen >> dann den container down shutten?
        //dann etwas in firebase storage schreiben in die collection namens appcycle
      } else if (state == AppLifecycleState.hidden) {
        // App wird minimiert
        logger.i("Applifecycle hidden");
      } else if (state == AppLifecycleState.inactive) {
        // App wird pausiert
        logger.i("Applifecycle inactive");
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                ChangeNotifierProvider<CurrencyTypeProvider>(create: (context) => CurrencyTypeProvider()),
                ProxyProvider<CurrencyChangeProvider, BitcoinPriceStream>(
                  update: (context, currencyChangeProvider, bitcoinPriceStream) {
                    if (bitcoinPriceStream == null || bitcoinPriceStream.localCurrency != currencyChangeProvider.selectedCurrency) {
                      bitcoinPriceStream?.dispose();
                      final newStream = BitcoinPriceStream();
                      newStream.updateCurrency(currencyChangeProvider.selectedCurrency ?? 'usd');
                      newStream.priceStream.asBroadcastStream().listen((data) {
                        Get.find<WalletsController>().chartLines.value = data;
                      });
                      return newStream;
                    }
                    bitcoinPriceStream.priceStream.asBroadcastStream().listen((data) {
                      Get.find<WalletsController>().chartLines.value = data;
                    });
                    return bitcoinPriceStream;
                  },
                  dispose: (context, bitcoinPriceStream) => bitcoinPriceStream.dispose(),
                ),
              ],
              child: bTree.WidgetTree(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<CardChangeProvider>(create: (context) => CardChangeProvider()),
              ChangeNotifierProvider<CurrencyTypeProvider>(create: (context) => CurrencyTypeProvider()),
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
                  if (bitcoinPriceStream == null || bitcoinPriceStream.localCurrency != currencyChangeProvider.selectedCurrency) {
                    bitcoinPriceStream?.dispose();
                    final newStream = BitcoinPriceStream();
                    newStream.updateCurrency(currencyChangeProvider.selectedCurrency ?? 'usd');
                    newStream.priceStream.asBroadcastStream().listen((data) {
                      Get.find<WalletsController>().chartLines.value = data;
                    });
                    return newStream;
                  }
                  bitcoinPriceStream.priceStream.asBroadcastStream().listen((data) {
                    Get.find<WalletsController>().chartLines.value = data;
                  });
                  return bitcoinPriceStream;
                },
                dispose: (context, bitcoinPriceStream) => bitcoinPriceStream.dispose(),
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
