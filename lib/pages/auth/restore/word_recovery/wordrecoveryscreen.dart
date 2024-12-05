import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/recoverKeyWithMnemonic.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/flutter_bitcoin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/macaroon_mnemnoic.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitcoin/flutter_bitcoin.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:provider/provider.dart';
import 'package:bip39/bip39.dart' as bip39;


class WordRecoveryScreen extends StatefulWidget {
  @override
  _RestoreWalletScreenState createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<WordRecoveryScreen> {
  // PageController _pageController = PageController();

  // bool onLastPage = false;
  bool _isLoading = false;
  String? username = '';

  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getBIPWords();
  }

  @override
  void dispose() {
    // textControllers.forEach((controller) => controller.dispose());
    // focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  // getBIPWords() async {
  //   bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
  //   splittedbipwords = bipwords.split(" ");
  // }

  void onSignInPressesd(mCtrl, tCtrls) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final logger = Get.find<LoggerService>();
      final String mnemonic =
          tCtrls.map((controller) => controller.text).join(' ');
      logger.d("User mnemonic: $mnemonic");

      String seed = bip39.mnemonicToSeedHex(mnemonic);
      print('Seed derived from mnemonic:\n$seed\n');
      Uint8List seedUnit = bip39.mnemonicToSeed(mnemonic);
      HDWallet hdWallet = HDWallet.fromSeed(seedUnit,);
      // Master public key (compressed)
      String did = hdWallet.pubKey!;
      String privateKeyHex = hdWallet.privKey!;

      print('Master Public Key and did: $did\n');

      String challengeData = "Mnemonic Login Challenge";

      String signatureHex = await signChallengeData(privateKeyHex, did, challengeData);

      logger.d('Generated signature hex: $signatureHex');

      PrivateData privateData = PrivateData(did: did, privateKey: privateKeyHex,);

      await Auth().signIn(ChallengeType.mnemonic_login, privateData, signatureHex, context);

      showOverlay(context, "Successfully Signed In.",
          color: AppTheme.successColor);

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showOverlay(context, "No User was found with the provided Mnemonic",
          color: AppTheme.errorColor);

      throw Exception("Irgendeine error message lel: $e");
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
            : EdgeInsets.symmetric(horizontal: (screenWidth / 2 - 250.w) < 0 ? 0 :screenWidth / 2 - 250.w),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: bitnetAppBar(
            text: L10n.of(context)!.confirmMnemonic,
            context: context,
            onTap: () {
              context.go('/authhome/login');
            },
            actions: [const PopUpLangPickerWidget()]),
        body: MnemonicFieldWidget(
          mnemonicController: null,
          triggerMnemonicCheck: onSignInPressesd,
        ),
      );
    });
  }
}
