import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BalanceHideProvider extends ChangeNotifier{
  bool _hideBalance = false;

  bool? get hideBalance => _hideBalance;

  void setHideBalance({bool? hide}){
    if(hide != null){
      _hideBalance = hide;
    }
    settingsCollection
        .doc(FirebaseAuth.instance.currentUser?.uid).update({
      "hide_balance": !_hideBalance,
    });
    _hideBalance = !_hideBalance;
    notifyListeners();
  }

}

