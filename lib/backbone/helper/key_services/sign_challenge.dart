import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:convert/convert.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';

//need to change this into DER format in order to be able to sign utxos with it before broadcasting
Future<String> signChallengeData(String masterPrivateKeyHex,
    String masterPublicKeyHex, String challengeData) async {
  try {
    // Step 1: Use a fixed mnemonic for consistency

    print('Master Private Key (Hex): $masterPrivateKeyHex\n');
    print('Master Public Key (Hex): $masterPublicKeyHex\n');
    print("Challenge Data: $challengeData\n");

    // Step 5: Define challenge data and hash it
    final SHA256Digest sha256 = SHA256Digest();
    final Uint8List messageHash =
        sha256.process(Uint8List.fromList(utf8.encode(challengeData)));
    print('Message Hash (Hex): ${hex.encode(messageHash)}');

    // Step 6: Prepare private key for signing
    final BigInt privateKeyBigInt =
        BigInt.parse(masterPrivateKeyHex, radix: 16);
    final domainParams = ECCurve_secp256k1();
    final n = domainParams.n;

    // Step 7: Generate deterministic k using RFC 6979
    Uint8List kBytes = generateDeterministicK(privateKeyBigInt, messageHash);
    BigInt k = bytesToBigInt(kBytes);
    print('Deterministic k (Hex): ${hex.encode(kBytes)}');

    // Step 8: Calculate r and s
    final G = domainParams.G;
    final point = G * k;
    final r = point!.x!.toBigInteger()! % n;
    print('r (Hex): ${r.toRadixString(16).padLeft(64, '0')}');
    if (r == BigInt.zero) {
      throw Exception("r is zero");
    }

    final e = bytesToBigInt(messageHash);
    BigInt s = ((k.modInverse(n)) * (e + (privateKeyBigInt * r))) % n;
    print(
        's before normalization (Hex): ${s.toRadixString(16).padLeft(64, '0')}');
    if (s == BigInt.zero) {
      throw Exception("s is zero");
    }

    // Normalize s to lower half order
    final halfN = n >> 1;
    if (s > halfN) {
      s = n - s;
      print('s normalized (Hex): ${s.toRadixString(16).padLeft(64, '0')}');
    } else {
      print('s remains (Hex): ${s.toRadixString(16).padLeft(64, '0')}');
    }

    // Serialize r and s to fixed-length bytes and concatenate
    final Uint8List signatureRaw = _serializeSignature(r, s);
    print('Signature (Raw R || S, Hex): ${hex.encode(signatureRaw)}');
    print('Generated Signature (Hex): ${hex.encode(signatureRaw)}');
    return (hex.encode(signatureRaw)).toString();
  } catch (e) {
    print("Error in entireWorkflow: $e");
    return "Error in entireWorkflow: $e";
  }
}

Uint8List _serializeSignature(BigInt r, BigInt s) {
  Uint8List rBytes = _toFixedLengthBytes(r, 32);
  Uint8List sBytes = _toFixedLengthBytes(s, 32);
  return Uint8List.fromList(rBytes + sBytes);
}

Uint8List _toFixedLengthBytes(BigInt value, int length) {
  String hexValue = value.toRadixString(16).padLeft(length * 2, '0');
  return Uint8List.fromList(hex.decode(hexValue));
}

Uint8List generateDeterministicK(BigInt privateKey, Uint8List hash) {
  final curve = ECCurve_secp256k1();
  final n = curve.n;
  final q = n.bitLength;
  final h1 = hash;

  // Step a: Initialize
  Uint8List V = Uint8List(32);
  for (int i = 0; i < V.length; i++) V[i] = 0x01;

  Uint8List K = Uint8List(32);
  for (int i = 0; i < K.length; i++) K[i] = 0x00;

  // Step b
  final privKeyBytes = bigIntToBytes(privateKey, 32);
  K = _hmacSha256(K, Uint8List.fromList([...V, 0x00] + privKeyBytes + h1));

  // Step c
  V = _hmacSha256(K, V);

  // Step d
  K = _hmacSha256(K, Uint8List.fromList([...V, 0x01] + privKeyBytes + h1));

  // Step e
  V = _hmacSha256(K, V);

  // Step f
  Uint8List T = Uint8List(0);
  while (T.length < 32) {
    V = _hmacSha256(K, V);
    T = Uint8List.fromList([...T, ...V]);
  }

  BigInt k = bytesToBigInt(T.sublist(0, 32));

  // Step g
  if (k < BigInt.one || k >= n) {
    throw Exception("Generated k is out of bounds");
  }

  return bigIntToBytes(k, 32);
}

Uint8List _hmacSha256(Uint8List key, Uint8List data) {
  final hmac = HMac(SHA256Digest(), 64)..init(KeyParameter(key));
  hmac.update(data, 0, data.length);
  final out = Uint8List(hmac.macSize);
  hmac.doFinal(out, 0);
  return out;
}

Uint8List bigIntToBytes(BigInt number, int length) {
  var bytes = encodeBigInt(number);
  if (bytes.length > length) {
    throw Exception("Number too large");
  }
  if (bytes.length == length) return bytes;
  // Prepend with zeros if necessary
  return Uint8List.fromList(List.filled(length - bytes.length, 0) + bytes);
}

BigInt bytesToBigInt(Uint8List bytes) {
  BigInt result = BigInt.zero;
  for (var byte in bytes) {
    result = (result << 8) | BigInt.from(byte);
  }
  return result;
}

Uint8List encodeBigInt(BigInt number) {
  // Remove sign
  String hexString = number.toRadixString(16);
  if (hexString.length.isOdd) hexString = '0$hexString';
  return Uint8List.fromList(hex.decode(hexString));
}
