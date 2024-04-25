import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return  Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
        child: Column(
          children: [
            TextField(
              focusNode: controller.focusNodeUsername,
              readOnly: controller.currentview.value == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                isDense: true,
                border: InputBorder.none,
                errorText: controller.displayNameValid.value
                    ? null
                    : 'Bad characters', // Add this line
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.white70,
                  ),
              controller: controller.userNameController,
            ),
            const SizedBox(height: AppTheme.cardPadding),
            TextField(
              focusNode: controller.focusNodeDisplayName,
              readOnly: controller.currentview.value == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  isDense: true,
                  border: InputBorder.none,
                  errorText: controller.displayNameValid.value
                      ? null
                      : "Couldn't change username"),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppTheme.white90),
              controller: controller.displayNameController,
            ),
            TextField(
              focusNode: controller.focusNodeBio,
              readOnly: controller.currentview.value == 2 ? false : true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                isDense: true,
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppTheme.white70),
              controller: controller.bioController,
            ),
            const SizedBox(height: AppTheme.elementSpacing / 2),
          ],
        ),
      );
  }
}