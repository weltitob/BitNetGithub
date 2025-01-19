import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());

    return Positioned(
      top: AppTheme.elementSpacing,
      right: AppTheme.elementSpacing,
      child: Align(
        child: Padding(
            padding: const EdgeInsets.only(
              right: AppTheme.cardPadding,
              top: AppTheme.cardPadding,
            ),
            child: Builder(
              builder: (context) {
                return RoundedButtonWidget(
                  size: AppTheme.cardPadding * 1.75,
                  buttonType: ButtonType.transparent,
                  iconData: Icons.brightness_low_rounded,
                  iconColor: Theme.of(context).brightness == Brightness.light
                      ? AppTheme.black70
                      : AppTheme.white90,
                  onTap: () {
                    BitNetBottomSheet(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height * 0.7,
                      context: context,
                      borderRadius: AppTheme.borderRadiusBig,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .canvasColor, // Add a background color here
                          borderRadius: new BorderRadius.only(
                            topLeft: AppTheme.cornerRadiusBig,
                            topRight: AppTheme.cornerRadiusBig,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.only(
                            topLeft: AppTheme.cornerRadiusBig,
                            topRight: AppTheme.cornerRadiusBig,
                          ),
                          child: Settings(),
                        ),
                      ),
                    );
                
                    //showSettingsBottomSheet(context: context);
                  },
                );
              }
            )),
      ),
    );
  }
}
