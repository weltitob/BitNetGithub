import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/settings/setting_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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
    WidgetsBinding.instance.addObserver(this);
    (widget.child as Router).routeInformationProvider!.addListener(() {
      setState(() {});
    });
    initMatrix();
    initLoadingDialog();
    // InternetPopup().initializeCustomWidget(
    //   context: context,
    //   widget: FutureBuilder(
    //       future: Future.delayed(Duration(milliseconds: 100)),
    //       builder: (context, snapshot) {
    //         print(snapshot.data);
    //          showOverlayInternet(context, 'No Internet Connection',
    //             color: AppTheme.errorColor);
            

    //         return SizedBox();
    //       }),
    // );
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

  void initLoadingDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoadingDialog.defaultTitle = L10n.of(context)!.loadingPleaseWait;
      LoadingDialog.defaultBackLabel = L10n.of(context)!.close;
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
    LoggerService logger = Get.find();
    logger.i('AppLifecycleState = $state');
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
}

class WebBuilder extends StatelessWidget {
  const WebBuilder({
    super.key,
    required this.widget,
  });

  final Matrix widget;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: cloneMediaQueryWithSize(
          MediaQueryData.fromView(View.of(context)), Size(375, 812)),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).brightness == Brightness.light
                    ? lighten(
                        Theme.of(context).colorScheme.primaryContainer, 50)
                    : darken(
                        Theme.of(context).colorScheme.primaryContainer, 80),
                Theme.of(context).brightness == Brightness.light
                    ? lighten(
                        Theme.of(context).colorScheme.tertiaryContainer, 50)
                    : darken(
                        Theme.of(context).colorScheme.tertiaryContainer, 80),
              ],
            ),
          ),
          child: ClipRRect(
              child: Center(child: SizedBox(width: 375, child: widget.child)))),
    );
  }

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
