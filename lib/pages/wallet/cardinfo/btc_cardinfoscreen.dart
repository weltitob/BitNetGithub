import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/loaders/loaders.dart';
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
  State<BitcoinCardInformationScreen> createState() =>
      _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState
    extends State<BitcoinCardInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());
  final homeController = Get.put(HomeController());

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
                  height: AppTheme.cardPadding * 7.5,
                  padding:
                      EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: BalanceCardBtc(),
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
                  trailing: Text("Show"),
                  onTap: () async {

                      BitNetBottomSheet(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.65.h,
                          borderRadius: AppTheme.borderRadiusBig,
                          child: AddressesWidget());
                    }
                ),
              )),
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
              ),
            ),
            Transactions(
              hideLightning: true,
              hideOnchain: true,
              filters: [L10n.of(context)!.onchain],
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}

class AddressesWidget extends StatefulWidget {
  AddressesWidget({
    super.key,
  });

  @override
  State<AddressesWidget> createState() => _AddressesWidgetState();
}

class _AddressesWidgetState extends State<AddressesWidget> {

  String searchPrompt = '';
  bool isLoadingAddress = false;
  late List<MapEntry<String, double>> sortedAddresses;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    loadData();
  }

  void loadData() async {
    if (!isLoadingAddress) {
      setState(() {
        isLoadingAddress = true;
      });
      Map<String, double> finalAddresses = {};
      RestResponse response = await listBtcAddresses();
      var accounts =
      response.data['account_with_addresses'] as List;
      for (int i = 0; i < accounts.length; i++) {
        var addresses = accounts[i]['addresses'];
        for (int j = 0; j < addresses.length; j++) {
          finalAddresses[addresses[j]['address']] =
              double.parse(addresses[j]['balance']);
        }
      }
      List<MapEntry<String, double>> sortedAddresses =
      finalAddresses.entries.toList();

      sortedAddresses
          .sort((a, b) => b.value.compareTo(a.value));

      isLoadingAddress = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
        height: AppTheme.cardPadding * 6,
        child: Center(
          child: dotProgress(context),
        ),
      )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: AppTheme.cardPadding * 3),
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
                    height: AppTheme.cardPadding * 6,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: sortedAddresses.length,
                      itemBuilder: (ctx, i) {
                        if (!sortedAddresses[i].key
                                .contains(searchPrompt) &&
                            searchPrompt.isNotEmpty) {
                          return Container();
                        }
                        return BitNetListTile(
                          leading: SizedBox(
                              width: 0.4.sw,
                              child: Text(
                                sortedAddresses[i].key,
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
                                    sortedAddresses[i].value
                                        .toInt()
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(AppTheme.satoshiIcon)
                                ],
                              )),
                          onTap: () {
                            context.go(
                                '/wallet/bitcoincard/btcaddressinfo/${sortedAddresses[i].key}',
                                extra: sortedAddresses[i].value);
                          },
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
