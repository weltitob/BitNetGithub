import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/generate_custom_token.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/routetrees/controllers/widget_tree_controller.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/pages/settings/setting_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:internet_popup/internet_popup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Matrix extends StatefulWidget {
  final Widget? child;

  final BuildContext context;
  final Map<String, String>? queryParameters;

  const Matrix({
    this.child,
    required this.context,
    this.queryParameters,
    Key? key,
  }) : super(key: key);

  @override
  MatrixState createState() => MatrixState();

  /// Returns the (nearest) Client instance of your application.
  static MatrixState of(BuildContext context) =>
      Provider.of<MatrixState>(context, listen: false);
}

class MatrixState extends State<Matrix> with WidgetsBindingObserver {
  late BuildContext navigatorContext;
  @override
  void initState() {
    super.initState();

    try {
      // Initialize required controllers for web
      if (kIsWeb) {
        // Make sure LoggerService is registered
        if (!Get.isRegistered<LoggerService>()) {
          Get.put(LoggerService(), permanent: true);
        }

        // Make sure WidgetTreeController is registered
        if (!Get.isRegistered<WidgetTreeController>()) {
          Get.put(WidgetTreeController(), permanent: true);
        }
      }

      WidgetsBinding.instance.addObserver(this);

      // Safe route listener
      try {
        final router = widget.child as Router;
        final provider = router.routeInformationProvider;
        if (provider != null) {
          provider.addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        }
      } catch (e) {
        print(
            'Error setting up route listener (safe to ignore in web preview): $e');
      }

      // Defer initialization to allow build to complete first
      Future.microtask(() {
        if (mounted) {
          try {
            initMatrix();
          } catch (e) {
            print('Error in initMatrix (safe to ignore in web preview): $e');
          }

          try {
            initLoadingDialog();
          } catch (e) {
            print(
                'Error in initLoadingDialog (safe to ignore in web preview): $e');
          }

          try {
            initAuthListener();
          } catch (e) {
            print(
                'Error in initAuthListener (safe to ignore in web preview): $e');
          }
        }
      });
    } catch (e) {
      print('Error in Matrix initState (safe to ignore in web preview): $e');
    }
  }

