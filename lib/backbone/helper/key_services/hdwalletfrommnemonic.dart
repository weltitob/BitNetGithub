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

  // Create the HDWallet from the seed
  HDWallet hdWallet = HDWallet.fromSeed(seedUnit).derivePath("m/86'/0'/0'/0/");
  return hdWallet;
}

List<String> deriveTaprootAddresses(String mnemonic) {
  LoggerService logger = Get.find<LoggerService>();

  // Create the master HD wallet from the mnemonic
  final hdWallet = hdWalletFromMnemonic(mnemonic) as HDWallet;

  // Taproot derivation path for BIP86:
  // m/86'/0'/0'/0/i for mainnet receiving addresses
  const pathFormat = "m/86'/0'/0'/0/";

  List<String> derivedAddresses = [];
  for (int i = 0; i < 10; i++) {
    final child = hdWallet.derivePath("$pathFormat$i");
    final address = child.address; // Ensure this uses P2TR logic internally
    derivedAddresses.add(address!);
    logger.i("Taproot Address #$i: $address");
  }

  return derivedAddresses;
}
