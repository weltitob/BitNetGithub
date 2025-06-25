import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CountryProvider extends ChangeNotifier {
  String? _country;
  void setCountryInDatabase(String country, {bool isUser = true}) {
    if (isUser) {
      settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "country": country,
      });
    }
    _country = country;
    notifyListeners();
  }

  void loadCountry() async {
    _country = (await settingsCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data()?['country'];
    notifyListeners();
  }

  String? getCountry() {
    return _country;
  }
}
