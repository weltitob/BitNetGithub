import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileBio extends StatelessWidget {
  const ProfileBio({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      child: Obx(() {
        final isEditMode = controller.currentview.value == 4;
        final bioText = controller.bioController.text;
        
        if (bioText.isEmpty) {
          return const SizedBox.shrink();
        }

        if (isEditMode) {
          return GlassContainer(
            borderRadius: AppTheme.cardRadiusMid,
            customColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black.withOpacity(0.5)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bioText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppTheme.white70),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            bioText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppTheme.white70),
          ),
        );
      }),
    );
  }
}