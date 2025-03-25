import 'dart:async';
import 'dart:isolate';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/restore/userslist_controller.dart';
import 'package:bitnet/pages/routetrees/widgettree.dart' as bTree;
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';
import 'package:shake/shake.dart';
import 'package:timezone/data/latest.dart' as tz;
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
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠈⠉⠛⠻⠿⠿⠿⠿⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀

//██████╗░██╗████████╗███╗░░██╗███████╗████████╗
//██╔══██╗██║╚══██╔══╝████╗░██║██╔════╝╚══██╔══╝
//██████╦╝██║░░░██║░░░██╔██╗██║█████╗░░░░░██║░░░
//██╔══██╗██║░░░██║░░░██║╚████║██╔══╝░░░░░██║░░░
//██████╦╝██║░░░██║░░░██║░╚███║███████╗░░░██║░░░
//╚═════╝░╚═╝░░░╚═╝░░░╚═╝░░╚══╝╚══════╝░░░╚═╝░░░

Future<void> main() async {
  // Set up error handler to catch Firebase initialization errors first
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception.toString().contains('Firebase')) {
      print('Suppressed Firebase error in web: ${details.exception}');
    } else {
      FlutterError.presentError(details);
    }
  };

  // Ensure that Flutter binding is initialized in the same zone as runApp
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize only the critical services needed for startup
  await initializeDateFormatting();
  tz.initializeTimeZones();
  
  // Special handling for web to prevent Firebase initialization issues
  if (kIsWeb) {
    // Initialize splash screen
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    
    // Error handling for Firebase errors, but without zones
    try {
      // Run the app immediately
      runApp(const MyApp());
      
      // Delay initialization of non-critical services
      Future.delayed(const Duration(milliseconds: 100), () {
        _initializeWebServices();
        FlutterNativeSplash.remove();
      });
    } catch (error) {
      if (error.toString().contains('Firebase')) {
        print('Caught Firebase error in web: $error');
      } else {
        print('Error: $error');
        rethrow; // Rethrow if not Firebase related
      }
    }
  } else {
    // For mobile, initialize all services before launching UI
    await _initializeAllServices();
    
    // Run the app
    runApp(const MyApp());
  }
}

// Separate function for web services that handles errors gracefully
Future<void> _initializeWebServices() async {
  try {
    // Initialize only minimal services needed for web
    Get.put(LoggerService(), permanent: true);
    Get.put(DioClient(), permanent: true);
    
    // Try to initialize remote config if possible
    try {
      final remoteConfigController = Get.put(RemoteConfigController(), permanent: true);
      remoteConfigController.fetchRemoteConfigData().catchError((e) {
        print('Remote config error (safe to ignore in web preview): $e');
      });
    } catch (e) {
      print('Remote config initialization error (safe to ignore in web preview): $e');
    }
  } catch (e) {
    print('Web services initialization error (safe to ignore in web preview): $e');
  }
}

// Separate function to initialize all services for mobile platforms
Future<void> _initializeAllServices() async {
  await LocalStorage.instance.initStorage();
  
  ShakeDetector.autoStart(
    onPhoneShake: () {
      if (AppRouter.navigatorKey.currentContext != null) {
        GoRouter.of(AppRouter.navigatorKey.currentContext!).push('/report');
      }
    },
    shakeThresholdGravity: 4.5,
    minimumShakeCount: 5,
  );

  await _initializeFirebaseServices();
  await _initializeControllers();
}

// Function to initialize Firebase services
Future<void> _initializeFirebaseServices() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAjN44otvMhSGsLOQeDHduRw6x2KQgbYQY',
        appId: '466393582939',
        messagingSenderId: '01',
        projectId: 'bitnet-cb34f',
        storageBucket: 'bitnet-cb34f.appspot.com'
    ),
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  // Reduce Firestore cache size for better performance on web
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = Settings(
    cacheSizeBytes: kIsWeb ? 5242880 : 20971520, // 5MB for web, 20MB for mobile
  );
}

