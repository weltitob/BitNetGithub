import 'dart:typed_data';
import 'package:blockchain_utils/base58/base58_base.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/pointycastle.dart';


// Function to decode WIF to private key bytes
List<int> decodeWIF(String wifPrivateKey) {
  // Decode Base58
  List<int> decoded = Base58Decoder.decode(wifPrivateKey);

  // Return as a List<int> for further processing
  return decoded;
}

/// Helper: Convert private key to WIF format
String convertPrivateKeyToWIF(List<int> privateKey, {bool compressed = true}) {
  // Add prefix (0x80 for Bitcoin mainnet)
  List<int> prefix = [0x80];
  List<int> payload = prefix + privateKey;

  // Add 0x01 if using compressed public key
  if (compressed) {
    payload.add(0x01);
  }

  // Calculate checksum
  List<int> checksum = sha256Digest(sha256Digest(payload)).sublist(0, 4);

  // Append checksum to payload
  List<int> wif = payload + checksum;

  // Encode in Base58 using blockchain_utils

  return Base58Encoder.encode(Uint8List.fromList(wif));
}

// Helper: Perform a SHA-256 digest
List<int> sha256Digest(List<int> data) {
  return sha256.convert(Uint8List.fromList(data)).bytes;
}

// Helper: Convert byte list to hexadecimal string
String bytesToHex(List<int> bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
}