import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  void loadData(_) async {
    QuerySnapshot querySnapshot = await settingsCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    if (allData.contains(FirebaseAuth.instance.currentUser!.uid)) {
      var data = await settingsCollection
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
      Provider.of<BitcoinPriceStream>(context, listen: false)
        ..updateCurrency(data.data()?['selected_currency'] ?? "USD");
      Provider.of<CurrencyTypeProvider>(context, listen: false)
          .setCurrencyType(data.data()?['showCoin'] ?? false);
      Get.put(WalletsController())
          .setHideBalance(hide: data.data()?['hide_balance'] ?? false);
      setState(() {
        _themeMode = ThemeMode.values
            .singleWhereOrNull((value) => value.name == rawThemeMode);
        Get.find<SettingsController>().selectedTheme.value =
            _themeMode ?? ThemeMode.system;
        _primaryColor = rawColor == null ? Colors.white : Color(rawColor);
      });
    } else {
      Map<String, dynamic> data = {
        "theme_mode": "system",
        "lang": "en",
        "primary_color": Colors.white.value,
        "selected_currency": "USD",
        "selected_card": "lightning",
        "hide_balance": false
      };
      settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
    }
  }

  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    LoggerService logger = Get.find();
    logger.d('setThemeMode: $newThemeMode');
    await settingsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({widget.themeModeSettingsKey: newThemeMode.name});
    _themeMode = newThemeMode;
    Get.find<SettingsController>().selectedTheme.value = newThemeMode;
    setState(() {});
  }

  Future<void> setPrimaryColor(Color? newPrimaryColor) async {
    if (newPrimaryColor == Colors.white || newPrimaryColor == Colors.black) {
      newPrimaryColor = AppTheme.colorSchemeSeed;
      await settingsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({widget.primaryColorSettingsKey: newPrimaryColor?.value});
    }
    if (newPrimaryColor == null) {
      await settingsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({widget.primaryColorSettingsKey: newPrimaryColor?.value});
    } else {
      await settingsCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({widget.primaryColorSettingsKey: newPrimaryColor.value});
    }
    setState(() {
      _primaryColor = newPrimaryColor;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(loadData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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