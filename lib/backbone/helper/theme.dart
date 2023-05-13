import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Darken a color by [percent] amount (100 = black)
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

/// Lighten a color by [percent] amount (100 = white)
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}

class AppTheme {
  //borderradius
  static BorderRadius cardRadiusSuperSmall = BorderRadius.circular(10);
  static BorderRadius cardRadiusSmall = BorderRadius.circular(16);
  static BorderRadius cardRadiusMid = BorderRadius.circular(24);
  static BorderRadius cardRadiusBig = BorderRadius.circular(28);
  static BorderRadius cardRadiusBigger = BorderRadius.circular(32);
  static Radius cornerRadiusBig = const Radius.circular(28);
  static Radius cornerRadiusMid = const Radius.circular(24);
  static BorderRadius cardRadiusCircular = BorderRadius.circular(500);

  //Boxshadows
  static BoxShadow boxShadowSmall = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: const Offset(0, 2.5),
    blurRadius: 10,
  );
  static BoxShadow boxShadowBig = const BoxShadow(
    color: Colors.black45,
    offset: Offset(0, 5),
    blurRadius: 8.0,
  );

  static BoxShadow boxShadowProfile = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: const Offset(0, 2.5),
    blurRadius: 10,
  );

  //spaces
  static const double cardPadding = 24;
  static const double cardPaddingBig = 28;
  static const double cardPaddingBigger = 32;
  static const double elementSpacing = cardPadding * 0.5;
  static const double bottomNavBarHeight = 64;

  //sizes
  static const double iconSize = cardPadding;
  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;

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

  static Color glassMorphColor = Colors.black.withOpacity(0.2);
  static Color glassMorphColorLight = Colors.white.withOpacity(0.2);
  static Color glassMorphColorDark = Colors.black.withOpacity(0.3);

  // //bitcoincolors
  // static const Color orange = Color(0xFFFFBD69);
  // static const Color kAccentColor = Color(0xFFFFC107);
  static const Color colorBitcoin = Color(0xfff2a900);
  static const Color colorBackground = Color(0xff150036);
  static const Color colorPrimaryGradient = Color(0xfff25d00);
  //
  //green and red
  static const Color errorColor = Color(0xFFFF6363);
  static const Color successColor = Color(0xFF5DE165);


  static InputDecoration textfieldDecoration(String hintText, BuildContext context) => InputDecoration(
    hintText: hintText,
    contentPadding: const EdgeInsets.all(0.25),
    border: InputBorder.none,
    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
    ),
  );

  static ThemeData customColorTheme(Color color, Brightness brightness) =>
      ThemeData(
        //later change seed to the one selected
        colorSchemeSeed: color,
        useMaterial3: true,
        brightness: brightness,
        textTheme: (brightness == Brightness.light) ? textTheme : textThemeDarkMode,
      );

  static ThemeData standardTheme() => ThemeData(
    //later change seed to the one selected
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: textThemeDarkMode,
    colorScheme: ColorScheme(
        background: AppTheme.colorBackground,
        brightness: Brightness.dark,
        primary: AppTheme.colorBitcoin,
        secondary: AppTheme.colorBitcoin,
        onBackground: AppTheme.white90,
        surface: AppTheme.colorBitcoin,
        onPrimary: AppTheme.colorBitcoin,
        error: AppTheme.colorPrimaryGradient,
        onSecondary: AppTheme.white90,
        onError: AppTheme.errorColor,
        onSurface: AppTheme.colorPrimaryGradient),
  );

  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
    ),
    displayMedium: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.0,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyMedium: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    labelLarge: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w400,
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
      color: AppTheme.white70,
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
    labelLarge: textTheme.labelLarge!.copyWith(
      color: AppTheme.white90,
    ),
  );
  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColorDark: Colors.grey[400],
    primaryColorLight: Colors.grey[800],
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.red,
    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),

    iconTheme: const IconThemeData(color: white100),
    // textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)


    //Theme for Bottom Nav
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white100,
      selectedItemColor: Colors.white70,
      unselectedItemColor: white60,
      selectedIconTheme: IconThemeData(color: white60),
      showUnselectedLabels: true,
    ),
  );
}