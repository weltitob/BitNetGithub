import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
    const Locale('zh'),
    const Locale('es'),
    const Locale('de'),
    const Locale('ar'),
    const Locale('it'),
    const Locale('ja'),
    const Locale('id'),
    const Locale('hi'),
    const Locale('ur'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇬🇧';
      case 'fr':
        return '🇫🇷';
      case 'zh':
        return '🇨🇳';
      case 'es':
        return '🇪🇸';
      case 'de':
        return '🇩🇪';
      case 'ar':
        return '🇸🇦';
      case 'it':
        return '🇮🇹';
      case 'ja':
        return '🇯🇵';
      case 'id':
        return '🇮🇩';
      case 'hi':
        return '🇮🇳';
      case 'ur':
        return '🇵🇰';
      default:
        return '🇬🇧';
    }
  }
}
