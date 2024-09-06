import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_helper.dart';
import 'package:bitnet/backbone/security/security.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WidgetTreeController extends BaseController {
  RxBool hasBiometrics = true.obs;
  RxBool isSecurityChecked = false.obs;
  RxBool isBioAuthenticated = false.obs;
  RxString? initialUrl = ''.obs;
  late final StreamSubscription<Uri> appLinks;
  bool openedWithDeepLink = false;
  RxBool? columnMode = false.obs;
  RxBool isLoadingClients = true.obs;

  @override
  void onInit() {
    super.onInit();
    isBiometricsAvailable();
    appLinks = AppLinks().uriLinkStream.listen(onListenStream);
  }

  void onListenStream(Uri? uri) {
    if (uri == null) {
      return;
    }
    openedWithDeepLink = true;
    String uriString = uri.toString();
    if (uriString.startsWith('https://${AppTheme.currentWebDomain}/#/showprofile') && !kIsWeb) {
      String profileId = uriString.split('showprofile/')[1];
      if (AppRouter.navigatorKey.currentContext != null) {
        try {
          GoRouter.of(AppRouter.navigatorKey.currentContext!).push('/showprofile/$profileId');
        } catch (e) {
          logger.i('failed to push showprofile: $e');
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(AppRouter.navigatorKey.currentContext!).push('/showprofile/$profileId');
        });
      }
    } else if (uriString.startsWith('https://${AppTheme.currentWebDomain}/#/wallet/send') && !kIsWeb) {
      String parameter = uriString.split('send/')[1];

      if (AppRouter.navigatorKey.currentContext != null) {
        String path = GoRouter.of(AppRouter.navigatorKey.currentContext!).routerDelegate.currentConfiguration.uri.path;
        if (GoRouter.of(AppRouter.navigatorKey.currentContext!).routerDelegate.currentConfiguration.uri.path.contains('send')) {
          GoRouter.of(AppRouter.navigatorKey.currentContext!).pushReplacement('/wallet/send/$parameter');
        } else {
          GoRouter.of(AppRouter.navigatorKey.currentContext!).go('/wallet/send/$parameter');
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(AppRouter.navigatorKey.currentContext!).go('/wallet/send/$parameter');
        });
      }
    }
    // else if (!kIsWeb && AppRouter.navigatorKey.currentContext != null) {
    //   GoRouter.of(AppRouter.navigatorKey.currentContext!).go(routes[1]);
    // }
  }

  @override
  void onClose() {
    super.onClose();
    appLinks.cancel();
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked.value = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if (isSecurityChecked.value == true) {
      hasBiometrics.value = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        isBioAuthenticated.value = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated.value == false;
      }
    } else {
      hasBiometrics.value = false;
    }
  }
}
