import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrencyChangeProvider extends ChangeNotifier {
  String? _firstCurrency;
  String? _secondCurrency;

  // Getters for currencies
  String? get firstCurrency => _firstCurrency;
  String? get secondCurrency => _secondCurrency;

  // Method to update the first currency and its corresponding Firestore document
  void setFirstCurrencyInDatabase(String firstCurrency) {
    FirebaseFirestore.instance.collection("settings")
        .doc(FirebaseAuth.instance.currentUser!.uid).update({
      "firstCurrency": firstCurrency,
    });
    _firstCurrency = firstCurrency;
    notifyListeners();
  }

  // Method to update the second currency and its corresponding Firestore document
  void setSecondCurrencyInDatabase(String secondCurrency) {
    FirebaseFirestore.instance.collection("settings")
        .doc(FirebaseAuth.instance.currentUser!.uid).update({
      "secondCurrency": secondCurrency,
    });
    _secondCurrency = secondCurrency;
    notifyListeners();
  }

  // Clear method adjusted to reset currency values
  void clearCurrencies() {
    _firstCurrency = null;
    _secondCurrency = null;
    notifyListeners();
  }
}