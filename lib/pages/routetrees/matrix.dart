import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/settings/setting_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import 'package:flutter_gen/gen_l10n/l10n.dart';
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


  //
  // final onRoomKeyRequestSub = <String, StreamSubscription>{};
  // final onKeyVerificationRequestSub = <String, StreamSubscription>{};
  // final onNotification = <String, StreamSubscription>{};
  //
  // StreamSubscription<html.Event>? onFocusSub;
  // StreamSubscription<html.Event>? onBlurSub;
  //
  // String? _cachedPassword;
  // Timer? _cachedPasswordClearTimer;
  //
  // String? get cachedPassword => _cachedPassword;
  //
  // set cachedPassword(String? p) {
  //   LoggerService logger = Get.find();
  //   logger.d('Password cached');
  //   _cachedPasswordClearTimer?.cancel();
  //   _cachedPassword = p;
  //   _cachedPasswordClearTimer = Timer(const Duration(minutes: 10), () {
  //     _cachedPassword = null;
  //     logger.d('Cached Password cleared');
  //   });
  // }
  //
  // bool webHasFocus = true;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initMatrix();
    initLoadingDialog();
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


    // if (kIsWeb) {
    //   onFocusSub = html.window.onFocus.listen((_) => webHasFocus = true);
    //   onBlurSub = html.window.onBlur.listen((_) => webHasFocus = false);
    // }


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

    // onRoomKeyRequestSub.values.map((s) => s.cancel());
    // onKeyVerificationRequestSub.values.map((s) => s.cancel());
    // onNotification.values.map((s) => s.cancel());
    // onFocusSub?.cancel();
    // onBlurSub?.cancel();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => this,
      child: widget.child,
    );
  }
}