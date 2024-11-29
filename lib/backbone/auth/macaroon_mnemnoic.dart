import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/pointycastle.dart';

Uint8List deriveSeedFromMnemonic(String mnemonic, {String passphrase = ''}) {
  final salt = utf8.encode('mnemonic$passphrase');
  final iterations = 2048;
  final keyLength = 64; // 64 bytes = 512 bits for BIP-39 standard seed

  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA512Digest(), 128))
    ..init(Pbkdf2Parameters(Uint8List.fromList(salt), iterations, keyLength));

  final mnemonicBytes = utf8.encode(mnemonic);
  return pbkdf2.process(Uint8List.fromList(mnemonicBytes));
}

Map<String, Uint8List> derivePrivateMasterKey(Uint8List seed) {
  // BIP-32 standard uses the "Bitcoin seed" key for HMAC-SHA512
  final hmac = HMac(SHA512Digest(), 128);
  hmac.init(KeyParameter(utf8.encode("Bitcoin seed")));
  final I = hmac.process(seed);

  // Left half (32 bytes) is the master private key
  final masterPrivateKey = I.sublist(0, 32);
  // Right half (32 bytes) is the master chain code
  final masterChainCode = I.sublist(32);

  // Validate the private key (must be less than curve order)
  final curve = ECCurve_secp256k1();
  final privateKeyNum = BigInt.parse(
    masterPrivateKey.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
    radix: 16,
  );
  if (privateKeyNum >= curve.n) {
    throw Exception('Invalid private key: exceeds curve order.');
  }

  return {
    'privateKey': masterPrivateKey,
    'chainCode': masterChainCode,
  };
}

Uint8List deriveMasterPublicKey(Uint8List masterPrivateKey, {bool compressed = true}) {
  // Use the secp256k1 elliptic curve (same as Bitcoin)
  final curve = ECCurve_secp256k1();
  final G = curve.G;

  // Parse the private key into a BigInt
  final privateKeyNum = BigInt.parse(
    masterPrivateKey.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
    radix: 16,
  );

  // Multiply the generator point G with the private key to get the public key point
  final publicKeyPoint = G * privateKeyNum;

  // Validate that the public key point is not null
  if (publicKeyPoint == null) {
    throw Exception('Failed to derive public key.');
  }

  // Convert the public key point to the desired format
  return publicKeyPoint.getEncoded(compressed);
}
