import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(200.0),
              topRight: Radius.circular(200.0),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24)
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //deprecated replace with new color
            HueRingPicker(
              enableAlpha: false,
              displayThumbColor: true,
              hueRingStrokeWidth: AppTheme.cardPadding,
              colorPickerHeight: AppTheme.iconSize * 8.5,
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
                    backgroundColor: WidgetStateProperty.all(AppTheme.errorColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: const Icon(Icons.stop_rounded),
                ),
                ElevatedButton(
                  onPressed: actionright,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppTheme.successColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                  child: const Icon(Icons.done_rounded),
                )
              ],
            ),
          ],
        ),
        elevation: 20.0,
      );
    },
  );
}