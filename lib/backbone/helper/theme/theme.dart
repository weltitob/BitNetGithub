import 'dart:math';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static IconData satoshiIcon = const IconData(0x0021, fontFamily: 'SatoshiSymbol');

  static String baseUrlLightningTerminal = 'mybitnet.com';
  static String baseUrlLightningTerminalWithPort = 'mybitnet.com:8443';

  static String coinGeckoApiKey = 'CG-tSVcnPrFSyfWd8G7xaA4qUUv';
  static String applicationName = 'BitNet';

  static dynamic targetConf = 4;

  static Color? colorSchemeSeed = const Color(0xffffffff);
  static const Color primaryColor = Color(0xffffffff);

  static const Color colorBackground = Color(0xff130036);

  static const bool allowOtherHomeservers = true;
  static const bool enableRegistration = true;

  static const Color primaryColorLight = Color(0xFFCCBDEA);
  static const Color secondaryColor = Color(0xFF41a2bc);

  static Color glassMorphColor = Colors.black.withOpacity(0.2);
  static Color glassMorphColorLight = Colors.white.withOpacity(0.2);
  static Color glassMorphColorDark = Colors.black.withOpacity(0.3);

  // //bF2A900FFitcoincolors
  // static const Color orange = Color(0xFFFFBD69);
  // static const Color kAccentColor = Color(0xFFFFC107);

  static const Color colorLink = Colors.blueAccent;
  static const Color colorBitcoin = Color(0xfff7931a);
  static const Color colorPrimaryGradient = Color(0xfff25d00);

  //green and red
  static const Color errorColor = Color(0xFFFF6363);
  static const Color errorColorGradient = Color(0xFFC54545);
  static const Color successColor = Color(0xFF5DE165);
  static const Color successColorGradient = Color(0xFF148C1A);

  //SOCIALS
  //onTap: () => launchUrlString(AppTheme.supportUrl),
  //Marketing startegie ist EXTREME CONTENT STRATEGIE

  static String stripeTestKey =
      "pk_test_51Ov55sRxZq4zmuaG9zp35ejVDONTsacEXYDDbGQ2gjo97XDMKnhsRivkXBEBiMMAaeRADwrIrqrtPWMgZbFYlO0C00xBfhtT6Z";

  static String stripeLiveKey =
      'pk_live_51Ov55sRxZq4zmuaGqPWpgAj2CQWjApOVT6zoILTT5vRbwsltB6FFCS8RpfC0DvaeJEs7SztsSFLajGJpsKWZGkNp00a3AtBcwb';

  static String createStripeAccountUrl = "https://bitnet.ai/#/website/redirect";

  static String whatsappChannelUrl = 'https://www.whatsapp.com/bitnet.ai/';

  static String instagramUrl = 'https://www.instagram.com/bitnet.ai/';
  static String twitterUrl = 'https://twitter.com/bitnet_ai';
  static String facebookUrl = 'https://www.facebook.com/bitnet.ai';
  static String linkedinUrl = 'https://www.linkedin.com/company/bitnet-ai';
  static String pinterestUrl = 'https://www.pinterest.com/bitnet_ai';
  static String youtubeUrl = 'https://www.youtube.com/channel/UCnrJYplZtmZwDn3ia8J5Obg';
  static String discordUrl = 'https://discord.gg/9QJ2X8Q';
  static String telegramUrl = 'https://t.me/bitnet_ai';
  static String snapchatUrl = 'https://www.snapchat.com/add/bitnet.ai';
  static String tiktokUrl = 'https://tiktok.com/@bitnet_ai';

  //for exchangerates:
  static String mykey = 'b16be475b04d4272b9a06fcb2b4c0bbd';
  static String baseUrl = 'https://openexchangerates.org/api/';
  static String ratesUrl = '${baseUrl}latest.json?base=USD&app_id=$mykey'; //this only gives usd?

  static String baseUrlCoinGecko = 'https://openexchangerates.org/api/';
  //NEXT 5 TO BE ADDED TO CONTENT MASCHINE

  //twitch
  //github
  //medium
  //reddit
  //tumblr

  //DIESE plattformen auch haben aber nicht erwähnen auf website wo content geuploaded wird
  //pornhub
  //onlyfans
  //patreon
  //XVideos
  //xhamster
  //YouPorn
  //RedTube

  static String goFundMeUrl = 'https://www.gofundme.com/manage/bitnet-a-decentralized-metaverse-application';

  static String _privacyUrl = 'https://gitlab.com/famedly/fluffychat/-/blob/main/PRIVACY.md';
  static String get privacyUrl => _privacyUrl;
  static const String enablePushTutorial = 'https://gitlab.com/famedly/fluffychat/-/wikis/Push-Notifications-without-Google-Services';
  static const String encryptionTutorial = 'https://gitlab.com/famedly/fluffychat/-/wikis/How-to-use-end-to-end-encryption-in-FluffyChat';
  static const String appId = 'com.bitnet.bitnet';
  static const String appOpenUrlScheme = 'com.bitnet';


  static String _webBaseUrl = 'https://mybitnet.com'; //'https://fluffychat.im/web';
  static String get webBaseUrl => _webBaseUrl;


  static const String currentWebDomain = 'bitnet.ai';
  static const String supportUrl = 'https://gitlab.com/famedly/fluffychat/issues';
  static final Uri newIssueUrl = Uri(
    scheme: 'https',
    host: 'gitlab.com',
    path: '/famedly/fluffychat/-/issues/new',
  );
  static const bool enableSentry = true;
  static const String sentryDns = 'https://8591d0d863b646feb4f3dda7e5dcab38@o256755.ingest.sentry.io/5243143';
  static bool renderHtml = true;
  static bool hideRedactedEvents = false;
  static bool hideUnknownEvents = true;
  static bool hideUnimportantStateEvents = true;
  static bool showDirectChatsInSpaces = true;
  static bool separateChatTypes = false;
  static bool autoplayImages = true;
  static bool sendOnEnter = false;
  static bool experimentalVoip = false;
  static const bool hideTypingUsernames = false;
  static const bool hideAllStateEvents = false;
  static const String inviteLinkPrefix = 'https://matrix.to/#/';
  static const String deepLinkPrefix = 'com.mybitnet://chat/';
  static const String schemePrefix = 'matrix:';

  //wtf is this here ------------------------------------------------

  static const String pushNotificationsChannelId = 'fluffychat_push';
  static const String pushNotificationsChannelName = 'FluffyChat push channel';
  static const String pushNotificationsChannelDescription = 'Push notifications for FluffyChat';
  static const String pushNotificationsAppId = 'chat.fluffy.fluffychat';
  static const String pushNotificationsGatewayUrl = 'https://push.fluffychat.im/_matrix/push/v1/notify';

  //wtf is this here ------------------------------------------------

  static const String pushNotificationsPusherFormat = 'event_id_only';
  static const String emojiFontName = 'Noto Emoji';
  static const String emojiFontUrl = 'https://github.com/googlefonts/noto-emoji/';

  static void loadFromJson(Map<String, dynamic> json) {
    LoggerService logger = Get.find();
    if (json['chat_color'] != null) {
      try {
        colorSchemeSeed = Color(json['chat_color']);
      } catch (e) {
        logger.i('Invalid color in config.json! Please make sure to define the color in this format: "0xffdd0000", error: $e');
      }
    }
    if (json['privacy_url'] is String) {
      _webBaseUrl = json['privacy_url'];
    }
    if (json['web_base_url'] is String) {
      _privacyUrl = json['web_base_url'];
    }
    if (json['render_html'] is bool) {
      renderHtml = json['render_html'];
    }
    if (json['hide_redacted_events'] is bool) {
      hideRedactedEvents = json['hide_redacted_events'];
    }
    if (json['hide_unknown_events'] is bool) {
      hideUnknownEvents = json['hide_unknown_events'];
    }
  }

  //borderradius
  static BorderRadius cardRadiusSuperSmall = BorderRadius.circular(10);
  static BorderRadius cardRadiusSmall = BorderRadius.circular(16);
  static BorderRadius cardRadiusMid = BorderRadius.circular(24);
  static BorderRadius cardRadiusBig = BorderRadius.circular(28);
  static BorderRadius cardRadiusBigger = BorderRadius.circular(32);
  static BorderRadius cardRadiusBiggest = BorderRadius.circular(36);
  static Radius cornerRadiusBig = const Radius.circular(28);
  static Radius cornerRadiusMid = const Radius.circular(24);
  static BorderRadius cardRadiusCircular = BorderRadius.circular(500);

  static const double borderRadiusSuperSmall = 10.0;
  static const double borderRadiusSmall = 16.0;
  static const double borderRadiusMid = 24.0;
  static const double borderRadiusBig = 28.0;
  static const double borderRadiusBigger = 32.0;
  static const double borderRadiusCircular = 500.0;

  static const double tabbarBorderWidth = 1.5;

  static const double navRailWidth = 2 * cardPadding + elementSpacing;
  //spaces
  static const double cardPadding = 24;
  static const double columnWidth = 14 * cardPadding;
  static const double cardPaddingSmall = 16;
  static const double cardPaddingBig = 28;
  static const double cardPaddingBigger = 32;
  static const double elementSpacing = cardPadding * 0.5;
  static const double bottomNavBarHeight = 64;

  //sizes
  static const double iconSize = cardPadding;
  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  //responsiveness
  static bool isColumnModeByWidth(double width) => width > columnWidth * 2 + navRailWidth;

  static bool isColumnMode(BuildContext context) => isColumnModeByWidth(MediaQuery.of(context).size.width);

  //breakpoints
  static const double isSuperSmallScreen = 600;
  static const double isSmallScreen = 1000;
  static const double isIntermediateScreen = 1350;
  static const double isSmallIntermediateScreen = 1100;
  static const double isMidScreen = 1600;

  //Boxshadows
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.25),
    offset: const Offset(0, 2),
    blurRadius: 5,
  );
  static BoxShadow boxShadowSuperSmall = BoxShadow(
    color: Colors.black.withOpacity(0.05), // Reduced opacity for less intensity
    offset: const Offset(0, 4), // Smaller offset to keep the shadow closer
    blurRadius: 15, // Significantly reduced blur radius for a tighter shadow
    spreadRadius: 0.5, // Smaller spread to limit the shadow's reach
  );
  static BoxShadow boxShadowSmall = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: const Offset(0, 10),
    blurRadius: 80,
    spreadRadius: 1.5,
  );
  static BoxShadow boxShadowBig = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: const Offset(0, 2.5),
    blurRadius: 40.0,
  );

  static BoxShadow boxShadowButton = BoxShadow(
    color: Colors.black.withOpacity(0.6),
    offset: const Offset(0, 2.5),
    blurRadius: 40.0,
  );

  static BoxShadow boxShadowProfile = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: const Offset(0, 2.5),
    blurRadius: 10,
  );

  //duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  //colors
  //textcolors
  static const Color black100 = Color(0xFF000000);
  static Color black90 = const Color(0xFF000000).withOpacity(0.9);
  static Color black80 = const Color(0xFF000000).withOpacity(0.8);
  static Color black70 = const Color(0xFF000000).withOpacity(0.7);
  static Color black60 = const Color(0xFF000000).withOpacity(0.6);

  static const Color white100 = Color(0xFFFFFFFF);
  static Color white90 = const Color(0xFFFFFFFF).withOpacity(0.9);
  static Color white80 = const Color(0xFFFFFFFF).withOpacity(0.8);
  static Color white70 = const Color(0xFFFFFFFF).withOpacity(0.7);
  static Color white60 = const Color(0xFFFFFFFF).withOpacity(0.6);

  static Color colorGlassContainer = const Color(0xFFFFFFFF).withOpacity(0.15);

  static InputDecoration textfieldDecoration(String hintText, BuildContext context) => InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(0.25),
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
            ),
      );

  //.inter
  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.lexend(
      fontSize: 52,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.lexend(
        fontSize: 40,
        fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
        letterSpacing: -0.5),
    displaySmall: GoogleFonts.lexend(
      fontSize: 28,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: 0.0,
    ),
    headlineLarge: GoogleFonts.lexend(
      fontSize: 24,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: 0.25,
    ),
    headlineMedium: GoogleFonts.lexend(
      fontSize: 22,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: 0.15,
    ),
    titleLarge: GoogleFonts.lexend(
      fontSize: 17,
      fontWeight: FontWeight.w700, // Changed from FontWeight.bold (w700) to w600
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.lexend(
      fontSize: 17,
      fontWeight: FontWeight.w500, // Changed from FontWeight.w600 to w500
      letterSpacing: 0.0,
    ),
    titleSmall: GoogleFonts.lexend(
      fontSize: 15,
      fontWeight: FontWeight.w500, // Changed from FontWeight.w600 to w500
      letterSpacing: 0.0,
    ),
    bodyLarge: GoogleFonts.lexend(
      fontSize: 17,
      fontWeight: FontWeight.w400, // Changed from FontWeight.w500 to w400
      letterSpacing: 0.15,
    ),
    bodyMedium: GoogleFonts.lexend(
      fontSize: 15,
      fontWeight: FontWeight.w400, // Changed from FontWeight.w500 to w400
      letterSpacing: 0.15,
    ),
    bodySmall: GoogleFonts.lexend(
      fontSize: 12,
      fontWeight: FontWeight.w400, // Changed from FontWeight.w500 to w400
      letterSpacing: 0.25,
    ),
    labelLarge: GoogleFonts.lexend(
      fontSize: 12,
      fontWeight: FontWeight.w300, // Changed from FontWeight.w400 to w300
      letterSpacing: 0.25,
    ),
    labelMedium: GoogleFonts.lexend(
      fontSize: 15,
      fontWeight: FontWeight.w300, // Changed from FontWeight.w400 to w300
      letterSpacing: 0.25,
    ),
    labelSmall: GoogleFonts.lexend(
      fontSize: 10,
      fontWeight: FontWeight.w300, // Changed from FontWeight.w400 to w300
      letterSpacing: 0.25,
    ),
  );

  static final textThemeDarkMode = textTheme.copyWith(
    displayLarge: textTheme.displayLarge!.copyWith(
      color: AppTheme.white90,
    ),
    displayMedium: textTheme.displayMedium!.copyWith(
      color: AppTheme.white90,
    ),
    displaySmall: textTheme.displaySmall!.copyWith(
      color: AppTheme.white90,
    ),
    headlineLarge: textTheme.headlineMedium!.copyWith(
      color: AppTheme.white90,
    ),
    headlineMedium: textTheme.headlineMedium!.copyWith(
      color: AppTheme.white90,
    ),
    headlineSmall: textTheme.headlineSmall!.copyWith(
      color: AppTheme.white90,
    ),
    titleLarge: textTheme.titleLarge!.copyWith(
      color: AppTheme.white90,
    ),
    titleMedium: textTheme.titleMedium!.copyWith(
      color: AppTheme.white80,
    ),
    titleSmall: textTheme.titleSmall!.copyWith(
      color: AppTheme.white70,
    ),
    bodyLarge: textTheme.bodyLarge!.copyWith(
      color: AppTheme.white60,
    ),
    bodyMedium: textTheme.bodyMedium!.copyWith(
      color: AppTheme.white60,
    ),
    bodySmall: textTheme.bodySmall!.copyWith(
      color: AppTheme.white60,
    ),
    labelSmall: textTheme.labelSmall!.copyWith(
      color: AppTheme.white60,
    ),
    labelMedium: textTheme.labelMedium!.copyWith(
      color: AppTheme.white60,
    ),
    labelLarge: textTheme.labelLarge!.copyWith(
      color: AppTheme.white60,
    ),
  );

  static const fallbackTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontFamilyFallback: ['NotoEmoji'],
  );

  static var fallbackTextTheme = const TextTheme(
    bodyLarge: fallbackTextStyle,
    bodyMedium: fallbackTextStyle,
    labelLarge: fallbackTextStyle,
    bodySmall: fallbackTextStyle,
    labelSmall: fallbackTextStyle,
    displayLarge: fallbackTextStyle,
    displayMedium: fallbackTextStyle,
    displaySmall: fallbackTextStyle,
    headlineMedium: fallbackTextStyle,
    headlineSmall: fallbackTextStyle,
    titleLarge: fallbackTextStyle,
    titleMedium: fallbackTextStyle,
    titleSmall: fallbackTextStyle,
  );

  static bool getDisplayNavigationRail(BuildContext context) =>
      GoRouter.of(context).routeInformationProvider.value.uri.path.startsWith('/settings');

  static const Curve animationCurve = Curves.easeInOut;

  static ThemeData customTheme(Brightness brightness, [Color? seed]) {
    //hier die genauen hexes angeben je nachdme wie es in der cloud steht
    Color defaultSeed = seed ?? AppTheme.primaryColor;

    if (defaultSeed == const Color(0xffffffff) || defaultSeed == const Color(0xff000000)) {
      if (brightness == Brightness.dark) {
        ColorScheme colorScheme = ColorScheme(
          onPrimaryContainer: Colors.white,
          // onPrimaryFixed: AppTheme.white80,
          // onPrimaryFixedVariant: AppTheme.white80,
          primary: AppTheme.colorBitcoin,
          secondary: AppTheme.secondaryColor,
          secondaryContainer: Colors.black,
          primaryContainer: Colors.black,
          tertiary: Colors.black,
          // tertiary: AppTheme.colorBackground,
          tertiaryContainer: Colors.black,
          brightness: Brightness.dark,
          onPrimary: AppTheme.white80,

          onSecondary: Colors.black,
          error: AppTheme.errorColor,
          onError: AppTheme.errorColor,
          surface: Colors.black,
          onSurface: Colors.white,
        );
        ThemeData themeData = ThemeData.from(
          colorScheme: colorScheme,
          textTheme: brightness == Brightness.light ? fallbackTextTheme.merge(textTheme) : fallbackTextTheme.merge(textThemeDarkMode),
        );
        return themeData;
      } else {
        //lightmode
        ColorScheme colorScheme = const ColorScheme(
          brightness: Brightness.light,
          onPrimaryContainer: Colors.black,
          onPrimary: Colors.black,
          onSecondaryContainer: Colors.black,
          onSecondary: Colors.black,
          primary: AppTheme.colorBitcoin,
          onSurface: Colors.black,
          secondary: AppTheme.secondaryColor,
          secondaryContainer: Color(0xfff2f2f2),
          primaryContainer: Color(0xfff2f2f2),
          tertiary: Color(0xfff2f2f2),
          tertiaryContainer: Color(0xfff2f2f2),
          error: AppTheme.errorColor,
          onError: AppTheme.errorColor,
          surface: Color(0xfff2f2f2),
        );
        ThemeData themeData = ThemeData.from(
          colorScheme: colorScheme,
          textTheme: fallbackTextTheme.merge(textTheme),
        );
        return themeData;
      }
    } else {
      ColorScheme colorScheme = ColorScheme.fromSeed(
        seedColor: defaultSeed,
        brightness: brightness,
      );
      ThemeData themeData = ThemeData.from(
        colorScheme: colorScheme,
        textTheme: brightness == Brightness.light ? fallbackTextTheme.merge(textTheme) : fallbackTextTheme.merge(textThemeDarkMode),
      );
      return themeData;
    }
  }
}

extension on Brightness {
  Brightness get reversed => this == Brightness.dark ? Brightness.light : Brightness.dark;
}

/// Darken a color by [percent] amount (100 = black)
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(), (c.blue * f).round());
}

/// Lighten a color by [percent] amount (100 = white)
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha, c.red + ((255 - c.red) * p).round(), c.green + ((255 - c.green) * p).round(), c.blue + ((255 - c.blue) * p).round());
}

dynamic qrCodeSize(BuildContext context) => min(AppTheme.cardPadding * 9.5, AppTheme.cardPadding * 9.5).toDouble();
