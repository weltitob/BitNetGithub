import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/dialogsandsheets/colorpicker.dart';
import 'package:BitNet/main.dart';
import 'package:BitNet/models/user/usertheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
// create some values
  Color pickerColor = Color(0xff443a49);
  final user = Auth().currentUser;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void onThemeChange(Color color, Brightness brightness) async {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.getTheme;

    themeNotifier.setTheme(AppTheme.customColorTheme(color, brightness));
    final pref = await SharedPreferences.getInstance();
    final colorString = colorToHex(color).toString();
    pref.setString("ThemeMode", colorString);
    pref.setString("Brightness", brightness.toString());
    syncWithThemeWithDatabase(colorString);
  }


  void syncWithThemeWithDatabase(String color) async {
    try {
      //muss auch abchecken ob es schon eins gibt wenn ja muss es überschrieben werden
      //anosnten so hier neu reinadden

      //need to switch true and false because we already changed the Brightness
      final bool isDarkMode =
      (Theme.of(context).brightness == Brightness.light) ? true : false;

      final bool isCustomMode = true;

      final theme = UserTheme(
        isDarkmode: isDarkMode,
        isCustomMode: false,
        customHexCode: color,
        userId: user!.uid,
      );
      await settingsCollection
          .doc(user!.uid)
          .collection("themeData")
          .doc("currentTheme")
          .set(theme.toJson());
      print('Successfully updated Theme in Database');
    } catch (e) {
      print('Something went wrong updating UserTheme in the database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 55, vertical: AppTheme.cardPadding),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LightMode",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Switcher(
                value: false,
                size: SwitcherSize.medium,
                switcherButtonRadius: 50,
                enabledSwitcherButtonRotate: true,
                iconOff: Icons.sunny,
                iconOn: Icons.dark_mode,
                colorOff: Colors.grey,
                colorOn: Colors.grey.shade800,
                onChanged: (bool state) {
                  onThemeChange(
                      Theme.of(context).primaryColor,
                      (Theme.of(context).brightness == Brightness.dark)
                          ? Brightness.light
                          : Brightness.dark);
                },
              ),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Text(
                "DarkMode",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: AppTheme.cardPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Standard",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Switcher(
                value: false,
                size: SwitcherSize.medium,
                switcherButtonRadius: 50,
                enabledSwitcherButtonRotate: true,
                iconOff: Icons.lock,
                iconOn: Icons.lock_open_rounded,
                colorOff: AppTheme.colorBitcoin,
                colorOn: pickerColor,
                onChanged: (bool state) {
                },
              ),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Text(
                "Custom",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.cardPadding * 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
          child: LongButtonWidgetTransparent(title: "Change Custom Color", onTap:
              () => showColorPickerDialouge(
            actionright: () {
              Navigator.of(context, rootNavigator: true).pop();
              onThemeChange(pickerColor, Theme.of(context).brightness);
            },
            actionleft: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            pickerColor: pickerColor,
            context: context,
            onColorChanged: changeColor,
          ),),
        )
      ],
    );
  }

  Widget buildDefaultColor(Color color, String text) {
    return GestureDetector(
      onTap: () {
        //select element make it bigger or animate and also circle around
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            child: Container(
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.circle,
                      size: AppTheme.iconSize,
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}