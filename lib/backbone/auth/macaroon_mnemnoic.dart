import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';

Uint8List deriveMacaroonRootKey(String mnemonic, {String passphrase = ''}) {


  final salt = utf8.encode('mnemonic$passphrase');
  final iterations = 2048;
  final keyLength = 32; // 32 bytes = 256 bits

  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA512Digest(), 128))
    ..init(Pbkdf2Parameters(Uint8List.fromList(salt), iterations, keyLength));

  final mnemonicBytes = utf8.encode(mnemonic);
  return pbkdf2.process(Uint8List.fromList(mnemonicBytes));
}
