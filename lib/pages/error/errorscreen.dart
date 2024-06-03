import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        body: Container(
          child: Center(
            child: Text("Error"),
          ),
        ),
        context: context);
  }
}
