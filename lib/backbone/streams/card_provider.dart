import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardChangeProvider extends ChangeNotifier {
  String? _selectedCard;

  // Getters for currencies
  String? get selectedCard => _selectedCard;

  // Method to update the first currency and its corresponding Firestore document
  void setCardInDatabase(String selectedCard) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "selected_card": selectedCard,
    });
    _selectedCard = selectedCard;
    notifyListeners();
  }

  // Clear method adjusted to reset currency values
  void clearCard() {
    _selectedCard = null;
    notifyListeners();
  }
}
