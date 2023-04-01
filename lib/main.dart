import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/streams/bitcoinpricestream.dart';
import 'package:nexus_wallet/backbone/helper/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nexus_wallet/components/chart/chart.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/routetrees/widgettree.dart';
import 'package:provider/provider.dart';
import 'backbone/auth/auth.dart';

// Main function to start the application
Future<void> main() async {
  // Ensure that Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

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
        StreamProvider<UserWallet?>(
          create: (_) => Auth().userWalletStream,
          initialData: null,
        ),
        // Provide a stream of user wallet data for authentication changes
        //this has to be below in order to overwrite the null when not authenticated yet from above stream
        StreamProvider<UserWallet?>(
          create: (_) => Auth().userWalletStreamForAuthChanges,
          initialData: null,
        ),
        // Provide a stream of user wallet data
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BitNet',
        theme: AppTheme.standardTheme(),
        home: const WidgetTree(),
      ),
    );
  }
}