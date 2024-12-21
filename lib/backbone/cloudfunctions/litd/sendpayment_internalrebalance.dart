import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/models/litd/accounts.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'dart:convert';

dynamic callInternalRebalance(
    String lightningAddress,
    String fallbackAddress,
    String amountSatoshi,
    String senderUserId,
    String restHost,
    ) async {
  final logger = Get.put(LoggerService());
  try {
    // Attempt to retrieve App Check tokens for additional security.
    try {
      final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      logger.i("App Check Token: $appCheckToken");
      logger.i("New App Check Token: $newAppCheckToken");
    } catch (e) {
      logger.e("Fehler beim Abrufen des App Check Tokens: $e");
    }

    logger.i("Generating challenge...");
    UserChallengeResponse? userChallengeResponse =
    await create_challenge(senderUserId, ChallengeType.internal_account_rebalance);

    if (userChallengeResponse == null) {
      logger.e("Challenge konnte nicht erstellt werden.");
      return null;
    }

    logger.d('Created challenge for user ${senderUserId}: $userChallengeResponse');

    String challengeId = userChallengeResponse.challenge.challengeId;
    logger.d('Challenge ID: $challengeId');

    String challengeData = userChallengeResponse.challenge.title;
    logger.d('Challenge Data: $challengeData');

    // Retrieve private data (DID, private key)
    PrivateData privateData = await getPrivateData(senderUserId);
    logger.d('Retrieved private data for user ${senderUserId}');
    HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
    final String publicKeyHex = hdWallet.pubkey;
    logger.d('Public Key Hex: $publicKeyHex');

    final String privateKeyHex = hdWallet.privkey;
    logger.d('Private Key Hex: $privateKeyHex');

    // Sign the challenge data
    String signatureHex =
    await signChallengeData(privateKeyHex, publicKeyHex, challengeData);
    logger.d('Generated signature hex: $signatureHex');

    // Initialize FirebaseFunctions and call the Cloud Function
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'internal_rebalance',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Prepare data for internal_rebalance

    logger.i("Calling internal_rebalance Cloud Function with data: "
        "lightningAddress: $lightningAddress, "
        "fallbackAddress: $fallbackAddress, "
        "amountSatoshi: $amountSatoshi, "
        "senderUserId: $senderUserId, "
        "restHost: $restHost");

    // Send request
    final dynamic response = await callable.call(<String, dynamic>{
      'lightningAddress': lightningAddress,
      'fallbackAddress': fallbackAddress,
      'amountSatoshi': amountSatoshi,
      'senderUserId': senderUserId,
      'signedMessage': signatureHex,
      'challenge_data': challengeData,
      'restHost': restHost,
    });

    logger.i("Response from server: ${response.data}");
    Map<String, dynamic> responseData;

    if (response.data is Map) {
      responseData = Map<String, dynamic>.from(response.data as Map);
    } else {
      // If data is not a Map, wrap it in a map
      responseData = {'message': response.data};
    }

    try {
      final message = responseData['message'] ?? {};
      final data = message['data'] ?? {};

      // Extract fields
      final success = data['success'];
      final serverMessage = data['message'];

      if (success == true) {
        logger.i("Rebalance erfolgreich abgeschlossen: $serverMessage");
      } else {
        logger.e("Rebalance fehlgeschlagen: $serverMessage");
        return null;
      }

      return data;
    } catch (e) {
      logger.e("Fehler beim Parsen der Antwortdaten: $e");
      return null;
    }
  } catch (e) {
    final logger = Get.find<LoggerService>();
    logger.e("Fehler beim Aufruf der Cloud Function: $e");
    return null;
  }
}
