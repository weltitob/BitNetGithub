import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';

int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}

getaverage(dynamic currentline) {
  return currentline.map((m) => m.price).reduce((a, b) => a + b) /
      currentline.length;
}

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

String toPercent(double value) => NumberFormat('+#.##%; -#.##%').format(value);

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;
  final BuildContext context;

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
    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toString());
    } else if (double.parse(newValue.text) > max) {
      displaySnackbar(context, "You dont have enough Bitcoin");
      return oldValue;
    } else
      return newValue;
  }
}

class DotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int numDots = RegExp(r"\.").allMatches(oldValue.toString()).length;
    print("The string '$oldValue' contains $numDots dots.");

    int newDots = RegExp(r"\.").allMatches(newValue.toString()).length;
    print("The string '$newValue' contains $newDots dots.");

    //flutter thinks there are two more dots then there really are
    if (numDots >= 3) {
      return oldValue;
    } else if (newDots == 2) {
      return newValue;
    } else if (newDots == 3) {
      return newValue;
    } else if (newDots > 3) {
      return oldValue;
    } else
      return newValue;
  }
}
