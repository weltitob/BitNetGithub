import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/ecc/api.dart';

String signChallengeData(String challengeData, ECPrivateKey privateKey) {
  // Hash the challenge data using SHA-256
  var digest = Digest('SHA-256');
  Uint8List hash = digest.process(utf8.encode(challengeData));

  // Sign the hash using ECDSA with the private key
  var signer = Signer('SHA-256/ECDSA');
  signer.init(true, PrivateKeyParameter<ECPrivateKey>(privateKey));

  ECSignature signature = signer.generateSignature(hash) as ECSignature;

  // Encode the signature to DER format
  ASN1Sequence sequence = ASN1Sequence();
  sequence.add(ASN1Integer(signature.r));
  sequence.add(ASN1Integer(signature.s));
  Uint8List? derEncodedSignature = sequence.encodedBytes;

  // Convert to hex string to send to server
  String signatureHex = derEncodedSignature!.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  return signatureHex;
}
