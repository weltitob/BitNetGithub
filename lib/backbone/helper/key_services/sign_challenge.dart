import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/random/fortuna_random.dart';

String signChallengeData(String challengeData, ECPrivateKey privateKey) {
  final logger = Get.find<LoggerService>();
  logger.i("Starting to sign challenge data.");

  try {
    logger.d("Challenge data length: ${challengeData.length}");

    // Hash the challenge data using SHA-256
    logger.d("Hashing challenge data with SHA-256.");
    var digest = SHA256Digest();
    Uint8List hash = digest.process(utf8.encode(challengeData) as Uint8List);
    logger.d("SHA-256 hash: ${hash.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}");

    // Create SecureRandom instance
    logger.d("Creating SecureRandom instance.");
    SecureRandom secureRandom = _secureRandom();

    // Sign the hash using ECDSA with the private key
    logger.d("Initializing ECDSA signer with private key and SecureRandom.");
    var signer = Signer('SHA-256/ECDSA');
    var params = ParametersWithRandom(
      PrivateKeyParameter<ECPrivateKey>(privateKey),
      secureRandom,
    );
    signer.init(true, params);
    logger.d("Signing the hash.");
    ECSignature signature = signer.generateSignature(hash) as ECSignature;
    logger.d("Signature generated. r: ${signature.r}, s: ${signature.s}");

    // Encode the signature to DER format
    logger.d("Encoding signature to DER format.");
    ASN1Sequence sequence = ASN1Sequence();
    sequence.add(ASN1Integer(signature.r));
    sequence.add(ASN1Integer(signature.s));

    // Corrected code: Call encode() to get the DER-encoded bytes
    Uint8List derEncodedSignature = sequence.encode();
    logger.d("DER-encoded signature: ${derEncodedSignature.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}");

    // Convert to hex string to send to server
    logger.d("Converting DER-encoded signature to hex string.");
    String signatureHex = derEncodedSignature.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    logger.i("Successfully signed challenge data.");
    return signatureHex;
  } catch (e) {
    logger.e("Error in signChallengeData: $e");
    rethrow; // Re-throw the exception after logging
  }
}

SecureRandom _secureRandom() {
  final secureRandom = FortunaRandom();
  final seed = Uint8List(32);
  final random = Random.secure();
  for (int i = 0; i < seed.length; i++) {
    seed[i] = random.nextInt(256);
  }
  secureRandom.seed(KeyParameter(seed));
  return secureRandom;
}
