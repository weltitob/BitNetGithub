import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/custom_scroll_behaviour.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/loaders/empty_page.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:app_links/app_links.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_helper.dart';
import 'package:bitnet/backbone/security/security.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';



class WidgetTree extends StatefulWidget {
  static GlobalKey<NavigatorState>? routerKey = GlobalKey<NavigatorState>();

  
  const WidgetTree({Key? key}) : super(key: key);

  /// getInitialLink may rereturn the value multiple times if this view is
  /// opened multiple times for example if the user logs out after they logged
  /// in with qr code or magic link.
  static bool gotInitialLink = false;

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  @override
  initState() {
    super.initState();


    //getclientsfunc();
    isBiometricsAvailable();
    _appLinks = AppLinks(
      onAppLink: (Uri uri, String string) {
        // Handle the deep link here. You can push to a new page, or perform
        // some action based on the data in the URI.
        print('Got deep link: $uri');
      },
    );
  }

  bool hasBiometrics = true;
  late bool isSecurityChecked;
  bool isBioAuthenticated = false;

  //add applinks later on to make transactions even easier where all qrs are involved
  //send and receive bitcoin applinks (deeplinks)
  //also restore account applinks
  late final AppLinks _appLinks;
  String? _initialUrl;

  bool? columnMode;

  @override
  void dispose() {
    super.dispose();
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if (isSecurityChecked == true) {
      hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        isBioAuthenticated = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated == false;
      }
      setState(() {});
    } else {
      hasBiometrics = false;
    }
  }

  getclientsfunc() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
 if(kIsWeb) {
  _initialUrl = '/website';
   } else {
    if(Auth().currentUser != null) {
      _initialUrl = '/feed';
    } else {
      _initialUrl = '/authhome';
    }
   }

    });
  
  }

  @override
  Widget build(BuildContext context) {
    //not sure what about this userData because this gets requested too and must be given when it loads till infinity it probably is because we miss the userData
    final userData = Provider.of<UserData?>(context);
    final provider = Provider.of<LocalProvider>(context);

    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => LayoutBuilder(
        builder: (context, constraints) {
          final isColumnMode =
              AppTheme.isColumnModeByWidth(constraints.maxWidth);
          if (isColumnMode != columnMode) {
            Logs().v('Set Column Mode = $isColumnMode');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                //#TODO: Check this out later
                _initialUrl ="/loading";
                columnMode = isColumnMode;
              });
            });
          }
          print("running");
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: false,
              splitScreenMode: false,
              builder: (_, child) {
                return MaterialApp.router(
                //  key: WidgetTree.routerKey,
                  routerConfig: AppRouter.router,
                  title: AppTheme.applicationName,
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: AppTheme.customTheme(Brightness.light, primaryColor),
                  darkTheme: AppTheme.customTheme(Brightness.dark, primaryColor),
                  scrollBehavior: CustomScrollBehavior(),
                  locale: provider.locale,
                  supportedLocales: L10n.supportedLocales,
                  localizationsDelegates: const [
                    L10n.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) =>
                      //child,
                      // (_isLoadingClients)
                      //     ? EmptyPage(
                      //         loading: true, text: "Clients still loading...")
                      //     :
                          //WebsiteLandingPage(),
                          Matrix(
                              context: context,
                              child: child,
                            ),

                  // : StreamBuilder(
                  //     stream: Auth().authStateChanges,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return EmptyPage(
                  //           loading: true,
                  //           text: snapshot.error.toString(),
                  //         );
                  //       }
                  //       //causes loading when switched anywhere in the app basically lol
                  //       // if (snapshot.connectionState ==
                  //       //     ConnectionState.waiting) {
                  //       //   return EmptyPage(
                  //       //     loading: true,
                  //       //     text:
                  //       //         "Loading something (authstate changes or request smth etc.)",
                  //       //   );
                  //       // }
                  //       if (snapshot.hasData) {
                  //         return
                  //           //WebsiteLandingPage();
                  //         Matrix(
                  //           context: context,
                  //           router: WidgetTree.routerKey,
                  //           clients: clients,
                  //           child: child,
                  //         );
                  //       }
                  //       return
                  //         //WebsiteLandingPage();
                  //         Matrix(
                  //         context: context,
                  //         router: WidgetTree.routerKey,
                  //         clients: clients,
                  //         child: child,
                  //       );
                  //     },
                  //   ),
                );
              });
        },
      ),
    );
  }

  int? primaryColor;
  SharedPreferences? preferences;

  // Future getColor() async {
  //   preferences = await SharedPreferences.getInstance();
  //   var data = await settingsCollection.doc(profileId).get();
  //   primaryColor = data['primary_color'];
  //   setState(() {});
  //   return primaryColor.toString();
  // }
  //
  // ThemeMode? theme_mode;
  //
  // Future getBrightness() async {
  //   preferences = await SharedPreferences.getInstance();
  //   String theme = preferences!.getString("theme_mode") ?? '';
  //   print('theeme');
  //   print(theme);
  //   setState(() {});
  //   return theme_mode.toString();
  // }

}
