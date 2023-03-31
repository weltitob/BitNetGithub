import 'package:shared_preferences/shared_preferences.dart';

// checks the authentificationstatus with SharedPreferences
Future<bool> SharedPrefSecurityCheck() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isSecurityChecked') ?? false;
  return isLoggedIn;
}

Future<void> checkSecurityStatus() async {
  bool isSecurityChecked = await SharedPrefSecurityCheck();
  if (isSecurityChecked) {
  } else {
  }
}