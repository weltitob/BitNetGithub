import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_scroll_behaviour.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/intl/generated/l10n.dart' as intl;
import 'package:bitnet/pages/routetrees/controllers/widget_tree_controller.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatelessWidget {
  static GlobalKey<NavigatorState>? routerKey = GlobalKey<NavigatorState>();

  static bool gotInitialLink = false;

  // Store the previous column mode to avoid unnecessary rebuilds
  bool? _previousColumnMode;
  WidgetTreeController? _controller;
  
  // Memoize theme data to avoid rebuilds
  ThemeData? _lightTheme;
  ThemeData? _darkTheme;
  
  ThemeData _getLightTheme(Color? primaryColor) {
    return _lightTheme ??= AppTheme.customTheme(Brightness.light, primaryColor);
  }
  
  ThemeData _getDarkTheme(Color? primaryColor) {
    return _darkTheme ??= AppTheme.customTheme(Brightness.dark, primaryColor);
  }

  // Flag to track if we've handled Firebase initialization
  static bool _safeFirebaseInitialized = false;

  // Safe Firebase initialization for web
  Future<void> _ensureFirebaseInitialized() async {
    if (_safeFirebaseInitialized) return;
    
    try {
      // Check if Firebase is available and initialized
      if (kIsWeb && !Firebase.apps.isNotEmpty) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyAjN44otvMhSGsLOQeDHduRw6x2KQgbYQY',
            appId: '466393582939',
            messagingSenderId: '01',
            projectId: 'bitnet-cb34f',
            storageBucket: 'bitnet-cb34f.appspot.com'
          ),
        );
      }
    } catch (e) {
      print('Firebase initialization error (safe to ignore in web preview): $e');
    }
    
    _safeFirebaseInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    // Try to initialize Firebase safely
    _ensureFirebaseInitialized();
    
    final provider = Provider.of<LocalProvider>(context);
    
    // Initialize required services if not already initialized
    // 1. Initialize LoggerService
    LoggerService logger;
    if (!Get.isRegistered<LoggerService>()) {
      logger = Get.put(LoggerService());
    } else {
      logger = Get.find<LoggerService>();
    }
    
    // 2. Initialize DioClient
    if (!Get.isRegistered<DioClient>()) {
      Get.put(DioClient());
    }
    
    // 3. Initialize WidgetTreeController safely
    try {
      if (!Get.isRegistered<WidgetTreeController>()) {
        Get.put(WidgetTreeController());
      }
      _controller ??= Get.find<WidgetTreeController>();
    } catch (e) {
      print('Error initializing WidgetTreeController (safe to ignore in web preview): $e');
      // Create an emergency backup controller if needed
      if (_controller == null) {
        _controller = WidgetTreeController(); // Create locally without registering
      }
    }
    
    final controller = _controller!;

    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) {
        // Memoize theme data
        final lightTheme = _getLightTheme(primaryColor);
        final darkTheme = _getDarkTheme(primaryColor);
        
        return LayoutBuilder(
          builder: (context, constraints) {
            final isColumnMode = AppTheme.isColumnModeByWidth(constraints.maxWidth);
            
            // Only update column mode if it changed to avoid unnecessary rebuilds
            if (_previousColumnMode != isColumnMode) {
              _previousColumnMode = isColumnMode;
              logger.i('Set Column Mode = $isColumnMode');
              
              // Avoid unnecessary Flutter tree rebuilds by using microtask
              Future.microtask(() {
                // Only set initialUrl if it's empty to prevent duplicate router initialization
                if (controller.initialUrl!.value.isEmpty) {
                  controller.initialUrl!.value = "/loading";
                }
                controller.columnMode!.value = isColumnMode;
              });
            }
            
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: false,
              splitScreenMode: false,
              builder: (_, child) {
                return GetMaterialApp(
                  themeMode: themeMode,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  home: MaterialApp.router(
                    routerConfig: AppRouter.router,
                    title: AppTheme.applicationName,
                    debugShowCheckedModeBanner: false,
                    themeMode: themeMode,
                    theme: lightTheme, // Use cached theme
                    darkTheme: darkTheme, // Use cached theme
                    scrollBehavior: CustomScrollBehavior(),
                    locale: provider.locale,
                    supportedLocales: L10n.supportedLocales,
                    localizationsDelegates: const [
                      intl.L10n.delegate,
                      L10n.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    builder: (context, child) => Matrix(
                      context: context,
                      child: child,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  int? primaryColor;
  SharedPreferences? preferences;
}
