import 'dart:typed_data';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter_bitcoin/flutter_bitcoin.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bip39/bip39.dart' as bip39;


dynamic hdWalletFromMnemonic(String mnemonicString) {
  LoggerService logger = Get.find<LoggerService>();

  // Validate the mnemonic
  bool isValid = bip39.validateMnemonic(mnemonicString);
  logger.i('Mnemonic is valid: $isValid\n');

  // Convert mnemonic to seed
  String seed = bip39.mnemonicToSeedHex(mnemonicString);
  logger.i('Seed derived from mnemonic:\n$seed\n');
  Uint8List seedUnit = bip39.mnemonicToSeed(mnemonicString);

  // // BIP49 Derivation Path: m/49'/0'/0'/0/0
  // final String bip49Path = "m/49'/0'/0'/0/0";
  // HDWallet hdWallet = HDWallet.fromSeed(seedUnit).derivePath(bip49Path);
  HDWallet hdWallet = HDWallet.fromSeed(seedUnit);

  return hdWallet;
}