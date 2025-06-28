import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/backbone/helper/image_picker/image_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_manager/photo_manager.dart';

class MiniAppCreator extends StatefulWidget {
  const MiniAppCreator({Key? key}) : super(key: key);

  @override
  State<MiniAppCreator> createState() => _MiniAppCreatorState();
}

class _MiniAppCreatorState extends State<MiniAppCreator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _appUrlController = TextEditingController();
  final TextEditingController _appDescController = TextEditingController();

  final FocusNode _appNameFocus = FocusNode();
  final FocusNode _appUrlFocus = FocusNode();
  final FocusNode _appDescFocus = FocusNode();

  bool _isCreating = false;
  File? _selectedImage;
  String? _uploadedImageUrl;
  String? _storageFileName;

  @override
  void dispose() {
    _appNameController.dispose();
    _appUrlController.dispose();
    _appDescController.dispose();

    _appNameFocus.dispose();
    _appUrlFocus.dispose();
    _appDescFocus.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final OverlayController overlayController = Get.find<OverlayController>();

    // Request photo permissions
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth && !ps.hasAccess) {
      overlayController.showOverlay(
        'Please give the app photo access to continue.',
        color: AppTheme.errorColor,
      );
      return;
    }

    // Show custom image picker bottom sheet
    File? file = await ImagePickerCombinedBottomSheet(
      context,
      includeNFTs: false,
      onImageTap: (album, image, pair) async {
        if (image != null) {
          File? file = await image.file;
          context.pop(file);
        }
      },
    );

    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    try {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${_appNameController.text.replaceAll(' ', '_').toLowerCase()}.png';
      _storageFileName = fileName; // Store the filename for later use

      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('mini_app_icons')
          .child(fileName);

      final UploadTask uploadTask = storageRef.putFile(_selectedImage!);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      LoggerService logger = Get.find<LoggerService>();
      logger.e("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _createMiniApp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCreating = true;
    });

    LoggerService logger = Get.find<LoggerService>();

    try {
      // Upload image if selected
      if (_selectedImage != null) {
        _uploadedImageUrl = await _uploadImage();
      }

      // Generate a unique app ID
      final String appId =
          'app_${DateTime.now().millisecondsSinceEpoch}_${Auth().currentUser!.uid.substring(0, 8)}';

      // Create app data directly (no pending status, no email required)
      final Map<String, dynamic> appData = {
        'docId': appId,
        'name': _appNameController.text.trim(),
        'url': _appUrlController.text.trim(),
        'desc': _appDescController.text.trim(),
        'ownerId': Auth().currentUser!.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'parameters': {},
      };

      // Handle icon settings based on whether an image was uploaded
      if (_uploadedImageUrl != null && _storageFileName != null) {
        // User uploaded a custom icon - use Firebase Storage
        appData['useNetworkAsset'] = true;
        appData['storage_name'] = _storageFileName;
        appData['useNetworkImage'] = false;
      } else {
        // No custom icon - use network favicon from the app URL
        appData['useNetworkImage'] = true;
        appData['useNetworkAsset'] = false;
      }

      // Add app to total apps collection
      await FirebaseFirestore.instance
          .collection('mini_apps')
          .doc('total_apps')
          .collection('apps')
          .doc(appId)
          .set(appData);

      // Add app to user's apps list
      await FirebaseFirestore.instance
          .collection('mini_apps')
          .doc(Auth().currentUser!.uid)
          .set({
        'apps': FieldValue.arrayUnion([appId])
      }, SetOptions(merge: true));

      // Show success message
      if (context.mounted) {
        OverlayController overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          'Mini app created successfully!',
          color: AppTheme.successColor,
        );

        // Navigate back
        context.pop();
      }

      logger.i("Mini app created automatically: ${_appNameController.text}");
    } catch (e) {
      logger.e("Error creating mini app: $e");

      if (context.mounted) {
        OverlayController overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          'Failed to create mini app',
          color: AppTheme.errorColor,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  Widget _buildCustomTextField({
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputAction? textInputAction,
    Function(String)? onFieldSubmitted,
    String? Function(String?)? validator,
    bool isMultiline = false,
    double? height,
  }) {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: isMultiline ? 12.h : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? AppTheme.white60
                      : AppTheme.colorGlassContainer,
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
              maxLines: isMultiline ? null : 1,
              textAlign: isMultiline ? TextAlign.left : TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                    ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: isMultiline
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(vertical: 16.h),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding.w,
                  vertical: AppTheme.elementSpacing.h,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 3),

                      // Title
                      Text(
                        "Create Mini App",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppTheme.elementSpacing),
                      Text(
                        "Your mini app will be created instantly and available in your apps list. No email required, no waiting, instant creation.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: AppTheme.cardPadding.h),

                      // App Icon Picker
                      Center(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(
                                  AppTheme.borderRadiusMid.r),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppTheme.borderRadiusMid.r),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        size: 40.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.5),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        "Add Icon",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.5),
                                            ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(height: AppTheme.cardPadding.h),

                      // App Name Field
                      _buildCustomTextField(
                        hintText: "App Name",
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
                      _buildCustomTextField(
                        hintText: "App URL",
                        controller: _appUrlController,
                        focusNode: _appUrlFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => _appDescFocus.requestFocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your app URL';
                          }
                          if (!(Uri.tryParse(value)?.hasScheme ?? false)) {
                            return 'Please enter a valid URL (include https://)';
                          }
                          return null;
                        },
                      ),

                      // App Description Field
                      _buildCustomTextField(
                        hintText: "App Description",
                        controller: _appDescController,
                        focusNode: _appDescFocus,
                        textInputAction: TextInputAction.done,
                        isMultiline: true,
                        height: 100.h,
                        onFieldSubmitted: (_) => _createMiniApp(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: AppTheme.cardPadding.h),

                      // Create Button
                      LongButtonWidget(
                        title: _isCreating ? "Creating..." : "Create App",
                        onTap: _isCreating ? null : _createMiniApp,
                        buttonType: ButtonType.solid,
                        customWidth: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
