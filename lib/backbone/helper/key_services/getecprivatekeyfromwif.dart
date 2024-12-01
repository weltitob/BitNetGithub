import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';
import 'package:convert/convert.dart';


ECPrivateKey getUserPrivateKeyFromWIF(String wifPrivateKey) {
  List<int> privateKeyBytes = decodeWIF(wifPrivateKey);
  BigInt privateKeyInt = BigInt.parse(bytesToHex(privateKeyBytes), radix: 16);
  final ECDomainParameters domainParams = ECDomainParameters('secp256k1');
  return ECPrivateKey(privateKeyInt, domainParams);
}
//
// void main() {
//   // Replace these values with your actual private and public keys
//   final privateKeyHex = 'e68b357276044cebb7aabbdb01e59b5520dfcd482fbbf9806a314a5b1205acbb';
//   final publicKeyHex = '02ef2a1349b62c7036b7a0d36a5e4914bae6835f0cf15ea826cb09573534c7e406';
//
//   // Challenge data
//   final challengeData = 'Default Auth Challenge';
//
//   // Step 1: Hash the message
//   final sha256 = SHA256Digest();
//   final messageBytes = utf8.encode(challengeData);
//   final messageHash = sha256.process(Uint8List.fromList(messageBytes));
//
//   // Step 2: Convert the private key to a BigInt
//   final privateKeyBigInt = BigInt.parse(privateKeyHex, radix: 16);
//
//   // Step 3: Set up the EC domain and private key parameters
//   final domainParams = ECCurve_secp256k1();
//   final privateKeyParams = PrivateKeyParameter(ECPrivateKey(privateKeyBigInt, domainParams));
//
//   // Step 4: Initialize the ECDSA signer
//   final signer = ECDSASigner(SHA256Digest(), HMac(SHA256Digest(), 64));
//   signer.init(true, privateKeyParams);
//
//   // Step 5: Sign the message hash
//   final ECSignature originalSignature = signer.generateSignature(messageHash) as ECSignature;
//
//   // Normalize the signature (to match the Python library's output)
//   final curveOrder = domainParams.n;
//   final halfCurveOrder = curveOrder >> 1;
//   final BigInt normalizedS = originalSignature.s.compareTo(halfCurveOrder) > 0
//       ? curveOrder - originalSignature.s
//       : originalSignature.s;
//
//   final ECSignature normalizedSignature = ECSignature(originalSignature.r, normalizedS);
//
//   // Combine r and s to create the signature
//   final signatureBytes = Uint8List.fromList(
//     _bigIntToBytes(normalizedSignature.r, 32) + _bigIntToBytes(normalizedSignature.s, 32),
//   );
//
//   print('Signature (hex): ${hex.encode(signatureBytes)}');
//
//   // Step 6: Verify the signature (optional)
//   final publicKey = domainParams.curve.decodePoint(hex.decode(publicKeyHex));
//   final publicKeyParams = PublicKeyParameter(ECPublicKey(publicKey, domainParams));
//   signer.init(false, publicKeyParams);
//
//   final isValid = signer.verifySignature(messageHash, normalizedSignature);
//   print('Is signature valid? $isValid');
// }
//
// Uint8List _bigIntToBytes(BigInt number, int length) {
//   final byteArray = number.toRadixString(16).padLeft(length * 2, '0');
//   return Uint8List.fromList(hex.decode(byteArray));
// }
