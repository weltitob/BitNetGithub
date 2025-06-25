import 'dart:collection';
import 'dart:isolate';

import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/bitcoin_controller.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
// import 'package:bitnet/models/firebase/restresponse.dart'; // Uncomment if needed, currently unused
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
// import 'package:bitnet/pages/wallet/wallet.dart'; // Uncomment if needed, currently unused
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Currently unused
import 'package:timezone/timezone.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    ThemeMode themeMode,
    Color? primaryColor,
  ) builder;

  final String themeModeSettingsKey;
  final String primaryColorSettingsKey;

  const ThemeBuilder({
    required this.builder,
    this.themeModeSettingsKey = 'theme_mode',
    this.primaryColorSettingsKey = 'primary_color',
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeBuilder> createState() => ThemeController();
}

class ThemeController extends State<ThemeBuilder> {
  // SharedPreferences? _sharedPreferences; // Currently unused
  ThemeMode? _themeMode;
  Color? _primaryColor;

  // Using user's provided initialization
  late final LoggerService _logger = Get.find();

  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  Color? get primaryColor => _primaryColor ?? Colors.white;

  // Static getter remains the same
  static ThemeController of(BuildContext context) =>
      Provider.of<ThemeController>(
        context,
        listen: false,
      );

  // Set default values for web preview to avoid Firebase errors
  void _setWebDefaultValues() {
    // Changed from .w to .i
    _logger.i(
        '[_setWebDefaultValues] Running in web mode, setting default values.');
    if (!mounted) {
      // Changed from .w to .i
      _logger
          .i('[_setWebDefaultValues] Widget not mounted, cannot set defaults.');
      return;
    }

    try {
      // Set default values for providers
      final localeProvider = Provider.of<LocalProvider>(context, listen: false);
      localeProvider.setLocaleInDatabase('en', const Locale('en'));
      _logger.d('[_setWebDefaultValues] Default locale set to en');

      Provider.of<CountryProvider>(context, listen: false)
          .setCountryInDatabase('US');
      _logger.d('[_setWebDefaultValues] Default country set to US');

      Provider.of<CardChangeProvider>(context, listen: false)
          .setCardInDatabase('lightning');
      _logger.d('[_setWebDefaultValues] Default card set to lightning');

      Provider.of<CurrencyChangeProvider>(context, listen: false)
          .setFirstCurrencyInDatabase("USD");
      _logger.d('[_setWebDefaultValues] Default currency set to USD');

      Provider.of<TimezoneProvider>(context, listen: false)
          .setTimezoneInDatabase(getLocation("UTC"));
      _logger.d('[_setWebDefaultValues] Default timezone set to UTC');

      Provider.of<BitcoinPriceStream>(context, listen: false)
          .updateCurrency("USD");
      _logger
          .d('[_setWebDefaultValues] BitcoinPriceStream currency set to USD');

      Provider.of<CurrencyTypeProvider>(context, listen: false)
          .setCurrencyType(false);
      _logger.d(
          '[_setWebDefaultValues] Default currency type set to false (show fiat)');

      if (!Get.isRegistered<WalletsController>()) {
        _logger.d('[_setWebDefaultValues] Registering WalletsController...');
        Get.put(WalletsController()).setHideBalance(hide: false);
        _logger.d('[_setWebDefaultValues] Default hideBalance set to false');
      } else {
        Get.find<WalletsController>().setHideBalance(hide: false);
        _logger.d(
            '[_setWebDefaultValues] WalletsController already registered, setting default hideBalance to false');
      }

      setState(() {
        _themeMode = ThemeMode.system;
        _logger.d('[_setWebDefaultValues] Setting local themeMode to system');
        if (Get.isRegistered<SettingsController>()) {
          Get.find<SettingsController>().selectedTheme.value = ThemeMode.system;
          _logger
              .d('[_setWebDefaultValues] Updated SettingsController themeMode');
        }
        _primaryColor =
            Colors.white; // Use white as default for web consistency
        _logger.d('[_setWebDefaultValues] Setting local primaryColor to white');
      });

      // Initialize Bitcoin controller with default values for web
      if (!Get.isRegistered<BitcoinController>()) {
        _logger.d('[_setWebDefaultValues] Registering BitcoinController...');
        Get.put(BitcoinController());
        // Use mock data for web preview
        Get.find<BitcoinController>().getChartLine("USD");
        Get.find<BitcoinController>().getpbChartline("USD");
        _logger.d('[_setWebDefaultValues] Fetched mock chart data for web');
      } else {
        _logger
            .d('[_setWebDefaultValues] BitcoinController already registered.');
        // Optionally fetch mock data again if needed, or assume it's handled
      }
      _logger.i('[_setWebDefaultValues] Successfully set web default values.');
    } catch (e) {
      // Removed stackTrace: s
      _logger.e('[_setWebDefaultValues] Error setting web default values: $e');
    }
  }

  void loadData(_) async {
    _logger.i('[loadData] Starting data loading...');
    try {
      // For web, use default values to avoid Firebase errors
      if (kIsWeb) {
        // Changed from .w to .i
        _logger.i(
            '[loadData] Running in web mode, skipping Firebase load and using defaults.');
        return;
      }

      _logger.d('[loadData] Running in mobile/native mode.');
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Changed from .w to .i
        _logger.i(
            '[loadData] User is not authenticated. Cannot load or save settings.');
        // Optionally set defaults for unauthenticated state if needed, similar to web?
        // For now, just returning as original code implicitly did.
        return;
      }

      final String uid = user.uid;
      _logger.d(
          '[loadData] Authenticated user found: $uid. Checking Firestore settings...');

      // Check if settings document exists first
      final docRef = Databaserefs.settingsCollection.doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        _logger.i(
            '[loadData] Settings document found for user $uid. Loading data...');
        final data = docSnapshot.data();
        if (data == null) {
          _logger.e(
              '[loadData] Settings document exists but data is null for user $uid. This should not happen.');
          // Fallback or error handling needed here? For now, maybe create defaults again.
          await _createDefaultSettings(uid);
          return; // Retry loading might be needed or handle error state
        }

        _logger.d('[loadData] Raw settings data: $data');

        // Load Theme Mode
        final rawThemeMode = data['theme_mode'] as String?;
        _themeMode = ThemeMode.values
                .singleWhereOrNull((value) => value.name == rawThemeMode) ??
            ThemeMode.system;
        _logger.d('[loadData] Loaded themeMode: $_themeMode');

        // Load Primary Color
        final rawColor = data['primary_color'] as int?;
        _primaryColor = rawColor == null
            ? AppTheme.immutableColorSchemeSeed
            : Color(rawColor); // Use seed color if null
        _logger.d('[loadData] Loaded primaryColor: $_primaryColor');

        // Load Locale
        final lang = data['lang'] as String? ?? 'en';
        final locale = Locale.fromSubtags(languageCode: lang);
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(lang, locale);
        _logger.d('[loadData] Loaded locale: $lang');

        // Load Country
        final country = data['country'] as String? ?? 'US';
        Provider.of<CountryProvider>(context, listen: false)
            .setCountryInDatabase(country);
        _logger.d('[loadData] Loaded country: $country');

        // Load Card
        final card = data['selected_card'] as String? ?? 'lightning';
        Provider.of<CardChangeProvider>(context, listen: false)
            .setCardInDatabase(card);
        _logger.d('[loadData] Loaded selected_card: $card');

        // Load Currency
        final currency = data['selected_currency'] as String? ?? "USD";
        Provider.of<CurrencyChangeProvider>(context, listen: false)
            .setFirstCurrencyInDatabase(currency);
        Provider.of<BitcoinPriceStream>(context, listen: false)
            .updateCurrency(currency);
        _logger.d('[loadData] Loaded selected_currency: $currency');

        // Load Timezone
        final timezone = data['timezone'] as String? ?? "UTC";
        Provider.of<TimezoneProvider>(context, listen: false)
            .setTimezoneInDatabase(getLocation(timezone));
        _logger.d('[loadData] Loaded timezone: $timezone');

        // Load Currency Type (Show Coin)
        final showCoin = data['showCoin'] as bool? ?? false;
        Provider.of<CurrencyTypeProvider>(context, listen: false)
            .setCurrencyType(showCoin);
        _logger.d('[loadData] Loaded showCoin: $showCoin');

        // Load Hide Balance
        final hideBalance = data['hide_balance'] as bool? ?? false;
        if (!Get.isRegistered<WalletsController>()) {
          _logger.d('[loadData] Registering WalletsController...');
          Get.put(WalletsController()).setHideBalance(hide: hideBalance);
        } else {
          Get.find<WalletsController>().setHideBalance(hide: hideBalance);
        }
        _logger.d('[loadData] Loaded hide_balance: $hideBalance');

        // Update UI State
        if (mounted) {
          // Check if mounted before calling setState
          setState(() {
            _logger.d(
                '[loadData] Calling setState to apply loaded themeMode and primaryColor.');
            // Theme mode and primary color already set above
            if (Get.isRegistered<SettingsController>()) {
              Get.find<SettingsController>().selectedTheme.value =
                  _themeMode ?? ThemeMode.system;
              _logger.d('[loadData] Updated SettingsController themeMode');
            }
          });
        } else {
          _logger.i("[loadData] Widget not mounted, cannot call setState.");
          // Update internal state directly if needed, though should be set above already
        }

        // Fetch BTC Addresses (Async, no await needed here)
        _logger.d('[loadData] Initiating BTC address fetch...');
        getBTCAddresses().then((btcData) {
          _logger.i(
              '[loadData] Successfully fetched/merged ${btcData.length} BTC addresses.');
          LocalStorage.instance.setStringList(btcData, "btc_addresses:$uid");
          if (Get.isRegistered<WalletsController>()) {
            Get.find<WalletsController>().btcAddresses = btcData;
            _logger.d('[loadData] Updated WalletsController btcAddresses.');
          }
        }, onError: (err) {
          // Removed stackTrace from onError
          _logger.e('[loadData] Error fetching BTC addresses: $err');
          final localAddresses =
              LocalStorage.instance.getStringList("btc_addresses:$uid") ?? [];
          // Changed from .w to .i
          _logger.i(
              '[loadData] Using ${localAddresses.length} locally stored BTC addresses due to fetch error.');
          if (Get.isRegistered<WalletsController>()) {
            Get.find<WalletsController>().btcAddresses = localAddresses;
          }
        });

        // Initialize BitcoinController if needed and fetch chart data
        if (!Get.isRegistered<BitcoinController>()) {
          _logger.d('[loadData] Registering BitcoinController...');
          Get.put(BitcoinController());
        }
        _logger.d('[loadData] Fetching chart data for currency: $currency');
        Get.find<BitcoinController>().getChartLine(currency);
        Get.find<BitcoinController>().getpbChartline(currency);

        _logger.i(
            '[loadData] Finished loading existing user settings successfully.');
      } else {
        // Changed from .w to .i
        _logger.i(
            '[loadData] No settings document found for user $uid. Creating default settings...');
        await _createDefaultSettings(uid);
      }
    } catch (e) {
      // Removed stackTrace: s
      _logger.e('[loadData] Critical error during settings loading: $e');
      // Changed from .w to .i
      _logger.i('[loadData] Falling back to default web values due to error.');
      // Use fallback theme settings
      _setWebDefaultValues(); // Use defaults as a safe fallback
    }
  }

  Future<void> _createDefaultSettings(String uid) async {
    _logger.i(
        '[_createDefaultSettings] Creating default Firestore settings for user $uid');
    Map<String, dynamic> defaultData = {
      "theme_mode": ThemeMode.system.name,
      "lang": "en",
      "primary_color":
          AppTheme.immutableColorSchemeSeed!.value, // Default color seed
      "selected_currency": "USD",
      "selected_card": "lightning",
      "hide_balance": false,
      "showCoin": false,
      "country": "US",
      "timezone": "UTC",
      // Add any other missing defaults here
    };
    try {
      await Databaserefs.settingsCollection.doc(uid).set(defaultData);
      _logger.i(
          '[_createDefaultSettings] Successfully saved default settings for user $uid.');
      // Apply these defaults locally immediately
      _themeMode = ThemeMode.system;
      _primaryColor = AppTheme.immutableColorSchemeSeed;
      // Apply other defaults to providers and controllers as done in loadData
      // (Consider refactoring this into a common 'applySettings' function)
      // Added null checks and listen: false for Provider calls inside async method
      if (mounted) {
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase('en', const Locale('en'));
        Provider.of<CountryProvider>(context, listen: false)
            .setCountryInDatabase('US');
        Provider.of<CardChangeProvider>(context, listen: false)
            .setCardInDatabase('lightning');
        Provider.of<CurrencyChangeProvider>(context, listen: false)
            .setFirstCurrencyInDatabase("USD");
        Provider.of<TimezoneProvider>(context, listen: false)
            .setTimezoneInDatabase(getLocation("UTC"));
        Provider.of<BitcoinPriceStream>(context, listen: false)
            .updateCurrency("USD");
        Provider.of<CurrencyTypeProvider>(context, listen: false)
            .setCurrencyType(false);
      } else {
        _logger.i(
            "[_createDefaultSettings] Widget not mounted, skipping Provider updates.");
      }

      if (!Get.isRegistered<WalletsController>()) {
        Get.put(WalletsController());
      }
      Get.find<WalletsController>().setHideBalance(hide: false);
      if (!Get.isRegistered<BitcoinController>()) {
        Get.put(BitcoinController());
      }
      Get.find<BitcoinController>().getChartLine("USD");
      Get.find<BitcoinController>().getpbChartline("USD");

      if (mounted) {
        // Check if mounted before calling setState
        setState(() {
          _logger.d(
              '[_createDefaultSettings] Calling setState after creating default settings.');
          // State variables _themeMode and _primaryColor already updated
          if (Get.isRegistered<SettingsController>()) {
            Get.find<SettingsController>().selectedTheme.value =
                ThemeMode.system;
          }
        });
      } else {
        _logger.i(
            "[_createDefaultSettings] Widget not mounted, cannot call setState.");
      }
    } catch (e) {
      // Removed stackTrace: s
      _logger.e(
          '[_createDefaultSettings] Failed to save default settings for user $uid: $e');
      // Consider how to handle this failure - maybe retry? Or just use in-memory defaults?
      // Current behavior will likely fallback to _setWebDefaultValues if loadData catches this outer error.
    }
  }

  Future<List<String>> getBTCAddresses() async {
    _logger.d('[getBTCAddresses] Starting BTC address fetch...');
    if (kIsWeb) {
      // Changed from .w to .i
      _logger
          .i('[getBTCAddresses] Running in web mode, returning mock address.');
      return ['mock_address_for_web_preview'];
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Changed from .w to .i
      _logger.i(
          '[getBTCAddresses] User not authenticated, cannot fetch or load addresses. Returning empty list.');
      return [];
    }
    final String uid = user.uid;
    final String localStorageKey = 'btc_addresses:$uid';

    try {
      _logger.d('[getBTCAddresses] Calling listBtcAddresses cloud function...');
      final receivePort = ReceivePort();
      // Assuming listBtcAddresses returns Map<String, dynamic> or similar
      final dynamic response =
          await listBtcAddresses(); // Use dynamic initially
      _logger.d(
          '[getBTCAddresses] Received response from listBtcAddresses. Type: ${response.runtimeType}');

      // Ensure response is a Map before proceeding
      if (response is! Map) {
        _logger.e(
            '[getBTCAddresses] listBtcAddresses returned unexpected type: ${response.runtimeType}. Expected Map.');
        return LocalStorage.instance.getStringList(localStorageKey) ??
            []; // Fallback to local
      }
      // Now cast safely
      final Map<String, dynamic> remoteAddressesMap =
          Map<String, dynamic>.from(response);
      _logger.i(
          '[getBTCAddresses] Fetched ${remoteAddressesMap.length} addresses from cloud function.');

      List<String> localAddresses =
          LocalStorage.instance.getStringList(localStorageKey) ?? [];
      _logger.d(
          '[getBTCAddresses] Found ${localAddresses.length} addresses in local storage.');

      _logger.d('[getBTCAddresses] Spawning isolate to merge addresses...');
      await Isolate.spawn(loadAddresses,
          [receivePort.sendPort, remoteAddressesMap, localAddresses]);

      final mergedData =
          await receivePort.first as List<String>; // Wait for isolate result
      _logger.i(
          '[getBTCAddresses] Isolate completed. Final merged address count: ${mergedData.length}');
      return mergedData;
    } catch (e) {
      // Removed stackTrace: s
      _logger.e('[getBTCAddresses] Error getting/merging BTC addresses: $e');
      final localAddresses =
          LocalStorage.instance.getStringList(localStorageKey) ?? [];
      // Changed from .w to .d (it's just debug info now)
      _logger.d(
          '[getBTCAddresses] Returning ${localAddresses.length} locally stored addresses due to error.');
      return localAddresses; // Fallback to local storage on error
    }
  }

  // Isolate function - Use print for logging as Get/LoggerService might not be available.
  static void loadAddresses(List<dynamic> args) async {
    print('[Isolate loadAddresses] Starting address merge...');
    SendPort sendPort = args[0];
    Map<String, dynamic> remoteData = args[1];
    List<String> localAddresses = args[2];

    // Extract keys (addresses) from the remote map
    List<String> remoteAddresses = remoteData.keys.toList();
    print(
        '[Isolate loadAddresses] Received ${remoteAddresses.length} remote addresses and ${localAddresses.length} local addresses.');

    // Use a Set for efficient merging and deduplication
    Set<String> mergedSet = {...remoteAddresses, ...localAddresses};
    List<String> mergedList = mergedSet.toList();

    print(
        '[Isolate loadAddresses] Merged into ${mergedList.length} unique addresses.');

    sendPort.send(mergedList);
    print('[Isolate loadAddresses] Sent merged list back to main isolate.');
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    _logger.i(
        '[setThemeMode] Attempting to set theme mode to ${newThemeMode.name}');
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (!kIsWeb && user != null) {
        final String uid = user.uid;
        _logger.d(
            '[setThemeMode] Updating theme mode in Firestore for user $uid.');
        await Databaserefs.settingsCollection
            .doc(uid)
            .update({widget.themeModeSettingsKey: newThemeMode.name});
        _logger.d('[setThemeMode] Firestore update successful.');
      } else {
        // Changed from .w to .i
        _logger.i(
            '[setThemeMode] Skipping Firestore update (isWeb: $kIsWeb, userAuthenticated: ${user != null})');
      }

      // Update local state regardless of DB success/skip
      _themeMode = newThemeMode;
      if (Get.isRegistered<SettingsController>()) {
        Get.find<SettingsController>().selectedTheme.value = newThemeMode;
        _logger.d('[setThemeMode] Updated SettingsController themeMode value.');
      }
      if (mounted) {
        setState(() {
          _logger.d(
              '[setThemeMode] Local theme mode state updated and setState called.');
        });
      } else {
        // Changed from .w to .i
        _logger.i('[setThemeMode] Widget not mounted, cannot call setState.');
      }
      _logger.i(
          '[setThemeMode] Theme mode successfully set locally to ${newThemeMode.name}.');
    } catch (e) {
      // Removed stackTrace: s
      _logger.e('[setThemeMode] Error setting theme mode: $e');
      // Changed from .w to .i
      _logger.i('[setThemeMode] Updating local state despite Firestore error.');
      // Still update locally even if Firebase fails
      _themeMode = newThemeMode;
      if (Get.isRegistered<SettingsController>()) {
        Get.find<SettingsController>().selectedTheme.value = newThemeMode;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> setPrimaryColor(Color? newPrimaryColor, bool updateDB) async {
    _logger.i(
        '[setPrimaryColor] Attempting to set primary color to $newPrimaryColor (updateDB: $updateDB)');
    Color? finalColor = newPrimaryColor; // Store the potentially modified color
    int dbValue = Colors.white.value; // Default DB value if color becomes null

    try {
      // Determine the final color to be used and the value for the database
      if (newPrimaryColor == Colors.white || newPrimaryColor == Colors.black) {
        _logger.d(
            '[setPrimaryColor] Input color is white/black, resetting to default immutable seed.');
        finalColor = AppTheme.immutableColorSchemeSeed;
        dbValue = finalColor!.value; // Use the seed color value for DB
      } else if (newPrimaryColor == null) {
        _logger.d(
            '[setPrimaryColor] Input color is null. Using null locally, will save white to DB if requested.');
        finalColor = null; // Keep local as null
        dbValue = Colors.white.value; // Use white for DB when local is null
      } else {
        _logger.d('[setPrimaryColor] Using provided color: $newPrimaryColor');
        finalColor = newPrimaryColor; // Use as is
        dbValue = finalColor.value;
      }

      // Update local state first
      if (mounted) {
        setState(() {
          _primaryColor = finalColor;
          _logger.d(
              '[setPrimaryColor] Local primary color state updated to $_primaryColor and setState called.');
        });
      } else {
        _primaryColor =
            finalColor; // Update internal state even if not mounted yet (e.g., during init)
        // Changed from .w to .i
        _logger.i(
            '[setPrimaryColor] Widget not mounted, updated _primaryColor but did not call setState.');
      }

      // Update Database if requested and applicable
      if (updateDB) {
        final user = FirebaseAuth.instance.currentUser;
        if (!kIsWeb && user != null) {
          final String uid = user.uid;
          _logger.d(
              '[setPrimaryColor] Updating primary color in Firestore for user $uid with value $dbValue.');
          await Databaserefs.settingsCollection
              .doc(uid)
              .update({widget.primaryColorSettingsKey: dbValue});
          _logger.d('[setPrimaryColor] Firestore update successful.');
        } else {
          // Changed from .w to .i
          _logger.i(
              '[setPrimaryColor] Skipping Firestore update (updateDB: $updateDB, isWeb: $kIsWeb, userAuthenticated: ${user != null})');
        }
      } else {
        _logger.d(
            '[setPrimaryColor] Skipping Firestore update as updateDB is false.');
      }
      _logger.i('[setPrimaryColor] Primary color successfully processed.');
    } catch (e) {
      // Removed stackTrace: s
      _logger.e('[setPrimaryColor] Error setting primary color: $e');
      // Changed from .w to .i
      _logger.i(
          '[setPrimaryColor] Updating local state despite potential Firestore error.');
      // Still update locally even if Firebase fails
      if (mounted) {
        setState(() {
          _primaryColor = finalColor; // Use the processed color
        });
      } else {
        _primaryColor = finalColor;
        // Changed from .w to .i
        _logger.i(
            '[setPrimaryColor] Widget not mounted during error handling, updated _primaryColor.');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Get logger instance - using the field initialized via Get.find()
    // This assumes LoggerService is registered *before* this widget is created.
    try {
      // Log initialization success (or failure if find throws)
      _logger.d('[ThemeController initState] Initialized.');
    } catch (e) {
      // Fallback if Get.find fails immediately (as it might if Get isn't ready)
      print(
          '[ThemeController initState] CRITICAL ERROR: Could not find LoggerService via Get.find() during initialization. Logging will likely fail. Error: $e');
      // Consider throwing or using a dummy logger to prevent crashes later
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure logger is available here (might have failed in initState)
      try {
        // No need to re-find, just use _logger. If it failed above, it will fail here too.
        _logger.i(
            '[ThemeController PostFrameCallback] Triggered, calling loadData.');
        loadData(_);
      } catch (e) {
        // Removed stackTrace: s
        print(
            '[ThemeController PostFrameCallback] Error during setup or loadData call: $e');
        // Log using print as _logger might be faulty
        _logger.e(
            '[ThemeController PostFrameCallback] Error during setup or loadData call: $e');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No logger re-initialization needed here as it uses the direct Get.find() in the field declaration
    _logger.d('[ThemeController didChangeDependencies] Called.');
  }

  @override
  Widget build(BuildContext context) {
    // Avoid logging excessively in build method unless necessary for debugging layout issues.
    // _logger.d('[ThemeController build] Building with themeMode: $themeMode, primaryColor: $primaryColor');
    // print('primaryColor is ${primaryColor}'); // Original print statement

    return Provider(
      create: (_) => this,
      child: DynamicColorBuilder(
        builder: (lightColorScheme, darkColorScheme) {
          // Determine the effective primary color for the builder
          Color? effectivePrimaryColor = primaryColor;

          // If primaryColor is null (meaning use dynamic), try getting from DynamicColorBuilder
          if (effectivePrimaryColor == null) {
            final isDarkMode = themeMode == ThemeMode.dark ||
                (themeMode == ThemeMode.system &&
                    MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark);
            effectivePrimaryColor = isDarkMode
                ? darkColorScheme?.primary
                : lightColorScheme?.primary;
            //_logger.d('[ThemeController build] Using dynamic color: $effectivePrimaryColor (isDarkMode: $isDarkMode)');
          }
          // If still null (e.g., dynamic color not supported), fallback to a default seed?
          // The original code implicitly handled this by passing null to the builder. Let's keep that.
          // effectivePrimaryColor ??= AppTheme.immutableColorSchemeSeed;

          return widget.builder(
            context,
            themeMode,
            effectivePrimaryColor, // Pass the determined color
          );
        },
      ),
    );
  }
}
// (LoggerService) - Refined logging levels (removed .w), removed stackTrace parameter, kept user's Get.find() initialization.
