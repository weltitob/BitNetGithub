import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//All diffrent dialogs go here, they should have a consistent design

//ErrorDialog

Future<bool?> showErrorDialog({
  required BuildContext context,
  required String title,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline3),
            Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                height: 140,
                width: 140,
                child: Image.asset("images/error_triangle.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //add a issue sucessfully reported thing or smth like this
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Text(
                    "REPORT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
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
        elevation: 20.0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
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
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.cardRadiusBig,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            Container(
                padding: EdgeInsets.only(
                    top: AppTheme.cardPadding, bottom: AppTheme.elementSpacing),
                height: AppTheme.elementSpacing * 12,
                width: AppTheme.elementSpacing * 12,
                child: Image.asset(image)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    leftAction();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(
                    FontAwesomeIcons.cancel,
                    color: AppTheme.white70,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    rightAction();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.successColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(
                    FontAwesomeIcons.check,
                    color: AppTheme.white70,
                  ),
                )
              ],
            ),
          ],
        ),
        elevation: AppTheme.cardPadding,
        backgroundColor: AppTheme.white90,
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
        elevation: 20.0,
        backgroundColor: Theme.of(context).colorScheme.background,
      );
    },
  );
}
