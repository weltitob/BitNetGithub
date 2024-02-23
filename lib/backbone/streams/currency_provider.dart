import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrencyChangeProvider extends ChangeNotifier {
  String? _selectedCurrency;

  // Getters for currencies
  String? get selectedCurrency => _selectedCurrency;

  // Method to update the first currency and its corresponding Firestore document
  void setFirstCurrencyInDatabase(String selectedCurrency) {
    FirebaseFirestore.instance.collection("settings")
        .doc(FirebaseAuth.instance.currentUser!.uid).update({
      "selectedCurrency": selectedCurrency,
    });
    _selectedCurrency = selectedCurrency;
    notifyListeners();
  }


  // Clear method adjusted to reset currency values
  void clearCurrencies() {
    _selectedCurrency = null;
    notifyListeners();
  }
}