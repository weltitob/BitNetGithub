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
import 'package:bitnet/pages/profile/widgets/profile_actions.dart';
import 'package:bitnet/pages/profile/widgets/profile_avatar.dart';
import 'package:bitnet/pages/profile/widgets/profile_bio.dart';
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
                          SizedBox(width: AppTheme.cardPadding.w),
                          const ProfileAvatar(),
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
                    SizedBox(height: AppTheme.elementSpacing),
                    const ProfileBio(),
                    SizedBox(
                      height: AppTheme.cardPadding.h,
                    ),
                    const ProfileActions(),
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

    return Container(
      child: Obx(() {
        final isEditMode = controller.currentview.value == 4;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isEditMode
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
                  readOnly: !isEditMode,
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
                readOnly: !isEditMode,
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
            isEditMode
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
                  readOnly: !isEditMode,
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
                readOnly: !isEditMode,
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
        );
      }),
    );
  }
}