// Function to initialize controllers
Future<void> _initializeControllers() async {
  // Initialize essential controllers first
  Get.put(LoggerService(), permanent: true);
  Get.put(DioClient(), permanent: true);
  
  // Initialize and fetch remote config
  final remoteConfigController = Get.put(RemoteConfigController(), permanent: true);
  await remoteConfigController.fetchRemoteConfigData();
  
  // Initialize remaining controllers
  Get.put(SettingsController());
  Get.put(TransactionController());
  Get.put(LitdController());
  Get.put(ReceiveController(), permanent: true);
  Get.put(OverlayController(), permanent: true);
  Get.put(UsersListController(), permanent: true);
}

// Asynchronously initialize remaining services for web after UI is rendered
void _initializeRemainingServices() async {
  await Future.delayed(const Duration(milliseconds: 100)); // Tiny delay to ensure UI is prioritized
  await LocalStorage.instance.initStorage();
  await _initializeFirebaseServices();
  await _initializeControllers();
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

  // Create memoized providers for better performance
  final List<dynamic> _webProviders = [];
  List<dynamic> _getWebProviders() {
    if (_webProviders.isEmpty) {
      _webProviders.addAll([
        ChangeNotifierProvider<CardChangeProvider>(
          create: (context) => CardChangeProvider(),
        ),
        ChangeNotifierProvider<LocalProvider>(
          create: (context) => LocalProvider(),
        ),
        ChangeNotifierProvider<TimezoneProvider>(
          create: (context) => TimezoneProvider(),
        ),
        ChangeNotifierProvider<CountryProvider>(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider<CurrencyChangeProvider>(
          create: (context) => CurrencyChangeProvider(),
        ),
        ChangeNotifierProvider<CurrencyTypeProvider>(
          create: (context) => CurrencyTypeProvider(),
        ),
      ]);
    }
    return _webProviders;
  }

  @override
  Widget build(BuildContext context) {
    // Get memoized providers 
    final providers = _getWebProviders();
    
    return kIsWeb
        ? SeoController(
            tree: WidgetTree(context: context),
            child: MultiProvider(
              providers: [
                ...providers,
                // Stream providers are created with lazily to prevent
                // unnecessary data flow until needed
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStream,
                  initialData: null,
                  lazy: true, // Only subscribe when listened to
                ),
                StreamProvider<UserData?>(
                  create: (_) => Auth().userWalletStreamForAuthChanges,
                  initialData: null,
                  lazy: true, // Only subscribe when listened to
                ),
                ProxyProvider<CurrencyChangeProvider, BitcoinPriceStream>(
                  // Debounce updates to avoid excessive stream creation
                  update: (context, currencyChangeProvider, bitcoinPriceStream) {
                    // Skip unnecessary updates if the app isn't fully initialized
                    if (!Get.isRegistered<WalletsController>()) {
                      return bitcoinPriceStream ?? BitcoinPriceStream()
                        ..updateCurrency(currencyChangeProvider.selectedCurrency ?? 'usd');
                    }
                    
                    if (bitcoinPriceStream == null ||
                        bitcoinPriceStream.localCurrency !=
                            currencyChangeProvider.selectedCurrency) {
                      bitcoinPriceStream?.dispose();
                      final newStream = BitcoinPriceStream();
                      newStream.updateCurrency(
                          currencyChangeProvider.selectedCurrency ?? 'usd');
                      
                      if (Auth().currentUser != null) {
                        // Use a single subscription to avoid memory leaks
                        newStream.priceStream
                            .asBroadcastStream()
                            .listen((data) {
                          Get.find<WalletsController>().chartLines.value = data;
                        });
                      }
                      return newStream;
                    }
                    
                    return bitcoinPriceStream;
                  },
                  dispose: (context, bitcoinPriceStream) =>
                      bitcoinPriceStream.dispose(),
                  lazy: true, // Only create when needed
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
              ChangeNotifierProvider<TimezoneProvider>(
                create: (context) => TimezoneProvider(),
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
                    if (Auth().currentUser != null) {
                      newStream.priceStream.asBroadcastStream().listen((data) {
                        // Get.put(WalletsController());
                        Get.find<WalletsController>().chartLines.value = data;
                      });
                    }
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