  void initMatrix() {
    // Display the app lock
    if (PlatformInfos.isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ([TargetPlatform.linux].contains(Theme.of(context).platform)
                ? SharedPreferences.getInstance()
                    .then((prefs) => prefs.getString(SettingKeys.appLockKey))
                : const FlutterSecureStorage()
                    .read(key: SettingKeys.appLockKey))
            .then((lock) {
          if (lock?.isNotEmpty ?? false) {
            AppLock.of(widget.context)!.enable();
            AppLock.of(widget.context)!.showLockScreen();
          }
        });
      });
    }
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // if (routeInformation.uri.fragment == '/website/redirect') {
    //   print('prevented something ig');
    //   return SynchronousFuture(false);

    //   /// let the event bubble up to [GoRouteInformationProvider]
    // }
    // print('prevented something ig but weird');

    return SynchronousFuture(true);

    /// and stop event bubbling
  }

  void initLoadingDialog() {
    // Skip on web to avoid errors or use safe initialization
    if (kIsWeb) {
      // Set default values without L10n
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LoadingDialog.defaultTitle = "Loading, please wait...";
        LoadingDialog.defaultBackLabel = "Close";
      });
      return;
    }

    // Safe initialization for mobile
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final l10n = L10n.of(context);
        if (l10n != null) {
          LoadingDialog.defaultTitle = l10n.loadingPleaseWait;
          LoadingDialog.defaultBackLabel = l10n.close;
        } else {
          // Fallback values
          LoadingDialog.defaultTitle = "Loading, please wait...";
          LoadingDialog.defaultBackLabel = "Close";
        }
      } catch (e) {
        print('Error in initLoadingDialog (safe to ignore in web preview): $e');
        // Fallback values
        LoadingDialog.defaultTitle = "Loading, please wait...";
        LoadingDialog.defaultBackLabel = "Close";
      }
    });
  }

  Future<void> initConfig() async {
    LoggerService logger = Get.find();
    try {
      final configJsonString =
          utf8.decode((await http.get(Uri.parse('config.json'))).bodyBytes);
      final configJson = json.decode(configJsonString);
      AppTheme.loadFromJson(configJson);
    } on FormatException catch (_) {
      logger.i('[ConfigLoader] config.json not found');
    } catch (e) {
      logger.i('[ConfigLoader] config.json not found, error: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    try {
      // Check if LoggerService is registered
      if (Get.isRegistered<LoggerService>()) {
        LoggerService logger = Get.find<LoggerService>();
        logger.i('AppLifecycleState = $state');
      } else {
        print('AppLifecycleState = $state (LoggerService not available)');
      }
    } catch (e) {
      print(
          'Error in didChangeAppLifecycleState (safe to ignore in web preview): $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldBeBuilder = kIsWeb &&
        !(widget.child as Router)
            .routeInformationProvider!
            .value
            .uri
            .toString()
            .contains('website');
    return Provider(
      create: (_) => this,
      child: (kIsWeb &&
              !(widget.child as Router)
                  .routeInformationProvider!
                  .value
                  .uri
                  .toString()
                  .contains('website'))
          ? WebBuilder(widget: widget)
          : widget.child,
    );
  }

  void initAuthListener() {
    try {
      Auth().authStateChanges.listen((val) async {
        try {
          if (val == null) {
            String? savedUser =
                LocalStorage.instance.getString("most_recent_user");
            if (savedUser != null && savedUser != "") {
              String? token = await generateCustomToken(savedUser);
              if (token != null) {
                Auth().reAuthenticate(customToken: token);
              }
            }
          }
        } catch (e) {
          print(
              'Error in auth listener callback (safe to ignore in web preview): $e');
        }
      });
    } catch (e) {
      print(
          'Error initializing auth listener (safe to ignore in web preview): $e');
    }
  }
}

class WebBuilder extends StatefulWidget {
  const WebBuilder({
    super.key,
    required this.widget,
  });

  final Matrix widget;

  @override
  State<WebBuilder> createState() => _WebBuilderState();
}

class _WebBuilderState extends State<WebBuilder> {
  @override
  void initState() {
    super.initState();

    // Make sure WidgetTreeController is registered
    if (!Get.isRegistered<WidgetTreeController>()) {
      Get.put(WidgetTreeController(), permanent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current screen size
    final screenSize = MediaQuery.of(context).size;

    // Determine if this is a narrow screen that should use mobile layout
    final isMobileWidth = screenSize.width < 768;

    // For small screens, use mobile layout with fixed width
    // For larger screens, use a responsive layout with constraints
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).brightness == Brightness.light
                ? lighten(Theme.of(context).colorScheme.primaryContainer, 50)
                : darken(Theme.of(context).colorScheme.primaryContainer, 80),
            Theme.of(context).brightness == Brightness.light
                ? lighten(Theme.of(context).colorScheme.tertiaryContainer, 50)
                : darken(Theme.of(context).colorScheme.tertiaryContainer, 80),
          ],
        ),
      ),
      child: ClipRRect(
        child: Center(
          child: isMobileWidth
              // On narrow screens, show as a fixed-width mobile UI
              ? SizedBox(width: 375, child: widget.widget.child)
              // On wider screens, use a responsive layout with constraints
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1200, // Maximum width for very large screens
                    minWidth: 768, // Minimum width
                  ),
                  child: widget.widget.child,
                ),
        ),
      ),
    );
  }

  // This method is no longer used but kept for reference
  MediaQueryData cloneMediaQueryWithSize(MediaQueryData data, Size size) {
    return MediaQueryData(
      size: size,
      devicePixelRatio: data.devicePixelRatio,
      textScaler: data.textScaler,
      platformBrightness: data.platformBrightness,
      padding: data.padding,
      viewInsets: data.viewInsets,
      systemGestureInsets: data.systemGestureInsets,
      viewPadding: data.viewPadding,
      alwaysUse24HourFormat: data.alwaysUse24HourFormat,
      accessibleNavigation: data.accessibleNavigation,
      invertColors: data.invertColors,
      highContrast: data.highContrast,
      onOffSwitchLabels: data.onOffSwitchLabels,
      disableAnimations: data.disableAnimations,
      boldText: data.boldText,
      navigationMode: data.navigationMode,
      gestureSettings: data.gestureSettings,
      displayFeatures: data.displayFeatures,
    );
  }
}
