import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/import_account.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:get/get.dart';
import 'package:wallet/wallet.dart' as wallet;

Future<HDWallet> createUserWallet(String mnemonic) async {
  LoggerService logger = Get.find<LoggerService>();

  final seed = wallet.mnemonicToSeed(mnemonic.split(' '));

  const taprootPath = "m/86'/0'/0'";
  wallet.ExtendedPrivateKey master =
      wallet.ExtendedPrivateKey.master(seed, wallet.zprv);
  // Step 2: Generate master key (BIP-32 Slip10 for secp256k1)
  wallet.ExtendedKey root = master.forPath(taprootPath);
  var privKey = wallet.PrivateKey(master.key);

  String publicKey =
      hex.encode(wallet.bitcoinbech32.createPublicKey(privKey).value);
  String privKeyString = privKey.value.toRadixString(16);
  String xpubkey = root.publicKey.toString();
  // Step 3: Get the master fingerprint
  final masterFingerprint = base64.encode(root.fingerprint);

  // Step 4: Derive the xpub for Taproot path "m/86'/0'/0'/0"
  await importAccount(publicKey, xpubkey, masterFingerprint);

  List<String> derivedAddresses = [];

  for (int i = 0; i < 5; i++) {
    RestResponse addr = await nextAddr(publicKey);
    print("Response" + addr.toString());
    BitcoinAddress address = BitcoinAddress.fromJson(addr.data);
    derivedAddresses.add(address.addr);
  }

  btcAddressesRef
      .doc(publicKey)
      .set({"addresses": derivedAddresses, "count": 5});
  return HDWallet(
      pubkey: publicKey,
      xpubkey: xpubkey,
      privkey: privKeyString,
      fingerprint: masterFingerprint);
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
    const taprootPath = "m/86'/0'/0'";
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

  factory HDWallet.fromMnemonic(String mnemonic) {
    final seed = wallet.mnemonicToSeed(mnemonic.split(' '));
    return HDWallet.fromSeed(seed);
  }
}
