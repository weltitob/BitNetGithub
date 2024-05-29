import 'dart:io';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';


abstract class PlatformInfos {
  static bool get isWeb => kIsWeb;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isCupertinoStyle => isIOS || isMacOS;

  static bool get isMobile => isAndroid || isIOS;

  /// For desktops which don't support ChachedNetworkImage yet
  static bool get isBetaDesktop => isWindows || isLinux;

  static bool get isDesktop => isLinux || isWindows || isMacOS;

  static bool get usesTouchscreen => !isMobile;

  static bool get platformCanRecord => (isMobile || isMacOS);

  static Future<String> getVersion() async {
    var version = kIsWeb ? 'Web' : 'Unknown';
    try {
      version = (await PackageInfo.fromPlatform()).version;
    } catch (_) {}
    return version;
  }

  static void showDialog(BuildContext context) async {
    final version = await PlatformInfos.getVersion();
    showAboutDialog(
      context: context,
      useRootNavigator: false,
      children: [
        Text('Version: $version'),
        OutlinedButton(
          onPressed: () => launchUrlString(AppTheme.emojiFontUrl),
          child: const Text(AppTheme.emojiFontName),
        ),
        OutlinedButton(
          onPressed: () => context.go('logs'),
          child: const Text('Logs'),
        ),
      ],
      applicationIcon: Image.asset(
        'assets/images/logoclean.png',
        width: AppTheme.cardPadding * 2,
        height: AppTheme.cardPadding * 2,
        filterQuality: FilterQuality.medium,
      ),
      // applicationName: AppTheme.applicationName,
    );
  }
}
