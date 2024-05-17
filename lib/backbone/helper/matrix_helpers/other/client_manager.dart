import 'dart:convert';

import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/flutter_hive_collections_database.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_http_client.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_image_resizer.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:flutter/foundation.dart';
import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';

import 'famedlysdk_store.dart';

abstract class ClientManager {
  static const String clientNamespace = 'im.fluffychat.store.clients';

  static Future<List<Client>> getClients({bool initialize = true}) async {
    final clientNames = <String>{};

    try {
      print('insiide get clients started //////////////');
      final rawClientNames = await Store().getItem(clientNamespace);
      print('got raw client names  //////////////');

      if (rawClientNames != null) {
        clientNames.addAll((jsonDecode(rawClientNames) as List).cast<String>());
      }
      print('list populated ///////${clientNames.length}///////');
    } catch (e) {
      print('Error reading client names: $e');
      await Store().deleteItem(clientNamespace);
    }

    if (clientNames.isEmpty) {
      print('client names empty');
      clientNames.add(PlatformInfos.clientName);
      await Store().setItem(
        clientNamespace,
        jsonEncode(
          clientNames.toList(),
        ),
      );
    }
    Stopwatch stopwatch = Stopwatch()..start();

    final clients = clientNames.map(createClient).toList();
    stopwatch.stop();
    print(
        "Execution Time: create client  ${stopwatch.elapsedMilliseconds} milliseconds");

    print('clients are asigned ${clients.length}');
    if (initialize) {
      List<Future<void>> futures = [];

      for (Client client in clients) {
        futures.add(
          client
              .init(
            waitForFirstSync: false,
            waitUntilLoadCompletedLoaded: false,
          )
              .catchError((e, s) {
            print('Failed to initialize client $client: $e');
          }),
        );
      }
      print('loop finished');

      await Future.wait(futures);
      print('finished the future');
    }

    // Clean up any clients that are not logged in, if necessary
    clients.removeWhere(
      (client) => !client.isLogged(),
    );
    print('removed the clients that are loggedout');
    return clients;
  }

  static Future<void> addClientNameToStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    clientNamesList.add(clientName);
    await Store().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  static Future<void> removeClientNameFromStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await Store().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    clientNamesList.remove(clientName);
    await Store().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  static NativeImplementations get nativeImplementations => kIsWeb
      ? const NativeImplementationsDummy()
      : NativeImplementationsIsolate(compute);

  static Client createClient(String clientName) {
    return Client(
      clientName,
      httpClient:
          PlatformInfos.isAndroid ? CustomHttpClient.createHTTPClient() : null,
      verificationMethods: {
        KeyVerificationMethod.numbers,
        if (kIsWeb || PlatformInfos.isMobile || PlatformInfos.isLinux)
          KeyVerificationMethod.emoji,
      },
      importantStateEvents: <String>{
        // To make room emotes work
        'im.ponies.room_emotes',
        // To check which story room we can post in
        EventTypes.RoomPowerLevels,
      },
      logLevel: kReleaseMode ? Level.warning : Level.verbose,
      databaseBuilder: FlutterHiveCollectionsDatabase.databaseBuilder,
      supportedLoginTypes: {
        //
        AuthenticationTypes.password,
        AuthenticationTypes.sso,
      },
      nativeImplementations: nativeImplementations,
      customImageResizer: PlatformInfos.isMobile ? customImageResizer : null,
    );
  }
}
