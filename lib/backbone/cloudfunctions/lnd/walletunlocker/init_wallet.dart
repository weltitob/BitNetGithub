import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';


Uint8List deriveSeedFromMnemonic(String mnemonic, {String passphrase = ''}) {
  final salt = utf8.encode('mnemonic$passphrase');
  final iterations = 2048;
  final keyLength = 64; // 64 bytes = 512 bits for BIP-39 standard seed

  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA512Digest(), 128))
    ..init(Pbkdf2Parameters(Uint8List.fromList(salt), iterations, keyLength));

  final mnemonicBytes = utf8.encode(mnemonic);
  return pbkdf2.process(Uint8List.fromList(mnemonicBytes));
}




Future<RestResponse> initWallet(List<String> mnemonicSeed, String macaroonRootKeyHex) async {
  LoggerService logger = Get.find();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  String url = 'https://$restHost/v1/initwallet';

  logger.i("Init wallet is called: $url");

  logger.i("Original Macaroon Root Key Hex: $macaroonRootKeyHex");

  // Decode the hex string into bytes (64 bytes)
  List<int> macaroonRootKeyBytes = hex.decode(macaroonRootKeyHex);

  //Truncate to 32 bytes
  if (macaroonRootKeyBytes.length > 32) {
    macaroonRootKeyBytes = macaroonRootKeyBytes.sublist(0, 32);
    logger.i("Truncated Macaroon Root Key Bytes to 32 bytes.");
  }

  // Encode the 32-byte array to base64
  String macaroonRootKeyBase64 = base64Encode(macaroonRootKeyBytes);
  logger.i("Truncated Macaroon Root Key Base64: $macaroonRootKeyBase64");

  //31353): │ ⛔ Failed to initialize wallet: 500, {"code":2,"message":"wrong seed version","details":[]} import 'dart:io';

  //this is a allowed mnmenoic seed
  List<String> mnemonicSeedNew = [
    'about', 'double', 'estate', 'saddle', 'floor', 'where', 'nut', 'soon',
    'beach', 'address', 'describe', 'maple', 'child', 'razor', 'claim', 'mountain',
    'kitten', 'struggle', 'boost', 'useful', 'prevent', 'baby', 'more', 'rescue'
  ];

  //combine all strings in mnemonicSeedNew
  // String mnemonic = mnemonicSeedNew.join(' ');
  // dynamic macaroon_root_key =  deriveSeedFromMnemonic(mnemonic);
  //
  // logger.i("Mnemonic Seed in init_wallet: $mnemonicSeedNew");

  Map<String, dynamic> data = {
    'wallet_password': base64Encode(utf8.encode('development_password_dj83zb')),
    //based on this the wallet will be recovered
    'cipher_seed_mnemonic': mnemonicSeedNew, //this needs to be in azeed format
    'recovery_window': 0,
    'channel_backups': null,
    'stateless_init': false,
    'macaroon_root_key': macaroonRootKeyBase64,
  };

  // Load and convert the macaroon asset
  dynamic byteData = await loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );



    logger.i('Raw Response Init Wallet: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String adminMacaroon = responseData['admin_macaroon'] ?? 'Admin macaroon not found';
      logger.i("Admin Macaroon: $adminMacaroon");

      return RestResponse(
        statusCode: "${response.statusCode}",
        message: "Wallet initialized successfully",
        data: responseData,
      );
    } else {
      logger.e('Failed to initialize wallet: ${response.statusCode}, ${response.body}');
      return RestResponse(
        statusCode: "error",
        message: "Failed to initialize wallet: ${response.statusCode}, ${response.body}",
        data: {},
      );
    }
  } catch (e) {
    logger.e('Error in initializing wallet: $e');
    return RestResponse(
      statusCode: "error",
      message: "Failed to initialize wallet: Could not get response from server!",
      data: {},
    );
  }
}
