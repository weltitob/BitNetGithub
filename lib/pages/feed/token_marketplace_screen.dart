import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenMarketplaceScreen extends StatefulWidget {
  final String tokenSymbol;
  final String tokenName;
  
  const TokenMarketplaceScreen({
    Key? key,
    required this.tokenSymbol,
    required this.tokenName,
  }) : super(key: key);

  @override
  State<TokenMarketplaceScreen> createState() => _TokenMarketplaceScreenState();
}

class _TokenMarketplaceScreenState extends State<TokenMarketplaceScreen> {
  // Controllers for amount input
  late TextEditingController btcController;
  late TextEditingController currController;
  late TextEditingController satController;
  late TextEditingController priceController;
  late FocusNode focusNode;
  
  // Buy flow state
  int buyStep = 1; // 1 = amount, 2 = best matches
  String buyAmount = '';
  
  // Sell flow state
  int sellStep = 1; // 1 = price, 2 = amount, 3 = overview
  String selectedPrice = '';
  String selectedAmount = '';
  
  // Additional controllers for sell flow
  late TextEditingController sellPriceBtcController;
  late TextEditingController sellPriceCurrController;
  late TextEditingController sellPriceSatController;
  late FocusNode sellPriceFocusNode;
  
  @override
  void initState() {
    super.initState();
    btcController = TextEditingController();
    currController = TextEditingController();
    satController = TextEditingController();
    priceController = TextEditingController();
    focusNode = FocusNode();
    
    // Initialize sell flow controllers
    sellPriceBtcController = TextEditingController();
    sellPriceCurrController = TextEditingController();
    sellPriceSatController = TextEditingController();
    sellPriceFocusNode = FocusNode();
  }
  
  // Generate realistic price history for tokens (to be deleted later only to mock user workflow)
  List<Map<String, dynamic>> _generatePriceHistory(
    double currentPrice,
    int dataPoints,
    Duration totalDuration,
    double volatility,
  ) {
    final List<Map<String, dynamic>> priceHistory = [];
    final now = DateTime.now();
    final intervalMs = totalDuration.inMilliseconds ~/ dataPoints;
    
    // Start with a lower price to show growth
    double price = currentPrice * 0.7; // Start at 70% of current price
    
    // Use a seed for consistent but varied results
    int seed = currentPrice.toInt() + dataPoints;
    
    for (int i = 0; i < dataPoints; i++) {
      final timestamp = now.subtract(totalDuration).add(Duration(milliseconds: intervalMs * i));
      
      // Generate pseudo-random number using seed
      seed = (seed * 1103515245 + 12345) % (1 << 31);
      final random = (seed % 100) / 100.0;
      final change = (random - 0.5) * volatility;
      
      // Trend towards current price
      final trendFactor = i / dataPoints;
      final targetPrice = currentPrice * (0.7 + 0.3 * trendFactor);
      
      price = price * (1 + change) + (targetPrice - price) * 0.1;
      
      // Add some market-like patterns
      if (i % 10 == 0) {
        // Occasional spikes
        price *= (1 + (random - 0.5) * volatility * 2);
      }
      
      // Ensure we end close to current price
      if (i == dataPoints - 1) {
        price = currentPrice;
      }
      
      priceHistory.add({
        'time': timestamp.millisecondsSinceEpoch,
        'price': price.toStringAsFixed(2),
      });
    }
    
    return priceHistory;
  }
  
  @override
  void dispose() {
    btcController.dispose();
    currController.dispose();
    satController.dispose();
    priceController.dispose();
    focusNode.dispose();
    
    // Dispose sell flow controllers
    sellPriceBtcController.dispose();
    sellPriceCurrController.dispose();
    sellPriceSatController.dispose();
    sellPriceFocusNode.dispose();
    super.dispose();
  }
  
  // Lazy initialization for price history
  Map<String, Map<String, dynamic>>? _tokenPriceHistory;
  
  Map<String, Map<String, dynamic>> get tokenPriceHistory {
    _tokenPriceHistory ??= _generateAllTokenPriceHistory();
    return _tokenPriceHistory!;
  }
  
  // Generate price history for all tokens (to be deleted later only to mock user workflow)
  Map<String, Map<String, dynamic>> _generateAllTokenPriceHistory() {
    return {
      'GENST': {
        '1D': _generatePriceHistory(48350, 96, Duration(days: 1), 0.02),
        '1W': _generatePriceHistory(48350, 168, Duration(days: 7), 0.05),
        '1M': _generatePriceHistory(48350, 30, Duration(days: 30), 0.08),
        '1Y': _generatePriceHistory(48350, 365, Duration(days: 365), 0.15),
      },
      'HTDG': {
        '1D': _generatePriceHistory(15.75, 96, Duration(days: 1), 0.03),
        '1W': _generatePriceHistory(15.75, 168, Duration(days: 7), 0.07),
        '1M': _generatePriceHistory(15.75, 30, Duration(days: 30), 0.10),
        '1Y': _generatePriceHistory(15.75, 365, Duration(days: 365), 0.20),
      },
      'LUMN': {
        '1D': _generatePriceHistory(2345, 96, Duration(days: 1), 0.025),
        '1W': _generatePriceHistory(2345, 168, Duration(days: 7), 0.06),
        '1M': _generatePriceHistory(2345, 30, Duration(days: 30), 0.09),
        '1Y': _generatePriceHistory(2345, 365, Duration(days: 365), 0.18),
      },
      'NBLA': {
        '1D': _generatePriceHistory(890, 96, Duration(days: 1), 0.04),
        '1W': _generatePriceHistory(890, 168, Duration(days: 7), 0.08),
        '1M': _generatePriceHistory(890, 30, Duration(days: 30), 0.12),
        '1Y': _generatePriceHistory(890, 365, Duration(days: 365), 0.25),
      },
      'QUSR': {
        '1D': _generatePriceHistory(142.5, 96, Duration(days: 1), 0.035),
        '1W': _generatePriceHistory(142.5, 168, Duration(days: 7), 0.075),
        '1M': _generatePriceHistory(142.5, 30, Duration(days: 30), 0.11),
        '1Y': _generatePriceHistory(142.5, 365, Duration(days: 365), 0.22),
      },
      'VRTX': {
        '1D': _generatePriceHistory(9.45, 96, Duration(days: 1), 0.05),
        '1W': _generatePriceHistory(9.45, 168, Duration(days: 7), 0.10),
        '1M': _generatePriceHistory(9.45, 30, Duration(days: 30), 0.15),
        '1Y': _generatePriceHistory(9.45, 365, Duration(days: 365), 0.30),
      },
    };
  }
  
