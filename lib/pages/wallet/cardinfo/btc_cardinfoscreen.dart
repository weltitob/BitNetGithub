import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BitcoinCardInformationScreen extends StatefulWidget {
  BitcoinCardInformationScreen({super.key});

  @override
  State<BitcoinCardInformationScreen> createState() => _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState extends State<BitcoinCardInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());
  final homeController = Get.put(HomeController());
  bool isLoadingAddress = false;

  @override
  void initState() {
    controller.getAddressComponent('bc1p5lfahjz2j3679ynqy4fu8tvteem92fuqfqfsax7vx97lyr3vhkwqlxjh5e');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: L10n.of(context)!.bitcoinInfoCard,
      ),
      context: context,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go("/feed");
        },
        child: Obx(
          () => controller.isLoadingAddress.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: BalanceCardBtc(),
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: BitNetListTile(
                    //     text: L10n.of(context)!.address,
                    //     trailing: Text(
                    //       'bc1qkmlp...' + '30fltzunefdjln',
                    //       style: Theme.of(context).textTheme.bodyMedium,
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: BitNetListTile(
                    //     text: L10n.of(context)!.scanQr,
                    //     trailing: Container(
                    //       padding: const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                    //       height: 200,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: AppTheme.cardRadiusBigger,
                    //       ),
                    //       child: PrettyQrView.data(
                    //         data: "bc1qkmlpuea96ekcjlk2wpjhsrr030fltzunefdjln",
                    //         decoration: const PrettyQrDecoration(
                    //           shape: PrettyQrSmoothSymbol(
                    //             roundFactor: 1,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: const SizedBox(height: 10),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: BitNetListTile(
                    //     text: L10n.of(context)!.totalReceived,
                    //     trailing: Row(
                    //       children: [
                    //         Text(
                    //           '${((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                    //           style: Theme.of(context).textTheme.bodyMedium,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: const SizedBox(height: 5),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: BitNetListTile(
                    //     text: L10n.of(context)!.totalSent,
                    //     trailing: Row(
                    //       children: [
                    //         Text(
                    //           '${((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                    //           style: Theme.of(context).textTheme.bodyMedium,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: const SizedBox(height: 5),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: BitNetListTile(
                    //     text: L10n.of(context)!.balance,
                    //     trailing: Row(
                    //       children: [
                    //         Text(
                    //           '${(((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)).toStringAsFixed(8)} BTC',
                    //           style: Theme.of(context).textTheme.bodyMedium,
                    //         ),
                    //         const SizedBox(width: 5),
                    //         Text(
                    //           '\$${((((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)) * controller.currentUSD.value).toStringAsFixed(2)}',
                    //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(child: SizedBox(height: AppTheme.elementSpacing * 2)),
                    SliverToBoxAdapter(
                      child: Center(
                        child: isLoadingAddress
                            ? CircularProgressIndicator()
                            : LongButtonWidget(
                                title: 'Show Addresses',
                                onTap: () async {
                                  if (!isLoadingAddress) {
                                    setState(() {
                                      isLoadingAddress = true;
                                    });
                                    Map<String, double> finalAddresses = {};
                                    RestResponse response = await listBtcAddresses();
                                    var accounts = response.data['account_with_addresses'] as List;
                                    for (int i = 0; i < accounts.length; i++) {
                                      var addresses = accounts[i]['addresses'];
                                      for (int j = 0; j < addresses.length; j++) {
                                        finalAddresses[addresses[j]['address']] = double.parse(addresses[j]['balance']);
                                      }
                                    }
                                    List<MapEntry<String, double>> sortedAddresses = finalAddresses.entries.toList();

                                    sortedAddresses.sort((a, b) => b.value.compareTo(a.value));

                                    isLoadingAddress = false;
                                    setState(() {});
                                    BitNetBottomSheet(
                                        context: context,
                                        height: MediaQuery.of(context).size.height * 0.65.h,
                                        borderRadius: AppTheme.borderRadiusBig,
                                        child: AddressesWidget(sortedAddresses: sortedAddresses));
                                  }
                                }),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: const SizedBox(height: AppTheme.elementSpacing * 2),
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
      ),
    );
  }
}

class AddressesWidget extends StatefulWidget {
  const AddressesWidget({
    super.key,
    required this.sortedAddresses,
  });

  final List<MapEntry<String, double>> sortedAddresses;

  @override
  State<AddressesWidget> createState() => _AddressesWidgetState();
}

class _AddressesWidgetState extends State<AddressesWidget> {
  String searchPrompt = '';
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      context: context,
      appBar: bitnetAppBar(
        text: 'Your Addresses',
        context: context,
        buttonType: ButtonType.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50),
            SearchFieldWidget(
              hintText: 'Search for specific address',
              isSearchEnabled: true,
              handleSearch: (dynamic) {},
              onChanged: (val) {
                setState(() {
                  searchPrompt = val;
                });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.sortedAddresses.length,
                itemBuilder: (ctx, i) {
                  if (!widget.sortedAddresses[i].key.contains(searchPrompt) && searchPrompt.isNotEmpty) {
                    return Container();
                  }
                  return Container(
                      height: 60,
                      child: BitNetListTile(
                        leading: SizedBox(
                            width: 0.4.sw,
                            child: Text(
                              widget.sortedAddresses[i].key,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            )),
                        trailing: SizedBox(
                            width: 0.3.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  textAlign: TextAlign.end,
                                  widget.sortedAddresses[i].value.toInt().toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(AppTheme.satoshiIcon)
                              ],
                            )),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
