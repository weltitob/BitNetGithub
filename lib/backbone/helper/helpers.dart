import 'dart:math';

import 'package:bitnet/pages/auth/restore/did_and_pk/didandpkscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

enum MediaType { image, audio, camera, document, pdf, text, link, sticker, location, wallet }

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}


final datetime = DateTime.now();
Timestamp timestamp = Timestamp.fromDate(datetime); //To TimeStamp

bool isStringaDID(String input) {
  RegExp didPattern = RegExp(r'^did:[a-zA-Z0-9]+:[A-Za-z0-9._-]{22,}$', caseSensitive: false);
  return didPattern.hasMatch(input);
}

bool isStringALNInvoice(String input) {
  RegExp lnInvoicePattern = RegExp(r'^ln[a-zA-Z0-9]+[0-9]{1,}[a-zA-Z0-9]*$', caseSensitive: false);
  return lnInvoicePattern.hasMatch(input);
}

bool isLightningAdressAsMail(String input) {
  RegExp lightningAddressPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', caseSensitive: false);
  return lightningAddressPattern.hasMatch(input);
}


String getRandomString(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
//if already exists dont know if would actually be an problem

//new generated codes need to be added to pesons own profile and als with used and unused
//also needs to get added in sperate stroagepoint where there simply are all codes and info if theyre already used
}

var uuid = Uuid();

// Load Lottie composition from an asset file
Future<LottieComposition> loadComposition(String assetPath) async {
  var assetData = await rootBundle.load(assetPath);
  dynamic mycomposition = await LottieComposition.fromByteData(assetData);
  return mycomposition;
}

// Get the current time in milliseconds
int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}

// Get the average price of a list of items
getaverage(dynamic currentline) {
  return currentline.map((m) => m.price).reduce((a, b) => a + b) /
      currentline.length;
}

// Display the time ago from a timestamp
String displayTimeAgoFromTimestamp(String publishedAt,
    {bool numericDates = true}) {
  DateTime date = DateTime.parse(publishedAt);
  final date2 = DateTime.now();
  final difference = date2.difference(date);

  if ((difference.inDays / 365).floor() >= 2) {
    return 'vor ${(difference.inDays / 365).floor()} Jahren';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? 'Vor 1 Jahr' : 'Letztes Jahr';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return 'vor ${(difference.inDays / 365).floor()} Monaten';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? 'Vor 1 Monat' : 'Letzter Monat';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return 'vor ${(difference.inDays / 7).floor()} Wochen';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? 'vor 1 Woche' : 'Letzte Woche';
  } else if (difference.inDays >= 2) {
    return 'vor ${difference.inDays} Tagen';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? 'vor 1 Tag' : 'Gestern';
  } else if (difference.inHours >= 2) {
    return 'vor ${difference.inHours} Stunden';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? 'vor 1 Stunde' : 'vor einer Stunde';
  } else if (difference.inMinutes >= 2) {
    return 'vor ${difference.inMinutes} Minuten';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? 'vor 1 Minute' : 'vor einer Minute';
  } else if (difference.inSeconds >= 3) {
    return 'vor ${difference.inSeconds} Sekunden';
  } else {
    return 'Gerade eben';
  }
}
String displayTimeAgoFromInt(int time, {bool numericDates = true}) {
  // Convert the string timestamp to an integer and then to milliseconds
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  final DateTime date2 = DateTime.now();
  final Duration difference = date2.difference(date);

  // The rest of your logic remains the same
  if ((difference.inDays / 365).floor() >= 2) {
    return 'vor ${(difference.inDays / 365).floor()} Jahren';
  } else if ((difference.inDays / 365).floor() >= 1) {
    return (numericDates) ? 'Vor 1 Jahr' : 'Letztes Jahr';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return 'vor ${(difference.inDays / 30).floor()} Monaten';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? 'Vor 1 Monat' : 'Letzter Monat';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return 'vor ${(difference.inDays / 7).floor()} Wochen';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? 'vor 1 Woche' : 'Letzte Woche';
  } else if (difference.inDays >= 2) {
    return 'vor ${difference.inDays} Tagen';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? 'vor 1 Tag' : 'Gestern';
  } else if (difference.inHours >= 2) {
    return 'vor ${difference.inHours} Stunden';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? 'vor 1 Stunde' : 'vor einer Stunde';
  } else if (difference.inMinutes >= 2) {
    return 'vor ${difference.inMinutes} Minuten';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? 'vor 1 Minute' : 'vor einer Minute';
  } else if (difference.inSeconds >= 3) {
    return 'vor ${difference.inSeconds} Sekunden';
  } else {
    return 'Gerade eben';
  }
}

// Format a double value as a percentage string
String toPercent(double value) => NumberFormat('+#.##%; -#.##%').format(value);

// Format the input value within a specified numerical range, and display a snackbar if the value exceeds the maximum
// This class formats a numerical input value within a specified range, and displays a snackbar if the value exceeds the maximum
// It extends the TextInputFormatter class, which is used to modify the text being entered into a text field
class NumericalRangeFormatter extends TextInputFormatter {
  final double min; // The minimum value allowed
  final double max; // The maximum value allowed
  final BuildContext
      context; // The context of the widget where the formatter is being used

  NumericalRangeFormatter({
    required this.min,
    required this.max,
    required this.context,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, return it without any modifications
    if (newValue.text == '') {
      return newValue;
    }
    // If the new value is less than the minimum allowed, set it to the minimum value
    else if (double.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toString());
    }
    // If the new value is greater than the maximum allowed, display a snackbar and set the value to the old value
    else if (double.parse(newValue.text) > max) {
      return oldValue;
    }
    // Otherwise, return the new value without any modifications
    else {
      return newValue;
    }
  }
}

// This class formats a numerical input value to allow only one decimal point
class DotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int numDots = RegExp(r"\.").allMatches(oldValue.toString()).length;
    print("The string '$oldValue' contains $numDots dots.");

    int newDots = RegExp(r"\.").allMatches(newValue.toString()).length;
    print("The string '$newValue' contains $newDots dots.");

    // If the old value already contains 3 or more decimal points, return the old value without any modifications
    if (numDots >= 3) {
      return oldValue;
    }
    // If the new value has exactly 2 decimal points, return it without any modifications
    else if (newDots == 2) {
      return newValue;
    }
    // If the new value has exactly 3 decimal points, return it without any modifications
    else if (newDots == 3) {
      return newValue;
    }
    // If the new value has more than 3 decimal points, return the old value without any modifications
    else if (newDots > 3) {
      return oldValue;
    }
    // Otherwise, return the new value without any modifications
    else {
      return newValue;
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
