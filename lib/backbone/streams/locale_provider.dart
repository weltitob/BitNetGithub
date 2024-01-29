import 'package:flutter/material.dart';
import 'package:bitnet/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier{
  Locale ? _locale;
  Locale? get locale => _locale;

  void setLocale(Locale locale){
    if(!L10n.all.contains(locale))return;
    _locale = locale;
    notifyListeners();
  }


  void setLocale3(Locale value) {
    _locale = value;
    notifyListeners();
  }

  // void setLocale2(String langName,Locale locale){
  //   if(langName == 'English'){
  //     FirebaseFirestore.instance.collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid).update({
  //       "lang" : "French" ,
  //     });
  //     _locale = locale;
  //   }else{
  //     FirebaseFirestore.instance.collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid).update({
  //       "lang" : "English" ,
  //     });
  //     _locale = locale;
  //   }
  //   notifyListeners();
  // }

  void clearLocale(){
    _locale= null as Locale;
    notifyListeners();
  }
}