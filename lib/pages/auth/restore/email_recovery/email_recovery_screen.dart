import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/email_recovery/activate_email_recovery.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/email_recovery_helper.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/fields/verification/verificationspace.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'dart:typed_data';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:pin_code_fields/pin_code_fields.dart';
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
  String? mnemonic;
  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool _loading = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String _error = "";
  String? _textValueClipboard = '';
  bool wanttocopy = true;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();

    // Initialize as needed
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    errorController.close();
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

      // OLD: Multiple users one node approach - HDWallet-based key derivation
      // Uint8List seedUnit = wallet.mnemonicToSeed(mnemonic.split(' '));
      // HDWallet hdWallet = HDWallet.fromSeed(seedUnit);
      // String did = hdWallet.pubkey;
      // String privateKeyHex = hdWallet.privkey;
      
      // NEW: One user one node approach - Lightning aezeed format
      // Generate DID from Lightning mnemonic (no BIP39 validation needed for aezeed)
      String did = Bip39DidGenerator.generateDidFromLightningMnemonic(mnemonic);

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
            body: mnemonic != null
                ? VerifyEmailCodeScreen(
                    textEditingController: textEditingController,
                    errorController: errorController,
                    formKey: formKey,
                    onSignInPressed: () {
                      onSignInPressed(mnemonic!);
                    },
                    email: _emailController.text,
                  )
                : Stack(
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Please input your email and password to restore your account.",
                                    maxLines: 2,
                                    softWrap: true,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                            customWidth:
                                MediaQuery.of(context).size.width * 0.9,
                            state: loadingLogIn
                                ? ButtonState.loading
                                : ButtonState.idle,
                            title: "Restore Account",
                            onTap: () async {
                              loadingLogIn = true;
                              setState(() {});
                              validateEmail(_emailController);
                              validatePassword(_passwordController);
                              if (emailError.isEmpty && passwordError.isEmpty) {
                                QuerySnapshot<Map<String, dynamic>> doc =
                                    await emailRecoveryCollection
                                        .where("email",
                                            isEqualTo: _emailController.text)
                                        .get();
                                QueryDocumentSnapshot<Map<String, dynamic>>?
                                    firstDoc = doc.docs.firstOrNull;
                                if (firstDoc == null) {
                                  final overlayController =
                                      Get.find<OverlayController>();

                                  overlayController.showOverlay(
                                    "There is no account linked to this email.",
                                    color: AppTheme.errorColor,
                                  );
                                  return;
                                }
                                Map<String, dynamic> data = firstDoc.data();
                                if (!data['verified']) {
                                  final overlayController =
                                      Get.find<OverlayController>();

                                  overlayController.showOverlay(
                                    "The recovery setup was never completed for this email.",
                                    color: AppTheme.errorColor,
                                  );
                                  return;
                                }

                                String? mnemonicVar =
                                    await activateEmailRecovery(
                                        _passwordController.text,
                                        _emailController.text);

                                if (mnemonicVar != null) {
                                  String code = generateCode();
                                  firstDoc.reference.update({
                                    'code': code,
                                    'code_valid_until': Timestamp.fromDate(
                                        DateTime.now().add(Duration(hours: 1)))
                                  });
                                  await sendEmail(
                                      _emailController.text, code, 1);
                                  mnemonic = mnemonicVar;
                                  setState(() {});

                                  // onSignInPressed(mnemonic);
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

class VerifyEmailCodeScreen extends StatefulWidget {
  final TextEditingController textEditingController;
  final StreamController<ErrorAnimationType> errorController;
  final GlobalKey<FormState> formKey;
  final Function() onSignInPressed;
  final String email;

  const VerifyEmailCodeScreen({
    super.key,
    required this.textEditingController,
    required this.errorController,
    required this.formKey,
    required this.onSignInPressed,
    required this.email,
  });

  @override
  State<VerifyEmailCodeScreen> createState() => _VerifyEmailCodeScreenState();
}

class _VerifyEmailCodeScreenState extends State<VerifyEmailCodeScreen> {
  bool loading = false;
  bool hasError = false;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 5.5.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logoclean.png',
                  width: AppTheme.cardPadding.h,
                  height: AppTheme.cardPadding.h,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing.w / 2,
                ),
                Text(
                  "BitNet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(
              height: AppTheme.cardPadding.h,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2.w),
              child: Text(
                "We've sent a 5 letter code to your email, please type it in below.",
                style: Theme.of(context).textTheme.titleMedium!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: VerificationSpace(
                  textEditingController: widget.textEditingController,
                  errorController: widget.errorController,
                  formKey: widget.formKey,
                  onCompleted: (v) {
                    checkIfCodeIsValid(
                      v,
                      widget.email,
                    );
                  },
                  loading: loading,
                  hasError: hasError,
                  errorText: errorText,
                ),
              ),
              TextButton(
                onPressed: () async {
                  int codeAttempts = LocalStorage.instance
                          .getInt("email_send_code_attempts") ??
                      0;
                  if (codeAttempts > 0) {
                    LocalStorage.instance.setInt(
                        DateTime.now()
                            .add(Duration(minutes: 5))
                            .millisecondsSinceEpoch,
                        "email_send_code_cooldown");
                    final overlayController = Get.find<OverlayController>();

                    overlayController.showOverlay(
                      "Please wait before attempting to resend the code again.",
                      color: AppTheme.errorColor,
                    );
                    return;
                  }
                  int cooldown = LocalStorage.instance
                          .getInt("email_send_code_cooldown") ??
                      0;
                  if (cooldown != 0) {
                    if (DateTime.now().millisecondsSinceEpoch > cooldown) {
                      LocalStorage.instance.remove("email_send_code_cooldown");
                    } else {
                      final overlayController = Get.find<OverlayController>();

                      overlayController.showOverlay(
                        "Please wait before attempting to resend the code again.",
                        color: AppTheme.errorColor,
                      );
                      return;
                    }
                  }
                  LocalStorage.instance.remove("email_recovery_attempts");
                  LocalStorage.instance.remove("email_recovery_cooldown");

                  QuerySnapshot<Map<String, dynamic>> doc =
                      await emailRecoveryCollection
                          .where("email", isEqualTo: widget.email)
                          .get();
                  QueryDocumentSnapshot<Map<String, dynamic>>? firstDoc =
                      doc.docs.firstOrNull;
                  if (firstDoc == null) {
                    final overlayController = Get.find<OverlayController>();

                    overlayController.showOverlay(
                      "We failed to send the email.",
                      color: AppTheme.errorColor,
                    );
                    return;
                  }

                  String code = generateCode();
                  firstDoc.reference.update({
                    'code': code,
                    'code_valid_until': Timestamp.fromDate(
                        DateTime.now().add(Duration(hours: 1)))
                  });
                  await sendEmail(widget.email, code, 1);
                  final overlayController = Get.find<OverlayController>();

                  overlayController.showOverlay(
                    "Email sent.",
                    color: AppTheme.successColor,
                  );
                  LocalStorage.instance.setInt(
                      (LocalStorage.instance
                                  .getInt("email_send_code_attempts") ??
                              0) +
                          1,
                      "email_send_code_attempts");
                },
                child: Text(
                  'Resend Code',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              )
            ],
          ),
        ),
      ],
    );
  }

  void checkIfCodeIsValid(String currentCode, String email) async {
    setState(() {
      loading = true;
    });
    bool success = false;
    int attempts = LocalStorage.instance.getInt("email_recovery_attempts") ?? 0;
    if (attempts >= 3) {
      LocalStorage.instance.setInt(
          DateTime.now().add(Duration(minutes: 5)).millisecondsSinceEpoch,
          "email_recovery_cooldown");
      LocalStorage.instance.setInt(0, "email_recovery_attempts");
      OverlayController overlayController = Get.find<OverlayController>();
      overlayController.showOverlay(
        "You've made too many attempts. Please try again in 5 minutes.",
        color: AppTheme.errorColor,
      );
      loading = false;
      hasError = false;
      setState(() {});
      return;
    }
    int cooldown = LocalStorage.instance.getInt("email_recovery_cooldown") ?? 0;
    if (cooldown != 0) {
      if (DateTime.now().millisecondsSinceEpoch > cooldown) {
        LocalStorage.instance.setInt(0, "email_recovery_cooldown");
      } else {
        OverlayController overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          "Please wait before making any further attempts.",
          color: AppTheme.errorColor,
        );
        loading = false;
        hasError = false;
        setState(() {});

        return;
      }
    }
    try {
      widget.formKey.currentState?.validate();
      QuerySnapshot<Map<String, dynamic>> doc =
          await emailRecoveryCollection.where("email", isEqualTo: email).get();
      QueryDocumentSnapshot<Map<String, dynamic>>? firstDoc =
          doc.docs.firstOrNull;
      if (firstDoc != null &&
          firstDoc.data()['code'] == currentCode &&
          (firstDoc.data()['code_valid_until'] as Timestamp)
                  .millisecondsSinceEpoch >
              Timestamp.now().millisecondsSinceEpoch) {
        success = true;
        // loading = false;
        widget.onSignInPressed();
        firstDoc.reference.update({"code": ""});
      } else if (firstDoc != null &&
          firstDoc.data()['code'] == currentCode &&
          (firstDoc.data()['code_valid_until'] as Timestamp)
                  .millisecondsSinceEpoch <
              Timestamp.now().millisecondsSinceEpoch) {
        widget.errorController.add(ErrorAnimationType.shake);
        errorText = "This code is expired";
        loading = false;
        hasError = true;
        setState(() {});
      } else {
        widget.errorController.add(ErrorAnimationType.shake);
        errorText = "This code was incorrect";
        loading = false;
        hasError = true;
        setState(() {});
      }
    } catch (error) {
      errorText = L10n.of(context)!.codeNotValid;
      widget.errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        loading = false;
        hasError = true;
      });
    }
    if (!success) {
      LocalStorage.instance.setInt(
          (LocalStorage.instance.getInt("email_recovery_attempts") ?? 0) + 1,
          "email_recovery_attempts");
    } else {
      LocalStorage.instance.remove("email_recovery_attempts");
      LocalStorage.instance.remove("email_recovery_cooldown");
    }
  }
}
