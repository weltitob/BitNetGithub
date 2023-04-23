import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<bool?> showColorPickerDialouge({
  required BuildContext context,
  required Color pickerColor,
  required Function() actionleft,
  required Function() actionright,
  required onColorChanged,
}) {

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(200.0),
              topRight: Radius.circular(200.0),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24)
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HueRingPicker(
              enableAlpha: false,
              hueRingStrokeWidth: 22,
              colorPickerHeight: AppTheme.iconSize * 10,
              portraitOnly: false,
              pickerColor: pickerColor,
              onColorChanged: onColorChanged,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: actionleft,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.errorColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: Icon(Icons.stop_rounded),
                ),
                ElevatedButton(
                  onPressed: actionright,
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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      );
    },
  );
}