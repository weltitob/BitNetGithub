import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/other_profile/widgets/other_center_widget.dart';
import 'package:bitnet/pages/other_profile/widgets/other_user_information.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtherProfileHeader extends StatelessWidget {
  const OtherProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherProfileController>();
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
                        Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.25),
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
                              () => Avatar(
                                mxContent: Uri.parse(controller.userData.value.profileImageUrl),
                                size: AppTheme.cardPadding * 5.25.h,
                                type: profilePictureType.lightning,
                                isNft: controller.userData.value.nft_profile_id.isNotEmpty,
                                cornerWidget: controller.currentview.value == 2 ? const ProfileButton() : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const OtherUserInformation(),
                      SizedBox(height: AppTheme.cardPadding * 1.5.h),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding.h * 1,
              ),
            ],
          ),
          const OtherCenterWidget(),
        ]),
      ],
    );
  }
}
