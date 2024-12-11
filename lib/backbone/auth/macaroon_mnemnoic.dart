import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:convert/convert.dart'; // For hex encoding/decoding

Uint8List deriveSeedFromMnemonic(String mnemonic) {
  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
  final params = Pbkdf2Parameters(
    Uint8List.fromList(utf8.encode('salt')),
    100000,
    64, // Desired key length in bytes
  );
  pbkdf2.init(params);
  Uint8List mnemonicBytes = Uint8List.fromList(utf8.encode(mnemonic));
  Uint8List seed = pbkdf2.process(mnemonicBytes);
  return seed;
}

Map<String, dynamic> derivePrivateMasterKey(Uint8List seed) {
  // Take the first 32 bytes of the seed for the private key
  Uint8List privateKeyBytes = seed.sublist(0, 32);
  BigInt privateKeyInt = BigInt.parse(hex.encode(privateKeyBytes), radix: 16);
  var domain = ECDomainParameters('secp256k1');
  ECPrivateKey privateKey = ECPrivateKey(privateKeyInt, domain);

  // Optionally, use the remaining bytes as the chain code
  Uint8List chainCode = seed.sublist(32);

  return {
    'privateKey': privateKey,
    'chainCode': chainCode,
  };
}


Uint8List deriveMasterPublicKey(ECPrivateKey privateKey,
    {bool compressed = true}) {
  var domain = privateKey.parameters;
  ECPoint? Q = domain!.G * privateKey.d;

  return Q!.getEncoded(compressed);
}
