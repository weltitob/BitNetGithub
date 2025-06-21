import 'dart:collection';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/cloudfunctions/stripe/createstripeaccount.dart';
import 'package:bitnet/backbone/cloudfunctions/stripe/requestclientsecret.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/token_data_service.dart';
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
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoinfoitem.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/items/floor_price_widget.dart';
import 'package:bitnet/components/items/token_action_buttons.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/purchase_sheet_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BitcoinScreen extends StatefulWidget {
  final Map<String, dynamic>? tokenData;
  
  const BitcoinScreen({
    Key? key,
    this.tokenData,
  }) : super(key: key);

  @override
  State<BitcoinScreen> createState() => _BitcoinScreenState();
}

// Mock token balance helper
String _getMockTokenBalance(String tokenSymbol) {
  // Return mock balances for different tokens
  switch (tokenSymbol) {
    case 'GENST':
      return '1250000'; // 1.25M GENST tokens
    case 'HTDG':
      return '850000'; // 850K HTDG tokens
    case 'CAT':
      return '42000'; // 42K CAT tokens
    case 'EMRLD':
      return '175'; // 175 EMRLD tokens
    case 'LILA':
      return '9850'; // 9.85K LILA tokens
    case 'MINRL':
      return '567'; // 567 MINRL tokens
    case 'TBLUE':
      return '125000'; // 125K TBLUE tokens
    default:
      return '1000000'; // 1M tokens default
  }
}

// Helper to get token image path using centralized service
String _getTokenImagePath(String tokenSymbol) {
  final metadata = TokenDataService.instance.getTokenMetadata(tokenSymbol);
  return metadata?['image'] ?? 'assets/images/bitcoin.png';
}

