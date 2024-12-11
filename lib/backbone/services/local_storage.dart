import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage instance = LocalStorage();
  LocalStorage();
  late final SharedPreferences prefs;
  Future<void> initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool getBool(String id) {
    return prefs.getBool(id) ?? false;
  }

  void setBool(bool val, String id) {
    prefs.setBool(id, val);
  }

  String? getString(String id) {
    return prefs.getString(id);
  }

  void setString(String val, String id) {
    prefs.setString(id, val);
  }

  void setStringList(List<String> strings, String id) {
    prefs.setStringList(id, strings);
  }

  List<String>? getStringList(String id) {
    return prefs.getStringList(id);
  }
}
