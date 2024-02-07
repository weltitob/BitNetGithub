import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyThemeProvider extends ChangeNotifier{


  ThemeMode themeMode= ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleTheme(ThemeMode mode){
    themeMode= mode;
    notifyListeners();
  }

  void updateThemeInDatabase(ThemeMode mode){
    FirebaseFirestore.instance.collection("settings")
        .doc(FirebaseAuth.instance.currentUser!.uid).update({
      "theme" : mode == ThemeMode.light ? "Light" :
      mode == ThemeMode.dark ? "Dark" : "System",
    });
    themeMode = mode == ThemeMode.light ? ThemeMode.light :
    mode == ThemeMode.dark ? ThemeMode.dark : ThemeMode.system;
    notifyListeners();
  }

}


class MyThemes{

  static final darkTheme= ThemeData(
    scaffoldBackgroundColor: AppTheme.colorBackground,
    primaryColor: AppTheme.colorBackground,
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme= ThemeData(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.indigo,
    colorScheme: const ColorScheme.light(),
  );
}