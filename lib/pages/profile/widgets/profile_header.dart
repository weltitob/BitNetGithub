import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:bitnet/pages/profile/widgets/qr_button.dart';
import 'package:bitnet/pages/profile/widgets/setting_button.dart';
import 'package:bitnet/pages/profile/widgets/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

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
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [
                      AppTheme.boxShadowProfile,
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        controller.userData.value.backgroundImageUrl,
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.25),
                        BlendMode.dstATop,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: AppTheme.cornerRadiusBig,
                      bottomRight: AppTheme.cornerRadiusBig,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Obx(
                              () => GestureDetector(
                                onTap: controller.currentview.value != 2
                                    ? () {
                                        print('follow dagelassen lol');
                                      }
                                    : () {
                                        showDialogueMultipleOptions(
                                          isActives: [
                                            true,
                                            true,
                                            true,
                                            true,
                                          ],
                                          actions: [
                                            (ctx) {
                                              Navigator.pop(ctx);
                                              ImagePickerNftMixedBottomSheet(
                                                  context, onImageTap:
                                                      (AssetPathEntity? album,
                                                          AssetEntity? image,
                                                          MediaDatePair?
                                                              pair) async {
                                                if (image != null) {
                                                  await controller
                                                      .handleProfileImageSelected(
                                                          image);
                                                } else if (pair != null) {
                                                  await controller
                                                      .handleProfileNftSelected(
                                                          pair);
                                                }
                                                Navigator.pop(context);
                                              });
                                            },
                                            (ctx) {
                                              Navigator.pop(ctx);
                                              ImagePickerNftMixedBottomSheet(
                                                  context, onImageTap:
                                                      (AssetPathEntity? album,
                                                          AssetEntity? image,
                                                          MediaDatePair?
                                                              pair) async {
                                                if (image != null) {
                                                  await controller
                                                      .handleBackgroundImageSelected(
                                                          image);
                                                } else if (pair != null) {
                                                  await controller
                                                      .handleBackgroundNftSelected(
                                                          pair);
                                                }
                                                Navigator.pop(context);
                                              });
                                            },
                                          ],
                                          images: [
                                            'assets/images/bitcoin.png',
                                            'assets/images/bitcoin.png',
                                          ],
                                          texts: [
                                            'Profile Picture',
                                            'Background',
                                          ],
                                          context: context,
                                        );
                                      },
                                child: Stack(
                                  children: [
                                    Obx(
                                      () => Avatar(
                                        mxContent: Uri.parse(controller
                                            .userData.value.profileImageUrl),
                                        size: AppTheme.cardPadding * 5.25.h,
                                        type: profilePictureType.lightning,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 4,
                                      child: ProfileButton(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      UserInformation(),
                      SizedBox(height: AppTheme.cardPadding * 2.h),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding.h * 1,
              ),
            ],
          ),
          SettingsButton(),
          QrButton(),
          CenterWidget(),
        ]),
      ],
    );
  }
}
