import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/theme/theme_builder.dart';
import 'package:BitNet/components/loaders/empty_page.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/matrix/utils/other/background_push.dart';
import 'package:BitNet/pages/matrix/utils/other/custom_scroll_behaviour.dart';
import 'package:BitNet/pages/matrix/utils/other/platform_infos.dart';
import 'package:BitNet/pages/routetrees/matrix.dart';
import 'package:BitNet/pages/routetrees/routes.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';
import 'package:BitNet/backbone/security/security.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../matrix/utils/other/client_manager.dart';

class WidgetTree extends StatefulWidget {
  static GlobalKey<VRouterState> routerKey = GlobalKey<VRouterState>();

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
    getclientsfunc();
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
  late List<Client> clients;
  bool _isLoadingClients = true;

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
    try {
      clients = await ClientManager.getClients();
      setState(() {
        _isLoadingClients = false;
      });
      print("Fetched clients: ${clients.toString()}");
      // Preload first client if we have clients
      print("If now firstornullerror its here...");
      final firstClient = clients.isNotEmpty ? clients.first : null;
      print("First client: $firstClient");

      await firstClient?.roomsLoading;
      await firstClient?.accountDataLoading;
      print("clients after loading: $clients");

      if (PlatformInfos.isMobile) {
        BackgroundPush.clientOnly(clients.first);
      }
      final queryParameters = <String, String>{};

      //why is this line executed try with own mobile phone next
      if (kIsWeb) {
        queryParameters
            .addAll(Uri.parse(html.window.location.href).queryParameters);
      }

      print("Loading should be finished");
    } catch (e) {
      throw Exception("error loading matrix: $e");
    }
    if (clients.isNotEmpty) {
      print('Client is not null so this gets triggered...');
      _initialUrl =
          clients.any((client) => client.isLogged()) ? '/feed' : '/authhome';
    } else {
      print('Client seems to be null...');
      _initialUrl = '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    //not sure what about this userData because this gets requested too and must be given when it loads till infinity it probably is because we miss the userData
    final userData = Provider.of<UserData?>(context);

    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => LayoutBuilder(
        builder: (context, constraints) {
          final isColumnMode =
              AppTheme.isColumnModeByWidth(constraints.maxWidth);
          if (isColumnMode != columnMode) {
            Logs().v('Set Column Mode = $isColumnMode');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _initialUrl = WidgetTree.routerKey.currentState?.url;
                columnMode = isColumnMode;
                WidgetTree.routerKey = GlobalKey<VRouterState>();
              });
            });
          }
          return VRouter(
            key: WidgetTree.routerKey,
            title: AppTheme.applicationName,
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme:
                //AppTheme.standardTheme(),
                AppTheme.customTheme(Brightness.light, primaryColor),
            darkTheme:
                //AppTheme.standardTheme(),
                AppTheme.customTheme(Brightness.dark, primaryColor),
            scrollBehavior: CustomScrollBehavior(),
            logs: kReleaseMode ? VLogs.none : VLogs.info,
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            initialUrl: _initialUrl ?? '/',
            routes: AppRoutes(columnMode ?? false).routes,
            builder: (context, child) =>
                //child,
                (_isLoadingClients)
                    ? EmptyPage(loading: true, text: "Clients still loading...")
                    // : Matrix(
                    //     context: context,
                    //     router: WidgetTree.routerKey,
                    //     clients: clients,
                    //     child: child,
                    //   ),

                    : StreamBuilder(
                        stream: Auth().authStateChanges,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return EmptyPage(
                              loading: true,
                              text: snapshot.error.toString(),
                            );
                          }
                          //causes loading when switched anywhere in the app basically lol
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          //   return EmptyPage(
                          //     loading: true,
                          //     text:
                          //         "Loading something (authstate changes or request smth etc.)",
                          //   );
                          // }
                          if (snapshot.hasData) {
                            return Matrix(
                              context: context,
                              router: WidgetTree.routerKey,
                              clients: clients,
                              child: child,
                            );
                          }
                          return Matrix(
                            context: context,
                            router: WidgetTree.routerKey,
                            clients: clients,
                            child: child,
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
