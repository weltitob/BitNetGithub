import 'dart:ui';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

class LocalProvider extends ChangeNotifier {
  Locale? _locale;
  Locale get locale => _locale ?? PlatformDispatcher.instance.locale;

  void setLocaleInDatabase(String langCode, Locale locale, {bool isUser = true}) {
    if (!L10n.supportedLocales.contains(locale)) {
      return;
    }
    if (isUser) {
      settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "lang": langCode,
      });
    }
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
