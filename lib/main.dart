import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/secondpages/lock_screen.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:provider/provider.dart';
import 'backbone/auth/auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:universal_html/html.dart' as html; // Changed from 'dart:html'
import 'package:BitNet/pages/matrix/utils/other/platform_infos.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

//import 'firebase_options.dart';

late ThemeData activeTheme;
late Brightness brightness;

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  ThemeNotifier(this._themeData);
  ThemeData get getTheme => _themeData;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}

// Main function to start the application
Future<void> main() async {
  void onAppLink() {
    print("APPLINK WAS TRIGGERED");
  }

  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Date Formatting
  await initializeDateFormatting();

  // Initialize Firebase
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  Logs().nativeColors = !PlatformInfos.isIOS;
  // Run the app
  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) =>
                //matrix_chat_app.dart apply later
                const MyApp(),
            lockScreen: const LockScreen(),
            enabled: false,
          )
        : const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserData?>(
          create: (_) => Auth().userWalletStream,
          initialData: null,
        ),
        // Provide a stream of user wallet data for authentication changes
        //this has to be below in order to overwrite the null when not authenticated yet from above stream
        StreamProvider<UserData?>(
          create: (_) => Auth().userWalletStreamForAuthChanges,
          initialData: null,
        ),
        // Provide a stream of user wallet data
      ],
      child: WidgetTree(),
    );
  }
}
