import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class LightningCardInformationScreen extends StatelessWidget {
  const LightningCardInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        body: PopScope(
            canPop: false,
            onPopInvoked: (v) {
              context.go("/feed");
            },
            child: Container()),
        appBar: bitnetAppBar(
          text: L10n.of(context)!.lightningCardInfo,
          context: context,
          onTap: () {
            context.go("/feed");
          },
        ),
        context: context);
  }
}
