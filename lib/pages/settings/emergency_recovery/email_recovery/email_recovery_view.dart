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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            SizedBox(height: AppTheme.cardPadding * 2),
            
            // Success icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.successColor.withOpacity(0.1),
                border: Border.all(
                  color: AppTheme.successColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.check_circle_outline,
                size: 60,
                color: AppTheme.successColor,
              ),
            ),
            
            SizedBox(height: AppTheme.cardPadding),
            
            // Success message
            Text(
              'Success!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.successColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.elementSpacing),
            
            Text(
              'Your email is now verified.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.cardPadding),
            
            Container(
              padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  SizedBox(height: AppTheme.elementSpacing / 2),
                  Text(
                    'You can now use email recovery to restore your account if needed.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppTheme.elementSpacing / 2),
                  Text(
                    'Access: Settings → Recover Account → Email Recovery',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Spacer(),
            
            // Change email button
            TextButton(
              onPressed: () {
                settingsController.pageControllerEmailRecovery.jumpToPage(0);
              },
              child: Text(
                'Change Email',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            
            SizedBox(height: AppTheme.cardPadding),
          ],
        ),
      ),
    );
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            SizedBox(height: AppTheme.cardPadding * 2),
            
            // Icon section
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.email_outlined,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            SizedBox(height: AppTheme.cardPadding),
            
            // Title and description
            Text(
              'Check Your Email',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.elementSpacing),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                'We have sent you a verification email. Please verify your email to continue.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            Spacer(),
            
            // Action buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: reloading
                      ? Container(
                          height: 50,
                          child: Center(child: dotProgress(context)),
                        )
                      : LongButtonWidget(
                          title: 'I\'ve Verified My Email',
                          onTap: () async {
                            setState(() {
                              reloading = true;
                            });
                            
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
                            
                            setState(() {
                              reloading = false;
                            });
                          },
                        ),
                ),
                
                SizedBox(height: AppTheme.elementSpacing),
                
                TextButton(
                  onPressed: () {
                    settingsController.pageControllerEmailRecovery.jumpToPage(0);
                  },
                  child: Text(
                    'Change Email',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                
                SizedBox(height: AppTheme.cardPadding),
              ],
            ),
          ],
        ),
      ),
    );
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            SizedBox(height: AppTheme.cardPadding),
            
            // Header section
            Column(
              children: [
                Text(
                  "Setup Email Recovery",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppTheme.elementSpacing),
                Container(
                  padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: AppTheme.elementSpacing / 2),
                      Expanded(
                        child: Text(
                          "Use your email and password to encrypt your recovery data securely.",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppTheme.cardPadding * 2),
            
            // Form fields
            Column(
              children: [
                FormTextField(
                  width: double.infinity,
                  hintText: 'Email address',
                  onChanged: (val) {
                    if (emailError.isNotEmpty) {
                      setState(() {
                        emailError = "";
                      });
                    }
                  },
                  controller: settingsController.emailFieldController,
                  isObscure: false,
                ),
                if (emailError.isNotEmpty) ...[
                  SizedBox(height: AppTheme.elementSpacing / 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      emailError,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                  ),
                ],
                
                SizedBox(height: AppTheme.cardPadding),
                
                FormTextField(
                  width: double.infinity,
                  hintText: 'Password',
                  onChanged: (val) {
                    if (passwordError.isNotEmpty) {
                      setState(() {
                        passwordError = "";
                      });
                    }
                  },
                  controller: settingsController.passwordFieldController,
                  isObscure: obscurePass,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePass = !obscurePass;
                      });
                    },
                    icon: Icon(
                      obscurePass ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
                if (passwordError.isNotEmpty) ...[
                  SizedBox(height: AppTheme.elementSpacing / 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      passwordError,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            
            Spacer(),
            
            // Bottom button
            Padding(
              padding: EdgeInsets.only(bottom: AppTheme.cardPadding),
              child: SizedBox(
                width: double.infinity,
                child: LongButtonWidget(
                  state: loadingSetupRecovery ? ButtonState.loading : ButtonState.idle,
                  title: "Setup Recovery",
                  onTap: () async {
                    setState(() {
                      loadingSetupRecovery = true;
                    });
                    
                    validateEmail(settingsController.emailFieldController);
                    validatePassword(settingsController.passwordFieldController);
                    
                    if (emailError.isEmpty && passwordError.isEmpty) {
                      try {
                        PrivateData privData = await getPrivateData(Auth().currentUser!.uid);
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
                        
                        await sendEmail(settingsController.emailFieldController.text, token, 0);
                        
                        Get.find<SettingsController>()
                            .pageControllerEmailRecovery
                            .nextPage(
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                      } catch (e) {
                        // Handle error
                      }
                    }
                    
                    setState(() {
                      loadingSetupRecovery = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
