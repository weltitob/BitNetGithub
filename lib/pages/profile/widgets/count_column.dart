import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountColumn extends StatelessWidget {
  final int count;
  final String label;
  const CountColumn({required this.count, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return controller.isUserLoading.value
        ? Container()
        : MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: AppTheme.cardRadiusMid),
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: AppTheme.elementSpacing / 4,
                ),
                Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: AppTheme.white90),
                ),
                const SizedBox(
                  height: AppTheme.elementSpacing / 4,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.white70, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: AppTheme.elementSpacing / 4,
                ),
              ],
            ),
          );
    ;
  }
}
