import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BitcoinCardInformationScreen extends StatelessWidget {
  const BitcoinCardInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        body: Container(),
        appBar: bitnetAppBar(
          onTap: () {
            context.go("/feed");
          },
          text: "Bitcoin Card Information",
          context: context,
        ),
        context: context);
  }
}
