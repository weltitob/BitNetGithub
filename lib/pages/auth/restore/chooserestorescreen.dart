import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/users.dart';
import 'package:bitnet/pages/auth/restore/userslist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:bitnet/backbone/debug/create_test_user.dart'; // Debug test user utility

// Global overlay entry for loading indicator
OverlayEntry? _globalLoadingOverlay;

// Helper function to show loading overlay
void _showLoadingOverlay(BuildContext context, {Color color = Colors.orange}) {
  _hideLoadingOverlay(); // Ensure any existing overlay is removed first
  
  _globalLoadingOverlay = OverlayEntry(
    builder: (context) => Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    ),
  );
  
  Overlay.of(context).insert(_globalLoadingOverlay!);
}

// Helper function to hide loading overlay
void _hideLoadingOverlay() {
  _globalLoadingOverlay?.remove();
  _globalLoadingOverlay = null;
}

class ChooseRestoreScreen extends StatefulWidget {
  const ChooseRestoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseRestoreScreen> createState() => _ChooseRestoreScreenState();
}

class _ChooseRestoreScreenState extends State<ChooseRestoreScreen> {
  late TextEditingController tokenController;

  @override
  void initState() {
    tokenController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure any loading overlay is removed
    _hideLoadingOverlay();
    tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.restoreAccount,
        context: context,
        onTap: () {
          Navigator.pop(context);
          //context.go('/authhome/login');
        },
        actions: [
          // const PopUpLangPickerWidget()
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 1.5.h,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              L10n.of(context)!.restoreOptions,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BitNetImageWithTextContainer(L10n.of(context)!.wordRecovery, () {
                context.go('/authhome/login/word_recovery');
              }, image: "assets/images/wallet.png"),
              BitNetImageWithTextContainer(
                  L10n.of(context)!.connectWithOtherDevices, () {
                context.go('/authhome/login/device_recovery');
              }, image: "assets/images/scan_qr_device.png"),
            ],
          ),
          SizedBox(
            height: AppTheme.cardPadding.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BitNetImageWithTextContainer(L10n.of(context)!.socialRecovery,
                  () {
                context.go('/authhome/login/social_recovery');
              }, image: "assets/images/friends.png"),
              BitNetImageWithTextContainer(
                "Email Recovery",
                () {
                  context.go('/authhome/login/email_recovery');
                },
                image: "assets/images/key.png",
              )
              // BitNetImageWithTextContainer(L10n.of(context)!.socialRecovery,
              //         () {
              //       context.go('/authhome/login/social_recovery');
              //     }, image: "assets/images/friends.png"),
            ],
          ),
          // Commented out sections
          SizedBox(
            height: AppTheme.cardPadding * 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: Text(
              L10n.of(context)!.locallySavedAccounts,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // List accounts
          UsersListWidget(),

          const SizedBox(
            height: AppTheme.cardPadding,
          ),

          // Debug test user button (only in debug mode)
          if (kDebugMode) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.bug_report,
                      color: Colors.orange,
                    ),
                  ),
                  title: const Text(
                    'Debug Login: testuser_2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Node: node2 (Debug Test User)'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    // Store context references before async gap
                    final messenger = ScaffoldMessenger.of(context);
                    final router = GoRouter.of(context);
                    
                    // Show loading overlay
                    _showLoadingOverlay(context, color: Colors.orange);

                    bool success = false;
                    String? errorMessage;
                    
                    try {
                      // Add timeout to prevent hanging
                      success = await CreateTestUser.createOrLoginTestUser()
                          .timeout(
                            const Duration(seconds: 30),
                            onTimeout: () {
                              throw TimeoutException('Operation timed out after 30 seconds');
                            },
                          );
                    } on TimeoutException catch (e) {
                      errorMessage = 'Operation timed out. Please try again.';
                    } catch (e) {
                      errorMessage = 'Error: $e';
                    } finally {
                      // Always hide loading overlay
                      _hideLoadingOverlay();
                    }

                    // Handle result
                    if (success) {
                      // Navigate to home
                      router.go('/home');
                    } else {
                      // Show error
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(errorMessage ?? 'Failed to create/login test user'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding * 0.5,
            ),
            
            // Delete test user button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                  title: const Text(
                    'Delete Debug User',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: const Text('Remove testuser_2 and all associated data'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    // Show confirmation dialog
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Test User?'),
                        content: const Text(
                          'This will permanently delete the test user "testuser_2" and all associated data including:\n\n'
                          '• User profile\n'
                          '• Node mappings\n'
                          '• Recovery data\n'
                          '• Onchain addresses\n\n'
                          'This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    
                    if (shouldDelete != true) return;
                    
                    // Store context references before async gap
                    final messenger = ScaffoldMessenger.of(context);
                    
                    // Show loading overlay
                    _showLoadingOverlay(context, color: Colors.red);

                    bool deleteSuccess = false;
                    String? errorMessage;
                    
                    try {
                      // Add timeout to prevent hanging
                      await CreateTestUser.deleteTestUser()
                          .timeout(
                            const Duration(seconds: 30),
                            onTimeout: () {
                              throw TimeoutException('Delete operation timed out after 30 seconds');
                            },
                          );
                      deleteSuccess = true;
                    } on TimeoutException catch (e) {
                      errorMessage = 'Delete operation timed out. Please try again.';
                    } catch (e) {
                      errorMessage = 'Error deleting test user: $e';
                    } finally {
                      // Always hide loading overlay
                      _hideLoadingOverlay();
                    }

                    // Show result
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(deleteSuccess 
                            ? 'Test user deleted successfully' 
                            : errorMessage ?? 'Failed to delete test user'),
                        backgroundColor: deleteSuccess ? Colors.green : Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
          ],

          const SizedBox(
            height: AppTheme.cardPadding,
          ),
        ],
      ),
      context: context,
    );
  }
}
