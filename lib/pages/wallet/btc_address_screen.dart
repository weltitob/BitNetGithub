import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class BitcoinAddressInformationScreen extends StatefulWidget {
  BitcoinAddressInformationScreen({super.key, required this.state});
  final GoRouterState state;
  @override
  State<BitcoinAddressInformationScreen> createState() => _BitcoinAddressInformationScreenState();
}

class _BitcoinAddressInformationScreenState extends State<BitcoinAddressInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());
  final homeController = Get.put(HomeController());
  bool isLoadingAddress = false;

  @override
  void initState() {
    controller.getAddressComponent(widget.state.pathParameters['address']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String address = widget.state.pathParameters['address']!;
    double balance = CurrencyConverter.convertSatoshiToBTC((widget.state.extra! as double));
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price;

    String currBalance = CurrencyConverter.convertCurrency('BTC', balance, currency, bitcoinPrice);
    String currSymbol = getCurrency(currency);
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: L10n.of(context)!.bitcoinInfoCard,
      ),
      context: context,
      body: Obx(
        () => controller.isLoadingAddress.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 60.0),
                  //     child: Container(
                  //       height: 200,
                  //       padding: EdgeInsets.symmetric(horizontal: 12.0),
                  //       child: BalanceCardBtc(),
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Container(
                        margin: const EdgeInsets.all(AppTheme.cardPadding * 2),
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                          // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                          child: CustomPaint(
                            foregroundPainter: Theme.of(context).brightness == Brightness.light ? BorderPainterBlack() : BorderPainter(),
                            child: Container(
                              padding: const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                              margin: const EdgeInsets.all(AppTheme.cardPadding),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: AppTheme.cardRadiusBigger),
                              child: PrettyQrView.data(
                                  data: address,
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      roundFactor: 1,
                                    ),
                                    image: PrettyQrDecorationImage(
                                      image: const AssetImage('assets/images/bitcoin.png'),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BitNetListTile(
                      text: L10n.of(context)!.address,
                      trailing: Text(
                        address,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: const SizedBox(height: 10),
                  ),
                  SliverToBoxAdapter(
                    child: BitNetListTile(
                      text: L10n.of(context)!.totalReceived,
                      trailing: Row(
                        children: [
                          Text(
                            '${((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 5),
                  ),
                  SliverToBoxAdapter(
                    child: BitNetListTile(
                      text: L10n.of(context)!.totalSent,
                      trailing: Row(
                        children: [
                          Text(
                            '${((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 5),
                  ),
                  SliverToBoxAdapter(
                    child: BitNetListTile(
                      text: L10n.of(context)!.balance,
                      trailing: Row(
                        children: [
                          Text(
                            '${balance.toStringAsFixed(8)} BTC',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$currSymbol $currBalance',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: AppTheme.elementSpacing),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppTheme.cardPadding.h * 1.75),
                          Text(L10n.of(context)!.activity, style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: AppTheme.elementSpacing.h),
                        ],
                      ),
                    ),
                  ),
                  Transactions(hideLightning: true, hideOnchain: true, filters: [L10n.of(context)!.onchain]),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
