import 'package:bitnet/components/container/coinlogo.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Material(
        color: Colors.transparent,
        child: controller.currentview.value != 2
            ? CoinLogoWidgetSmall(coinid: 1)
            : Container(
                width: 30.0,
                height: 30.0,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Icon(
                    Icons.edit,
                    size: 20.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
      ),
    );
  }
}
