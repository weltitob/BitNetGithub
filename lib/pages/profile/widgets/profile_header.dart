import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:bitnet/pages/profile/widgets/qr_button.dart';
import 'package:bitnet/pages/profile/widgets/setting_button.dart';
import 'package:bitnet/pages/profile/widgets/user_information.dart';
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
        Stack(alignment: Alignment.center, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                // decoration: BoxDecoration(
                //   color: Colors.black,
                //   boxShadow: [
                //     AppTheme.boxShadowProfile,
                //   ],
                //   image: DecorationImage(
                //     image: NetworkImage(
                //       controller.userData.value.backgroundImageUrl ?? '',
                //     ),
                //     fit: BoxFit.cover,
                //     colorFilter: ColorFilter.mode(
                //       Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.25),
                //       BlendMode.dstATop,
                //     ),
                //   ),
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: AppTheme.cornerRadiusBig,
                //     bottomRight: AppTheme.cornerRadiusBig,
                //   ),
                // ),
                child: Column(
                  children: [
                    SizedBox(height: AppTheme.cardPadding.h * 2),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppTheme.cardPadding.w,
                          ),
                          Obx(
                                () => GestureDetector(
                              onTap: controller.currentview.value == 4 && Auth().currentUser!.uid == controller.userData.value.did
                                  ? () async {
                                    // Sichere ProfileController-Referenz
                                    ProfileController? profileController;
                                    try {
                                      profileController = Get.find<ProfileController>();
                                    } catch (e) {
                                      print("ProfileController not found: $e");
                                      overlayController.showOverlay(
                                          'Profile controller error. Please try again.',
                                          color: AppTheme.errorColor);
                                      return;
                                    }
                                    
                                    if (profileController == null) {
                                      overlayController.showOverlay(
                                          'Unable to access profile settings.',
                                          color: AppTheme.errorColor);
                                      return;
                                    }
                                    
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
                                                        'please give the app photo access to continue.',
                                                        color: AppTheme.errorColor);
                                                    return;
                                                  }
                                                  ImagePickerCombinedBottomSheet(
                                                      context, 
                                                      includeNFTs: true,
                                                      onImageTap: (AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair) async {
                                                        if (image != null) {
                                                          await profileController!.handleProfileImageSelected(image);
                                                        } else if (pair != null) {
                                                          await profileController!.handleProfileNftSelected(pair);
                                                        }
                                                        Navigator.pop(context);
                                                  });
                                                },
                                                onRightButtonTap: () async {
                                                  Navigator.pop(context);
                                                  final PermissionState ps = await PhotoManager.requestPermissionExtend();
                                                  if (!ps.isAuth && !ps.hasAccess) {
                                                    overlayController.showOverlay(
                                                        'please give the app photo access to continue.',
                                                        color: AppTheme.errorColor);
                                                    return;
                                                  }
                                                  ImagePickerCombinedBottomSheet(
                                                      context, 
                                                      includeNFTs: true,
                                                      onImageTap: (AssetPathEntity? album, AssetEntity? image, MediaDatePair? pair) async {
                                                        if (image != null) {
                                                          await profileController!.handleBackgroundImageSelected(image);
                                                        } else if (pair != null) {
                                                          await profileController!.handleBackgroundNftSelected(pair);
                                                        }
                                                        Navigator.pop(context);
                                                  });
                                                })
                                          ],
                                        ),
                                      ),
                                    );
                              }
                                  : () {
                                print('Avatar clicked, but not in edit mode');
                              },
                              child: Obx(
                                    () => Avatar(
                                  mxContent: Uri.parse(controller
                                      .userData.value.profileImageUrl),
                                  size: AppTheme.cardPadding * 3.h, // Hier wird der Avatar kleiner gemacht
                                  type: profilePictureType.lightning,
                                  isNft: controller
                                      .userData.value.nft_profile_id.isNotEmpty,
                                  cornerWidget:
                                  controller.currentview.value == 4 && Auth().currentUser!.uid == controller.userData.value.did
                                      ? const ProfileButton()
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppTheme.cardPadding.w * 0.5,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width -
                                  AppTheme.cardPadding.w * 8,
                              child: UserInformation()),
                          SizedBox(width: AppTheme.cardPadding.w,),
                          SettingsButton(),

                        ],
                      ),
                    ),
                    SizedBox(height: AppTheme.elementSpacing,),
                    // Bio-Text unter dem Profilbild
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding.w),
                      child: Obx(
                            () => controller.currentview.value == 4
                            ? GlassContainer(
                          borderRadius: AppTheme.cardRadiusMid,
                          customColor: Theme.of(context).brightness == Brightness.light
                              ? Colors.black.withOpacity(0.5)
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.bioController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppTheme.white70),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.bioController.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppTheme.white70),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding.w),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Auth().currentUser!.uid == controller.userData.value.did
                            ? Obx(() => controller.currentview.value == 4 
                                ? LongButtonWidget(
                                    title: "Save Changes",
                                    onTap: () {
                                      controller.updateDisplayName();
                                      controller.updateUsername();
                                      controller.updateBio();
                                      controller.currentview.value = 0;
                                    },
                                    buttonType: ButtonType.transparent,
                                    customHeight: AppTheme.cardPadding * 1.75,
                                    customWidth: (MediaQuery.of(context).size.width -
                                        AppTheme.cardPadding * 2.5.w) /
                                        2,
                                    leadingIcon: Icon(
                                      Icons.check,
                                      size: AppTheme.cardPadding * 0.8,
                                    ),
                                  )
                                : LongButtonWidget(
                                    title: "Edit",
                                    onTap: () {
                                      controller.currentview.value = 4;
                                    },
                                    buttonType: ButtonType.transparent,
                                    customHeight: AppTheme.cardPadding * 1.75,
                                    customWidth: (MediaQuery.of(context).size.width -
                                        AppTheme.cardPadding * 2.5.w) /
                                        2,
                                    leadingIcon: Icon(
                                      Icons.edit,
                                      size: AppTheme.cardPadding * 0.8,
                                    ),
                                  ))
                            : LongButtonWidget(
                                title: controller.isFollowing?.value == true ? "Unfollow" : "Follow",
                                onTap: () {
                                  controller.isFollowing?.value == true 
                                      ? controller.handleUnfollowUser() 
                                      : controller.handleFollowUser();
                                },
                                buttonType: ButtonType.transparent,
                                customHeight: AppTheme.cardPadding * 1.75,
                                customWidth: (MediaQuery.of(context).size.width -
                                    AppTheme.cardPadding * 2.5.w) /
                                    2,
                                leadingIcon: Icon(
                                  controller.isFollowing?.value == true 
                                      ? Icons.person_remove 
                                      : Icons.person_add,
                                  size: AppTheme.cardPadding * 0.8,
                                ),
                              ),
                            SizedBox(
                              width: AppTheme.cardPadding.w / 2,
                            ),
                            Auth().currentUser!.uid == controller.userData.value.did
                            ? Obx(() => controller.currentview.value == 4
                                ? LongButtonWidget(
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
                                    customWidth: (MediaQuery.of(context).size.width -
                                        AppTheme.cardPadding * 2.5.w) /
                                        2,
                                    leadingIcon: Icon(
                                      Icons.close,
                                      size: AppTheme.cardPadding * 0.75,
                                      color: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
                                          ? Colors.white 
                                          : Theme.of(context).brightness == Brightness.light 
                                              ? AppTheme.white70 
                                              : AppTheme.black60,
                                    ),
                                  )
                                : LongButtonWidget(
                                    title: "Share",
                                    onTap: () {
                                      // Add share functionality here
                                    },
                                    buttonType: ButtonType.solid,
                                    customHeight: AppTheme.cardPadding * 1.75,
                                    customWidth: (MediaQuery.of(context).size.width -
                                        AppTheme.cardPadding * 2.5.w) /
                                        2,
                                    leadingIcon: Icon(
                                      Icons.share,
                                      size: AppTheme.cardPadding * 0.75,
                                      color: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
                                          ? Colors.white 
                                          : Theme.of(context).brightness == Brightness.light 
                                              ? AppTheme.white70 
                                              : AppTheme.black60,
                                    ),
                                  ))
                            : LongButtonWidget(
                                title: "Tip",
                                onTap: () {},
                                buttonType: ButtonType.solid,
                                customHeight: AppTheme.cardPadding * 1.75,
                                customWidth: (MediaQuery.of(context).size.width -
                                    AppTheme.cardPadding * 2.5.w) /
                                    2,
                                leadingIcon: Icon(
                                  FontAwesomeIcons.btc,
                                  size: AppTheme.cardPadding * 0.75,
                                  color: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
                                      ? Colors.white 
                                      : Theme.of(context).brightness == Brightness.light 
                                          ? AppTheme.white70 
                                          : AppTheme.black60,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 3.2.h,
                    )
                  ],
                ),
              ),
            ],
          ),


          // QrButton(),
          const CenterWidget(),
        ]),
      ],
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(
          () => Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            controller.currentview.value == 4
                ? GlassContainer(
              borderRadius: BorderRadius.only(
                  topRight: AppTheme.cornerRadiusMid / 2,
                  topLeft: AppTheme.cornerRadiusMid / 2),
              customColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.black.withOpacity(0.5)
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  focusNode: controller.focusNodeDisplayName,
                  readOnly:
                  controller.currentview.value == 4 ? false : true,
                  // Align top-left:
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    isDense: true,
                    border: InputBorder.none,
                    errorText: controller.displayNameValid.value
                        ? null
                        : L10n.of(context)!.coudntChangeUsername,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppTheme.white90),
                  controller: controller.displayNameController,
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                focusNode: controller.focusNodeDisplayName,
                readOnly: controller.currentview.value == 4 ? false : true,
                // Align top-left:
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  isDense: true,
                  border: InputBorder.none,
                  errorText: controller.displayNameValid.value
                      ? null
                      : L10n.of(context)!.coudntChangeUsername,
                ),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppTheme.white90),
                controller: controller.displayNameController,
              ),
            ),

            //username
            controller.currentview.value == 4
                ? GlassContainer(
              borderRadius: BorderRadius.only(
                  bottomLeft: AppTheme.cornerRadiusMid / 2,
                  bottomRight: AppTheme.cornerRadiusMid / 2),
              customColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.black.withOpacity(0.5)
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  focusNode: controller.focusNodeUsername,
                  readOnly:
                  controller.currentview.value == 4 ? false : true,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    isDense: true,
                    border: InputBorder.none,
                    errorText: controller.displayNameValid.value
                        ? null
                        : L10n.of(context)!.badCharacters,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.white90,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: controller.userNameController,
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                focusNode: controller.focusNodeUsername,
                readOnly: controller.currentview.value == 4 ? false : true,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  isDense: true,
                  border: InputBorder.none,
                  errorText: controller.displayNameValid.value
                      ? null
                      : L10n.of(context)!.badCharacters,
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppTheme.white90,
                  fontWeight: FontWeight.w600,
                ),
                controller: controller.userNameController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}