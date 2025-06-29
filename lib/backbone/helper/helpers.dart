import 'dart:convert';
import 'dart:math';

import 'package:bip39/bip39.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

// Vibration helper class for consistent haptic feedback across the app
class HapticFeedback {
  // Standard feedback for UI interactions
  static Future<void> lightImpact() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(duration: 20, amplitude: 40);
      } else {
        Vibration.vibrate();
      }
    }
  }

  // Medium feedback for confirmations
  static Future<void> mediumImpact() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(duration: 40, amplitude: 120);
      } else {
        Vibration.vibrate();
      }
    }
  }

  // Strong feedback for important events
  static Future<void> heavyImpact() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(duration: 80, amplitude: 255);
      } else {
        Vibration.vibrate();
      }
    }
  }

  // Success feedback pattern
  static Future<void> successNotification() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(
          pattern: [0, 30, 20, 60, 20, 100],
          intensities: [0, 50, 100, 150, 100, 50],
        );
      } else {
        Vibration.vibrate();
      }
    }
  }

  // Warning feedback pattern
  static Future<void> warningNotification() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(pattern: [0, 100, 100, 100]);
      } else {
        Vibration.vibrate();
      }
    }
  }

  // Error feedback pattern
  static Future<void> errorNotification() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(pattern: [0, 50, 100, 50, 100, 150]);
      } else {
        Vibration.vibrate();
      }
    }
  }
}

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
  RegExp txidPattern = RegExp(r'^[a-fA-F0-9]{64}$');
  return txidPattern.hasMatch(input);
}

bool isValidBitcoinAddressHash(String input) {
  if (input.isEmpty) return false;

  // P2PKH addresses (start with 1, length 26-35, base58)
  if (input.startsWith('1')) {
    return RegExp(r'^1[1-9A-HJ-NP-Za-km-z]{25,34}$').hasMatch(input) &&
        input.length >= 26 &&
        input.length <= 35;
  }

  // P2SH addresses (start with 3, length 26-35, base58)
  if (input.startsWith('3')) {
    return RegExp(r'^3[1-9A-HJ-NP-Za-km-z]{25,34}$').hasMatch(input) &&
        input.length >= 26 &&
        input.length <= 35;
  }

  // Bech32 addresses (start with bc1, lowercase)
  if (input.startsWith('bc1')) {
    return RegExp(r'^bc1[a-z0-9]{39,59}$').hasMatch(input) &&
        input.length >= 42;
  }

  return false;
}

bool containsSixIntegers(String input) {
  RegExp sixIntegersPattern = RegExp(r'(?<!\d)\d{6}(?!\d)');
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
  if (input.toLowerCase().startsWith("bitcoin:")) {
    Uri? uri = Uri.tryParse(input);
    if (uri != null) {
      String? lightningParam = uri.queryParameters["lightning"];

      if (lightningParam != null) {
        if ((lightningParam.toUpperCase().startsWith("LNBC") ||
                lightningParam.toUpperCase().startsWith("LNTB") ||
                lightningParam.toUpperCase().startsWith("LNBCRT")) &&
            isValidBitcoinAddressHash(uri.path)) {
          return true;
        }
      }
    }
  }
  return false;
}

