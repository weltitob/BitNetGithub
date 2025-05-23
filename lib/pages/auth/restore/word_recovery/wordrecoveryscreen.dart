import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'dart:typed_data';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:wallet/wallet.dart' as wallet;

class WordRecoveryScreen extends StatefulWidget {
  @override
  _RestoreWalletScreenState createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<WordRecoveryScreen> {
  bool _isLoading = false;
  String? username = '';

  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize as needed
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void onSignInPressed(mCtrl, tCtrls) async {

    final overlayController = Get.find<OverlayController>();

    try {
      setState(() {
        _isLoading = true;
      });

      final logger = Get.find<LoggerService>();
      final String mnemonic =
          tCtrls.map((controller) => controller.text).join(' ');
      logger.d("User mnemonic: $mnemonic");

      // OLD: Multiple users one node approach - HDWallet-based key derivation
      // Uint8List seedUnit = wallet.mnemonicToSeed(mnemonic.split(' '));
      // HDWallet hdWallet = HDWallet.fromSeed(seedUnit);
      // String did = hdWallet.pubkey;
      // String privateKeyHex = hdWallet.privkey;
      
      // NEW: One user one node approach - BIP39-based validation and key derivation
      // Validate BIP39 mnemonic
      if (!bip39.validateMnemonic(mnemonic)) {
        throw Exception("Invalid BIP39 mnemonic provided");
      }
      
      // Generate DID and keys from BIP39 mnemonic
      String did = Bip39DidGenerator.generateDidFromMnemonic(mnemonic);
      Map<String, String> keys = Bip39DidGenerator.generateKeysFromMnemonic(mnemonic);
      String privateKeyHex = keys['privateKey']!;
      String publicKeyHex = keys['publicKey']!;

      print('Master Public Key and did: $did\n');

      String challengeData = "Mnemonic Login Challenge";

      // Sign the challenge data
      String signatureHex =
          await signChallengeData(privateKeyHex, did, challengeData);

      logger.d('Generated signature hex: $signatureHex');

      PrivateData privateData = PrivateData(did: did, mnemonic: mnemonic);

      // Perform sign-in
      await Auth().signIn(
        ChallengeType.mnemonic_login,
        privateData,
        signatureHex,
        context,
      );

      // Show success overlay
      overlayController.showOverlay(
        "Successfully Signed In.",
        color: AppTheme.successColor,
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      overlayController.showOverlay(
        "No User was found with the provided Mnemonic",
        color: AppTheme.errorColor,
      );

      // Log the exception
      final logger = Get.find<LoggerService>();
      logger.e("Sign-in Error: $e");

      // Optionally, you can handle specific exceptions here
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        bool isSuperSmallScreen =
            constraints.maxWidth < AppTheme.isSuperSmallScreen;

        return bitnetScaffold(
          context: context,
          margin: isSuperSmallScreen
              ? const EdgeInsets.symmetric(horizontal: 0)
              : EdgeInsets.symmetric(
                  horizontal: (screenWidth / 2 - 250.w) < 0
                      ? 0
                      : screenWidth / 2 - 250.w,
                ),
          extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: bitnetAppBar(
            text: L10n.of(context)!.confirmMnemonic,
            context: context,
            onTap: () {
              context.go('/authhome/login');
            },
            actions: [const PopUpLangPickerWidget()],
          ),
          body: SingleChildScrollView(
            // Make the body scrollable to prevent overflow
            child: Column(
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 4,
                ),
                MnemonicFieldWidget(
                  mnemonicController:
                      null, // Ensure this is handled correctly inside MnemonicFieldWidget
                  triggerMnemonicCheck: onSignInPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
