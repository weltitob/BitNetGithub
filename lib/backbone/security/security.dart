import 'package:shared_preferences/shared_preferences.dart';

Future<bool> SharedPrefSecurityCheck() async {
  // Überprüfen Sie den Authentifizierungsstatus des Nutzers
  // z.B. durch Token-Check oder Zugriff auf Anmeldestatus in der Datenbank.
  // Wenn der Nutzer angemeldet ist, geben Sie true zurück, andernfalls false.
  // Hier ein Beispiel mit SharedPreferences:

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isSecurityChecked') ?? false;
  return isLoggedIn;
}

Future<void> checkSecurityStatus() async {
  bool isSecurityChecked = await SharedPrefSecurityCheck();
  if (isSecurityChecked) {
    //blabla
  } else {
    //blabla
  }
}