import 'package:BitNet/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:provider/provider.dart';
import 'backbone/auth/auth.dart';
import 'generated/l10n.dart';
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
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(const MyApp());
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
      child: MaterialApp(
        //multilanguage support
        localizationsDelegates: [
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales, // Add this line
        // Other properties like theme, home, etc.
        debugShowCheckedModeBanner: false,
        title: 'BitNet',
        theme: AppTheme.standardTheme(),
        home: const WidgetTree(),
      ),
    );
  }
}
