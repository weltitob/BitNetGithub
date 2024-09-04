import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FiatCardInfoScreen extends StatefulWidget {
  const FiatCardInfoScreen({super.key});

  @override
  State<FiatCardInfoScreen> createState() => _FiatCardInfoScreenState();
}

class _FiatCardInfoScreenState extends State<FiatCardInfoScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: "Fiat Card Information Screen",
      ),
      context: context,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go("/feed");
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppTheme.cardPadding * 3),
                child: Container(
                  height: AppTheme.cardPadding * 7.5,
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: const FiatCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
