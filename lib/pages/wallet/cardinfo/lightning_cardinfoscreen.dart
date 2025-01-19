import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/inbound_liquidity.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/cardinfo/controller/lightning_info_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LightningCardInformationScreen extends StatefulWidget {
  const LightningCardInformationScreen({super.key});

  @override
  State<LightningCardInformationScreen> createState() =>
      _LightningCardInformationScreenState();
}

class _LightningCardInformationScreenState
    extends State<LightningCardInformationScreen> {
  late ScrollController scrollController;
  bool loadedLiquidity = false;
  int liquidity = 0;
  BitcoinUnitModel? liquidityUnitModel;
  String liquidityCurrBalance = '';
  String liquidityCurrSymbol = '';

  @override
  void initState() {


    // inboundLiquidity().then((response) {
    //   if (response.data.isEmpty) {
    //     liquidity = -1;
    //     loadedLiquidity = true;
    //     setState(() {});
    //   } else {
    //     liquidity = response.data['liquidity'].toInt();
    //     liquidityUnitModel = CurrencyConverter.convertToBitcoinUnit(liquidity.toDouble(), BitcoinUnits.SAT);
    //     String? currency = Provider.of<CurrencyChangeProvider>(context, listen: false).selectedCurrency;
    //     currency = currency ?? "USD";
    //     final chartLine = Get.find<WalletsController>().chartLines.value;
    //     final bitcoinPrice = chartLine?.price;
    //
    //     liquidityCurrBalance = CurrencyConverter.convertCurrency(
    //         liquidityUnitModel!.bitcoinUnitAsString, (liquidityUnitModel!.amount as num).toDouble(), currency, bitcoinPrice);
    //     liquidityCurrSymbol = getCurrency(currency);
    //     loadedLiquidity = true;
    //     setState(() {});
    //   }
    // });

    // controller.loadingState.listen((val) {
    //   setState(() {});
    // });
    super.initState();
    scrollController = ScrollController();

    // WalletsController walletController = Get.find<WalletsController>();
    //
    // final logger = Get.find<LoggerService>();
    // RxList<TransactionItemData> allActivity = walletController.allTransactions;
    //
    // logger.i("allActivity: $allActivity");
    //
    // transactions = allActivity
    //     .map((txData) => TransactionItem(data: txData))
    //     .toList();
    //
    // logger.i("transactions: $transactions");
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // String? currency =
    //     Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    // currency = currency ?? "USD";
    // final controller = Get.put(LightningInfoController());
    // final lightningInfoController = Get.find<LightningInfoController>();
    WalletsController walletController = Get.find<WalletsController>();

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: L10n.of(context)!.lightningCardInfo,
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
                        padding: const EdgeInsets.only(
                            top: AppTheme.cardPadding * 3),
                        child: Container(
                          height: AppTheme.cardPadding * 7,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding),
                          child: Obx(() {
                            final confirmedBalanceStr =
                                walletController
                                    .lightningBalance
                                    .value
                                    .balance
                                    .obs;

                            return BalanceCardLightning(
                              balance:
                              confirmedBalanceStr.value,
                              confirmedBalance:
                              confirmedBalanceStr.value,
                              defaultUnit:
                              BitcoinUnits.SAT,
                            );
                          }),
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //     child: Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                    //   child: BitNetListTile(
                    //     text: "Possible Capacity", //this is the inbound liquidity of the users node
                    //     trailing: loadedLiquidity
                    //         ? liquidity == -1
                    //             ? const Text('Error')
                    //             : AmountPreviewer(
                    //                 unitModel: liquidityUnitModel!,
                    //                 textStyle: Theme.of(context).textTheme.bodyMedium!,
                    //                 textColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    //               )
                    //         : dotProgress(context),
                    //   ),
                    // )),

                    SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppTheme.cardPadding.h * 1.75),
                              Text("Chart",
                                  style: Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: AppTheme.elementSpacing.h),
                            ],
                          ),
                        )),
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          child: CryptoItem(
                            context: context,
                            currency: Currency(
                              name: "Bitcoin",
                              code: "BTC",
                              icon: Image.asset("assets/images/bitcoin.png"),
                              // image: Image.asset("assets/images/bitcoin.png"),
                            ),

                          ),
                        )
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppTheme.cardPadding.h * 1.75),
                          Text(L10n.of(context)!.activity,
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: AppTheme.elementSpacing.h),
                        ],
                      ),
                    )),
                    Transactions(
                            // hideLightning: false,
                            hideOnchain: true,
                            // fullList: true,
                            filters: ['Lightning'],
                            // customTransactions: transactions,
                            scrollController: scrollController,
                          ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 20.0),
                    ),
                  ],
                ),
        ),
    );
  }
}
