import 'dart:collection';

import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BitcoinCardInformationScreen extends StatefulWidget {
  const BitcoinCardInformationScreen({super.key});

  @override
  State<BitcoinCardInformationScreen> createState() =>
      _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState
    extends State<BitcoinCardInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());
  final homeController = Get.put(HomeController());
  WalletsController walletController = Get.find<WalletsController>();

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
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppTheme.cardPadding * 3),
                child: Container(
                  height: AppTheme.cardPadding * 7,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Obx(() {
                    final logger = Get.find<LoggerService>();
                    final confirmedBalanceStr = walletController
                        .onchainBalance.value.confirmedBalance.obs;
                    final unconfirmedBalanceStr = walletController
                        .onchainBalance.value.unconfirmedBalance.obs;

                    logger.i(
                      "Confirmed Balance onchain: $confirmedBalanceStr",
                    );
                    logger.i(
                      "Unconfirmed Balance onchain: $unconfirmedBalanceStr",
                    );

                    return BalanceCardBtc(
                      balance: confirmedBalanceStr.value,
                      confirmedBalance: confirmedBalanceStr.value,
                      unconfirmedBalance: unconfirmedBalanceStr.value,
                      defaultUnit: BitcoinUnits.SAT,
                    );
                  }),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: BitNetListTile(
                    text: "Addresses",
                    trailing: LongButtonWidget(
                        buttonType: ButtonType.transparent,
                        customWidth: AppTheme.cardPadding * 3,
                        customHeight: AppTheme.cardPadding * 1.25,
                        title: "Show",
                        onTap: () async {
                          BitNetBottomSheet(
                              context: context,
                              height:
                                  MediaQuery.of(context).size.height * 0.65.h,
                              borderRadius: AppTheme.borderRadiusBig,
                              child: const AddressesWidget());
                        }),
                    onTap: () async {
                      BitNetBottomSheet(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.65.h,
                          borderRadius: AppTheme.borderRadiusBig,
                          child: const AddressesWidget());
                    }),
              )),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppTheme.cardPadding.h * 1.75),
                  Text("Chart", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: AppTheme.elementSpacing.h),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: CryptoItem(
                context: context,
                currency: Currency(
                  name: "Bitcoin",
                  code: "BTC",
                  icon: Image.asset("assets/images/bitcoin.png"),
                  // image: Image.asset("assets/images/bitcoin.png"),
                ),
              ),
            )),
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
              ),
            ),
            Transactions(
              hideLightning: true,
              hideOnchain: false,
              filters: [L10n.of(context)!.onchain],
              scrollController: scrollController,
              // newData: Get.find<WalletsController>().newTransactionData,
            ),
          ],
        ),
      ),
    );
  }
}

class AddressesWidget extends StatefulWidget {
  const AddressesWidget({
    super.key,
  });

  @override
  State<AddressesWidget> createState() => _AddressesWidgetState();
}

class _AddressesWidgetState extends State<AddressesWidget> {
  String searchPrompt = '';
  bool isLoadingAddress = true;
  late LinkedHashMap<String, int> sortedAddresses;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    sortedAddresses = await listBtcAddresses();
    isLoadingAddress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, int>> addressEntryList;
    if (!isLoadingAddress) {
      addressEntryList = sortedAddresses.entries.toList();
    } else {
      addressEntryList = List.empty();
    }
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        text: 'Your Addresses',
        context: context,
        buttonType: ButtonType.transparent,
      ),
      body: isLoadingAddress
          ? Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding * 2),
              height: AppTheme.cardPadding * 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: dotProgress(context),
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                  const Text(
                    "Loading your OnChain addresses... This might take a while",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: SearchFieldWidget(
                      hintText: 'Search for specific address',
                      isSearchEnabled: true,
                      handleSearch: (dynamic) {},
                      onChanged: (val) {
                        setState(() {
                          searchPrompt = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: sortedAddresses.length,
                      itemBuilder: (ctx, i) {
                        if (!addressEntryList[i].key.contains(searchPrompt) &&
                            searchPrompt.isNotEmpty) {
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.elementSpacing),
                          child: BitNetListTile(
                            leading: SizedBox(
                                width: 0.4.sw,
                                child: Text(
                                  addressEntryList[i].key,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                                      addressEntryList[i]
                                          .value
                                          .toInt()
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(AppTheme.satoshiIcon)
                                  ],
                                )),
                            onTap: () {
                              context.go(
                                  '/wallet/bitcoincard/btcaddressinfo/${addressEntryList[i].key}',
                                  extra: addressEntryList[i].value);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
