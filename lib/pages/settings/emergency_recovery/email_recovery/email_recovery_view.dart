import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/email_recovery/setup_email_recovery.dart';
import 'package:bitnet/backbone/cloudfunctions/generate_custom_token.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/email_recovery_helper.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../../bottomsheet/settings_controller.dart';

class EmailRecoveryView extends GetWidget<SettingsController> {
  EmailRecoveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: false,
      context: context,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageControllerEmailRecovery,
        children: [
          MaxWidthBody(
            withScrolling: false,
            child: EmailRecoveryPageOne(),
          ),
          MaxWidthBody(
            withScrolling: false,
            child: EmailRecoveryPageTwo(),
          ),
          MaxWidthBody(
            withScrolling: false,
            child: EmailRecoveryPageThree(),
          )
        ],
      ),
    );
  }
}

class EmailRecoveryPageThree extends StatelessWidget {
  const EmailRecoveryPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find<SettingsController>();
    return Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            child: Icon(Icons.check, size: 128),
          ),
          SizedBox(height: 16),
          Text(
            'Success! Your email is now verified.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Click on Settings -> Recover Account -> Email Recovery when you need to.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Divider(indent: 32, endIndent: 32),
          TextButton(
            onPressed: () {
              settingsController.pageControllerEmailRecovery.jumpToPage(0);
            },
            child: Text(
              'Change Email',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(height: 25),
        ]));
  }
}

class EmailRecoveryPageTwo extends StatefulWidget {
  const EmailRecoveryPageTwo({super.key});

  @override
  State<EmailRecoveryPageTwo> createState() => _EmailRecoveryPageTwoState();
}

class _EmailRecoveryPageTwoState extends State<EmailRecoveryPageTwo> {
  bool verified = false;
  bool reloading = false;
  @override
  void initState() {
    super.initState();
    emailRecoveryCollection.doc(Auth().currentUser!.uid).get().then((val) {
      verified = val.data()?['verified'] ?? false;
      if (verified) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<SettingsController>().pageControllerEmailRecovery.nextPage(
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        });
      } else {
        String? email = val.data()?['email'];
        listenForEmailVerification(email);
      }
    });
  }

  void listenForEmailVerification(String? email) {
    emailRecoveryCollection
        .doc(Auth().currentUser!.uid)
        .snapshots()
        .listen((data) {
      if (data.exists && data.data() != null && data.data()!['verified']) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<SettingsController>().pageControllerEmailRecovery.nextPage(
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find<SettingsController>();
    return Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            ),
            child: Icon(Icons.info, size: 128),
          ),
          SizedBox(height: 16),
          Text(
            'We have sent you a verification email. Please verify your email to continue.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Divider(indent: 32, endIndent: 32),
          TextButton(
            onPressed: () {
              settingsController.pageControllerEmailRecovery.jumpToPage(0);
            },
            child: Text(
              'Change Email',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 8),
          reloading
              ? dotProgress(context)
              : TextButton(
                  onPressed: () async {
                    reloading = true;
                    setState(() {});
                    await Auth().currentUser!.reload();

                    if (Auth().currentUser!.emailVerified) {
                      emailRecoveryCollection
                          .doc(Auth().currentUser!.uid)
                          .update({'verified': true});
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Get.find<SettingsController>()
                            .pageControllerEmailRecovery
                            .nextPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                      });
                    }
                    reloading = false;
                    setState(() {});
                  },
                  child: Text(
                    'Reload',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
          SizedBox(height: 25),
        ]));
  }
}

class EmailRecoveryPageOne extends StatefulWidget {
  @override
  State<EmailRecoveryPageOne> createState() => _EmailRecoveryPageOneState();
}

class _EmailRecoveryPageOneState extends State<EmailRecoveryPageOne> {
  bool obscurePass = true;
  String emailError = "";
  String passwordError = "";
  bool loadingSetupRecovery = false;
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find<SettingsController>();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Use your email and password to encrypt your data...",
                          maxLines: 2,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 2,
                ),
                FormTextField(
                  width: AppTheme.cardPadding * 14.ws,
                  hintText: 'email',
                  onChanged: (val) {},
                  controller: settingsController.emailFieldController,
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
                  controller: settingsController.passwordFieldController,
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
                  loadingSetupRecovery ? ButtonState.loading : ButtonState.idle,
              title: "Setup Recovery",
              onTap: () async {
                loadingSetupRecovery = true;
                setState(() {});
                validateEmail(settingsController.emailFieldController);
                validatePassword(settingsController.passwordFieldController);
                if (emailError.isEmpty && passwordError.isEmpty) {
                  PrivateData privData =
                      await getPrivateData(Auth().currentUser!.uid);
                  await setupEmailRecovery(
                      settingsController.passwordFieldController.text,
                      privData.mnemonic,
                      Auth().currentUser!.uid,
                      settingsController.emailFieldController.text);

                  String token = generateSecureToken();
                  emailRecoveryCollection.doc(Auth().currentUser!.uid).update({
                    'token': token,
                    'valid_until': Timestamp.fromDate(
                        DateTime.now().add(Duration(hours: 1))),
                    'verified': false
                  });
                  sendEmail(
                      settingsController.emailFieldController.text, token, 0);
                  loadingSetupRecovery = false;
                  setState(() {});
                  Get.find<SettingsController>()
                      .pageControllerEmailRecovery
                      .nextPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.easeIn);
                } else {
                  loadingSetupRecovery = false;
                  setState(() {});
                }
              }),
        )
      ],
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