bool isBip21WithBolt12(String input) {
  if (input.toLowerCase().startsWith("bitcoin:")) {
    Uri? uri = Uri.tryParse(input);
    if (uri != null) {
      String? lightningParam = uri.queryParameters["lightning"];

      if (lightningParam != null) {
        if (lightningParam.toUpperCase().startsWith("LNO")) {
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
  if (currentline == null || currentline.isEmpty) {
    return 0;
  }

  // Handle both lists of numbers and lists of objects with price property
  if (currentline[0] is num) {
    // Direct list of numbers
    double sum = 0.0;
    for (var item in currentline) {
      sum += item.toDouble();
    }
    return sum / currentline.length;
  } else {
    // List of objects with price property
    double sum = 0.0;
    for (var item in currentline) {
      sum += item.price.toDouble();
    }
    return sum / currentline.length;
  }
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
    return (numericDates) ? 'vor 1 Jahr' : 'letztes Jahr';
  } else if ((difference.inDays / 30).floor() >= 2) {
    return 'vor ${(difference.inDays / 30).floor()} Monaten';
  } else if ((difference.inDays / 30).floor() >= 1) {
    return (numericDates) ? 'vor 1 Monat' : 'letzten Monat';
  } else if ((difference.inDays / 7).floor() >= 2) {
    return 'vor ${(difference.inDays / 7).floor()} Wochen';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? 'vor 1 Woche' : 'letzte Woche';
  } else if (difference.inDays >= 2) {
    return 'vor ${difference.inDays} Tagen';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? 'vor 1 Tag' : 'gestern';
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
    return 'gerade eben';
  }
}

String displayTimeAgoFromInt(int time,
    {bool numericDates = false, String language = 'de'}) {
  // The time is already in milliseconds, so use it directly
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
  final DateTime date2 = DateTime.now();
  final Duration difference = date2.difference(date);

  // Validate the date (handle future dates)
  if (date.isAfter(date2)) {
    // Future date (invalid) - show current time instead
    return language == 'en' ? 'Just now' : 'gerade eben';
  }

  // Language-based formatting
  if (language == 'en') {
    // English format
    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  } else {
    // German format (default)
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
}

String convertIntoDateFormat(int time) {
  // Convert the timestamp to DateTime (time is already in milliseconds)
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
  // Format the DateTime object to a readable string
  String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(date);
  if (kDebugMode) {
    print("Formatted date: $formattedDate");
  }
  return formattedDate;
}

// Format a double value as a percentage string
String toPercent(double value) => NumberFormat('+#.##%; -#.##%').format(value);

void scrollToSearchFunc(ScrollController ctrl, FocusNode node) {
  if (ctrl.position.pixels <= -100 && !node.hasFocus) {
    ctrl.jumpTo(0);
    node.requestFocus();
    HapticFeedback.mediumImpact();
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

// Function to get consistent viewport fraction across feed tabs
double getStandardizedViewportFraction() {
  return 0.7;
}

// Function to get consistent enlargeFactor across feed tabs
double getStandardizedEnlargeFactor() {
  return 0.25;
}

// Function to get consistent carousel height across feed tabs
double getStandardizedCarouselHeight() {
  return AppTheme.cardPadding * 13;
}

// Debugging helper to print carousel dimensions (add to feed tab files for troubleshooting)
void debugPrintCarouselDimensions() {
  print("Carousel standardized dimensions:");
  print("- Height: ${getStandardizedCarouselHeight()}");
  print("- Card width: ${getStandardizedCardWidth()}");
  print("- Card margin: ${getStandardizedCardMargin()}");
  print("- Viewport fraction: ${getStandardizedViewportFraction()}");
  print("- Enlarge factor: ${getStandardizedEnlargeFactor()}");
}

// Function to get standard card width for carousels
double getStandardizedCardWidth() {
  return AppTheme.cardPadding * 10;
}

// Function to get standardized horizontal margin for carousel items
double getStandardizedCardMargin() {
  return AppTheme.elementSpacing / 4;
}

// Function to get standardized carousel options
CarouselOptions getStandardizedCarouselOptions({
  bool enableAutoPlay = true,
  double? customHeight,
  int autoPlayIntervalSeconds = 5,
}) {
  // Print debug info to help diagnose carousel autoplay issues
  print(
      "Creating carousel options with autoPlay: true (interval: ${autoPlayIntervalSeconds}s)");

  return CarouselOptions(
    // Always enable autoPlay regardless of debug mode to ensure consistent behavior
    autoPlay: true,
    viewportFraction: getStandardizedViewportFraction(),
    enlargeCenterPage: true,
    enlargeFactor: getStandardizedEnlargeFactor(),
    height: customHeight ?? getStandardizedCarouselHeight(),
    autoPlayInterval: Duration(seconds: autoPlayIntervalSeconds),
    autoPlayAnimationDuration: const Duration(milliseconds: 800),
    autoPlayCurve: Curves.easeInOutCubic,
    pauseAutoPlayOnTouch: true,
    scrollPhysics: const BouncingScrollPhysics(),
  );
}

double getZoomScale(BuildContext context) {
  final logicalSize = MediaQuery.of(context).size;
  final physicalSize = View.of(context).physicalSize;
  final dpr = MediaQuery.of(context).devicePixelRatio;

  final calculatedZoom = physicalSize.width / logicalSize.width;
  return calculatedZoom;
}
