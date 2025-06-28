import 'dart:convert';
import 'dart:math';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:get/get.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:uuid/uuid.dart';

String URL = " https://verify-email-http-rxdgrcyx2q-uc.a.run.app";
Future<String> encryptMnemonic(String mnemonic) async {
  // final publicKey =
  //     await parseKeyFromFile<RSAPublicKey>('/assets/keys/public_key_mnemonic.pem');
  final publicKey = encrypt.RSAKeyParser().parse(
          await rootBundle.loadString('assets/keys/public_key_mnemonic.pem'))
      as RSAPublicKey;
  final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));

  final encryptedMnemonic = encrypter.encrypt(mnemonic);
  return encryptedMnemonic.base64;
}

Future<String> decryptMnemonic(String encryptedMnemonic) async {
  final privateKey = encrypt.RSAKeyParser().parse(await rootBundle.loadString(
      'assets/keys/private_key_mnemonic_incoming.pem')) as RSAPrivateKey;
  final encrypter = encrypt.Encrypter(encrypt.RSA(privateKey: privateKey));

  final encrypted = encrypt.Encrypted(base64Decode(encryptedMnemonic));
  final decrypted = encrypter.decrypt(encrypted);

  return decrypted;
}

String generateSecureToken({int length = 32}) {
  final uuid = Uuid();
  final randomBytes =
      List<int>.generate(length, (i) => Random.secure().nextInt(256));
  final hash =
      sha256.convert(utf8.encode(uuid.v4() + base64UrlEncode(randomBytes)));
  return base64UrlEncode(hash.bytes).substring(0, length);
}

String generateCode() {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return List.generate(5, (index) => chars[random.nextInt(chars.length)])
      .join();
}

Future<bool> sendEmail(String email, String arg, int template) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'send_email_http',
  );
  String finalArg = arg;
  if (template == 0) {
    finalArg = "$URL?token=${arg}";
  }
  final logger = Get.find<LoggerService>();

  try {
    late final HttpsCallableResult<dynamic> response;
    if (template == 0) {
      response = await callable.call(<String, dynamic>{
        'email': email,
        'template': template,
        'url': finalArg
      });
    } else {
      response = await callable.call(<String, dynamic>{
        'email': email,
        'template': template,
        'code': finalArg
      });
    }

    logger.i("Response: ${response.data}");

    // Ensure response.data is not null and is a Map
    if (response.data != null && response.data is Map) {
      final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data as Map);
      if (responseData.containsKey('error')) {
        throw Exception("Send email failed");
      }
      return true;
    } else {
      logger.i("Response data is null or not a Map.");
    }
  } catch (e) {
    logger.e(
      "Error during email send: $e",
    );
    return false;
  }
  return false;
}
