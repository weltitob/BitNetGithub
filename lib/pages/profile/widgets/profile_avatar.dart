import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final overlayController = Get.find<OverlayController>();

    return Obx(() {
      final isEditMode = controller.currentview.value == 4;
      final isOwnProfile = Auth().currentUser!.uid == controller.userData.value.did;
      final canEdit = isEditMode && isOwnProfile;

      return GestureDetector(
        onTap: canEdit ? () => _handleAvatarTap(context, controller, overlayController) : null,
        child: Avatar(
          mxContent: Uri.parse(controller.userData.value.profileImageUrl),
          size: AppTheme.cardPadding * 3.h,
          type: profilePictureType.lightning,
          isNft: controller.userData.value.nft_profile_id.isNotEmpty,
          cornerWidget: canEdit ? const ProfileButton() : null,
        ),
      );
    });
  }

  void _handleAvatarTap(BuildContext context, ProfileController controller, OverlayController overlayController) async {
    await BitNetBottomSheet(
      height: MediaQuery.of(context).size.height * 0.6,
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: false,
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
          text: 'Change Images',
        ),
        body: Stack(
          children: [
            Container(
              child: const Column(
                children: [
                  SizedBox(height: AppTheme.cardPadding * 4),
                  Icon(FontAwesomeIcons.image, size: AppTheme.cardPadding * 4),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding,
                        vertical: AppTheme.cardPadding * 2),
                    child: Text(
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
                final PermissionState ps = await PhotoManager.requestPermissionExtend();
                if (!ps.isAuth && !ps.hasAccess) {
                  overlayController.showOverlay(
                      'Please give the app photo access to continue.',
                      color: AppTheme.errorColor);
                  return;
                }
                ImagePickerCombinedBottomSheet(
                    context, 
                    includeNFTs: true,
                    onImageTap: (AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair) async {
                      if (image != null) {
                        await controller.handleProfileImageSelected(image);
                      } else if (pair != null) {
                        await controller.handleProfileNftSelected(pair);
                      }
                      Navigator.pop(context);
                });
              },
              onRightButtonTap: () async {
                Navigator.pop(context);
                final PermissionState ps = await PhotoManager.requestPermissionExtend();
                if (!ps.isAuth && !ps.hasAccess) {
                  overlayController.showOverlay(
                      'Please give the app photo access to continue.',
                      color: AppTheme.errorColor);
                  return;
                }
                ImagePickerCombinedBottomSheet(
                    context, 
                    includeNFTs: true,
                    onImageTap: (AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair) async {
                      if (image != null) {
                        await controller.handleBackgroundImageSelected(image);
                      } else if (pair != null) {
                        await controller.handleBackgroundNftSelected(pair);
                      }
                      Navigator.pop(context);
                });
              }
            )
          ],
        ),
      ),
    );
  }
}