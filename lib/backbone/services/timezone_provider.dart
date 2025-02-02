import 'dart:ui';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:timezone/timezone.dart';

class TimezoneProvider extends ChangeNotifier {
  Location? _timeZone;
  Location get timeZone => _timeZone ?? getLocation("UTC");

  void setTimezoneInDatabase(Location timeZone, {bool isUser = true}) {
    if (isUser) {
      settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        "timezone": timeZone.name,
      });
    }
    _timeZone = timeZone;
    notifyListeners();
  }

  void clearTimeZone() {
    _timeZone = null;
    notifyListeners();
  }
}
