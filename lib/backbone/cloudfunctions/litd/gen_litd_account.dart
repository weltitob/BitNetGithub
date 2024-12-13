import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/models/litd/accounts.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'dart:convert';

dynamic callGenLitdAccount(String userId) async {
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
    await create_challenge(userId, ChallengeType.litd_account_creation);

    if (userChallengeResponse == null) {
      logger.e("Challenge konnte nicht erstellt werden.");
      return null;
    }

    logger.d('Created challenge for user ${userId}: $userChallengeResponse');

    String challengeId = userChallengeResponse.challenge.challengeId;
    logger.d('Challenge ID: $challengeId');

    String challengeData = userChallengeResponse.challenge.title;
    logger.d('Challenge Data: $challengeData');

    // Retrieve private data (DID, private key)
    PrivateData privateData = await getPrivateData(userId);
    logger.d('Retrieved private data for user ${userId}');

    final String publicKeyHex = privateData.did;
    logger.d('Public Key Hex: $publicKeyHex');

    final String privateKeyHex = privateData.privateKey;
    logger.d('Private Key Hex: $privateKeyHex');

    // Sign the challenge data
    String signatureHex =
    await signChallengeData(privateKeyHex, publicKeyHex, challengeData);
    logger.d('Generated signature hex: $signatureHex');

    // Initialize FirebaseFunctions and call the Cloud Function
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'gen_litd_account_http',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Send request
    final dynamic response = await callable.call(<String, dynamic>{
      'user_id': userId.toString(),
      'challenge_data': challengeData.toString(),
      'signature': signatureHex.toString(),
    });

    logger.i("Antwort vom Server: ${response.data}");
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
      final accountId = data['accountid'];
      final macaroon = data['macaroon'];

      if (accountId == null || macaroon == null) {
        logger.e("Fehler beim Aufruf der Cloud Function: Account-Informationen fehlen.");
        return null;
      }

      // The server only returns accountid and macaroon.
      // We'll create a minimal account response.
      final reshapedJson = {
        "account": {
          "id": accountId,
          "initial_balance": null,
          "current_balance": null,
          "last_update": null,
          "expiration_date": null,
          "invoices": [],
          "payments": [],
          "label": null
        },
        "macaroon": macaroon
      };

      final LitdAccountResponse accountResponse =
      LitdAccountResponse.fromJson(reshapedJson);

      logger.i("LITD Account ID: ${accountResponse.account?.id}");
      logger.i("LITD Initial Balance: ${accountResponse.account?.initialBalance}");
      logger.i("LITD Current Balance: ${accountResponse.account?.currentBalance}");
      logger.i("LITD Macaroon: ${accountResponse.macaroon}");

      return accountResponse;

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