class _BitcoinScreenState extends State<BitcoinScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Controllers for buy/sell bottom sheets
  final TextEditingController btcController = TextEditingController();
  final TextEditingController satController = TextEditingController();
  final TextEditingController currController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  
  // Sell flow controllers
  final TextEditingController sellPriceBtcController = TextEditingController();
  final TextEditingController sellPriceSatController = TextEditingController();
  final TextEditingController sellPriceCurrController = TextEditingController();
  final FocusNode sellPriceFocusNode = FocusNode();
  
  // State variables for buy/sell flow
  int buyStep = 1;
  int sellStep = 1;
  String buyAmount = '';
  String selectedPrice = '';
  String selectedAmount = '';
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
    
    // Debug: Check if token data is being received
    if (widget.tokenData != null) {
      print('BitcoinScreen received token data: ${widget.tokenData}');
    } else {
      print('BitcoinScreen: No token data received, showing Bitcoin');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    // Dispose buy/sell controllers
    btcController.dispose();
    satController.dispose();
    currController.dispose();
    focusNode.dispose();
    sellPriceBtcController.dispose();
    sellPriceSatController.dispose();
    sellPriceCurrController.dispose();
    sellPriceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletsController>();
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: bitnetAppBar(
        text: widget.tokenData != null 
          ? '${widget.tokenData!['tokenName']} Chart'
          : L10n.of(context)!.bitcoinChart,
        context: context,
        onTap: () {
          // Use context.canPop() to determine if we can safely go back in history
          if (context.canPop()) {
            // If we have a navigation history, use pop() to go back to previous screen
            context.pop();
          } else {
            // If no navigation history (e.g., deep linked), default to feed screen
            context.go('/feed');
          }
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
              
              // Chart Section (moved to correct position)
              SliverToBoxAdapter(
                child: ChartWidget(
                  tokenData: widget.tokenData,
                ),
              ),
              
              SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.cardPadding.h * 2),
              ),
              
              // Show buttons for both Bitcoin and tokens
              SliverToBoxAdapter(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BitNetImageWithTextButton(
                      L10n.of(context)!.send,
                      () {
                        if (widget.tokenData != null) {
                          // For tokens, show a coming soon message or navigate to token send
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Token send coming soon')),
                          );
                        } else {
                          context.go('/wallet/send');
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Get.find<SendsController>().getClipboardData();
                          });
                        }
                      },
                      // image: "assets/images/send_image.png",
                      width: AppTheme.cardPadding * 2.5.h,
                      height: AppTheme.cardPadding * 2.5.h,
                      fallbackIcon: Icons.arrow_upward_rounded,
                    ),
                    BitNetImageWithTextButton(
                      L10n.of(context)!.receive,
                      () {
                        if (widget.tokenData != null) {
                          // For tokens, show a coming soon message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Token receive coming soon')),
                          );
                        } else {
                          context.go('/wallet/receive');
                        }
                      },
                      // image: "assets/images/receive_image.png",
                      width: AppTheme.cardPadding * 2.5.h,
                      height: AppTheme.cardPadding * 2.5.h,
                      fallbackIcon: Icons.arrow_downward_rounded,
                    ),
                    // Use shared token action buttons for tokens
                    if (widget.tokenData != null) 
                      ...[
                        Expanded(
                          child: TokenActionButtons(
                            onBuyTap: _showTokenBuyBottomSheet,
                            onSellTap: _showTokenSellBottomSheet,
                          ),
                        ),
                      ]
                    else
                      ...[
                        BitNetImageWithTextButton(
                          "Swap",
                          () {
                            Get.put(LoopsController());
                            context.go("/wallet/loop_screen");
                          },
                          width: AppTheme.cardPadding * 2.5.h,
                          height: AppTheme.cardPadding * 2.5.h,
                          fallbackIcon: Icons.sync_rounded,
                          fallbackIconSize: AppTheme.iconSize * 1.5,
                        ),
                        BitNetImageWithTextButton(
                          "Buy",
                          () {
                            context.push("/wallet/buy");
                          },
                          width: AppTheme.cardPadding * 2.5.h,
                          height: AppTheme.cardPadding * 2.5.h,
                          fallbackIcon: FontAwesomeIcons.btc,
                          fallbackIconSize: AppTheme.iconSize * 1.5,
                        ),
                      ],
                  ],
                ),
                ),
              ),
              // Cryptos section for both Bitcoin and tokens
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 2),
                      Text(
                        "Cryptos",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.cardPadding.h),
                      if (widget.tokenData != null) ...[
                        // Token balance display with mock data
                        CryptoInfoItem(
                          balance: _getMockTokenBalance(widget.tokenData!['tokenSymbol']),
                          defaultUnit: BitcoinUnits.SAT,
                          currency: Currency(
                            code: widget.tokenData!['tokenSymbol'],
                            name: widget.tokenData!['tokenName'],
                            icon: Image.asset(
                              _getTokenImagePath(widget.tokenData!['tokenSymbol']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          context: context,
                          onTap: () {
                            // Scroll to top
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                        ),
                      ] else ...[
                        // Bitcoin balances
                        Obx(
                              () {
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
                            return CryptoInfoItem(
                              balance: confirmedBalanceStr.value,
                              // confirmedBalance: confirmedBalanceStr.value,
                              // unconfirmedBalance: unconfirmedBalanceStr.value,
                              defaultUnit: BitcoinUnits.SAT,
                              currency: Currency(
                                code: 'BTC',
                                name: 'Bitcoin (Onchain)',
                                icon: Image.asset("assets/images/bitcoin.png"),
                              ),
                              context: context,
                              onTap: () {
                                // No need to navigate when already on this screen
                                // Just scroll to top if needed
                                scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.elementSpacing.h),
                        Obx(() {
                          final confirmedBalanceStr =
                              walletController.lightningBalance.value.balance.obs;
                          return CryptoInfoItem(
                            balance: confirmedBalanceStr.value,
                            // confirmedBalance: confirmedBalanceStr.value,
                            defaultUnit: BitcoinUnits.SAT,
                            currency: Currency(
                              code: 'BTC',
                              name: 'Bitcoin (Lightning)',
                              icon: Image.asset("assets/images/lightning.png"),
                            ),
                            context: context,
                            onTap: () {
                              // No need to navigate when already on this screen
                              // Just scroll to top if needed
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                            // unconfirmedBalance: '',
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Go to Marketplace button for tokens
              if (widget.tokenData != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding.w,
                    vertical: AppTheme.cardPadding.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to token marketplace
                      context.push('/feed/token_marketplace/${widget.tokenData!['tokenSymbol']}/${widget.tokenData!['tokenName']}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            Theme.of(context).colorScheme.primary.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: AppTheme.cardRadiusMid,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(AppTheme.cardPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(AppTheme.elementSpacing),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.storefront_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: AppTheme.elementSpacing),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Go to Marketplace',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Buy or sell ${widget.tokenData!['tokenSymbol']} tokens',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Wallet Balances - Tab Bar
              if (widget.tokenData == null)
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
                      BitNetListTile(
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
                                    MediaQuery.of(context).size.height *
                                        0.65.h,
                                    borderRadius: AppTheme.borderRadiusBig,
                                    child: const AddressesWidget());
                              }),
                          onTap: () async {
                            BitNetBottomSheet(
                                context: context,
                                height: MediaQuery.of(context).size.height *
                                    0.65.h,
                                borderRadius: AppTheme.borderRadiusBig,
                                child: const AddressesWidget());
                          }),
                    ],
                  ),
                ),
              ),
              // Bitcoin/Token Info
              SliverToBoxAdapter(
                child: InformationWidget(
                  title: widget.tokenData != null 
                    ? 'About ${widget.tokenData!['tokenName']}'
                    : L10n.of(context)!.about,
                  description: widget.tokenData != null
                    ? '${widget.tokenData!['tokenName']} (${widget.tokenData!['tokenSymbol']}) is a digital asset with a current price of \$${widget.tokenData!['currentPrice']}.'
                    : L10n.of(context)!.bitcoinDescription,
                ),
              ),
              // Cryptos
              // Activity Header
              if (widget.tokenData == null) ...[
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
                filters: isOnchainSelected
                    ? [L10n.of(context)!.onchain]
                    : ['Lightning'],
                scrollController: scrollController,
                ),
              ],
              // Bottom padding
              SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.cardPadding * 4),
              ),
            ],
          ),
          // Buy/Sell Buttons
          // BottomButtons(
          //   leftButtonTitle: L10n.of(context)!.buy,
          //   rightButtonTitle: L10n.of(context)!.sell,
          //   onLeftButtonTap: () {
          //     Get.delete<PurchaseSheetController>();
          //     Get.put<PurchaseSheetController>(PurchaseSheetController());
          //     BitNetBottomSheet(
          //         height: MediaQuery.of(context).size.height * 0.85,
          //         context: context,
          //         child: const PurchaseSheet());
          //   },
          //   onRightButtonTap: () {
          //     Get.delete<SellSheetController>();
          //     Get.put<SellSheetController>(SellSheetController());
          //     
          //     BitNetBottomSheet(
          //         height: MediaQuery.of(context).size.height * 0.85,
          //         context: context,
          //         child: const SellSheet());
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildOnchainWallet(
      BuildContext context, WalletsController walletController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding,
        vertical: AppTheme.elementSpacing,
      ),
      child: Container(
        height: AppTheme.cardPadding * 7,
        child: Obx(() {
          final logger = Get.find<LoggerService>();
          final confirmedBalanceStr =
              walletController.onchainBalance.value.confirmedBalance.obs;
          final unconfirmedBalanceStr =
              walletController.onchainBalance.value.unconfirmedBalance.obs;
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

  Widget _buildLightningWallet(
      BuildContext context, WalletsController walletController) {
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
  
  // Token marketplace mock data (same as in token_marketplace_screen.dart)
  final Map<String, Map<String, dynamic>> tokenMarketData = {
    'GENST': {
      'floorPrice': 45000.0,
      'currentPrice': 48350.0,
      'sellOffers': [
        {'seller': 'GenesisKeeper', 'amount': '3', 'price': '46,500', 'rating': 4.9, 'trades': 342},
        {'seller': 'StoneCollector', 'amount': '5', 'price': '47,200', 'rating': 4.8, 'trades': 267},
        {'seller': 'CryptoVault', 'amount': '2', 'price': '47,800', 'rating': 5.0, 'trades': 523},
      ],
      'buyOffers': [
        {'buyer': 'TokenWhale', 'amount': '10', 'price': '45,000', 'rating': 4.8, 'trades': 156},
        {'buyer': 'GenesisHunter', 'amount': '4', 'price': '44,500', 'rating': 4.7, 'trades': 234},
      ]
    },
    'HTDG': {
      'floorPrice': 14.50,
      'currentPrice': 15.75,
      'sellOffers': [
        {'seller': 'HotdogKing', 'amount': '500', 'price': '15.00', 'rating': 4.9, 'trades': 876},
        {'seller': 'FoodToken', 'amount': '750', 'price': '15.50', 'rating': 4.7, 'trades': 432},
      ],
      'buyOffers': [
        {'buyer': 'HotdogFan', 'amount': '300', 'price': '14.00', 'rating': 4.8, 'trades': 234},
      ]
    },
    'CAT': {
      'floorPrice': 825.0,
      'currentPrice': 892.50,
      'sellOffers': [
        {'seller': 'CatLover', 'amount': '25', 'price': '850', 'rating': 5.0, 'trades': 567},
        {'seller': 'FelineTrader', 'amount': '40', 'price': '875', 'rating': 4.8, 'trades': 345},
      ],
      'buyOffers': [
        {'buyer': 'CatCollector', 'amount': '50', 'price': '820', 'rating': 4.9, 'trades': 423},
      ]
    },
    'EMRLD': {
      'floorPrice': 11500.0,
      'currentPrice': 12450.0,
      'sellOffers': [
        {'seller': 'EmeraldVault', 'amount': '8', 'price': '12,000', 'rating': 4.9, 'trades': 234},
        {'seller': 'GemTrader', 'amount': '12', 'price': '12,300', 'rating': 4.8, 'trades': 456},
      ],
      'buyOffers': [
        {'buyer': 'EmeraldSeeker', 'amount': '15', 'price': '11,500', 'rating': 4.7, 'trades': 189},
      ]
    },
    'LILA': {
      'floorPrice': 215.0,
      'currentPrice': 234.80,
      'sellOffers': [
        {'seller': 'LilaHolder', 'amount': '100', 'price': '225', 'rating': 4.8, 'trades': 678},
        {'seller': 'PurpleToken', 'amount': '150', 'price': '230', 'rating': 4.9, 'trades': 543},
      ],
      'buyOffers': [
        {'buyer': 'LilaInvestor', 'amount': '200', 'price': '215', 'rating': 4.9, 'trades': 345},
      ]
    },
    'MINRL': {
      'floorPrice': 3200.0,
      'currentPrice': 3567.25,
      'sellOffers': [
        {'seller': 'MineralMaster', 'amount': '20', 'price': '3,400', 'rating': 5.0, 'trades': 892},
        {'seller': 'RockCollector', 'amount': '35', 'price': '3,500', 'rating': 4.9, 'trades': 654},
      ],
      'buyOffers': [
        {'buyer': 'MineralWhale', 'amount': '50', 'price': '3,200', 'rating': 4.8, 'trades': 432},
      ]
    },
    'TBLUE': {
      'floorPrice': 62.0,
      'currentPrice': 67.90,
      'sellOffers': [
        {'seller': 'BlueTrader', 'amount': '400', 'price': '65.00', 'rating': 4.7, 'trades': 321},
        {'seller': 'TokenBlue', 'amount': '600', 'price': '67.00', 'rating': 4.8, 'trades': 456},
      ],
      'buyOffers': [
        {'buyer': 'BlueBuyer', 'amount': '800', 'price': '62.00', 'rating': 4.6, 'trades': 234},
      ]
    },
  };
  
  void _showTokenBuyBottomSheet() {
    // Clear controllers
    btcController.clear();
    currController.clear();
    satController.clear();
    
    // Reset buy flow state
    buyStep = 1;
    
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.7,
      child: StatefulBuilder(
        builder: (context, setBottomSheetState) {
          return Column(
            children: [
              // BitNet AppBar
              bitnetAppBar(
                context: context,
                text: buyStep == 1 ? 'Buy ${widget.tokenData!['tokenSymbol']}' : 'Best Matches',
                hasBackButton: buyStep == 1 ? false : true,
                onTap: () {
                  if (buyStep == 2) {
                    // Go back to amount step
                    setBottomSheetState(() {
                      buyStep = 1;
                    });
                  } else {
                    // Close bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.cardPadding.w),
                  child: buyStep == 1 ? _buildBuyAmountStep(setBottomSheetState) : _buildBestMatchesStep(setBottomSheetState),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  void _showTokenSellBottomSheet() {
    // Reset state
    sellStep = 1;
    selectedPrice = '';
    selectedAmount = '';
    btcController.clear();
    currController.clear();
    satController.clear();
    
    // Clear sell flow controllers
    sellPriceBtcController.clear();
    sellPriceCurrController.clear();
    sellPriceSatController.clear();
    
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.7,
      child: StatefulBuilder(
        builder: (context, setBottomSheetState) {
          return Column(
            children: [
              // BitNet AppBar
              bitnetAppBar(
                context: context,
                text: sellStep == 1 ? 'Set Price' : sellStep == 2 ? 'Set Amount' : 'Order Overview',
                hasBackButton: sellStep == 1 ? false : true,
                onTap: () {
                  if (sellStep == 3) {
                    // Go back to amount step
                    setBottomSheetState(() {
                      sellStep = 2;
                    });
                  } else if (sellStep == 2) {
                    // Go back to price step
                    setBottomSheetState(() {
                      sellStep = 1;
                    });
                  } else {
                    // Close bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.cardPadding.w),
                  child: sellStep == 1 
                    ? _buildPriceStep(setBottomSheetState) 
                    : sellStep == 2 
                      ? _buildAmountStep(setBottomSheetState)
                      : _buildOrderOverviewStep(setBottomSheetState),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildBuyAmountStep(StateSetter setBottomSheetState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // Amount input
        Text(
          'Amount to buy',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // AmountWidget for token amount
        AmountWidget(
          enabled: () => true,
          btcController: btcController,
          satController: satController,
          currController: currController,
          focusNode: focusNode,
          context: context,
          autoConvert: true,
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Find Best Matches',
          buttonState: (btcController.text.isEmpty || btcController.text == '0') 
            ? ButtonState.disabled 
            : ButtonState.idle,
          onButtonTap: () {
            buyAmount = btcController.text;
            setBottomSheetState(() {
              buyStep = 2;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildBestMatchesStep(StateSetter setBottomSheetState) {
    // Get token-specific data
    final tokenSymbol = widget.tokenData!['tokenSymbol'];
    final tokenData = tokenMarketData[tokenSymbol] ?? tokenMarketData['GENST']!;
    final sellOffers = List<Map<String, dynamic>>.from(tokenData['sellOffers']);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount summary
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Looking to buy: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '$buyAmount ${widget.tokenData!['tokenSymbol']}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        Text(
          'Best Matches',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // List of sellers
        Expanded(
          child: ListView.builder(
            itemCount: sellOffers.length,
            itemBuilder: (context, index) {
              final seller = sellOffers[index];
              return Container(
                margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(AppTheme.elementSpacing.w),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Text(
                      seller['seller'].substring(0, 2).toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(seller['seller']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text('${seller['rating']} • ${seller['trades']} trades'),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text('Available: ${seller['amount']} tokens'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${seller['price']}',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'per token',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    // Show purchase confirmation
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Purchase order placed for $buyAmount ${widget.tokenData!['tokenSymbol']} at \$${seller['price']} per token'),
                        backgroundColor: AppTheme.successColor,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildPriceStep(StateSetter setBottomSheetState) {
    final tokenData = tokenMarketData[widget.tokenData!['tokenSymbol']] ?? tokenMarketData['GENST']!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppTheme.elementSpacing.h),
        
        Text(
          'Set your price per ${widget.tokenData!['tokenSymbol']}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // Price input using AmountWidget
        AmountWidget(
          enabled: () => true,
          btcController: sellPriceBtcController,
          satController: sellPriceSatController,
          currController: sellPriceCurrController,
          focusNode: sellPriceFocusNode,
          context: context,
          autoConvert: true,
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Floor price info using shared widget
        FloorPriceWidget(
          price: '\$${tokenData['floorPrice'].toStringAsFixed(2)}',
          tokenSymbol: 'per token',
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Continue',
          buttonState: (sellPriceCurrController.text.isEmpty || sellPriceCurrController.text == '0.00') 
            ? ButtonState.disabled 
            : ButtonState.idle,
          onButtonTap: () {
            selectedPrice = sellPriceCurrController.text;
            setBottomSheetState(() {
              sellStep = 2;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildAmountStep(StateSetter setBottomSheetState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price summary
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            border: Border.all(
              color: AppTheme.successColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Your price: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '\$$selectedPrice per token',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Amount input
        Text(
          'How many ${widget.tokenData!['tokenSymbol']} to sell?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // AmountWidget for token amount
        AmountWidget(
          enabled: () => true,
          btcController: btcController,
          satController: satController,
          currController: currController,
          focusNode: focusNode,
          context: context,
          autoConvert: true,
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Review Order',
          buttonState: (btcController.text.isEmpty || btcController.text == '0') 
            ? ButtonState.disabled 
            : ButtonState.idle,
          onButtonTap: () {
            selectedAmount = btcController.text;
            setBottomSheetState(() {
              sellStep = 3;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildOrderOverviewStep(StateSetter setBottomSheetState) {
    final double totalValue = (double.tryParse(selectedAmount) ?? 0) * (double.tryParse(selectedPrice) ?? 0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order summary card
        Container(
          padding: EdgeInsets.all(AppTheme.cardPadding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Token info
              Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _getTokenImagePath(widget.tokenData!['tokenSymbol']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selling ${widget.tokenData!['tokenName']}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          widget.tokenData!['tokenSymbol'],
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.cardPadding.h),
              
              // Order details
              _buildOrderDetailRow('Amount', '$selectedAmount ${widget.tokenData!['tokenSymbol']}'),
              SizedBox(height: AppTheme.elementSpacing.h),
              _buildOrderDetailRow('Price per token', '\$$selectedPrice'),
              SizedBox(height: AppTheme.elementSpacing.h),
              Divider(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
              SizedBox(height: AppTheme.elementSpacing.h),
              _buildOrderDetailRow(
                'Total Value', 
                '\$${totalValue.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Put on Market',
          buttonState: ButtonState.idle,
          onButtonTap: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully listed $selectedAmount ${widget.tokenData!['tokenSymbol']} at \$$selectedPrice per token'),
                backgroundColor: AppTheme.successColor,
                duration: Duration(seconds: 3),
              ),
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildOrderDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal 
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: isTotal 
            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              )
            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
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
                  final String clientSecret =
                      await requestClientSecret("100000", "usd");
                  // await _initializePaymentSheet(clientSecret, context);
                  // await _presentPaymentSheet();
                } catch (e) {
                  print('Error during payment process: $e');
                }
                // Reset the button state to idle after operations
                controller.setButtonState(ButtonState.idle);
              },
            );
          })
        ],
      ),
    );
  }
}

// Future<void> _initializePaymentSheet(
//     String clientSecret, BuildContext context) async {
//   await Stripe.instance.initPaymentSheet(
//     paymentSheetParameters: SetupPaymentSheetParameters(
//       paymentIntentClientSecret: clientSecret,
//       style: Theme.of(context).brightness == Brightness.light
//           ? ThemeMode.light
//           : ThemeMode.dark,
//       customFlow: false,
//       paymentMethodOrder: [
//         'apple_pay',
//         'google_pay',
//         'paypal',
//         'klarna',
//         'card',
//       ],
//       googlePay: const PaymentSheetGooglePay(
//         merchantCountryCode: 'US',
//         currencyCode: 'usd',
//         amount: '100000',
//         label: 'BitNet GmbH',
//         testEnv: true,
//         buttonType: PlatformButtonType.pay,
//       ),
//       merchantDisplayName: 'BitNet GmbH',
//     ),
//   );
// }
//
// Future<void> _presentPaymentSheet() async {
//   try {
//     await Stripe.instance.presentPaymentSheet();
//   } catch (e) {
//     // Handle errors
//     print('Error presenting payment sheet: $e');
//   }
// }

/// Optimized SellSheet with better performance
class SellSheet extends GetWidget<SellSheetController> {
  const SellSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logger = Get.find<LoggerService>();
    
    return RepaintBoundary(
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: false,
          text: L10n.of(context)!.sell,
          context: context,
        ),
        body: Stack(
          children: [
            // Main content with performance optimizations
            RepaintBoundary(
              child: Column(
                children: [
                  const SizedBox(
                    height: AppTheme.cardPadding * 4,
                  ),
                  // Optimized AmountWidget wrapper
                  RepaintBoundary(
                    child: AmountWidget(
                        swapped: Get.find<WalletsController>().reversed.value,
                        enabled: () => true,
                        satController: controller.satCtrlBuy,
                        btcController: controller.btcCtrlBuy,
                        currController: controller.currCtrlBuy,
                        focusNode: controller.nodeSell,
                        autoConvert: true,
                        context: context),
                  ),
                  const SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                  // Additional spacing optimization
                  SizedBox(height: AppTheme.cardPadding),
                ],
              ),
            ),
            // Optimized button with debounced action
            Obx(() {
              return RepaintBoundary(
                child: BottomCenterButton(
                    buttonTitle: "Sell my Bitcoin",
                    buttonState: controller.buttonState.value,
                    onButtonTap: () => _handleSellAction(controller, logger)),
              );
            })
          ],
        ),
      ),
    );
  }

  /// Optimized sell action with proper error handling and debouncing
  Future<void> _handleSellAction(SellSheetController controller, LoggerService logger) async {
    // Prevent multiple taps
    if (controller.buttonState.value == ButtonState.loading) {
      return;
    }
    
    try {
      controller.buttonState.value = ButtonState.loading;
      
      // Use debouncing to prevent rapid fire actions
      await Future.delayed(const Duration(milliseconds: 300));
      
      bool hasStripeAccount = false;
      
      if (!hasStripeAccount) {
        logger.i("Creating a new stripe account for the user...");
        
        // Get the link for the user with timeout
        String accountlink = await createStripeAccount("USERIDNEW", "DE")
            .timeout(const Duration(seconds: 30));
        
        logger.i("Opening the link now... $accountlink");
        
        // Convert the link to a url with validation
        final uri = Uri.tryParse(accountlink);
        if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
          await launchUrl(uri);
        } else {
          logger.e("Invalid URL received: $accountlink");
          throw Exception("Invalid account link received");
        }
      } else {
        // Use the stripe account that already exists for the user to pay him out
        logger.i("Using the existing stripe account for the user...");
      }
    } catch (e, stackTrace) {
      logger.e("Error during sell action: $e\nStackTrace: $stackTrace");
      // Could show a snackbar or dialog here for user feedback
    } finally {
      // Always reset button state
      if (controller.isClosed == false) {
        controller.buttonState.value = ButtonState.idle;
      }
    }
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