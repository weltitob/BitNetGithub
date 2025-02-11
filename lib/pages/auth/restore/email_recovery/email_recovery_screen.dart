import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/email_recovery/activate_email_recovery.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
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

class EmailRecoveryScreen extends StatefulWidget {
  const EmailRecoveryScreen();
  @override
  _EmailRecoveryScreenState createState() => _EmailRecoveryScreenState();
}

class _EmailRecoveryScreenState extends State<EmailRecoveryScreen> {
  bool _isLoading = false;
  String? username = '';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  bool obscurePass = true;
  bool loadingLogIn = false;

  @override
  void initState() {
    super.initState();
    // Initialize as needed
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onSignInPressed(String mnemonic) async {
    final overlayController = Get.find<OverlayController>();

    try {
      setState(() {
        _isLoading = true;
      });

      final logger = Get.find<LoggerService>();
      logger.d("User mnemonic: $mnemonic");

      Uint8List seedUnit = wallet.mnemonicToSeed(mnemonic.split(' '));
      HDWallet hdWallet = HDWallet.fromSeed(
        seedUnit,
      );
      // Master public key (compressed)
      String did = hdWallet.pubkey;
      String privateKeyHex = hdWallet.privkey;

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
        "Something bad happened... please try again later.",
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
              text: "Email Recovery",
              context: context,
              onTap: () {
                context.go('/authhome/login');
              },
              actions: [const PopUpLangPickerWidget()],
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppTheme.cardPadding * 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back!",
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Please input your email and password to restore your account.",
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: AppTheme.cardPadding * 2,
                        ),
                        FormTextField(
                          width: AppTheme.cardPadding * 14.ws,
                          hintText: 'email',
                          onChanged: (val) {},
                          controller: _emailController,
                          isObscure: false,
                        ),
                        if (emailError.isNotEmpty)
                          Text(
                            emailError,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppTheme.errorColor),
                          ),
                        SizedBox(
                          height: 32,
                        ),
                        FormTextField(
                          prefixText: "         ",
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscurePass = !obscurePass;
                                setState(() {});
                              },
                              icon: Icon(obscurePass
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          width: AppTheme.cardPadding * 14.ws,
                          hintText: 'password',
                          onChanged: (val) {},
                          controller: _passwordController,
                          isObscure: obscurePass,
                        ),
                        if (passwordError.isNotEmpty)
                          Text(
                            passwordError,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppTheme.errorColor),
                          ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LongButtonWidget(
                      customWidth: MediaQuery.of(context).size.width * 0.9,
                      state:
                          loadingLogIn ? ButtonState.loading : ButtonState.idle,
                      title: "Restore Account",
                      onTap: () async {
                        loadingLogIn = true;
                        setState(() {});
                        validateEmail(_emailController);
                        validatePassword(_passwordController);
                        if (emailError.isEmpty && passwordError.isEmpty) {
                          String? mnemonic = await activateEmailRecovery(
                              _passwordController.text, _emailController.text);

                          if (mnemonic != null) {
                            onSignInPressed(mnemonic);
                          } else {
                            final overlayController =
                                Get.find<OverlayController>();

                            overlayController.showOverlay(
                              "Your email or password was incorrect.",
                              color: AppTheme.errorColor,
                            );
                          }
                          loadingLogIn = false;
                          setState(() {});
                        } else {
                          loadingLogIn = false;
                          setState(() {});
                        }
                      }),
                )
              ],
            ));
      },
    );
  }

  void validateEmail(TextEditingController controller) {
    String email = controller.text.trim();

    if (email.isEmpty) {
      emailError = "Email is required";
      return;
    }

    // Simple regular expression for validating an email address.
    RegExp emailRegex = RegExp(r"^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      emailError = "Invalid email address";
    } else {
      emailError = "";
    }
    setState(() {});
  }

  void validatePassword(TextEditingController controller) {
    String password = controller.text;

    if (password.isEmpty) {
      passwordError = "Password is required";
      return;
    }

    // Check length requirement
    if (password.length < 8 || password.length > 32) {
      passwordError = "Password must be between 8 and 32 characters";
      return;
    }

    // Check that every character is representable in Latin-1.
    // In Dart, Latin-1 (ISO-8859-1) supports code units 0 to 255.
    bool isLatin1 = password.codeUnits.every((unit) => unit <= 255);
    if (!isLatin1) {
      passwordError = "Password contains invalid characters";
    } else {
      passwordError = "";
    }
    setState(() {});
  }
}
