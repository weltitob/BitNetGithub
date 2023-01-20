import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

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
  static BorderRadius cardRadiusSuperSmall = BorderRadius.circular(8);
  static BorderRadius cardRadiusSmall = BorderRadius.circular(14);
  static BorderRadius cardRadiusMid = BorderRadius.circular(20);
  static BorderRadius cardRadiusBig = BorderRadius.circular(24);
  static BorderRadius cardRadiusBigger = BorderRadius.circular(32);
  static Radius cornerRadiusBig = const Radius.circular(24);
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
    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
    ),
  );

  static ThemeData standardTheme() => ThemeData(
    //later change seed to the one selected
    colorSchemeSeed: AppTheme.colorBitcoin,
    backgroundColor: AppTheme.colorBackground,
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: textThemeDarkMode,
  );

  static final textTheme = TextTheme(
    headline1: GoogleFonts.inter(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5
    ),
    headline3: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.0,
    ),
    headline4: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    headline6: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    subtitle2: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
    bodyText1: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyText2: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    caption: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    ),
    overline: GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
  );

  static final textThemeDarkMode = textTheme.copyWith(
    headline1: textTheme.headline1!.copyWith(
      color: AppTheme.white90,
    ),
    headline2: textTheme.headline2!.copyWith(
      color: AppTheme.white90,
    ),
    headline3: textTheme.headline3!.copyWith(
      color: AppTheme.white90,
    ),
    headline4: textTheme.headline4!.copyWith(
      color: AppTheme.white90,
    ),
    headline5: textTheme.headline5!.copyWith(
      color: AppTheme.white90,
    ),
    headline6: textTheme.headline6!.copyWith(
      color: AppTheme.white90,
    ),
    subtitle1: textTheme.subtitle1!.copyWith(
      color: AppTheme.white70,
    ),
    subtitle2: textTheme.subtitle2!.copyWith(
      color: AppTheme.white70,
    ),
    bodyText1: textTheme.bodyText1!.copyWith(
      color: AppTheme.white60,
    ),
    bodyText2: textTheme.bodyText2!.copyWith(
      color: AppTheme.white60,
    ),
    caption: textTheme.caption!.copyWith(
      color: AppTheme.white60,
    ),
    overline: textTheme.overline!.copyWith(
      color: AppTheme.white60,
    ),
    button: textTheme.button!.copyWith(
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