import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      child: Obx(() {
        final isOwnProfile = Auth().currentUser!.uid == controller.userData.value.did;
        final isEditMode = controller.currentview.value == 4;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPrimaryAction(context, controller, isOwnProfile, isEditMode),
            SizedBox(width: AppTheme.cardPadding.w / 2),
            _buildSecondaryAction(context, controller, isOwnProfile, isEditMode),
          ],
        );
      }),
    );
  }

  Widget _buildPrimaryAction(BuildContext context, ProfileController controller, bool isOwnProfile, bool isEditMode) {
    if (!isOwnProfile) {
      return LongButtonWidget(
        title: controller.isFollowing?.value == true ? "Unfollow" : "Follow",
        onTap: () {
          controller.isFollowing?.value == true 
              ? controller.handleUnfollowUser() 
              : controller.handleFollowUser();
        },
        buttonType: ButtonType.transparent,
        customHeight: AppTheme.cardPadding * 1.75,
        customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
        leadingIcon: Icon(
          controller.isFollowing?.value == true 
              ? Icons.person_remove 
              : Icons.person_add,
          size: AppTheme.cardPadding * 0.8,
        ),
      );
    }

    if (isEditMode) {
      return LongButtonWidget(
        title: "Save Changes",
        onTap: () {
          controller.updateDisplayName();
          controller.updateUsername();
          controller.updateBio();
          controller.currentview.value = 0;
        },
        buttonType: ButtonType.transparent,
        customHeight: AppTheme.cardPadding * 1.75,
        customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
        leadingIcon: Icon(
          Icons.check,
          size: AppTheme.cardPadding * 0.8,
        ),
      );
    }

    return LongButtonWidget(
      title: "Edit",
      onTap: () {
        controller.currentview.value = 4;
      },
      buttonType: ButtonType.transparent,
      customHeight: AppTheme.cardPadding * 1.75,
      customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
      leadingIcon: Icon(
        Icons.edit,
        size: AppTheme.cardPadding * 0.8,
      ),
    );
  }

  Widget _buildSecondaryAction(BuildContext context, ProfileController controller, bool isOwnProfile, bool isEditMode) {
    final iconColor = Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
        ? Colors.white 
        : Theme.of(context).brightness == Brightness.light 
            ? AppTheme.white70 
            : AppTheme.black60;

    if (!isOwnProfile) {
      return LongButtonWidget(
        title: "Tip",
        onTap: () {},
        buttonType: ButtonType.solid,
        customHeight: AppTheme.cardPadding * 1.75,
        customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
        leadingIcon: Icon(
          FontAwesomeIcons.btc,
          size: AppTheme.cardPadding * 0.75,
          color: iconColor,
        ),
      );
    }

    if (isEditMode) {
      return LongButtonWidget(
        title: "Cancel",
        onTap: () {
          // Reset values to what they were before editing
          controller.displayNameController.text = controller.userData.value.displayName;
          controller.userNameController.text = controller.userData.value.username;
          controller.bioController.text = controller.userData.value.bio;
          controller.currentview.value = 0;
        },
        buttonType: ButtonType.solid,
        customHeight: AppTheme.cardPadding * 1.75,
        customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
        leadingIcon: Icon(
          Icons.close,
          size: AppTheme.cardPadding * 0.75,
          color: iconColor,
        ),
      );
    }

    return LongButtonWidget(
      title: "Share",
      onTap: () {
        // Add share functionality here
      },
      buttonType: ButtonType.solid,
      customHeight: AppTheme.cardPadding * 1.75,
      customWidth: (MediaQuery.of(context).size.width - AppTheme.cardPadding * 2.5.w) / 2,
      leadingIcon: Icon(
        Icons.share,
        size: AppTheme.cardPadding * 0.75,
        color: iconColor,
      ),
    );
  }
}