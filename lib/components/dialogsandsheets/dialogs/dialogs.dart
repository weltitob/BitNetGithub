import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/personalactionbutton.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//All diffrent dialogs go here, they should have a consistent design

// Classic dialog 2 options
Future<bool?> showDialogue({
  required BuildContext context,
  required String title,
  required String image,
  required VoidCallback leftAction,
  required VoidCallback rightAction,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 20.0,
        insetPadding: const EdgeInsets.all(0),
        child: Container(
          height: AppTheme.cardPadding * 13,
          width: AppTheme.cardPadding * 13,
          child: GlassContainer(
            borderThickness: 1.5, // remove border if not active
            blur: 50,
            opacity: 0.1,
            borderRadius: AppTheme.cardRadiusBig,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.elementSpacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          top: AppTheme.elementSpacing * 1.5,
                          bottom: AppTheme.elementSpacing),
                      height: AppTheme.elementSpacing * 12,
                      width: AppTheme.elementSpacing * 12,
                      child: Image.asset(image)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      personalActionButton(
                          context: context,
                          onPressed: () {
                            leftAction();
                            Navigator.pop(context);
                          },
                          iconData: FontAwesomeIcons.cancel,
                          gradientColors: [
                            AppTheme.errorColorGradient,
                            AppTheme.errorColor,
                          ]),
                      personalActionButton(
                          context: context,
                          onPressed: () {
                            rightAction();
                            Navigator.pop(context);
                          },
                          iconData: FontAwesomeIcons.circleCheck,
                          gradientColors: [
                            AppTheme.successColorGradient,
                            AppTheme.successColor,
                          ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<bool?> showDialogueMultipleOptions({
  required BuildContext context,
  String? title,
  List<String?> texts = const [],
  List<String?> images = const [],
  List<bool> isActives = const [],
  List<Function(BuildContext)?> actions = const [],
}) {
  return showDialog(
    context: context,
    builder: (context) {
      // Ensure there are 4 items in all lists for consistency
      int length = texts.length;
      List<Widget> optionContainers = List.generate(
        length,
        (index) {
          if (index < length &&
              texts[index] != null &&
              images[index] != null &&
              actions[index] != null) {
            return BitNetImageWithTextContainer(
              isActive: index < isActives.length ? isActives[index] : true,
              height: AppTheme.cardPadding * 4.5,
              width: AppTheme.cardPadding * 4.5,
              texts[index]!,
              () {
                actions[index]!(context);
              },
              image: images[index]!,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

      List<Widget> rows = [];
      for (int i = 0; i < optionContainers.length; i += 2) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              optionContainers[i],
              if (i + 1 < optionContainers.length) ...[
                const SizedBox(width: AppTheme.elementSpacing),
                optionContainers[i + 1],
              ]
            ],
          ),
        );
        if (i + 2 < optionContainers.length)
          rows.add(const SizedBox(height: AppTheme.elementSpacing));
      }

      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: AppTheme.colorSchemeSeed,
        contentPadding: const EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.cardRadiusBig,
        ),
        content: GlassContainer(
          borderRadius: AppTheme.cardRadiusBig,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              bitnetAppBar(
                  context: context,
                  text: title ?? "Choose an option",
                  customIcon: Icons.close,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                child: Column(children: rows),
              ),
            ],
          ),
        ),
      );
    },
  );
}
