// import 'package:bip39_mnemonic/bip39_mnemonic.dart';
// import 'package:bitnet/backbone/auth/macaroon_mnemnoic.dart';
// import 'package:bitnet/backbone/auth/storePrivateData.dart';
// import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
// import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
// import 'package:bitnet/models/keys/privatedata.dart';
// import 'package:get/get.dart';
//
// void generateMnemonic() async {
//   LoggerService logger = Get.find<LoggerService>();
//   logger.i("Generating mnemonic...");
//
//   try {
//     // Generate 256-bit entropy and create a mnemonic
//     final mnemonic = Mnemonic.generate(
//       Language.english,
//       entropyLength: 256, // 24-word mnemonic
//     );
//     final mnemonicString = mnemonic.sentence;
//     logger.i("Generated Mnemonic: $mnemonicString");
//
//     // Derive the seed from the mnemonic
//     final seed = deriveSeedFromMnemonic(mnemonicString);
//     logger.i("Derived Seed: ${bytesToHex(seed)}");
//
//     // Derive private master key and chain code
//     final privateKeyMap = derivePrivateMasterKey(seed);
//     final privateKey = privateKeyMap['privateKey'];
//     final chainCode = privateKeyMap['chainCode'];
//     logger.i("Derived Private Key: ${bytesToHex(privateKey!)}");
//     logger.i("Derived Chain Code: ${bytesToHex(chainCode!)}");
//
//     // Convert private key to WIF (if required)
//     String wifPrivateKey = convertPrivateKeyToWIF(privateKey);
//     logger.i("WIF Private Key: $wifPrivateKey");
//
//     // Derive the public key from the private key
//     final publicKey = deriveMasterPublicKey(privateKey);
//     final publicKeyHex = bytesToHex(publicKey);
//     logger.i("Derived Public Key (Hex): $publicKeyHex");
//
//     // Set the DID (Decentralized Identifier) as the public key hex
//     final did = publicKeyHex;
//
//     // Save the mnemonic and keys securely
//     logger.i("Storing private data securely...");
//     final privateData = PrivateData(did: did, mnemonic: mnemonicString);
//     await storePrivateData(privateData);
//     logger.i("Private data stored successfully.");
//   } catch (e) {
//     logger.e("Error in generateMnemonic: $e");
//     // Handle errors (e.g., show user-friendly error message)
//   }
// }
