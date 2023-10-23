import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/personalactionbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//All diffrent dialogs go here, they should have a consistent design

//ErrorDialog
Future<bool?> showErrorDialog({
  required BuildContext context,
  required String title,
  required String image,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        surfaceTintColor: Colors.red.withOpacity(0.25),
        backgroundColor: Colors.transparent,
        elevation: 20.0,
        insetPadding: EdgeInsets.all(0),
        child: Container(
          height: AppTheme.cardPadding * 13,
          width: AppTheme.cardPadding * 13,
          child: GlassContainer(
            borderThickness: 1.5, // remove border if not active
            blur: 50,
            opacity: 0.1,
            borderRadius: AppTheme.cardRadiusBig,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: AppTheme.elementSpacing * 2, bottom: AppTheme.elementSpacing * 2),
                      height: AppTheme.elementSpacing * 12,
                      width: AppTheme.elementSpacing * 12,
                      decoration: BoxDecoration(
                        borderRadius: AppTheme.cardRadiusBigger,
                        boxShadow: [
                          AppTheme.boxShadowSmall
                        ],
                      ),
                      child: Image.asset(image)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      personalActionButton(
                          context: context,
                          onPressed: () {
                            Navigator.pop(context);
                            //add a issue successfully reported thing or smth like this
                          },
                          iconData: FontAwesomeIcons.check,
                          gradientColors: [AppTheme.errorColor, AppTheme.errorColorGradient]
                      ),
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
        insetPadding: EdgeInsets.all(0),
        child: Container(
          height: AppTheme.cardPadding * 13,
          width: AppTheme.cardPadding * 13,
          child: GlassContainer(
            borderThickness: 1.5, // remove border if not active
            blur: 50,
            opacity: 0.1,
            borderRadius: AppTheme.cardRadiusBig,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: AppTheme.elementSpacing * 1.5, bottom: AppTheme.elementSpacing),
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
                          gradientColors: [AppTheme.errorColorGradient, AppTheme.errorColor,]
                      ),
                      personalActionButton(
                          context: context,
                          onPressed: () {
                            rightAction();
                            Navigator.pop(context);
                          },
                          iconData: FontAwesomeIcons.circleCheck,
                          gradientColors: [AppTheme.successColorGradient, AppTheme.successColor,]
                      ),
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
  required String text1,
  required String text2,
  required String text3,
  required String text4,
  required String image1,
  required String image2,
  required String image3,
  required String image4,
  dynamic action1,
  dynamic action2,
  dynamic action3,
  dynamic action4,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.cardRadiusBig,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (title != null)
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: AppTheme.elementSpacing / 2,
                        bottom: AppTheme.elementSpacing / 2),
                    child: Text(title,
                        style: Theme.of(context).textTheme.displaySmall),
                  )
                : Container(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OptionContainer(context, text1, action1, image: image1),
                    OptionContainer(context, text2, action2, image: image2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OptionContainer(
                      context,
                      text3,
                      action3,
                      image: image3,
                    ),
                    OptionContainer(context, text4, action4, image: image4),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(Icons.stop_rounded),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}