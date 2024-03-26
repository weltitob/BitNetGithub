import 'package:flutter/material.dart';

class BalanceHideProvider extends ChangeNotifier{
  bool _hideBalance = false;

  bool? get hideBalance => _hideBalance;

  void setHideBalance(){
    _hideBalance = !_hideBalance;
    notifyListeners();
  }

}

