import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/colorpicker.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

class SettingsStyleView extends GetWidget<SettingsController> {
  const SettingsStyleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorPickerSize = AppTheme.cardPadding * 1.5;

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.changeTheme,
        buttonType: ButtonType.transparent,
        context: context,
        onTap: () {
          controller.switchTab('main');
        },
      ),
      body: MaxWidthBody(
        withScrolling: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppTheme.cardPadding * 3,
              ),
              Text(
                L10n.of(context)!.color,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: AppTheme.elementSpacing,
              ),
              SizedBox(
                height: colorPickerSize + 24,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: controller.customColors
                      .map(
                        (color) => Padding(
                          padding:
                              const EdgeInsets.all(AppTheme.elementSpacing),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(colorPickerSize),
                            onTap: () {
                              controller.setChatColor(color, context);
                            },
                            child: color == null
                                ? GestureDetector(
                                    onTap: () => showColorPickerDialouge(
                                      actionright: () {
                                        controller.setChatColor(
                                            controller.pickerColor.value,
                                            context);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      actionleft: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      pickerColor:
                                          controller.currentColor(context) ??
                                              Colors.white,
                                      context: context,
                                      onColorChanged: controller.changeColor,
                                    ),
                                    child: Material(
                                      elevation:
                                          AppTheme.colorSchemeSeed?.value ==
                                                  null
                                              ? 100
                                              : 0,
                                      shadowColor: AppTheme.colorSchemeSeed,
                                      borderRadius: BorderRadius.circular(
                                          colorPickerSize),
                                      child: Image.asset(
                                        'assets/colors.png',
                                        width: colorPickerSize,
                                        height: colorPickerSize,
                                      ),
                                    ),
                                  )
                                : color == Colors.white
                                    ? ColorCircle()
                                    : Material(
                                        color: color,
                                        elevation: 6,
                                        borderRadius: BorderRadius.circular(
                                            colorPickerSize),
                                        child: SizedBox(
                                          width: colorPickerSize,
                                          height: colorPickerSize,
                                          child:
                                              controller.currentColor == color
                                                  ? const Center(
                                                      child: Icon(
                                                        Icons.check,
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
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.systemTheme,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: AppTheme.elementSpacing,
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBitNetImageWithTextContainer(
                      L10n.of(context)!.systemTheme,
                      () {
                        controller.switchTheme(ThemeMode.system, context);
                        controller.selectedTheme.value = ThemeMode.system;
                      },
                      isActive:
                          controller.selectedTheme.value == ThemeMode.system,
                      image: "assets/images/system_theme.png",
                      height: AppTheme.cardPadding * 5.25,
                      width: AppTheme.cardPadding * 4,
                    ),
                    const SizedBox(
                      width: AppTheme.cardPadding,
                    ),
                    AnimatedBitNetImageWithTextContainer(
                      L10n.of(context)!.lightTheme,
                      () {
                        controller.switchTheme(ThemeMode.light, context);
                        controller.selectedTheme.value = ThemeMode.light;
                      },
                      image: "assets/images/sun_theme.png",
                      height: AppTheme.cardPadding * 5.25,
                      isActive:
                          controller.selectedTheme.value == ThemeMode.light,
                      width: AppTheme.cardPadding * 4,
                    ),
                    const SizedBox(
                      width: AppTheme.cardPadding,
                    ),
                    AnimatedBitNetImageWithTextContainer(
                      L10n.of(context)!.darkTheme,
                      () {
                        controller.switchTheme(ThemeMode.dark, context);
                        controller.selectedTheme.value = ThemeMode.dark;
                      },
                      image: "assets/images/moon_theme.png",
                      height: AppTheme.cardPadding * 5.25,
                      isActive:
                          controller.selectedTheme.value == ThemeMode.dark,
                      width: AppTheme.cardPadding * 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double colorPickerSize = 30.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          elevation: 6,
          borderRadius: BorderRadius.circular(colorPickerSize),
          child: SizedBox(
            width: colorPickerSize,
            height: colorPickerSize,
            child: CustomPaint(
              painter: CirclePainter(),
            ),
          ),
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    final Paint paint = Paint();

    // Draw white slice
    paint.color = Colors.white;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0,
        2 * 3.14 / 3, true, paint);

    // Draw black slice
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        2 * 3.14 / 3, 2 * 3.14 / 3, true, paint);

    // Draw colorBitcoin slice
    paint.color = AppTheme.colorBitcoin;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        4 * 3.14 / 3, 2 * 3.14 / 3, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
