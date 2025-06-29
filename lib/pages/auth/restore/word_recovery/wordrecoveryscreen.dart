import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
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
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

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

      // Generate DID from mnemonic using RecoveryIdentity
      String did = RecoveryIdentity.generateRecoveryDid(mnemonic);

      print('Master Public Key and did: $did\n');

      String challengeData = "Mnemonic Login Challenge";

      // Lightning approach - Signing functionality needs reimplementation for Lightning
      // TODO: Implement Lightning-based challenge signing when needed
      String signatureHex = "placeholder_signature"; // Temporary placeholder

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
