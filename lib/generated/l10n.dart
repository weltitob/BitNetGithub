// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `Restore Wallet`
  String get restoreWallet {
    return Intl.message(
      'Restore Wallet',
      name: 'restoreWallet',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get register {
    return Intl.message(
      'Create Account',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Powered with decentralized IDs by`
  String get poweredByDIDs {
    return Intl.message(
      'Powered with decentralized IDs by',
      name: 'poweredByDIDs',
      desc: '',
      args: [],
    );
  }

  /// `Public ION Key`
  String get publicIONKey {
    return Intl.message(
      'Public ION Key',
      name: 'publicIONKey',
      desc: '',
      args: [],
    );
  }

  /// `Private Key`
  String get privateKey {
    return Intl.message(
      'Private Key',
      name: 'privateKey',
      desc: '',
      args: [],
    );
  }

  /// `Restore Account with 24 words`
  String get restoreWith24words {
    return Intl.message(
      'Restore Account with 24 words',
      name: 'restoreWith24words',
      desc: '',
      args: [],
    );
  }

  /// `Pin Code Verification`
  String get pinCodeVerification {
    return Intl.message(
      'Pin Code Verification',
      name: 'pinCodeVerification',
      desc: '',
      args: [],
    );
  }

  /// `Invitation Code`
  String get invitationCode {
    return Intl.message(
      'Invitation Code',
      name: 'invitationCode',
      desc: '',
      args: [],
    );
  }

  /// `You don't have an account yet?`
  String get noAccountYet {
    return Intl.message(
      'You don\'t have an account yet?',
      name: 'noAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `You already have an registered Account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'You already have an registered Account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `It seems like this code has already been used`
  String get codeAlreadyUsed {
    return Intl.message(
      'It seems like this code has already been used',
      name: 'codeAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `Code is not valid.`
  String get codeNotValid {
    return Intl.message(
      'Code is not valid.',
      name: 'codeNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorSomethingWrong {
    return Intl.message(
      'Something went wrong',
      name: 'errorSomethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Power to the people!`
  String get powerToThePeople {
    return Intl.message(
      'Power to the people!',
      name: 'powerToThePeople',
      desc: '',
      args: [],
    );
  }

  /// `We're thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.`
  String get platformDemandText {
    return Intl.message(
      'We\'re thrilled to see such a high demand for the platform! However, at the moment user numbers had to be limited to invited users.',
      name: 'platformDemandText',
      desc: '',
      args: [],
    );
  }

  /// `We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.`
  String get platformExlusivityText {
    return Intl.message(
      'We encourage users to maintain the exclusivity and security of the platform by sharing Invitation Codes with individuals who you believe will contribute positively to our culture of trust and collaboration.',
      name: 'platformExlusivityText',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!`
  String get platformExpandCapacityText {
    return Intl.message(
      'Thanks for your patience as we work to expand our capacity and accommodate the growing demand. We appreciate your support and remain committed to enhancing the overall experience for everyone!',
      name: 'platformExpandCapacityText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
