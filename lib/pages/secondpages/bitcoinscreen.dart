import 'dart:collection';

import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/cloudfunctions/stripe/createstripeaccount.dart';
import 'package:bitnet/backbone/cloudfunctions/stripe/requestclientsecret.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/components/appstandards/informationwidget.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoinfoitem.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/purchase_sheet_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BitcoinScreen extends StatefulWidget {
  const BitcoinScreen({Key? key}) : super(key: key);

  @override
  State<BitcoinScreen> createState() => _BitcoinScreenState();
}

class _BitcoinScreenState extends State<BitcoinScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.put(BitcoinScreenController());
  final homeController = Get.put(HomeController());
  final transactionController = Get.put(TransactionController());
  late ScrollController scrollController;
  bool isOnchainSelected = true;
  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isOnchainSelected = _tabController.index == 0;
      });
    });
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletsController>();
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.bitcoinChart,
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              // Spacer at the top for AppBar
              SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.cardPadding * 3),
              ),
              
              // Chart Widget
              SliverToBoxAdapter(
                child: const ChartWidget(),
              ),
              
              // Wallet Balances - Tab Bar
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    top: AppTheme.cardPadding,
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Wallets",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.elementSpacing),
                      
                      // Custom Tab Bar 
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                          borderRadius: AppTheme.cardRadiusSmall,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          indicator: BoxDecoration(
                            borderRadius: AppTheme.cardRadiusSmall,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          ),
                          tabs: [
                            Tab(text: "Onchain"),
                            Tab(text: "Lightning"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Balance Cards based on selected tab
              SliverToBoxAdapter(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: isOnchainSelected 
                    ? CrossFadeState.showFirst 
                    : CrossFadeState.showSecond,
                  firstChild: _buildOnchainWallet(context, walletController),
                  secondChild: _buildLightningWallet(context, walletController),
                ),
              ),
              
              // Addresses Widget (only for onchain)
              SliverToBoxAdapter(
                child: isOnchainSelected ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding,
                      vertical: AppTheme.elementSpacing,
                    ),
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
                            height: MediaQuery.of(context).size.height * 0.65.h,
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
                  ),
                ) : SizedBox(),
              ),
              
              // Bitcoin Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.cardPadding),
                  child: InformationWidget(
                    title: L10n.of(context)!.about,
                    description: L10n.of(context)!.bitcoinDescription,
                  ),
                ),
              ),
                            
              
              // Bitcoin Network Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: RoundedContainer(
                    child: BitNetImageWithTextContainer(
                      "Bitcoin",
                      customColor: Theme.of(context).brightness == Brightness.light ? Colors.white.withAlpha(50) : null,
                      () {
                        context.push("/wallet/bitcoinscreen/mempool");
                      },
                      image: "assets/images/blockchain.png",
                      fallbackIcon: FontAwesomeIcons.bitcoinSign,
                      width: AppTheme.cardPadding * 4,
                      height: AppTheme.cardPadding * 4,
                    ),
                  ),
                ),
              ),
              // Cryptos
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                    vertical: AppTheme.elementSpacing,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cryptos",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.cardPadding),
                      CryptoItem(
                        context: context,
                        currency: Currency(
                          name: "Bitcoin",
                          code: "BTC",
                          icon: Image.asset("assets/images/bitcoin.png"),
                        ),
                      ),
                      SizedBox(height: AppTheme.elementSpacing),
                      CryptoItem(
                        context: context,
                        currency: Currency(
                          name: "Ethereum",
                          code: "ETH",
                          icon: Image.asset("assets/images/bitcoin.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Activity Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding * 1.75),
                      Text(L10n.of(context)!.activity,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.elementSpacing),
                    ],
                  ),
                ),
              ),
              
              // Transactions list
              Transactions(
                hideLightning: isOnchainSelected,
                hideOnchain: !isOnchainSelected,
                filters: isOnchainSelected ? [L10n.of(context)!.onchain] : ['Lightning'],
                scrollController: scrollController,
              ),
              
              // Bottom padding
              SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.cardPadding * 4),
              ),
            ],
          ),
          
          // Buy/Sell Buttons
          BottomButtons(
            leftButtonTitle: L10n.of(context)!.buy,
            rightButtonTitle: L10n.of(context)!.sell,
            onLeftButtonTap: () {
              Get.delete<PurchaseSheetController>();
              Get.put<PurchaseSheetController>(PurchaseSheetController());
              BitNetBottomSheet(
                  height: MediaQuery.of(context).size.height * 0.85,
                  context: context,
                  child: const PurchaseSheet());
            },
            onRightButtonTap: () {
              Get.delete<SellSheetController>();
              Get.put<SellSheetController>(SellSheetController());

              BitNetBottomSheet(
                  height: MediaQuery.of(context).size.height * 0.85,
                  context: context,
                  child: const SellSheet());
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildOnchainWallet(BuildContext context, WalletsController walletController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding,
        vertical: AppTheme.elementSpacing,
      ),
      child: Container(
        height: AppTheme.cardPadding * 7,
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
    );
  }
  
  Widget _buildLightningWallet(BuildContext context, WalletsController walletController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding,
        vertical: AppTheme.elementSpacing,
      ),
      child: Container(
        height: AppTheme.cardPadding * 7,
        child: Obx(() {
          final confirmedBalanceStr =
              walletController.lightningBalance.value.balance.obs;

          return BalanceCardLightning(
            balance: confirmedBalanceStr.value,
            confirmedBalance: confirmedBalanceStr.value,
            defaultUnit: BitcoinUnits.SAT,
          );
        }),
      ),
    );
  }
}

