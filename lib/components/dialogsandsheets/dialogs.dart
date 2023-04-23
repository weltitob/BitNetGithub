import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                    backgroundColor: MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Text("REPORT", style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.errorColor),
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
  required bool isfunction,
  required String image,
  dynamic actionleft,
  String? action2Text,
  required dynamic actionright,
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
                child: Image.asset(image)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: isfunction ? (){actionleft;
                  Navigator.pop(context);} : actionleft,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(Icons.stop_rounded),
                ),
                ElevatedButton(
                  onPressed: isfunction ? (){actionright;
                  Navigator.pop(context);} : actionright,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.successColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(Icons.done_rounded),
                )
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
            (title != null) ? Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Text(title, style: Theme.of(context).textTheme.headline3),
            ) : Container(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OptionContainer(context, image1, text1, action1),
                    OptionContainer(context, image2, text2, action2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OptionContainer(context, image3, text3, action3),
                    OptionContainer(context, image4, text4, action4),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.errorColor),
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

Widget OptionContainer(BuildContext context, String image, String text, action) {
  return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppTheme.cardRadiusMid,
        boxShadow: [
          AppTheme.boxShadowProfile
        ],
      ),
      child: Material(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: AppTheme.cardRadiusMid,
          child: InkWell(
            onTap: () {print('TEST');},
            borderRadius: AppTheme.cardRadiusMid,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(image),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing),
                  child: Text(text,
                      style: Theme.of(context).textTheme.caption),
                )
              ],
            ),
          )));
}