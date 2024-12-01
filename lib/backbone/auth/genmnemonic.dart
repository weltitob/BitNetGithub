// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:bip39_mnemonic/bip39_mnemonic.dart';
// import 'package:bitnet/backbone/auth/auth.dart';
// import 'package:bitnet/backbone/auth/macaroon_mnemnoic.dart';
// import 'package:bitnet/backbone/auth/storePrivateData.dart';
// import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
// import 'package:bitnet/backbone/helper/helpers.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
// import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
// import 'package:bitnet/backbone/services/local_storage.dart';
// import 'package:bitnet/backbone/streams/country_provider.dart';
// import 'package:bitnet/backbone/streams/locale_provider.dart';
// import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
// import 'package:bitnet/models/firebase/verificationcode.dart';
// import 'package:bitnet/models/keys/privatedata.dart';
// import 'package:bitnet/models/user/userdata.dart';
// import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
// import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
// import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/l10n.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pointycastle/pointycastle.dart';
// import 'package:provider/provider.dart';
//
//
// void generateMnemonic() async {
//   LoggerService logger = Get.find<LoggerService>();
//   logger.i("Generating mnemonic...");
//
//   try {
//     // Use the fixed mnemonic to mirror the Python code
//     String mnemonicString =
//         "cook evil track rather vast search hub coconut usual dilemma conduct demise explain motor cream push apart security exit squirrel seven false sustain sword";
//
//
//     logger.i("Using Mnemonic: $mnemonicString");
//
//     // Derive the seed from the mnemonic
//     final seed = deriveSeedFromMnemonic(mnemonicString);
//     logger.i("Derived Seed: ${bytesToHex(seed)}");
//
//     //--------------CHECKPOINT----------------
//
//     // Derive private master key and chain code
//     final privateKeyMap = derivePrivateMasterKey(seed);
//     final dynamic privateKey = privateKeyMap['privateKey'];
//     final dynamic chainCode = privateKeyMap['chainCode'];
//     logger.i("Derived Private Key: ${privateKey}");
//
//     // Convert private key to WIF (if required)
//     // String wifPrivateKey = convertPrivateKeyToWIF(privateKey!);
//     // logger.i("WIF Private Key: $wifPrivateKey");
//
//     // Derive the public key from the private key
//     Uint8List publicKey = deriveMasterPublicKey(privateKey as ECPrivateKey, compressed: true);
//
//     final publicKeyHex = bytesToHex(publicKey);
//     logger.i("Derived Public Key (Hex): $publicKeyHex");
//
//
//     // Save the mnemonic and keys securely
//     logger.i("Storing private data securely...");
//     final privateData = PrivateData(
//       did: publicKeyHex,
//       privateKey: privateKey.toString(),
//       mnemonic: mnemonicString,
//     );
//     await storePrivateData(privateData);
//     logger.i("Private data stored successfully.");
//
//     // Proceed with user registration or other operations
//     // ...
//
//   } catch (e) {
//     logger.e("Error in generateMnemonic: $e");
//     // Handle errors (e.g., show user-friendly error message)
//   }
// }