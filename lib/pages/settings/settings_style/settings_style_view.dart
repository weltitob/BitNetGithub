import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/colorpicker.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/provider/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'settings_style.dart';

class SettingsStyleView extends StatelessWidget {
  final SettingsStyleController controller;

  const SettingsStyleView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorPickerSize = AppTheme.cardPadding * 1.5;
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.changeTheme,
        context: context,
        onTap: () {
          print("pressed");
          Provider.of<SettingsProvider>(context, listen: false)
              .switchTab('main');
        },
      ),
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: MaxWidthBody(
        withScrolling: true,
        child: Column(
          children: [
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Text(
              "Color",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            SizedBox(
              height: colorPickerSize + 24,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: SettingsStyleController.customColors
                    .map(
                      (color) => Padding(
                        padding: const EdgeInsets.all(AppTheme.elementSpacing),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(colorPickerSize),
                          onTap: (){
                            controller.setChatColor(color);
                            },
                          child: color == null
                              ? GestureDetector(
                                  onTap: () => showColorPickerDialouge(
                                    actionright: () {
                                      controller
                                          .setChatColor(controller.pickerColor);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      //onThemeChange(pickerColor, Theme.of(context).brightness);
                                    },
                                    actionleft: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    pickerColor:
                                        controller.currentColor ?? Colors.white,
                                    context: context,
                                    onColorChanged: controller.changeColor,
                                  ),
                                  child: Material(
                                    elevation:
                                        AppTheme.colorSchemeSeed?.value == null
                                            ? 100
                                            : 0,
                                    shadowColor: AppTheme.colorSchemeSeed,
                                    borderRadius:
                                        BorderRadius.circular(colorPickerSize),
                                    child: Image.asset(
                                      'assets/colors.png',
                                      width: colorPickerSize,
                                      height: colorPickerSize,
                                    ),
                                  ),
                                )
                              : Material(
                                  color: color,
                                  elevation: 6,
                                  borderRadius:
                                      BorderRadius.circular(colorPickerSize),
                                  child: SizedBox(
                                    width: colorPickerSize,
                                    height: colorPickerSize,
                                    child: controller.currentColor == color
                                        ? const Center(
                                            child: Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Text(
              "System Theme",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionContainer(
                  L10n.of(context)!.systemTheme,
                  () {
                    Provider.of<MyThemeProvider>(context, listen: false)
                        .updateThemeInDatabase(ThemeMode.system);
                  },
                  isActive: controller.currentTheme == ThemeMode.system,
                  image: "assets/images/iphone.png",
                  height: AppTheme.cardPadding * 5.5,
                  width: AppTheme.cardPadding * 4,
                ),
                SizedBox(
                  width: AppTheme.cardPadding,
                ),
                OptionContainer(
                  L10n.of(context)!.lightTheme,
                  () {
                    Provider.of<MyThemeProvider>(context, listen: false)
                        .updateThemeInDatabase(ThemeMode.light);
                  },
                  image: "assets/images/lightmode.png",
                  height: AppTheme.cardPadding * 5.5,
                  isActive: controller.currentTheme == ThemeMode.light,
                  width: AppTheme.cardPadding * 4,
                ),
                SizedBox(
                  width: AppTheme.cardPadding,
                ),
                OptionContainer(
                  L10n.of(context)!.darkTheme,
                  () {
                    Provider.of<MyThemeProvider>(context, listen: false)
                        .updateThemeInDatabase(ThemeMode.dark);
                  },
                  image: "assets/images/darkmode.png",
                  height: AppTheme.cardPadding * 5.5,
                  isActive: controller.currentTheme == ThemeMode.dark,
                  width: AppTheme.cardPadding * 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
