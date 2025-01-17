import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/container/avatar.dart';

import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:bitnet/pages/profile/widgets/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final overlayController = Get.find<OverlayController>();
    final controller = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with banner image
        Row(
          children: [
            Obx(
                  () => Container(
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [AppTheme.boxShadowProfile],
                  image: DecorationImage(
                    image: NetworkImage(controller.userData.value.backgroundImageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.25),
                      BlendMode.dstATop,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: AppTheme.cornerRadiusBig,
                    bottomRight: AppTheme.cornerRadiusBig,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: controller.currentview.value == 3
                      ? GlassContainer(
                    customColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.black.withOpacity(0.5)
                        : null,
                    child: _buildTextField(
                      context: context,
                      controller: controller.bioController,
                      focusNode: controller.focusNodeBio,
                      isEditable: controller.currentview.value == 3,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white70,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  )
                      : _buildTextField(
                    context: context,
                    controller: controller.bioController,
                    focusNode: controller.focusNodeBio,
                    isEditable: false,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppTheme.white70,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Profile section with avatar and buttons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture
              Transform.translate(
                offset: Offset(0, -30.h),
                child: GestureDetector(
                  onTap: controller.currentview.value == 3
                      ? () => _handleImageChange(context, controller, overlayController)
                      : () => print('follow dagelassen lol'),
                  child: Obx(
                        () => Avatar(
                      mxContent: Uri.parse(controller.userData.value.profileImageUrl),
                      size: AppTheme.cardPadding * 4.h,
                      type: profilePictureType.lightning,
                      isNft: controller.userData.value.nft_profile_id.isNotEmpty,
                      cornerWidget: controller.currentview.value == 3
                          ? const ProfileButton()
                          : null,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SettingsButton(),
                  //
                  // QrButton(),
                ],
              ),
            ],
          ),
        ),

        // User Information Fields
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Name
              Container(
                width: double.infinity,
                child: controller.currentview.value == 3
                    ? GlassContainer(
                  customColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.black.withOpacity(0.5)
                      : null,
                  child: _buildTextField(
                    context: context,
                    controller: controller.displayNameController,
                    focusNode: controller.focusNodeDisplayName,
                    isEditable: controller.currentview.value == 3,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white90,
                    ),
                    errorText: controller.displayNameValid.value
                        ? null
                        : L10n.of(context)!.coudntChangeUsername,
                  ),
                )
                    : _buildTextField(
                  context: context,
                  controller: controller.displayNameController,
                  focusNode: controller.focusNodeDisplayName,
                  isEditable: false,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white90,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Username
              Container(
                width: double.infinity,
                child: controller.currentview.value == 3
                    ? GlassContainer(
                  customColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.black.withOpacity(0.5)
                      : null,
                  child: _buildTextField(
                    context: context,
                    controller: controller.userNameController,
                    focusNode: controller.focusNodeUsername,
                    isEditable: controller.currentview.value == 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppTheme.white70,
                    ),
                    errorText: controller.displayNameValid.value
                        ? null
                        : L10n.of(context)!.badCharacters,
                  ),
                )
                    : _buildTextField(
                  context: context,
                  controller: controller.userNameController,
                  focusNode: controller.focusNodeUsername,
                  isEditable: false,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.white70,
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Bio

            ],
          )),
        ),

        SizedBox(height: AppTheme.cardPadding.h),

        // Center widget
        const Center(child: CenterWidget()),
      ],
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isEditable,
    required TextStyle style,
    String? errorText,
    int? maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: !isEditable,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlign: TextAlign.left,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        fillColor: Colors.transparent,
        isDense: true,
        border: InputBorder.none,
        errorText: errorText,
      ),
    );
  }

  void _handleImageChange(BuildContext context, ProfileController controller, OverlayController overlayController) {
    BitNetBottomSheet(
      height: MediaQuery.of(context).size.height * 0.6,
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: false,
          context: context,
          onTap: () => Navigator.pop(context),
          text: 'Change Images',
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: AppTheme.cardPadding * 4),
                  const Icon(
                    FontAwesomeIcons.image,
                    size: AppTheme.cardPadding * 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding,
                      vertical: AppTheme.cardPadding * 2,
                    ),
                    child: const Text(
                      "Here you can change your profile picture or background image.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            BottomButtons(
              leftButtonTitle: "Profile Picture",
              rightButtonTitle: "Background",
              onLeftButtonTap: () async {
                Navigator.pop(context);
                await _handleImageSelection(context, controller, overlayController, isProfile: true);
              },
              onRightButtonTap: () async {
                Navigator.pop(context);
                await _handleImageSelection(context, controller, overlayController, isProfile: false);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleImageSelection(
      BuildContext context,
      ProfileController controller,
      OverlayController overlayController, {
        required bool isProfile,
      }) async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth && !ps.hasAccess) {
      overlayController.showOverlay(
        'please give the app photo access to continue.',
        color: AppTheme.errorColor,
      );
      return;
    }

    ImagePickerNftMixedBottomSheet(
      context,
      onImageTap: (AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair) async {
        if (image != null) {
          if (isProfile) {
            await controller.handleProfileImageSelected(image);
          } else {
            await controller.handleBackgroundImageSelected(image);
          }
        } else if (pair != null) {
          if (isProfile) {
            await controller.handleProfileNftSelected(pair);
          } else {
            await controller.handleBackgroundNftSelected(pair);
          }
        }
        Navigator.pop(context);
      },
    );
  }
}