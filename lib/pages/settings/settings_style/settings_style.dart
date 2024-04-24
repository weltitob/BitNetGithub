import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';


import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:matrix/matrix.dart';
import 'settings_style_view.dart';

class SettingsStyle extends StatefulWidget {
  const SettingsStyle({Key? key}) : super(key: key);

  @override
  SettingsStyleController createState() => SettingsStyleController();
}

class SettingsStyleController extends State<SettingsStyle> {

  // create some values
 
  //
  // void onThemeChange(Color color, Brightness brightness) async {
  //   final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
  //   themeNotifier.getTheme;
  //
  //   themeNotifier.setTheme(AppTheme.customColorTheme(color, brightness));
  //   final pref = await SharedPreferences.getInstance();
  //   final colorString = colorToHex(color).toString();
  //   pref.setString("ThemeMode", colorString);
  //   pref.setString("Brightness", brightness.toString());
  //   syncWithThemeWithDatabase(colorString);
  // }

  //
  // void syncWithThemeWithDatabase(String color) async {
  //   try {
  //     //muss auch abchecken ob es schon eins gibt wenn ja muss es überschrieben werden
  //     //anosnten so hier neu reinadden
  //
  //     //need to switch true and false because we already changed the Brightness
  //     final bool isDarkMode =
  //     (Theme.of(context).brightness == Brightness.light) ? true : false;
  //
  //     final bool isCustomMode = true;
  //
  //     final theme = UserTheme(
  //       isDarkmode: isDarkMode,
  //       isCustomMode: false,
  //       customHexCode: color,
  //       userId: user!.uid,
  //     );
  //     await settingsCollection
  //         .doc(user!.uid)
  //         .collection("themeData")
  //         .doc("currentTheme")
  //         .set(theme.toJson());
  //     print('Successfully updated Theme in Database');
  //   } catch (e) {
  //     print('Something went wrong updating UserTheme in the database: $e');
  //   }
  // }



  @override
  Widget build(BuildContext context) => SettingsStyleView();
}
