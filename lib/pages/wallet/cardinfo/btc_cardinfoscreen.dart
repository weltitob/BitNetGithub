import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';

class BitcoinCardInformationScreen extends StatefulWidget {
  const BitcoinCardInformationScreen({super.key});

  @override
  State<BitcoinCardInformationScreen> createState() => _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState extends State<BitcoinCardInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        body: Container(),
        appBar: bitnetAppBar(
          text: "Bitcoin Card Information",
          context: context,
        ),
        context: context
    );
  }
}
