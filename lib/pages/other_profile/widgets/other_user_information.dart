import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

class OtherUserInformation extends StatelessWidget {
  const OtherUserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherProfileController>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
        child: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: AppTheme.elementSpacing / 2,
              ),
              controller.currentview.value == 2
                  ? GlassContainer(
                      customColor: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.5) : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            isDense: true,
                            border: InputBorder.none,
                            errorText: controller.displayNameValid.value ? null : L10n.of(context)!.badCharacters,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppTheme.white70,
                              ),
                          controller: controller.userNameController,
                        ),
                      ),
                    )
                  : TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        isDense: true,
                        border: InputBorder.none,
                        errorText: controller.displayNameValid.value ? null : L10n.of(context)!.badCharacters,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.white70,
                          ),
                      controller: controller.userNameController,
                    ),
              const SizedBox(height: AppTheme.cardPadding - 4),
              controller.currentview.value == 2
                  ? GlassContainer(
                      customColor: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.5) : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              isDense: true,
                              border: InputBorder.none,
                              errorText: controller.displayNameValid.value ? null : L10n.of(context)!.coudntChangeUsername),
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppTheme.white90),
                          controller: controller.displayNameController,
                        ),
                      ),
                    )
                  : TextField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          isDense: true,
                          border: InputBorder.none,
                          errorText: controller.displayNameValid.value ? null : L10n.of(context)!.coudntChangeUsername),
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppTheme.white90),
                      controller: controller.displayNameController,
                    ),
              const SizedBox(height: 4),
              controller.currentview.value == 2
                  ? GlassContainer(
                      customColor: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.5) : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppTheme.white70),
                          controller: controller.bioController,
                        ),
                      ),
                    )
                  : TextField(
                      readOnly: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppTheme.white70),
                      controller: controller.bioController,
                    ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
            ],
          ),
        ));
  }
}
