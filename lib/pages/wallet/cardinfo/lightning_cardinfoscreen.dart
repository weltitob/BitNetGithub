import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LightningCardInformationScreen extends StatelessWidget {
  const LightningCardInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        body: Container(),
        appBar: bitnetAppBar(
          text: "Lightning Card Information",
          context: context,
          onTap: () {
            context.go("/feed");
          },
        ),
        context: context);
  }
}
