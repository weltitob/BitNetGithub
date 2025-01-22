import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';


// Future<ByteData> loadAdminMacaroonAsset() async {
//   return await rootBundle.load('assets/keys/lnd_admin.macaroon');
// }

// Diese Funktion ersetzt den bisherigen loadMacaroonAsset-Aufruf
// Sie liest den Macaroon aus dem Secure Storage für den aktuell eingelogten User aus.
Future<ByteData> loadMacaroonAsset() async {

  final userId = Auth().currentUser?.uid;
  if (userId == null) {
    throw Exception('No user logged in.');
  }

  // Retrieve accounts from secure storage
  final accounts = await getLitdAccountsData();

  // Find the account for the current user
  final Map<String, dynamic> account = accounts.firstWhere(
        (acc) => acc['userId'] == userId,
    orElse: () => <String, dynamic>{},
  );

  if (account.isEmpty) {
    throw Exception('No account data found for user $userId');
  }

  final macaroon = account['macaroon'];
  if (macaroon == null || macaroon.isEmpty) {
    throw Exception('No macaroon found for user $userId');
  }

  // Macaroon ist Base64 codiert, wir decodieren es in Bytes
  final macaroonBytes = base64.decode(macaroon);

  // Convert to ByteData
  final byteData = ByteData.view(Uint8List.fromList(macaroonBytes).buffer);
  return byteData;
}

Future<ByteData> loadLoopMacaroonAsset() async {
  return await rootBundle.load('assets/keys/loop.macaroon');
}

Future<ByteData> loadTapdMacaroonAsset() async {
  final LoggerService logger = Get.find();
  logger.i('Loading tapd macaroon');
  return rootBundle.load("assets/keys/tapd_admin.macaroon");
  // return await rootBundle.load('assets/keys/tapd_admin.macaroon');
}