class PurchaseSheet extends GetWidget<PurchaseSheetController> {
  const PurchaseSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        text: L10n.of(context)!.purchaseBitcoin,
        context: context,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: AppTheme.cardPadding * 4,
              ),
              AmountWidget(
                  swapped: Get.find<WalletsController>().reversed.value,
                  enabled: () => true,
                  satController: controller.satCtrlBuy,
                  btcController: controller.btcCtrlBuy,
                  currController: controller.currCtrlBuy,
                  focusNode: controller.nodeBuy,
                  autoConvert: true,
                  context: context),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              const SizedBox(height: AppTheme.cardPadding),

            ],
          ),
          Obx(() {
            // Use Obx to reactively display the button state
              return BottomCenterButton(
                  buttonTitle: "Secure my Bitcoin",
                  buttonState: controller.buttonState.value,
                onButtonTap: () async {
                  // Set the button to loading state
                  controller.setButtonState(ButtonState.loading);
              
                  // Wait for the UI to update
                  await Future.delayed(const Duration(milliseconds: 100));
              
                  try {
                    final String clientSecret = await requestClientSecret("100000", "usd");
                    await _initializePaymentSheet(clientSecret, context);
                    await _presentPaymentSheet();
                  } catch (e) {
                    print('Error during payment process: $e');
                  }
              
                  // Reset the button state to idle after operations
                  controller.setButtonState(ButtonState.idle);
                },);
            }
          )
        ],
      ),
    );
  }
}

Future<void> _initializePaymentSheet(String clientSecret, BuildContext context) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      style: Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      customFlow: false,
      paymentMethodOrder: [
        'apple_pay', 'google_pay', 'paypal', 'klarna', 'card',
      ],
      googlePay: const PaymentSheetGooglePay(
        merchantCountryCode: 'US',
        currencyCode: 'usd',
        amount: '100000',
        label: 'BitNet GmbH',
        testEnv: true,
        buttonType: PlatformButtonType.pay,
      ),
      merchantDisplayName: 'BitNet GmbH',
    ),
  );
}

Future<void> _presentPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
  } catch (e) {
    // Handle errors
    print('Error presenting payment sheet: $e');
  }
}

class SellSheet extends GetWidget<SellSheetController> {
  const SellSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logger = Get.find<LoggerService>();
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        text: L10n.of(context)!.sell,
        context: context,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: AppTheme.cardPadding * 4,
              ),
              AmountWidget(
                  swapped: Get.find<WalletsController>().reversed.value,
                  enabled: () => true,
                  satController: controller.satCtrlBuy,
                  btcController: controller.btcCtrlBuy,
                  currController: controller.currCtrlBuy,
                  focusNode: controller.nodeSell,
                  autoConvert: true,
                  context: context),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              const SizedBox(height: AppTheme.cardPadding),
            ],
          ),
          Obx(() {
            // Use Obx to reactively display the button state
              return BottomCenterButton(
                  buttonTitle: "Sell my Bitcoin",
                  buttonState: controller.buttonState.value,
                  onButtonTap: () async {
                    controller.buttonState.value = ButtonState.loading;
                    bool hasStripeAccount = false;
                    if(!hasStripeAccount){
                      logger.i("Creating a new stripe account for the user...");
                      //get the link for the user
                      String accountlink = await createStripeAccount("USERIDNEW", "DE");
                      //launch the link for the user
                      logger.i("Opening the link now... $accountlink");
                      //convert the link to a url
                      final uri = Uri.parse(accountlink);
                      //launch the link
                      await launchUrl(uri);
                      //we need to redirect to the app
              
                      //then we proceed with the payment
              
              
                    } else {
                      //use the stripe account that already exists for the user to pay him out
                      logger.i("Using the existing stripe account for the user...");
              
              
                    }
                    controller.buttonState.value = ButtonState.idle;
                  });
            }
          )
        ],
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