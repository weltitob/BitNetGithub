import 'dart:convert';
import 'dart:math';

import 'package:bip39/bip39.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/auth/restore/did_and_pk/didandpkscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

//camera, image_png, image_jpeg, gif, webp, audio_wav, audio_mp3, text, description, document, pdf, extenal_url, link, sticker, location, wallet
enum MediaType {
  youtube_url,
  spotify_url,
  instagram_url,
  instagram,
  twitter_url,
  youtubemusic_url,
  image,
  image_data,
  description,
  collection,
  text,
  audio,
  external_url,
  attributes,
  document,
  wallet_address
}

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

bool isCompressedPublicKey(String input) {
  // Compressed public keys in hex format are 66 characters long
  // They start with '02' or '03', followed by 64 hex characters (32 bytes)
  RegExp compressedKeyPattern = RegExp(r'^(02|03)[0-9a-fA-F]{64}$');
  return compressedKeyPattern.hasMatch(input);
}

bool isValidBitcoinTransactionID(String input) {
  RegExp txidPattern = RegExp(r'^[a-zA-Z0-9]{64}$');
  return txidPattern.hasMatch(input);
}

bool isValidBitcoinAddressHash(String input) {
  RegExp blockHashPattern = RegExp(
    r'^[a-zA-Z0-9]{62}$',
    caseSensitive: false,
  );
  return blockHashPattern.hasMatch(input);
}

bool containsSixIntegers(String input) {
  RegExp sixIntegersPattern = RegExp(r'^\d{6}$');
  return sixIntegersPattern.hasMatch(input);
}

bool isStringALNInvoice(String input) {
  RegExp lnInvoicePattern =
      RegExp(r'^ln[a-zA-Z0-9]+[0-9]{1,}[a-zA-Z0-9]*$', caseSensitive: false);
  return lnInvoicePattern.hasMatch(input);
}

bool isLightningAdressAsMail(String input) {
  RegExp lightningAddressPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false);
  return lightningAddressPattern.hasMatch(input);
}

bool isBip21WithBolt11(String input) {
  if (input.startsWith("bitcoin:")) {
    Uri? uri = Uri.tryParse(input);
    if (uri != null) {
      String? lightningParam = uri.queryParameters["lightning"];

      if (lightningParam != null) {
        if (lightningParam.startsWith("LNBC") &&
            isBitcoinWalletValid(uri.path)) {
          return true;
        }
      }
    }
  }
  return false;
}

bool isBip21WithBolt12(String input) {
  if (input.startsWith("bitcoin:")) {
    Uri? uri = Uri.tryParse(input);
    if (uri != null) {
      String? lightningParam = uri.queryParameters["lightning"];

      if (lightningParam != null) {
        if (lightningParam.startsWith("LNO")) {
          return true;
        }
      }
    }
  }
  return false;
}

bool isStringPrivateDataFunc(String input) {
  try {
    Map<String, dynamic> data = jsonDecode(input);
    PrivateData.fromJson(data);
    return true;
  } catch (e) {
    String mnemonic = input;
    if (validateMnemonic(mnemonic)) {
      return true;
    }

    return false;
  }
}

String getRandomString(int length) {
  Random random = Random();
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
//if already exists dont know if would actually be an problem

//new generated codes need to be added to pesons own profile and als with used and unused
//also needs to get added in sperate stroagepoint where there simply are all codes and info if theyre already used
}

var uuid = const Uuid();

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

String convertIntoDateFormat(int time) {
  // Convert the timestamp to DateTime
  final logger = Get.find<LoggerService>();
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  // Format the DateTime object to a readable string
  String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(date);
  logger.i("Formatted date: $formattedDate");
  return formattedDate;
}

// Format a double value as a percentage string
String toPercent(double value) => NumberFormat('+#.##%; -#.##%').format(value);

void scrollToSearchFunc(ScrollController ctrl, FocusNode node) {
  if (ctrl.position.pixels <= -100 && !node.hasFocus) {
    ctrl.jumpTo(0);
    node.requestFocus();
    Vibration.vibrate();
  }
}

Future<String?> extractLogoUrl(String baseUrl) async {
  final response = await http.get(Uri.parse(baseUrl));
  dynamic htmlContent;
  if (response.statusCode == 200) {
    htmlContent = response.body;
  } else {
    return null;
  }
  final document = parser.parse(htmlContent);

  // Try to find <link rel="icon"> or <link rel="shortcut icon"> tags
  var iconLink = document
          .querySelector('link[rel="icon"]')
          ?.attributes['href'] ??
      document.querySelector('link[rel="shortcut icon"]')?.attributes['href'] ??
      document
          .querySelector('link[rel="apple-touch-icon"]')
          ?.attributes['href'];

  if (iconLink != null) {
    return Uri.parse(baseUrl).resolve(iconLink).toString();
  }

  // If no icon link is found, try to find <meta property="og:image"> tag
  var ogImage = document
      .querySelector('meta[property="og:image"]')
      ?.attributes['content'];
  if (ogImage != null) {
    return Uri.parse(baseUrl).resolve(ogImage).toString();
  }

  return null;
}

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
      return const TextEditingValue().copyWith(text: min.toString());
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
