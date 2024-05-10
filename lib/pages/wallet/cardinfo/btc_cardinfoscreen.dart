import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BitcoinCardInformationScreen extends StatelessWidget {
  const BitcoinCardInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        onTap: () {
          context.go("/feed");
        },
        text: "Bitcoin Card Information",
        context: context,
      ),
      context: context,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 60.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: BalanceCardBtc(),
            ),
          ],
        ),
      ),
    );
  }
}