  // Comprehensive marketplace data for all tokens
  final Map<String, Map<String, dynamic>> tokenMarketData = {
    'GENST': {
      'floorPrice': 48100,
      'currentPrice': 48350,
      'sellOffers': [
        {'seller': 'CryptoKing', 'amount': '0.8', 'price': '48,200', 'rating': 4.9, 'trades': 267},
        {'seller': 'DiamondHands', 'amount': '1.5', 'price': '48,350', 'rating': 4.8, 'trades': 189},
        {'seller': 'BlockMaster', 'amount': '0.3', 'price': '48,400', 'rating': 4.7, 'trades': 142},
        {'seller': 'TokenTrader', 'amount': '2.1', 'price': '48,450', 'rating': 4.9, 'trades': 301},
        {'seller': 'SatoshiFan', 'amount': '0.6', 'price': '48,500', 'rating': 4.6, 'trades': 78},
        {'seller': 'AlphaWhale', 'amount': '3.2', 'price': '48,520', 'rating': 4.8, 'trades': 456},
        {'seller': 'CoinCollector', 'amount': '0.9', 'price': '48,580', 'rating': 4.5, 'trades': 93},
        {'seller': 'GemHunter', 'amount': '1.7', 'price': '48,600', 'rating': 4.7, 'trades': 234},
        {'seller': 'MoonLover', 'amount': '0.4', 'price': '48,650', 'rating': 4.4, 'trades': 67},
        {'seller': 'HODLer2024', 'amount': '2.8', 'price': '48,700', 'rating': 4.9, 'trades': 378},
        {'seller': 'DefiGuru', 'amount': '1.1', 'price': '48,750', 'rating': 4.6, 'trades': 156},
        {'seller': 'EarlyAdopter', 'amount': '0.7', 'price': '48,800', 'rating': 4.8, 'trades': 289},
        {'seller': 'StoneKeeper', 'amount': '5.0', 'price': '48,850', 'rating': 4.9, 'trades': 512},
        {'seller': 'ChainLink', 'amount': '1.3', 'price': '48,900', 'rating': 4.5, 'trades': 134},
        {'seller': 'CryptoNinja', 'amount': '0.5', 'price': '48,950', 'rating': 4.7, 'trades': 98},
        {'seller': 'TokenomicsExpert', 'amount': '2.4', 'price': '49,000', 'rating': 4.8, 'trades': 367},
        {'seller': 'GenesisHolder', 'amount': '0.2', 'price': '49,050', 'rating': 4.6, 'trades': 45},
        {'seller': 'BlockBuilder', 'amount': '1.9', 'price': '49,100', 'rating': 4.9, 'trades': 423},
        {'seller': 'DeFiDegen', 'amount': '0.8', 'price': '49,150', 'rating': 4.4, 'trades': 87},
        {'seller': 'ChainGuardian', 'amount': '3.6', 'price': '49,200', 'rating': 4.8, 'trades': 498},
        {'seller': 'CryptoSage', 'amount': '1.2', 'price': '49,250', 'rating': 4.7, 'trades': 201},
        {'seller': 'TokenVault', 'amount': '0.9', 'price': '49,300', 'rating': 4.5, 'trades': 123},
      ],
      'buyOffers': [
        {'buyer': 'StoneSeeker', 'amount': '1.5', 'price': '47,900', 'rating': 4.8, 'trades': 234},
        {'buyer': 'GemCollector', 'amount': '0.7', 'price': '47,850', 'rating': 4.7, 'trades': 156},
        {'buyer': 'CryptoHunter', 'amount': '2.3', 'price': '47,800', 'rating': 4.9, 'trades': 345},
        {'buyer': 'DigitalMiner', 'amount': '0.4', 'price': '47,750', 'rating': 4.6, 'trades': 89},
        {'buyer': 'BlockchainBuyer', 'amount': '3.1', 'price': '47,700', 'rating': 4.8, 'trades': 467},
        {'buyer': 'TokenAccumulator', 'amount': '1.8', 'price': '47,650', 'rating': 4.5, 'trades': 178},
        {'buyer': 'CoinEnthusiast', 'amount': '0.6', 'price': '47,600', 'rating': 4.7, 'trades': 123},
        {'buyer': 'DefiInvestor', 'amount': '2.9', 'price': '47,550', 'rating': 4.9, 'trades': 389},
        {'buyer': 'GenesisSeeker', 'amount': '1.2', 'price': '47,500', 'rating': 4.4, 'trades': 134},
        {'buyer': 'CryptoWhale', 'amount': '4.5', 'price': '47,450', 'rating': 4.8, 'trades': 567},
        {'buyer': 'ChainCollector', 'amount': '0.8', 'price': '47,400', 'rating': 4.6, 'trades': 98},
        {'buyer': 'TokenHoarder', 'amount': '2.1', 'price': '47,350', 'rating': 4.7, 'trades': 245},
        {'buyer': 'DigitalAssetFan', 'amount': '1.4', 'price': '47,300', 'rating': 4.5, 'trades': 167},
        {'buyer': 'CryptoBull', 'amount': '0.9', 'price': '47,250', 'rating': 4.8, 'trades': 201},
        {'buyer': 'BlockchainBeliever', 'amount': '3.7', 'price': '47,200', 'rating': 4.9, 'trades': 456},
        {'buyer': 'TokenTheorist', 'amount': '1.6', 'price': '47,150', 'rating': 4.6, 'trades': 189},
        {'buyer': 'CryptoOptimist', 'amount': '0.5', 'price': '47,100', 'rating': 4.7, 'trades': 87},
        {'buyer': 'ChainMaximalist', 'amount': '2.8', 'price': '47,050', 'rating': 4.8, 'trades': 334},
        {'buyer': 'GenesisCollector', 'amount': '1.3', 'price': '47,000', 'rating': 4.5, 'trades': 145},
        {'buyer': 'TokenBuyer2024', 'amount': '0.7', 'price': '46,950', 'rating': 4.9, 'trades': 213},
        {'buyer': 'CryptoPioneer', 'amount': '2.2', 'price': '46,900', 'rating': 4.4, 'trades': 278},
        {'buyer': 'DigitalGoldRush', 'amount': '1.9', 'price': '46,850', 'rating': 4.7, 'trades': 312},
      ]
    },
    'HTDG': {
      'floorPrice': 0.85,
      'currentPrice': 0.92,
      'sellOffers': [
        {'seller': 'HotdogKing', 'amount': '1250', 'price': '0.87', 'rating': 4.8, 'trades': 189},
        {'seller': 'MemeCoinLord', 'amount': '850', 'price': '0.89', 'rating': 4.9, 'trades': 267},
        {'seller': 'FunTokenTrader', 'amount': '2100', 'price': '0.91', 'rating': 4.7, 'trades': 134},
        {'seller': 'DogeLover', 'amount': '650', 'price': '0.92', 'rating': 4.6, 'trades': 98},
        {'seller': 'FoodCoinChef', 'amount': '3200', 'price': '0.93', 'rating': 4.8, 'trades': 345},
        {'seller': 'HotdogHODLer', 'amount': '1750', 'price': '0.94', 'rating': 4.5, 'trades': 156},
        {'seller': 'MemeMaster', 'amount': '920', 'price': '0.95', 'rating': 4.9, 'trades': 456},
        {'seller': 'SausageKing', 'amount': '1480', 'price': '0.96', 'rating': 4.7, 'trades': 234},
        {'seller': 'CryptoChef', 'amount': '760', 'price': '0.97', 'rating': 4.4, 'trades': 87},
        {'seller': 'FunCoinExpert', 'amount': '2850', 'price': '0.98', 'rating': 4.8, 'trades': 378},
        {'seller': 'HotdogEnthusiast', 'amount': '1120', 'price': '0.99', 'rating': 4.6, 'trades': 167},
        {'seller': 'MemeTokenGuru', 'amount': '1680', 'price': '1.00', 'rating': 4.9, 'trades': 423},
        {'seller': 'FoodieTrader', 'amount': '540', 'price': '1.01', 'rating': 4.5, 'trades': 123},
        {'seller': 'DogeCoinFan', 'amount': '2340', 'price': '1.02', 'rating': 4.7, 'trades': 289},
        {'seller': 'HotdogCollector', 'amount': '890', 'price': '1.03', 'rating': 4.8, 'trades': 201},
        {'seller': 'MemeCoinWhale', 'amount': '4100', 'price': '1.04', 'rating': 4.9, 'trades': 567},
        {'seller': 'SausageHODLer', 'amount': '1320', 'price': '1.05', 'rating': 4.6, 'trades': 178},
        {'seller': 'CryptoFoodie', 'amount': '750', 'price': '1.06', 'rating': 4.4, 'trades': 134},
        {'seller': 'HotdogMaxi', 'amount': '1950', 'price': '1.07', 'rating': 4.8, 'trades': 334},
        {'seller': 'FunTokenMaxi', 'amount': '1150', 'price': '1.08', 'rating': 4.7, 'trades': 245},
        {'seller': 'MemeKingdom', 'amount': '680', 'price': '1.09', 'rating': 4.5, 'trades': 156},
        {'seller': 'HotdogDealer', 'amount': '2670', 'price': '1.10', 'rating': 4.9, 'trades': 445},
      ],
      'buyOffers': [
        {'buyer': 'HotdogHunter', 'amount': '1800', 'price': '0.84', 'rating': 4.7, 'trades': 234},
        {'buyer': 'MemeCoinBuyer', 'amount': '950', 'price': '0.83', 'rating': 4.8, 'trades': 178},
        {'buyer': 'FoodTokenFan', 'amount': '2250', 'price': '0.82', 'rating': 4.6, 'trades': 156},
        {'buyer': 'DogeFollower', 'amount': '1350', 'price': '0.81', 'rating': 4.9, 'trades': 289},
        {'buyer': 'HotdogBuyer', 'amount': '760', 'price': '0.80', 'rating': 4.5, 'trades': 123},
        {'buyer': 'MemeLover', 'amount': '3100', 'price': '0.79', 'rating': 4.8, 'trades': 367},
        {'buyer': 'SausageSeeker', 'amount': '1490', 'price': '0.78', 'rating': 4.7, 'trades': 201},
        {'buyer': 'FunCoinCollector', 'amount': '820', 'price': '0.77', 'rating': 4.4, 'trades': 98},
        {'buyer': 'HotdogAccumulator', 'amount': '2780', 'price': '0.76', 'rating': 4.9, 'trades': 423},
        {'buyer': 'MemeTokenSeeker', 'amount': '1650', 'price': '0.75', 'rating': 4.6, 'trades': 167},
        {'buyer': 'CryptoFoodLover', 'amount': '910', 'price': '0.74', 'rating': 4.8, 'trades': 234},
        {'buyer': 'HotdogInvestor', 'amount': '2140', 'price': '0.73', 'rating': 4.5, 'trades': 189},
        {'buyer': 'DogeCoinTrader', 'amount': '1720', 'price': '0.72', 'rating': 4.7, 'trades': 278},
        {'buyer': 'MemeCoinHunter', 'amount': '630', 'price': '0.71', 'rating': 4.9, 'trades': 345},
        {'buyer': 'FoodieInvestor', 'amount': '3450', 'price': '0.70', 'rating': 4.8, 'trades': 456},
        {'buyer': 'HotdogMaximalist', 'amount': '1280', 'price': '0.69', 'rating': 4.6, 'trades': 134},
        {'buyer': 'SausageLover', 'amount': '870', 'price': '0.68', 'rating': 4.4, 'trades': 87},
        {'buyer': 'MemeCoinOptimist', 'amount': '2530', 'price': '0.67', 'rating': 4.7, 'trades': 312},
        {'buyer': 'HotdogBeliever', 'amount': '1450', 'price': '0.66', 'rating': 4.8, 'trades': 245},
        {'buyer': 'FunTokenBull', 'amount': '790', 'price': '0.65', 'rating': 4.5, 'trades': 156},
        {'buyer': 'CryptoSausage', 'amount': '1960', 'price': '0.64', 'rating': 4.9, 'trades': 389},
        {'buyer': 'HotdogWhale', 'amount': '4200', 'price': '0.63', 'rating': 4.7, 'trades': 567},
      ]
    },
    'LUMN': {
      'floorPrice': 15.30,
      'currentPrice': 16.85,
      'sellOffers': [
        {'seller': 'LumenGuardian', 'amount': '45', 'price': '15.45', 'rating': 4.9, 'trades': 345},
        {'seller': 'StarKeeper', 'amount': '78', 'price': '15.80', 'rating': 4.8, 'trades': 267},
        {'seller': 'CosmicTrader', 'amount': '32', 'price': '16.20', 'rating': 4.7, 'trades': 189},
        {'seller': 'LightCollector', 'amount': '156', 'price': '16.50', 'rating': 4.9, 'trades': 423},
        {'seller': 'StellarHolder', 'amount': '89', 'price': '16.75', 'rating': 4.6, 'trades': 134},
        {'seller': 'LumenMaster', 'amount': '234', 'price': '17.00', 'rating': 4.8, 'trades': 456},
        {'seller': 'GalaxyTrader', 'amount': '67', 'price': '17.25', 'rating': 4.5, 'trades': 123},
        {'seller': 'CelestialHODLer', 'amount': '123', 'price': '17.50', 'rating': 4.9, 'trades': 378},
        {'seller': 'StardustCollector', 'amount': '98', 'price': '17.75', 'rating': 4.7, 'trades': 234},
        {'seller': 'CosmosExplorer', 'amount': '187', 'price': '18.00', 'rating': 4.8, 'trades': 345},
        {'seller': 'LightBearer', 'amount': '56', 'price': '18.25', 'rating': 4.4, 'trades': 98},
        {'seller': 'StellarWhale', 'amount': '298', 'price': '18.50', 'rating': 4.9, 'trades': 567},
        {'seller': 'LumenLord', 'amount': '145', 'price': '18.75', 'rating': 4.6, 'trades': 189},
        {'seller': 'GalacticTrader', 'amount': '73', 'price': '19.00', 'rating': 4.8, 'trades': 278},
        {'seller': 'StarNavigator', 'amount': '167', 'price': '19.25', 'rating': 4.7, 'trades': 312},
        {'seller': 'CosmicCollector', 'amount': '89', 'price': '19.50', 'rating': 4.5, 'trades': 156},
        {'seller': 'CelestialKeeper', 'amount': '234', 'price': '19.75', 'rating': 4.9, 'trades': 445},
        {'seller': 'LumenSage', 'amount': '112', 'price': '20.00', 'rating': 4.8, 'trades': 289},
        {'seller': 'StarChaser', 'amount': '67', 'price': '20.25', 'rating': 4.6, 'trades': 167},
        {'seller': 'GalaxyGuardian', 'amount': '189', 'price': '20.50', 'rating': 4.7, 'trades': 334},
        {'seller': 'CosmicWisdom', 'amount': '145', 'price': '20.75', 'rating': 4.9, 'trades': 398},
        {'seller': 'StellarVault', 'amount': '78', 'price': '21.00', 'rating': 4.8, 'trades': 245},
      ],
      'buyOffers': [
        {'buyer': 'LumenSeeker', 'amount': '87', 'price': '15.10', 'rating': 4.8, 'trades': 234},
        {'buyer': 'StarHunter', 'amount': '145', 'price': '14.95', 'rating': 4.7, 'trades': 189},
        {'buyer': 'CosmicBuyer', 'amount': '56', 'price': '14.80', 'rating': 4.9, 'trades': 345},
        {'buyer': 'LightGatherer', 'amount': '234', 'price': '14.65', 'rating': 4.6, 'trades': 156},
        {'buyer': 'StellarInvestor', 'amount': '98', 'price': '14.50', 'rating': 4.8, 'trades': 278},
        {'buyer': 'LumenAccumulator', 'amount': '167', 'price': '14.35', 'rating': 4.5, 'trades': 123},
        {'buyer': 'GalaxyInvestor', 'amount': '123', 'price': '14.20', 'rating': 4.9, 'trades': 423},
        {'buyer': 'CelestialBuyer', 'amount': '78', 'price': '14.05', 'rating': 4.7, 'trades': 201},
        {'buyer': 'StardustHunter', 'amount': '189', 'price': '13.90', 'rating': 4.4, 'trades': 134},
        {'buyer': 'CosmicCollector', 'amount': '267', 'price': '13.75', 'rating': 4.8, 'trades': 367},
        {'buyer': 'LightCollector', 'amount': '89', 'price': '13.60', 'rating': 4.6, 'trades': 167},
        {'buyer': 'StellarSeeker', 'amount': '145', 'price': '13.45', 'rating': 4.9, 'trades': 456},
        {'buyer': 'LumenHunter', 'amount': '112', 'price': '13.30', 'rating': 4.7, 'trades': 245},
        {'buyer': 'GalacticBuyer', 'amount': '67', 'price': '13.15', 'rating': 4.5, 'trades': 156},
        {'buyer': 'StarCollector', 'amount': '198', 'price': '13.00', 'rating': 4.8, 'trades': 334},
        {'buyer': 'CosmosInvestor', 'amount': '145', 'price': '12.85', 'rating': 4.9, 'trades': 389},
        {'buyer': 'CelestialSeeker', 'amount': '89', 'price': '12.70', 'rating': 4.6, 'trades': 178},
        {'buyer': 'LumenWhale', 'amount': '356', 'price': '12.55', 'rating': 4.8, 'trades': 567},
        {'buyer': 'StarInvestor', 'amount': '123', 'price': '12.40', 'rating': 4.7, 'trades': 289},
        {'buyer': 'GalaxyCollector', 'amount': '78', 'price': '12.25', 'rating': 4.4, 'trades': 134},
        {'buyer': 'CosmicSeeker', 'amount': '234', 'price': '12.10', 'rating': 4.9, 'trades': 445},
        {'buyer': 'StellarWhale', 'amount': '189', 'price': '11.95', 'rating': 4.8, 'trades': 378},
      ]
    },
    'NBLA': {
      'floorPrice': 2.45,
      'currentPrice': 2.78,
      'sellOffers': [
        {'seller': 'NebulaKeeper', 'amount': '450', 'price': '2.50', 'rating': 4.9, 'trades': 423},
        {'seller': 'CosmicDust', 'amount': '320', 'price': '2.65', 'rating': 4.8, 'trades': 345},
        {'seller': 'StarFieldTrader', 'amount': '780', 'price': '2.70', 'rating': 4.7, 'trades': 267},
        {'seller': 'GalaxyMist', 'amount': '590', 'price': '2.75', 'rating': 4.9, 'trades': 456},
        {'seller': 'NebulaExplorer', 'amount': '234', 'price': '2.80', 'rating': 4.6, 'trades': 189},
        {'seller': 'CosmicCloud', 'amount': '867', 'price': '2.85', 'rating': 4.8, 'trades': 378},
        {'seller': 'StellarNebula', 'amount': '412', 'price': '2.90', 'rating': 4.5, 'trades': 156},
        {'seller': 'SpaceDustCollector', 'amount': '645', 'price': '2.95', 'rating': 4.9, 'trades': 567},
        {'seller': 'NebulaHODLer', 'amount': '298', 'price': '3.00', 'rating': 4.7, 'trades': 234},
        {'seller': 'GalacticMist', 'amount': '523', 'price': '3.05', 'rating': 4.8, 'trades': 312},
        {'seller': 'CosmicNebula', 'amount': '376', 'price': '3.10', 'rating': 4.4, 'trades': 134},
        {'seller': 'StarCloudTrader', 'amount': '789', 'price': '3.15', 'rating': 4.9, 'trades': 445},
        {'seller': 'NebulaGuardian', 'amount': '198', 'price': '3.20', 'rating': 4.6, 'trades': 167},
        {'seller': 'CosmicVapor', 'amount': '654', 'price': '3.25', 'rating': 4.8, 'trades': 289},
        {'seller': 'StellarMist', 'amount': '445', 'price': '3.30', 'rating': 4.7, 'trades': 245},
        {'seller': 'GalaxyNebula', 'amount': '312', 'price': '3.35', 'rating': 4.5, 'trades': 178},
        {'seller': 'CosmicStorm', 'amount': '567', 'price': '3.40', 'rating': 4.9, 'trades': 398},
        {'seller': 'NebulaVault', 'amount': '234', 'price': '3.45', 'rating': 4.8, 'trades': 278},
        {'seller': 'StardustNebula', 'amount': '698', 'price': '3.50', 'rating': 4.6, 'trades': 334},
        {'seller': 'CosmicWhirlwind', 'amount': '389', 'price': '3.55', 'rating': 4.7, 'trades': 256},
        {'seller': 'GalacticStorm', 'amount': '456', 'price': '3.60', 'rating': 4.9, 'trades': 367},
        {'seller': 'NebulaWhale', 'amount': '823', 'price': '3.65', 'rating': 4.8, 'trades': 489},
      ],
      'buyOffers': [
        {'buyer': 'NebulaHunter', 'amount': '567', 'price': '2.40', 'rating': 4.8, 'trades': 234},
        {'buyer': 'CosmicSeeker', 'amount': '234', 'price': '2.35', 'rating': 4.7, 'trades': 189},
        {'buyer': 'StarMistCollector', 'amount': '789', 'price': '2.30', 'rating': 4.9, 'trades': 345},
        {'buyer': 'GalaxyGatherer', 'amount': '412', 'price': '2.25', 'rating': 4.6, 'trades': 156},
        {'buyer': 'NebulaInvestor', 'amount': '645', 'price': '2.20', 'rating': 4.8, 'trades': 278},
        {'buyer': 'CosmicBuyer', 'amount': '298', 'price': '2.15', 'rating': 4.5, 'trades': 123},
        {'buyer': 'StellarCloudSeeker', 'amount': '523', 'price': '2.10', 'rating': 4.9, 'trades': 423},
        {'buyer': 'SpaceDustHunter', 'amount': '376', 'price': '2.05', 'rating': 4.7, 'trades': 201},
        {'buyer': 'NebulaAccumulator', 'amount': '698', 'price': '2.00', 'rating': 4.4, 'trades': 134},
        {'buyer': 'GalacticMistBuyer', 'amount': '456', 'price': '1.95', 'rating': 4.8, 'trades': 367},
        {'buyer': 'CosmicCloudCollector', 'amount': '234', 'price': '1.90', 'rating': 4.6, 'trades': 167},
        {'buyer': 'StarNebulaSeeker', 'amount': '789', 'price': '1.85', 'rating': 4.9, 'trades': 456},
        {'buyer': 'NebulaWhale', 'amount': '567', 'price': '1.80', 'rating': 4.7, 'trades': 245},
        {'buyer': 'CosmicStormChaser', 'amount': '345', 'price': '1.75', 'rating': 4.5, 'trades': 156},
        {'buyer': 'GalacticVaporBuyer', 'amount': '823', 'price': '1.70', 'rating': 4.8, 'trades': 334},
        {'buyer': 'StellarNebulaBuyer', 'amount': '412', 'price': '1.65', 'rating': 4.9, 'trades': 389},
        {'buyer': 'CosmicMistHunter', 'amount': '298', 'price': '1.60', 'rating': 4.6, 'trades': 178},
        {'buyer': 'NebulaMaximalist', 'amount': '945', 'price': '1.55', 'rating': 4.8, 'trades': 567},
        {'buyer': 'StarCloudInvestor', 'amount': '234', 'price': '1.50', 'rating': 4.7, 'trades': 289},
        {'buyer': 'GalaxyDustBuyer', 'amount': '656', 'price': '1.45', 'rating': 4.4, 'trades': 134},
        {'buyer': 'CosmicNebulaFan', 'amount': '378', 'price': '1.40', 'rating': 4.9, 'trades': 445},
        {'buyer': 'StellarWhirlwind', 'amount': '512', 'price': '1.35', 'rating': 4.8, 'trades': 378},
      ]
    },
    'QUSR': {
      'floorPrice': 125.50,
      'currentPrice': 132.75,
      'sellOffers': [
        {'seller': 'QuasarKeeper', 'amount': '12', 'price': '128.00', 'rating': 4.9, 'trades': 567},
        {'seller': 'StellarPulse', 'amount': '8', 'price': '130.50', 'rating': 4.8, 'trades': 423},
        {'seller': 'CosmicBeacon', 'amount': '15', 'price': '132.00', 'rating': 4.7, 'trades': 345},
        {'seller': 'QuasarHODLer', 'amount': '6', 'price': '133.75', 'rating': 4.9, 'trades': 456},
        {'seller': 'GalacticPulsar', 'amount': '23', 'price': '135.25', 'rating': 4.6, 'trades': 234},
        {'seller': 'StarBurstTrader', 'amount': '18', 'price': '137.00', 'rating': 4.8, 'trades': 378},
        {'seller': 'QuasarMaster', 'amount': '9', 'price': '138.50', 'rating': 4.5, 'trades': 189},
        {'seller': 'CosmicRadiation', 'amount': '27', 'price': '140.25', 'rating': 4.9, 'trades': 623},
        {'seller': 'StellarEruption', 'amount': '14', 'price': '142.00', 'rating': 4.7, 'trades': 312},
        {'seller': 'QuasarGuardian', 'amount': '21', 'price': '143.75', 'rating': 4.8, 'trades': 445},
        {'seller': 'GalaxyRadio', 'amount': '11', 'price': '145.50', 'rating': 4.4, 'trades': 167},
        {'seller': 'CosmicPhenomena', 'amount': '16', 'price': '147.25', 'rating': 4.9, 'trades': 534},
        {'seller': 'QuasarVault', 'amount': '7', 'price': '149.00', 'rating': 4.6, 'trades': 278},
        {'seller': 'StellarPhysics', 'amount': '24', 'price': '150.75', 'rating': 4.8, 'trades': 389},
        {'seller': 'CosmicEnergyTrader', 'amount': '13', 'price': '152.50', 'rating': 4.7, 'trades': 256},
        {'seller': 'QuasarCollector', 'amount': '19', 'price': '154.25', 'rating': 4.5, 'trades': 201},
        {'seller': 'GalacticForce', 'amount': '10', 'price': '156.00', 'rating': 4.9, 'trades': 456},
        {'seller': 'StellarGravity', 'amount': '22', 'price': '157.75', 'rating': 4.8, 'trades': 367},
        {'seller': 'CosmicSingularity', 'amount': '8', 'price': '159.50', 'rating': 4.6, 'trades': 234},
        {'seller': 'QuasarPhoenix', 'amount': '17', 'price': '161.25', 'rating': 4.7, 'trades': 345},
        {'seller': 'GalaxyCore', 'amount': '25', 'price': '163.00', 'rating': 4.9, 'trades': 578},
        {'seller': 'StellarUniverse', 'amount': '12', 'price': '164.75', 'rating': 4.8, 'trades': 423},
      ],
      'buyOffers': [
        {'buyer': 'QuasarSeeker', 'amount': '15', 'price': '125.00', 'rating': 4.8, 'trades': 345},
        {'buyer': 'StellarHunter', 'amount': '9', 'price': '123.50', 'rating': 4.7, 'trades': 234},
        {'buyer': 'CosmicCollector', 'amount': '20', 'price': '122.00', 'rating': 4.9, 'trades': 456},
        {'buyer': 'QuasarInvestor', 'amount': '7', 'price': '120.50', 'rating': 4.6, 'trades': 189},
        {'buyer': 'GalacticBuyer', 'amount': '18', 'price': '119.00', 'rating': 4.8, 'trades': 378},
        {'buyer': 'StarBeaconSeeker', 'amount': '12', 'price': '117.50', 'rating': 4.5, 'trades': 156},
        {'buyer': 'QuasarAccumulator', 'amount': '24', 'price': '116.00', 'rating': 4.9, 'trades': 567},
        {'buyer': 'CosmicEnergyBuyer', 'amount': '14', 'price': '114.50', 'rating': 4.7, 'trades': 289},
        {'buyer': 'StellarRadioBuyer', 'amount': '8', 'price': '113.00', 'rating': 4.4, 'trades': 167},
        {'buyer': 'QuasarWhale', 'amount': '31', 'price': '111.50', 'rating': 4.8, 'trades': 623},
        {'buyer': 'GalaxyPulseBuyer', 'amount': '16', 'price': '110.00', 'rating': 4.6, 'trades': 234},
        {'buyer': 'CosmicBurstSeeker', 'amount': '22', 'price': '108.50', 'rating': 4.9, 'trades': 445},
        {'buyer': 'StellarPhenomena', 'amount': '11', 'price': '107.00', 'rating': 4.7, 'trades': 312},
        {'buyer': 'QuasarMaximalist', 'amount': '19', 'price': '105.50', 'rating': 4.5, 'trades': 201},
        {'buyer': 'GalacticRadiation', 'amount': '26', 'price': '104.00', 'rating': 4.8, 'trades': 534},
        {'buyer': 'CosmicGravityBuyer', 'amount': '13', 'price': '102.50', 'rating': 4.9, 'trades': 456},
        {'buyer': 'StellarSingularity', 'amount': '9', 'price': '101.00', 'rating': 4.6, 'trades': 189},
        {'buyer': 'QuasarPhysicist', 'amount': '28', 'price': '99.50', 'rating': 4.8, 'trades': 578},
        {'buyer': 'GalaxyForceSeeker', 'amount': '17', 'price': '98.00', 'rating': 4.7, 'trades': 367},
        {'buyer': 'CosmicUniverseBuyer', 'amount': '21', 'price': '96.50', 'rating': 4.4, 'trades': 234},
        {'buyer': 'StellarCoreCollector', 'amount': '23', 'price': '95.00', 'rating': 4.9, 'trades': 612},
        {'buyer': 'QuasarEternity', 'amount': '15', 'price': '93.50', 'rating': 4.8, 'trades': 489},
      ]
    },
    'VRTX': {
      'floorPrice': 8.75,
      'currentPrice': 9.45,
      'sellOffers': [
        {'seller': 'VortexMaster', 'amount': '125', 'price': '8.90', 'rating': 4.9, 'trades': 445},
        {'seller': 'SpinTrader', 'amount': '87', 'price': '9.15', 'rating': 4.8, 'trades': 367},
        {'seller': 'QuantumVortex', 'amount': '156', 'price': '9.30', 'rating': 4.7, 'trades': 289},
        {'seller': 'CycloneKeeper', 'amount': '98', 'price': '9.40', 'rating': 4.9, 'trades': 523},
        {'seller': 'VortexGuardian', 'amount': '234', 'price': '9.55', 'rating': 4.6, 'trades': 234},
        {'seller': 'TornadoTrader', 'amount': '167', 'price': '9.70', 'rating': 4.8, 'trades': 378},
        {'seller': 'SpiralHODLer', 'amount': '76', 'price': '9.85', 'rating': 4.5, 'trades': 156},
        {'seller': 'VortexCollector', 'amount': '198', 'price': '10.00', 'rating': 4.9, 'trades': 612},
        {'seller': 'WhirlpoolMaster', 'amount': '134', 'price': '10.15', 'rating': 4.7, 'trades': 345},
        {'seller': 'CyclicTrader', 'amount': '89', 'price': '10.30', 'rating': 4.8, 'trades': 456},
        {'seller': 'VortexLord', 'amount': '267', 'price': '10.45', 'rating': 4.4, 'trades': 189},
        {'seller': 'SpinCycleTrader', 'amount': '145', 'price': '10.60', 'rating': 4.9, 'trades': 534},
        {'seller': 'QuantumSpiral', 'amount': '78', 'price': '10.75', 'rating': 4.6, 'trades': 278},
        {'seller': 'VortexExpert', 'amount': '223', 'price': '10.90', 'rating': 4.8, 'trades': 423},
        {'seller': 'TwistedTrader', 'amount': '112', 'price': '11.05', 'rating': 4.7, 'trades': 312},
        {'seller': 'CycloneCollector', 'amount': '189', 'price': '11.20', 'rating': 4.5, 'trades': 201},
        {'seller': 'VortexPhoenix', 'amount': '67', 'price': '11.35', 'rating': 4.9, 'trades': 445},
        {'seller': 'SpiralGalaxy', 'amount': '245', 'price': '11.50', 'rating': 4.8, 'trades': 389},
        {'seller': 'WhirlwindTrader', 'amount': '156', 'price': '11.65', 'rating': 4.6, 'trades': 256},
        {'seller': 'VortexUniverse', 'amount': '98', 'price': '11.80', 'rating': 4.7, 'trades': 367},
        {'seller': 'QuantumTornado', 'amount': '178', 'price': '11.95', 'rating': 4.9, 'trades': 578},
        {'seller': 'EternalVortex', 'amount': '134', 'price': '12.10', 'rating': 4.8, 'trades': 456},
      ],
      'buyOffers': [
        {'buyer': 'VortexSeeker', 'amount': '145', 'price': '8.65', 'rating': 4.8, 'trades': 345},
        {'buyer': 'SpinHunter', 'amount': '89', 'price': '8.50', 'rating': 4.7, 'trades': 234},
        {'buyer': 'QuantumCollector', 'amount': '267', 'price': '8.35', 'rating': 4.9, 'trades': 456},
        {'buyer': 'CycloneBuyer', 'amount': '123', 'price': '8.20', 'rating': 4.6, 'trades': 189},
        {'buyer': 'VortexInvestor', 'amount': '198', 'price': '8.05', 'rating': 4.8, 'trades': 378},
        {'buyer': 'TornadoSeeker', 'amount': '76', 'price': '7.90', 'rating': 4.5, 'trades': 156},
        {'buyer': 'SpiralBuyer', 'amount': '234', 'price': '7.75', 'rating': 4.9, 'trades': 567},
        {'buyer': 'VortexAccumulator', 'amount': '167', 'price': '7.60', 'rating': 4.7, 'trades': 289},
        {'buyer': 'WhirlpoolInvestor', 'amount': '98', 'price': '7.45', 'rating': 4.4, 'trades': 167},
        {'buyer': 'VortexWhale', 'amount': '345', 'price': '7.30', 'rating': 4.8, 'trades': 623},
        {'buyer': 'CyclicInvestor', 'amount': '189', 'price': '7.15', 'rating': 4.6, 'trades': 234},
        {'buyer': 'QuantumVortexBuyer', 'amount': '112', 'price': '7.00', 'rating': 4.9, 'trades': 445},
        {'buyer': 'SpinCycleBuyer', 'amount': '256', 'price': '6.85', 'rating': 4.7, 'trades': 312},
        {'buyer': 'VortexMaximalist', 'amount': '134', 'price': '6.70', 'rating': 4.5, 'trades': 201},
        {'buyer': 'TwistedInvestor', 'amount': '178', 'price': '6.55', 'rating': 4.8, 'trades': 534},
        {'buyer': 'CycloneWhale', 'amount': '298', 'price': '6.40', 'rating': 4.9, 'trades': 456},
        {'buyer': 'SpiralGalaxBuyer', 'amount': '89', 'price': '6.25', 'rating': 4.6, 'trades': 189},
        {'buyer': 'VortexEternity', 'amount': '223', 'price': '6.10', 'rating': 4.8, 'trades': 578},
        {'buyer': 'WhirlwindInvestor', 'amount': '145', 'price': '5.95', 'rating': 4.7, 'trades': 367},
        {'buyer': 'QuantumSpinBuyer', 'amount': '167', 'price': '5.80', 'rating': 4.4, 'trades': 234},
        {'buyer': 'VortexInfinity', 'amount': '234', 'price': '5.65', 'rating': 4.9, 'trades': 612},
        {'buyer': 'EternalSpiral', 'amount': '178', 'price': '5.50', 'rating': 4.8, 'trades': 489},
      ]
    },
  };

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Get token image based on symbol
    String tokenImage = 'assets/images/bitcoin.png';
    if (widget.tokenSymbol == 'GENST') {
      tokenImage = 'assets/tokens/genisisstone.webp';
    } else if (widget.tokenSymbol == 'HTDG') {
      tokenImage = 'assets/tokens/hotdog.webp';
    }

    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: widget.tokenName,
      ),
      body: VerticalFadeListView(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Token header info
            Container(
              padding: EdgeInsets.all(AppTheme.cardPadding.w),
              child: GlassContainer(
                customShadow: isDarkMode ? [] : null,
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.cardPadding.w),
                  child: Row(
                    children: [
                      // Token icon
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ]
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            tokenImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: AppTheme.elementSpacing.w),
                      // Token info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tokenName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              widget.tokenSymbol,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                              ),
                            ),
                            SizedBox(height: AppTheme.elementSpacing.h * 0.5),
                            Row(
                              children: [
                                ColoredPriceWidget(
                                  price: '48,224.65',
                                  isPositive: true,
                                ),
                                SizedBox(width: AppTheme.elementSpacing.w),
                                PercentageChangeWidget(
                                  percentage: '+5.2%',
                                  isPositive: true,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Currency tile for chart navigation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: GestureDetector(
                onTap: () {
                  // Navigate to BitcoinScreen with token data
                  context.pushNamed(
                    'bitcoin',
                    extra: {
                      'isToken': true,
                      'tokenSymbol': widget.tokenSymbol,
                      'tokenName': widget.tokenName,
                      'priceHistory': tokenPriceHistory[widget.tokenSymbol],
                      'currentPrice': _getCurrentTokenData()['currentPrice'],
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(AppTheme.cardPadding.w * 0.75),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      SizedBox(width: AppTheme.elementSpacing.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'View Price Chart',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Track ${widget.tokenSymbol} price movements',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
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
            
            SizedBox(height: AppTheme.cardPadding.h),

            // Buy/Sell buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: Row(
                children: [
                  Expanded(
                    child: LongButtonWidget(
                      buttonType: ButtonType.solid,
                      title: 'Buy ${widget.tokenSymbol}',
                      onTap: () {
                        _showBuyBottomSheet();
                      },
                    ),
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w),
                  Expanded(
                    child: LongButtonWidget(
                      buttonType: ButtonType.transparent,
                      title: 'Sell ${widget.tokenSymbol}',
                      onTap: () {
                        _showSellBottomSheet();
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppTheme.cardPadding.h),

            // Sell offers section
            CommonHeading(
              headingText: '💰 Sell Offers',
              hasButton: false,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: GlassContainer(
                customShadow: isDarkMode ? [] : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                  child: Column(
                    children: _getCurrentTokenData()['sellOffers'].take(5).map<Widget>((offer) => _buildOfferTile(offer, true)).toList(),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppTheme.cardPadding.h),

            // Buy offers section
            CommonHeading(
              headingText: '🛒 Buy Offers',
              hasButton: false,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: GlassContainer(
                customShadow: isDarkMode ? [] : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                  child: Column(
                    children: _getCurrentTokenData()['buyOffers'].take(5).map<Widget>((offer) => _buildOfferTile(offer, false)).toList(),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppTheme.cardPadding.h * 2),
          ],
        ),
      ),
    );
  }

  // Helper method to get current token data
  Map<String, dynamic> _getCurrentTokenData() {
    return tokenMarketData[widget.tokenSymbol] ?? tokenMarketData['GENST']!;
  }

  Widget _buildOfferTile(Map<String, dynamic> offer, bool isSellOffer) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding.w,
        vertical: AppTheme.elementSpacing.h * 0.5,
      ),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Text(
          offer[isSellOffer ? 'seller' : 'buyer'][0],
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer[isSellOffer ? 'seller' : 'buyer'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: AppTheme.colorBitcoin,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${offer['rating']} (${offer['trades']} trades)',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${offer['amount']} ${widget.tokenSymbol}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '\$${offer['price']} each',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                ),
              ),
            ],
          ),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: AppTheme.elementSpacing.h * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${offer['total']}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            LongButtonWidget(
              buttonType: ButtonType.solid,
              title: isSellOffer ? 'Buy' : 'Sell',
              customHeight: 32.h,
              customWidth: 80.w,
              onTap: () {
                // Handle buy/sell action
                _showTradeDialog(offer, isSellOffer);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTradeDialog(Map<String, dynamic> offer, bool isBuyingFromSeller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isBuyingFromSeller ? 'Buy ${widget.tokenSymbol}' : 'Sell ${widget.tokenSymbol}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${isBuyingFromSeller ? 'Seller' : 'Buyer'}: ${offer[isBuyingFromSeller ? 'seller' : 'buyer']}'),
            Text('Amount: ${offer['amount']} ${widget.tokenSymbol}'),
            Text('Price per token: \$${offer['price']}'),
            Text('Total: \$${offer['total']}'),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Are you sure you want to ${isBuyingFromSeller ? 'buy' : 'sell'} this amount?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Handle trade execution
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Trade initiated with ${offer[isBuyingFromSeller ? 'seller' : 'buyer']}'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: Text(isBuyingFromSeller ? 'Buy' : 'Sell'),
          ),
        ],
      ),
    );
  }

  void _showBuyBottomSheet() {
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
                text: buyStep == 1 ? 'Buy ${widget.tokenSymbol}' : 'Best Matches',
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

  void _showSellBottomSheet() {
    // Reset state
    sellStep = 1;
    selectedPrice = '';
    selectedAmount = '';
    priceController.clear();
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
                  child: sellStep == 1 ? _buildPriceStep(setBottomSheetState) : sellStep == 2 ? _buildAmountStep(setBottomSheetState) : _buildOverviewStep(setBottomSheetState),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceStep(StateSetter setBottomSheetState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price input section
        Text(
          'Your price per token',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // AmountWidget for price input (USD/currency mode)
        AmountWidget(
          enabled: () => true,
          btcController: sellPriceBtcController,
          satController: sellPriceSatController,
          currController: sellPriceCurrController,
          focusNode: sellPriceFocusNode,
          context: context,
          autoConvert: false,
          bitcoinUnit: BitcoinUnits.BTC,
          swapped: true, // Start in currency mode for price
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Floor price info
        Container(
          padding: EdgeInsets.all(AppTheme.cardPadding.w * 0.75),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: Row(
            children: [
              Icon(
                Icons.trending_down,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Floor Price: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '\$${_getCurrentTokenData()['floorPrice']}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // Price comparison
        if (sellPriceCurrController.text.isNotEmpty && sellPriceCurrController.text != '0.00') ...[
          Container(
            padding: EdgeInsets.all(AppTheme.elementSpacing.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                Expanded(
                  child: Text(
                    _getPriceComparisonTextFromAmount(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
        
        const Spacer(),
        
        // Continue button
        LongButtonWidget(
          buttonType: ButtonType.solid,
          title: 'Continue',
          onTap: (sellPriceCurrController.text.isEmpty || sellPriceCurrController.text == '0.00') ? null : () {
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
          'How many ${widget.tokenSymbol} to sell?',
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
          bitcoinUnit: BitcoinUnits.BTC,
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Available tokens info
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Available: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '2.5 ${widget.tokenSymbol}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Continue button
        LongButtonWidget(
          buttonType: ButtonType.solid,
          title: 'Continue',
          onTap: (btcController.text.isEmpty || btcController.text == '0') ? null : () {
            selectedAmount = btcController.text;
            setBottomSheetState(() {
              sellStep = 3;
            });
          },
        ),
      ],
    );
  }

  String _getPriceComparisonText() {
    final double userPrice = double.tryParse(priceController.text) ?? 0;
    const double floorPrice = 48100;
    
    if (userPrice > floorPrice) {
      final double difference = ((userPrice - floorPrice) / floorPrice * 100);
      return 'Your price is ${difference.toStringAsFixed(1)}% above floor price';
    } else if (userPrice < floorPrice) {
      final double difference = ((floorPrice - userPrice) / floorPrice * 100);
      return 'Your price is ${difference.toStringAsFixed(1)}% below floor price';
    } else {
      return 'Your price matches the floor price';
    }
  }

  String _getPriceComparisonTextFromAmount() {
    final double userPrice = double.tryParse(sellPriceCurrController.text) ?? 0;
    final double floorPrice = _getCurrentTokenData()['floorPrice'].toDouble();
    
    if (userPrice > floorPrice) {
      final double difference = ((userPrice - floorPrice) / floorPrice * 100);
      return 'Your price is ${difference.toStringAsFixed(1)}% above floor price';
    } else if (userPrice < floorPrice) {
      final double difference = ((floorPrice - userPrice) / floorPrice * 100);
      return 'Your price is ${difference.toStringAsFixed(1)}% below floor price';
    } else {
      return 'Your price matches the floor price';
    }
  }

  Widget _buildOverviewStep(StateSetter setBottomSheetState) {
    final double pricePerToken = double.tryParse(selectedPrice) ?? 0;
    final double amount = double.tryParse(selectedAmount) ?? 0;
    final double totalValue = pricePerToken * amount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order summary header
        Text(
          'Order Summary',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Order details container
        Container(
          padding: EdgeInsets.all(AppTheme.cardPadding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              // Token info
              Row(
                children: [
                  Container(
                    height: 50.h,
                    width: 50.w,
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
                        widget.tokenSymbol == 'GENST' 
                          ? 'assets/tokens/genisisstone.webp'
                          : widget.tokenSymbol == 'HTDG'
                            ? 'assets/tokens/hotdog.webp'
                            : 'assets/images/bitcoin.png',
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
                          'Selling ${widget.tokenName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          widget.tokenSymbol,
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
              _buildOrderDetailRow('Amount', '$selectedAmount ${widget.tokenSymbol}'),
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
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Floor price comparison info
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Expanded(
                child: Text(
                  _getPriceComparisonTextFromAmount(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Put on market button
        LongButtonWidget(
          buttonType: ButtonType.solid,
          title: 'Put on Market',
          onTap: () {
            Navigator.of(context).pop();
            _executeSellOrder();
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
                color: AppTheme.successColor,
              )
            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
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
          bitcoinUnit: BitcoinUnits.BTC,
          onAmountChange: (currencyType, text) {
            setBottomSheetState(() {});
          },
        ),
        
        const Spacer(),
        
        // Continue button
        LongButtonWidget(
          buttonType: ButtonType.solid,
          title: 'Find Best Matches',
          onTap: (btcController.text.isEmpty || btcController.text == '0') ? null : () {
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
    final tokenData = tokenMarketData[widget.tokenSymbol] ?? tokenMarketData['GENST']!;
    final sellOffers = List<Map<String, dynamic>>.from(tokenData['sellOffers']);
    
    // Filter and sort sellers based on the requested amount
    final requestedAmount = double.tryParse(buyAmount) ?? 0;
    
    // Advanced matching algorithm (to be deleted later only to mock user workflow)
    final availableSellers = sellOffers.where((seller) {
      final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
      return sellerAmount >= requestedAmount; // Only show sellers who have enough tokens
    }).toList();
    
    // Multi-factor sorting for best match (to be deleted later only to mock user workflow)
    availableSellers.sort((a, b) {
      final priceA = double.tryParse(a['price'].toString().replaceAll(',', '')) ?? 0;
      final priceB = double.tryParse(b['price'].toString().replaceAll(',', '')) ?? 0;
      final ratingA = double.tryParse(a['rating'].toString()) ?? 0;
      final ratingB = double.tryParse(b['rating'].toString()) ?? 0;
      final tradesA = int.tryParse(a['trades'].toString()) ?? 0;
      final tradesB = int.tryParse(b['trades'].toString()) ?? 0;
      
      // Calculate composite score (to be deleted later only to mock user workflow)
      // Lower price is better, higher rating is better, more trades is better
      final scoreA = (priceA / 100) - (ratingA * 2) - (tradesA / 100);
      final scoreB = (priceB / 100) - (ratingB * 2) - (tradesB / 100);
      
      return scoreA.compareTo(scoreB);
    });
    
    // If no exact matches, find sellers who can partially fulfill (to be deleted later only to mock user workflow)
    List<Map<String, dynamic>> partialSellers = [];
    if (availableSellers.isEmpty && requestedAmount > 0) {
      partialSellers = sellOffers.where((seller) {
        final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
        return sellerAmount > 0 && sellerAmount < requestedAmount;
      }).toList();
      
      partialSellers.sort((a, b) {
        final amountA = double.tryParse(a['amount'].toString()) ?? 0;
        final amountB = double.tryParse(b['amount'].toString()) ?? 0;
        return amountB.compareTo(amountA); // Sort by largest available amount first
      });
    }

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
                '$buyAmount ${widget.tokenSymbol}',
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
        
        // List of best matches
        Expanded(
          child: availableSellers.isEmpty && partialSellers.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                    SizedBox(height: AppTheme.elementSpacing.h),
                    Text(
                      'No sellers found for this amount',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: AppTheme.elementSpacing.h),
                    Text(
                      'Try a smaller amount or check back later',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // Show exact matches first
                  if (availableSellers.isNotEmpty) ...[
                    ...availableSellers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final seller = entry.value;
                      final isFirstItem = index == 0;
                      final pricePerToken = double.tryParse(seller['price'].toString().replaceAll(',', '')) ?? 0;
                      final totalCost = pricePerToken * requestedAmount;
                      final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
                  
                  return Container(
                    padding: EdgeInsets.all(AppTheme.elementSpacing.w),
                    margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h * 0.5),
                    decoration: BoxDecoration(
                      color: isFirstItem 
                        ? AppTheme.successColor.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surface.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      border: Border.all(
                        color: isFirstItem 
                          ? AppTheme.successColor.withOpacity(0.3)
                          : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Seller info
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          child: Text(
                            seller['seller'][0],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: AppTheme.elementSpacing.w * 0.75),
                        
                        // Name and rating
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    seller['seller'],
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (isFirstItem) ...[
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.verified,
                                      color: AppTheme.successColor,
                                      size: 12,
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: AppTheme.colorBitcoin,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '${seller['rating']}',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '\$${seller['price']}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'per token',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                        
                        // Total cost
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${totalCost.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isFirstItem ? AppTheme.successColor : null,
                                ),
                              ),
                              Text(
                                'total',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                        
                        // Buy button
                        LongButtonWidget(
                          buttonType: ButtonType.solid,
                          title: 'Buy',
                          customHeight: AppTheme.buttonHeight * 0.7.h,
                          customWidth: AppTheme.cardPadding * 3.w,
                          onTap: () {
                            Navigator.of(context).pop();
                            _executeBuyOrder(seller);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                  ],
                  
                  // If no exact matches, show partial sellers
                  if (availableSellers.isEmpty && partialSellers.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(AppTheme.elementSpacing.w),
                      margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 20,
                          ),
                          SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                          Expanded(
                            child: Text(
                              'Only partial amounts available. Multiple orders required.',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...partialSellers.map((seller) {
                      final pricePerToken = double.tryParse(seller['price'].toString().replaceAll(',', '')) ?? 0;
                      final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
                      final totalCost = pricePerToken * sellerAmount;
                      
                      return Container(
                        padding: EdgeInsets.all(AppTheme.elementSpacing.w),
                        margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h * 0.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Seller info
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              child: Text(
                                seller['seller'][0],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: AppTheme.elementSpacing.w * 0.75),
                            
                            // Name and available
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    seller['seller'],
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Has ${sellerAmount} tokens',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 10,
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${seller['price']}',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'per token',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 9),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Total cost
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${totalCost.toStringAsFixed(2)}',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'for ${sellerAmount}',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 9),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                            
                            // Buy partial button
                            LongButtonWidget(
                              buttonType: ButtonType.transparent,
                              title: 'Buy',
                              customHeight: AppTheme.buttonHeight * 0.7.h,
                              customWidth: AppTheme.cardPadding * 3.w,
                              onTap: () {
                                Navigator.of(context).pop();
                                _executeBuyOrder(seller);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ],
              ),
        ),
      ],
    );
  }

  void _executeBuyOrder([Map<String, dynamic>? seller]) {
    // Mock workflow implementation (to be deleted later only to mock user workflow)
    final sellerName = seller?['seller'] ?? 'Unknown Seller';
    final amount = seller?['amount'] ?? buyAmount;
    final price = seller?['price'] ?? '0';
    
    // Simulate order processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Auto-dismiss after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully bought $amount ${widget.tokenSymbol} from $sellerName at \$$price per token'),
              backgroundColor: AppTheme.successColor,
              duration: Duration(seconds: 3),
            ),
          );
        });
        
        return Center(
          child: Container(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: AppTheme.elementSpacing.h),
                Text(
                  'Processing order...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _executeSellOrder() {
    // Mock workflow implementation (to be deleted later only to mock user workflow)
    // Add the new sell order to mock data temporarily
    final newOrder = {
      'seller': 'You',
      'amount': selectedAmount,
      'price': selectedPrice,
      'rating': 5.0,
      'trades': 0,
    };
    
    // Update mock data for this token
    setState(() {
      if (tokenMarketData.containsKey(widget.tokenSymbol)) {
        (tokenMarketData[widget.tokenSymbol]!['sellOffers'] as List).insert(0, newOrder);
      }
    });
    
    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Auto-dismiss after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully listed $selectedAmount ${widget.tokenSymbol} at \$$selectedPrice per token'),
              backgroundColor: AppTheme.successColor,
              duration: Duration(seconds: 3),
            ),
          );
        });
        
        return Center(
          child: Container(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: AppTheme.elementSpacing.h),
                Text(
                  'Listing tokens...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}