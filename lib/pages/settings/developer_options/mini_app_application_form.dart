import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/settings/developer_options/developer_options_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MiniAppApplicationForm extends StatefulWidget {
  const MiniAppApplicationForm({Key? key}) : super(key: key);

  @override
  State<MiniAppApplicationForm> createState() => _MiniAppApplicationFormState();
}

class _MiniAppApplicationFormState extends State<MiniAppApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _appUrlController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _appNameFocus = FocusNode();
  final FocusNode _appUrlFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _appNameController.dispose();
    _appUrlController.dispose();
    _emailController.dispose();

    _appNameFocus.dispose();
    _appUrlFocus.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    LoggerService logger = Get.find<LoggerService>();

    try {
      // Get current timestamp for submission date
      final timestamp = FieldValue.serverTimestamp();

      // Create application data
      final applicationData = {
        'appName': _appNameController.text.trim(),
        'appUrl': _appUrlController.text.trim(),
        'email': _emailController.text.trim(),
        'status': 'pending',
        'submittedAt': timestamp,
        'owner_id': Auth().currentUser!.uid
      };

      await appApplicationsRef.add(applicationData);

      // Navigate back to developer options page
      if (context.mounted) {
        // Show success message
        OverlayController overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          'Application submitted successfully',
          color: AppTheme.successColor,
        );

        // Navigate back
        context.pop();
      }

      logger.i("Mini app application submitted: ${_appNameController.text}");
    } catch (e) {
      logger.e("Error submitting mini app application: $e");

      if (context.mounted) {
        OverlayController overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          'Failed to submit application',
          color: AppTheme.errorColor,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.cardPadding * 2),

              // Title and description

              Text(
                "Submit your application to register a mini app in the BitNet ecosystem.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppTheme.cardPadding),

              // App Name Field
              FormTextField(
                hintText: "App Name",
                insidePadding: EdgeInsets.all(8),
                controller: _appNameController,
                focusNode: _appNameFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _appUrlFocus.requestFocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your app name';
                  }
                  return null;
                },
              ),

              // App URL Field
              FormTextField(
                hintText: "App URL",
                insidePadding: EdgeInsets.all(8),
                controller: _appUrlController,
                focusNode: _appUrlFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your app URL';
                  }
                  if (!(Uri.tryParse(value)?.hasScheme ?? true)) {
                    return 'Please enter a valid URL (include https://)';
                  }
                  return null;
                },
              ),

              // Email Field
              FormTextField(
                hintText: "Contact Email",
                insidePadding: EdgeInsets.all(8),
                controller: _emailController,
                focusNode: _emailFocus,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitApplication(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Simple email validation
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppTheme.cardPadding),

              // Submit Button
              LongButtonWidget(
                title: _isSubmitting ? "Submitting..." : "Submit Application",
                onTap: _isSubmitting ? null : _submitApplication,
                buttonType: ButtonType.solid,
                customWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
