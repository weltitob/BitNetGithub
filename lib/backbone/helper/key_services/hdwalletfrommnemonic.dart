import 'dart:typed_data';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter_bitcoin/flutter_bitcoin.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bip32/bip32.dart' as bip32;
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

  HDWallet hdWallet = HDWallet.fromSeed(seedUnit);
  return [hdWallet, seedUnit];

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

HDWallet createUserWallet(String mnemonic) {
  LoggerService logger = Get.find<LoggerService>();

  // Create the master HD wallet from the mnemonic
  final data = hdWalletFromMnemonic(mnemonic);
  HDWallet wallet = data[0] as HDWallet;
  Uint8List seed = data[1];
  final bip32Var = bip32.BIP32.fromSeed(
      seed,
      bip32.NetworkType(
          bip32: bip32.Bip32Type(
              public: bitcoin.bip32.public, private: bitcoin.bip32.private),
          wif: bitcoin.wif));

  // Taproot derivation path for BIP86:
  // m/86'/0'/0'/0/i for mainnet receiving addresses
  const pathFormat = "m/86'/0'/0'/0/";

  List<String> derivedAddresses = [];
  for (int i = 0; i < 5; i++) {
    final child = derivePath(bip32Var, "$pathFormat$i");
    final address = child; // Ensure this uses P2TR logic internally
    derivedAddresses.add(address);
    logger.i("Taproot Address #$i: $address");
  }
  btcAddressesRef.doc(wallet.pubKey).set({"addresses": derivedAddresses});
  return wallet;
}

String derivePath(bip32.BIP32 bip, String path) {
  final bip32 = bip.derivePath(path);

  // Generate P2WPKH address (Native SegWit)
  final p2wpkh = P2WPKH(
    data: PaymentData(pubkey: bip32.publicKey),
    network: bitcoin, // Ensure this is set to bitcoin's mainnet or testnet
  );

  return p2wpkh.data.address!;
}
