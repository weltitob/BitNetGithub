import 'dart:convert';
import 'dart:typed_data';

import 'package:bitcoin_base/bitcoin_base.dart' as btc;
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/import_account.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:bs58/bs58.dart';
import 'package:cryptography/cryptography.dart';
import 'package:get/get.dart';
import 'package:pointycastle/export.dart';
import 'package:wallet/wallet.dart' as wallet;

Future<HDWallet> createUserWallet(String mnemonic) async {
  LoggerService logger = Get.find<LoggerService>();

  try {
    logger.i("Starting wallet creation process...");

    // Step 1: Convert mnemonic to seed
    final seed = wallet.mnemonicToSeed(mnemonic.split(' '));
    logger.i("Seed generated successfully.");

    // Step 2: Generate master key
    const taprootPath = "m/84'/0'/0'";
    wallet.ExtendedPrivateKey master =
    wallet.ExtendedPrivateKey.master(seed, wallet.zprv);
    logger.i("Master key generated successfully.");


    // Step 3: Generate extended key for path
    wallet.ExtendedKey root = master.forPath(taprootPath);
    logger.i("Extended key generated for path: $taprootPath");

    // Step 4: Derive private and public keys
    var privKey = wallet.PrivateKey(master.key);
    String publicKey = hex.encode(wallet.bitcoinbech32.createPublicKey(privKey).value);
    String privKeyString = privKey.value.toRadixString(16);
    String xpubkey = root.publicKey.toString();
    logger.i("Public and private keys derived successfully.");
    logger.i("Public Key: $publicKey");
    logger.i("XPub Key: $xpubkey");

    // Step 5: Get the master fingerprint
    final masterFingerprint = base64.encode(root.fingerprint);
    logger.i("Master fingerprint derived successfully: $masterFingerprint");

    // Step 6: Import account details
    await importAccount(publicKey, xpubkey, masterFingerprint);
    logger.i("Account imported successfully.");

    // Step 7: Generate derived addresses
    //THIS NEEDS TO GO INTO A FIREBASE FUNCTION 100%
    List<String> derivedAddresses = [];
    for (int i = 0; i < 5; i++) {
      String addr = await nextAddr(publicKey);
      logger.i("Derived address [$i]: $addr");
      BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
      derivedAddresses.add(address.addr);
    }
    logger.i("Derived addresses: $derivedAddresses");

    // Return the HDWallet instance
    logger.i("Wallet creation process completed successfully.");
    return HDWallet(
        pubkey: publicKey,
        xpubkey: xpubkey,
        privkey: privKeyString,
        fingerprint: masterFingerprint);
  } catch (e, stacktrace) {
    logger.e("Error in createUserWallet: $e");
    logger.e("Stacktrace: $stacktrace");
    throw Exception("Failed to create wallet: $e");
  }
}

class HDWallet {
  final String pubkey;
  final String xpubkey;
  final String privkey;
  final String fingerprint;
  HDWallet(
      {required this.fingerprint,
      required this.privkey,
      required this.pubkey,
      required this.xpubkey});

  factory HDWallet.fromSeed(Uint8List seed) {
    const taprootPath = "m/84'/0'/0'";
    wallet.ExtendedPrivateKey master =
        wallet.ExtendedPrivateKey.master(seed, wallet.zprv);
    // Step 2: Generate master key (BIP-32 Slip10 for secp256k1)
    wallet.ExtendedKey root = master.forPath(taprootPath);
    var privKey = wallet.PrivateKey(master.key);

    String publicKey =
        hex.encode(wallet.bitcoinbech32.createPublicKey(privKey).value);
    String privKeyString = privKey.value.toRadixString(16);
    String xpubkey = root.publicKey.toString();
    final masterFingerprint = base64.encode(root.fingerprint);

    return HDWallet(
        privkey: privKeyString,
        pubkey: publicKey,
        xpubkey: xpubkey,
        fingerprint: masterFingerprint);
  }

  btc.ECPrivate deriveKeyPair(
      String address, String mnemonic, int change, int index) {
    final seed = wallet.mnemonicToSeed(mnemonic.split(' '));
    const taprootPath = "m/84'/0'/0'";
    wallet.ExtendedPrivateKey master =
        wallet.ExtendedPrivateKey.master(seed, wallet.zprv);
    // Step 2: Generate master key (BIP-32 Slip10 for secp256k1)
    wallet.ExtendedPrivateKey root = master.derive(change).derive(index);
    wallet.PrivateKey privKey = wallet.PrivateKey(root.key);
    // Convert to Hexadecimal
    btc.ECPrivate keyPair = btc.ECPrivate.fromHex(root.key.toRadixString(16));
    String genAddress = keyPair
        .getPublic()
        .toSegwitAddress()
        .toAddress(btc.BitcoinNetwork.mainnet);
    // if (genAddress != address) {
    //   throw Exception('THE ADDRESSES ARE NOT THE SAME');
    // }
    return keyPair;
  }

  btc.ECPrivate findKeyPair(String address, String mnemonic, int change) {
    final seed = wallet.mnemonicToSeed(mnemonic.split(' '));
    const taprootPath = "m/84'/0'/0'";
    wallet.ExtendedPrivateKey master =
        wallet.ExtendedPrivateKey.master(seed, wallet.zprv);
    int index = 0;
    String genAddress = '';
    btc.ECPrivate? keyPair;
    var privKey = wallet.PrivateKey(master.key);

    // Step 2: Generate master key (BIP-32 Slip10 for secp256k1)
    while (genAddress != address) {
      wallet.ExtendedPrivateKey root =
          master.derive(84).derive(0).derive(0).derive(change).derive(index);
      wallet.PrivateKey privKey = wallet.PrivateKey(root.key);
      // Convert to Hexadecimal
      try {
        keyPair = btc.ECPrivate.fromHex(root.key.toRadixString(16));
      } catch (e) {
        index++;

        continue;
      }
      genAddress = keyPair
          .getPublic()
          .toSegwitAddress()
          .toAddress(btc.BitcoinNetwork.mainnet);

      if (genAddress == address) {
        break;
      }
      index++;
    }
    // if (genAddress != address) {
    //   throw Exception('THE ADDRESSES ARE NOT THE SAME');
    // }
    return keyPair!;
  }

  factory HDWallet.fromMnemonic(String mnemonic) {
    final seed = wallet.mnemonicToSeed(mnemonic.split(' '));
    return HDWallet.fromSeed(seed);
  }
}

Uint8List extractMasterPrivateKeyFromZprv(String zprv) {
  // Step 1: Decode the zprv string using Base58Check
  List<int> decoded = base58.decode(zprv);

  // Step 2: The first byte is the version byte (usually 0x80 for mainnet zprv)
  // The next 32 bytes are the master private key
  Uint8List masterPrivateKey = Uint8List.fromList(decoded.sublist(1, 33));

  return masterPrivateKey;
}
