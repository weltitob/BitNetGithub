import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/get_it.dart';
import 'package:nexus_wallet/backbone/streams/bitcoinpricestream.dart';
import 'package:nexus_wallet/backbone/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/routetrees/widgettree.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'backbone/auth/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetItService.initializeService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserWallet?>(
          create: (_) => Auth().userWalletStreamForAuthChanges,
          initialData: null,
        ),
        StreamProvider<UserWallet?>(
          create: (_) => Auth().userWalletStream,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nexus Wallet',
        theme: AppTheme.standardTheme(),
        home: const WidgetTree(),
      ),
    );
  }
}

