import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEyeRight extends StatelessWidget {
  const EditEyeRight({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Positioned(
      top: 165,
      right: 57,
      child: controller.currentview.value == 3
          ? Align(
              child: IconButton(
                color: AppTheme.white90,
                onPressed: () {
                  controller.showFollwers!.value =
                      !controller.showFollwers!.value;
                  controller
                      .updateShowFollowers(controller.showFollwers!.value);
                },
                icon: controller.showFollwers == null
                    ? Container()
                    : Icon(
                        controller.showFollwers!.value
                            ? Icons.remove_red_eye_rounded
                            : Icons.cancel,
                      ),
              ),
            )
          : Container(),
    );
    ;
  }
}
