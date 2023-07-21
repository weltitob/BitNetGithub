import 'package:BitNet/backbone/helper/theme/theme_builder.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/matrix/config/app_config.dart';
import 'package:BitNet/pages/matrix/utils/other/background_push.dart';
import 'package:BitNet/pages/matrix/utils/other/custom_scroll_behaviour.dart';
import 'package:BitNet/pages/matrix/utils/other/platform_infos.dart';
import 'package:BitNet/pages/routetrees/matrix.dart';
import 'package:BitNet/pages/matrix_chat_app.dart';
import 'package:BitNet/pages/routetrees/routes.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';
import 'package:BitNet/backbone/security/security.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/pages/bottomnav.dart';
import 'package:BitNet/pages/routetrees/getstartedtree.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../matrix/utils/other/client_manager.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  bool hasBiometrics = true;
  late bool isSecurityChecked;
  bool isBioAuthenticated = false;

  //add applinks later on to make transactions even easier where all qrs are involved
  //send and receive bitcoin applinks (deeplinks)
  //also restore account applinks
  late final AppLinks _appLinks;

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

  bool? columnMode;
  String? _initialUrl;
  dynamic clients;
  bool _isLoading = true;

  getclientsfunc() async {
    try{
      clients = await ClientManager.getClients();
      // Preload first client
      final firstClient = clients.firstOrNull;
      await firstClient?.roomsLoading;
      await firstClient?.accountDataLoading;

      if (PlatformInfos.isMobile) {
        BackgroundPush.clientOnly(clients.first);
      }

      final queryParameters = <String, String>{};
      //why is this line executed try with own mobile phone next
      if (kIsWeb) {
        queryParameters
            .addAll(Uri.parse(html.window.location.href).queryParameters);
      }

      _initialUrl =
      clients.any((client) => client.isLogged()) ? '/rooms' : '/home';
      _isLoading = false;
      print("Loading should be finished");
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      setState(() {
        _isLoading = false;
      });
      throw Exception("error loading matrix: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    //hier schon das erste mal aufrufen aber noch mit Fragezeichen >> daruch kann noch nicht null sein
    final userData = Provider.of<UserData?>(context);

    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (userData == null) {
            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 20)),
              builder: (context, snapshot) {
                // If Future is still running, show the loading progress
                //while retriving userData
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).colorScheme.background,
                    child: Center(
                      child: dotProgress(context),
                    ),
                  );
                }
                // If Future is completed, show the error message and a log out button
                //this is when the user is somehow logged in in the firebaseauth but we cant retrive the UserData correctly
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(AppTheme.cardPadding * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Something went wrong, please check your connection and try again later.",
                          style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
                          SizedBox(height: AppTheme.cardPadding,),
                          LongButtonWidgetTransparent(title: "Sign out", onTap:
                          (){
                            Auth().signOut();}
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        } //when userdata isnt null anymore (listening to Stream)
          if (isBioAuthenticated == true || hasBiometrics == false) {
            return _isLoading
                ? Center(child: dotProgress(context))
                : ThemeBuilder(
                  builder: (context, themeMode, primaryColor) => LayoutBuilder(
                    builder: (context, constraints) {
                      final isColumnMode = AppTheme.isColumnModeByWidth(constraints.maxWidth);
                      if (isColumnMode != columnMode) {
                        Logs().v('Set Column Mode = $isColumnMode');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _initialUrl = MatrixChatApp.routerKey.currentState?.url;
                            columnMode = isColumnMode;
                            MatrixChatApp.routerKey = GlobalKey<VRouterState>();
                          });
                        });
                      }
                      return BottomNav();
                    },
                  ),
                );
          }
          return Container(
            color: AppTheme.colorBackground,
            child: Center(
                child: Text("There is an issue please contact the support")),
          );
        } else {
          return GetStartedTree();
        }
      },
    );
  }
}
