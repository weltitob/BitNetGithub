import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrencyTypeProvider extends ChangeNotifier {
  bool? _coin;

  // Getters for currencies
  bool? get coin => _coin;

  // Method to update the first currency and its corresponding Firestore document
  void setCurrencyType(bool type) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "showCoin": type,
    });
    _coin = type;
    notifyListeners();
  }

  // Clear method adjusted to reset currency values
  void clearCurrencyType() {
    _coin = false;
    notifyListeners();
  }
}
