import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:path_provider/path_provider.dart';

import '../../platform_infos.dart';

/// helper class checking for updates on platforms without store release
///
/// Currently, this is only Windows
class UpdateCheckerNoStore {
  static const gitLabProjectId = '16112282';
  static const gitLabHost = 'gitlab.com';

  static Uri get tagsUri => Uri.parse(
        'https://$gitLabHost/projects/$gitLabProjectId/repository/tags',
      );

  final BuildContext context;

  const UpdateCheckerNoStore(this.context);

  Future<void> checkUpdate() async {
    LoggerService logger = Get.find();
    // platform-specific implementations
    try {
      if (PlatformInfos.isWindows) {
        final response = await get(tagsUri);
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          var latestTag = json[0]['name'] as String;
          var currentVersion = await PlatformInfos.getVersion();

          if (latestTag.startsWith('v')) {
            latestTag = latestTag.substring(1);
          }
          if (currentVersion.startsWith('v')) {
            currentVersion = currentVersion.substring(1);
          }
          if (latestTag != currentVersion) {
            final metadata = UpdateMetadata(latestTag);
            await showUpdateDialog(metadata);
          }
          return;
        } else {
          throw response;
        }
      } else {
        return;
      }
    } catch (e) {
      logger.e('Could not look for updates: $e');
      return;
    }
  }

  Uri downloadUri(UpdateMetadata metadata) {
    // platform specific
    if (PlatformInfos.isWindows) {
      return Uri.parse('https://$gitLabHost/famedly/fluffychat/-'
          '/jobs/artifacts/$metadata/raw/'
          'build/windows/runner/Release/fluffychat.msix?job=build_windows');
    } else {
      throw UnimplementedError('No download URI available for this platform.');
    }
  }

  /// launches an app update
  ///
  /// Either uses the operating systems package or app management to perform
  /// an update or launches a custom installer
  Future<void> launchUpdater(UpdateMetadata metadata) async {
    LoggerService logger = Get.find();
    // platform specific
    try {
      if (kIsWeb) return;
      if (PlatformInfos.isWindows) {
        final dir = await getTemporaryDirectory();
        final response = await get(downloadUri(metadata));
        if (response.statusCode == 200) {
          final file = File('${dir.path}/fluffychat.msix');
          await file.writeAsBytes(response.bodyBytes);
          Process.start(file.path, [], runInShell: true);
        } else {
          throw response;
        }
      }
    } catch (e) {
      logger.e('Error launching th update: $e');
    }
  }

  Future<void> showUpdateDialog(UpdateMetadata metadata) async {
    final result = await showOkCancelAlertDialog(
      title: L10n.of(context)!.updateAvailable,
      message: L10n.of(context)!.updateNow,
      context: context,
    );
    if (result == OkCancelResult.ok) {
      await launchUpdater(metadata);
    }
  }
}

class UpdateMetadata {
  final String version;

  const UpdateMetadata(this.version);

  @override
  String toString() => 'v$version';
}
