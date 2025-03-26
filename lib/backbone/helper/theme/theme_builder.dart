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
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  SharedPreferences? _sharedPreferences;
  ThemeMode? _themeMode;
  Color? _primaryColor;

  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  Color? get primaryColor => _primaryColor ?? Colors.white;

  static ThemeController of(BuildContext context) =>
      Provider.of<ThemeController>(
        context,
        listen: false,
      );

  // Set default values for web preview to avoid Firebase errors
  void _setWebDefaultValues() {
    if (!mounted) return;
    
    // Set default values for providers
    final localeProvider = Provider.of<LocalProvider>(context, listen: false);
    localeProvider.setLocaleInDatabase('en', const Locale('en'));
    
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
    
    if (!Get.isRegistered<WalletsController>()) {
      Get.put(WalletsController())
          .setHideBalance(hide: false);
    }
    
    setState(() {
      _themeMode = ThemeMode.system;
      if (Get.isRegistered<SettingsController>()) {
        Get.find<SettingsController>().selectedTheme.value = ThemeMode.system;
      }
      _primaryColor = Colors.white;
    });
    
    // Initialize Bitcoin controller with default values for web
    if (!Get.isRegistered<BitcoinController>()) {
      Get.put(BitcoinController());
      // Use mock data for web preview
      Get.find<BitcoinController>().getChartLine("USD");
      Get.find<BitcoinController>().getpbChartline("USD");
    }
  }

  void loadData(_) async {
    try {
      // For web, use default values to avoid Firebase errors
      if (kIsWeb) {
        print('Running in web mode - using default theme values');
        _setWebDefaultValues();
        return;
      }
      
      // Continue with normal Firebase implementation for mobile
      QuerySnapshot querySnapshot = await Databaserefs.settingsCollection.get();
      final allData = querySnapshot.docs.map((doc) => doc.id).toList();
      
      if (FirebaseAuth.instance.currentUser != null &&
          allData.contains(FirebaseAuth.instance.currentUser!.uid)) {
        var data = await Databaserefs.settingsCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        final rawThemeMode = data.data()?['theme_mode'];
        final rawColor = data.data()?['primary_color'];
        final locale = Locale.fromSubtags(languageCode: data.data()?['lang']);
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(data.data()?['lang'], locale);
        Provider.of<CountryProvider>(context, listen: false)
            .setCountryInDatabase(data.data()?['country']);
        Provider.of<CardChangeProvider>(context, listen: false)
            .setCardInDatabase(data.data()?['selected_card'] ?? 'lightning');
        Provider.of<CurrencyChangeProvider>(context, listen: false)
            .setFirstCurrencyInDatabase(
                data.data()?['selected_currency'] ?? "USD");
        Provider.of<TimezoneProvider>(context, listen: false)
            .setTimezoneInDatabase(
                getLocation(data.data()?['timezone'] ?? "UTC"));

        Provider.of<BitcoinPriceStream>(context, listen: false)
          ..updateCurrency(data.data()?['selected_currency'] ?? "USD");
        Provider.of<CurrencyTypeProvider>(context, listen: false)
            .setCurrencyType(data.data()?['showCoin'] ?? false);
        if (!Get.isRegistered<WalletsController>()) {
          Get.put(WalletsController())
              .setHideBalance(hide: data.data()?['hide_balance'] ?? false);
        }
        setState(() {
          _themeMode = ThemeMode.values
              .singleWhereOrNull((value) => value.name == rawThemeMode);
          if (Get.isRegistered<SettingsController>()) {
            Get.find<SettingsController>().selectedTheme.value =
                _themeMode ?? ThemeMode.system;
          }
          if (rawColor != null) {
            print('${Color(rawColor).value}');
          }
          _primaryColor = rawColor == null ? Colors.white : Color(rawColor);
        });

        getBTCAddresses().then((data) {
          LocalStorage.instance.setStringList(
              data, "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");

          Get.find<WalletsController>().btcAddresses = data;
        }, onError: (err) {
          Get.find<WalletsController>()
              .btcAddresses = LocalStorage.instance.getStringList(
                  "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}") ??
              [];
        });

        Get.put(BitcoinController());
        Get.find<BitcoinController>()
            .getChartLine(data.data()?['selected_currency'] ?? "USD");
        Get.find<BitcoinController>()
            .getpbChartline(data.data()?['selected_currency'] ?? "USD");
      } else {
        Map<String, dynamic> data = {
          "theme_mode": "system",
          "lang": "en",
          "primary_color": Colors.white.value,
          "selected_currency": "USD",
          "selected_card": "lightning",
          "hide_balance": false
        };
        Databaserefs.settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      }
    } catch (e) {
      print('Error loading theme settings (safe to ignore in web preview): $e');
      // Use fallback theme settings
      _setWebDefaultValues();
    }
  }

  Future<List<String>> getBTCAddresses() async {
    if (kIsWeb) {
      // Return mock addresses for web preview
      return ['mock_address_for_web_preview'];
    }
    
    try {
      final receivePort = ReceivePort();
      LinkedHashMap<String, int> response = await listBtcAddresses();

      List<String> localAddresses = LocalStorage.instance.getStringList(
              'btc_addresses:${FirebaseAuth.instance.currentUser!.uid}') ??
          [];
      await Isolate.spawn(
          loadAddresses, [receivePort.sendPort, response, localAddresses]);

      final data =
          await receivePort.first as List<String>; // Wait for isolate result
      return data;
    } catch (e) {
      print('Error getting BTC addresses (safe to ignore in web preview): $e');
      return [];
    }
  }

  static void loadAddresses(List<dynamic> args) async {
    SendPort sendPort = args[0];
    Map<String, dynamic> data = args[1];
    List<String> localAddresses = args[2];
    List<String> finalAddresses = data.keys.toList();

    List<String> mergedList = [
      ...{...finalAddresses, ...localAddresses}
    ];

    sendPort.send(mergedList);
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    try {
      LoggerService logger = Get.find();
      logger.d('setThemeMode: $newThemeMode');
      
      // Skip DB update in web mode
      if (!kIsWeb && FirebaseAuth.instance.currentUser != null) {
        await Databaserefs.settingsCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({widget.themeModeSettingsKey: newThemeMode.name});
      }
      
      _themeMode = newThemeMode;
      if (Get.isRegistered<SettingsController>()) {
        Get.find<SettingsController>().selectedTheme.value = newThemeMode;
      }
      setState(() {});
    } catch (e) {
      print('Error setting theme mode (safe to ignore in web preview): $e');
      // Still update locally even if Firebase fails
      setState(() {
        _themeMode = newThemeMode;
      });
    }
  }

  Future<void> setPrimaryColor(Color? newPrimaryColor, bool updateDB) async {
    try {
      if (newPrimaryColor == Colors.white || newPrimaryColor == Colors.black) {
        newPrimaryColor = AppTheme.immutableColorSchemeSeed;
        setState(() {
          _primaryColor = newPrimaryColor;
        });
        if (updateDB && !kIsWeb && FirebaseAuth.instance.currentUser != null) {
          await Databaserefs.settingsCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({widget.primaryColorSettingsKey: newPrimaryColor?.value});
        }
      } else if (newPrimaryColor == null) {
        setState(() {
          _primaryColor = newPrimaryColor;
        });
        if (updateDB && !kIsWeb && FirebaseAuth.instance.currentUser != null) {
          await Databaserefs.settingsCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({widget.primaryColorSettingsKey: Colors.white.value});
        }
      } else {
        setState(() {
          _primaryColor = newPrimaryColor;
        });

        if (updateDB && !kIsWeb && FirebaseAuth.instance.currentUser != null) {
          await Databaserefs.settingsCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({widget.primaryColorSettingsKey: newPrimaryColor.value});
        }
      }
    } catch (e) {
      print('Error setting primary color (safe to ignore in web preview): $e');
      // Still update locally even if Firebase fails
      setState(() {
        _primaryColor = newPrimaryColor;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(loadData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('primaryColor is ${primaryColor}');
    return Provider(
      create: (_) => this,
      child: DynamicColorBuilder(
        builder: (light, _) => widget.builder(
          context,
          themeMode,
          primaryColor ?? light?.primary,
        ),
      ),
    );
  }
}
