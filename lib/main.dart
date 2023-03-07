import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/widgettree.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Wallet',
      theme: AppTheme.standardTheme(),
      home: const WidgetTree(),
    );
  }
}

