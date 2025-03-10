import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LongButtonWidget(
                  title: "Cancel",
                  onTap: actionleft,
                  customWidth: AppTheme.cardPadding * 5,
                  customHeight: AppTheme.cardPadding * 2,
                  buttonType: ButtonType.transparent,
                  textColor: AppTheme.errorColor,
                  leadingIcon: Icon(Icons.stop_rounded, color: AppTheme.errorColor, size: 16),
                ),
                LongButtonWidget(
                  title: "Apply",
                  onTap: actionright,
                  customWidth: AppTheme.cardPadding * 5,
                  customHeight: AppTheme.cardPadding * 2,
                  buttonType: ButtonType.transparent,
                  textColor: AppTheme.successColor,
                  leadingIcon: Icon(Icons.done_rounded, color: AppTheme.successColor, size: 16),
                ),
              ],
            ),
          ],
        ),
        elevation: 20.0,
      );
    },
  );
}