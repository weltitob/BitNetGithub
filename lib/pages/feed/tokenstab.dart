import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/items/marketcap_widget.dart';
import 'package:bitnet/components/items/number_indicator.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';


class TokensTab extends StatefulWidget {
  const TokensTab({super.key});

  @override
  State<TokensTab> createState() => _TokensTabState();
}

class _TokensTabState extends State<TokensTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  // Get price history for a token (simplified version)
  Map<String, dynamic> _getTokenPriceHistory(String symbol) {
    // This should match the data from TokenMarketplaceScreen
    // In a real app, this would be fetched from a service
    double currentPrice;
    switch (symbol) {
      case 'GENST':
        currentPrice = 48350.0;
        break;
      case 'HTDG':
        currentPrice = 15.75;
        break;
      case 'CAT':
        currentPrice = 892.50;
        break;
      case 'EMRLD':
        currentPrice = 12450.0;
        break;
      case 'LILA':
        currentPrice = 234.80;
        break;
      case 'MINRL':
        currentPrice = 3567.25;
        break;
      case 'TBLUE':
        currentPrice = 67.90;
        break;
      default:
        currentPrice = 100.0;
    }
    return {
      '1D': _generateSimplePriceHistory(currentPrice, 24, Duration(days: 1)),
      '1W': _generateSimplePriceHistory(currentPrice, 7 * 24, Duration(days: 7)),
      '1M': _generateSimplePriceHistory(currentPrice, 30 * 24, Duration(days: 30)),
      '1J': _generateSimplePriceHistory(currentPrice, 365, Duration(days: 365)),
      'Max': _generateSimplePriceHistory(currentPrice, 730, Duration(days: 730)),
    };
  }
  
  List<Map<String, dynamic>> _generateSimplePriceHistory(
    double currentPrice,
    int dataPoints,
    Duration totalDuration,
  ) {
    final List<Map<String, dynamic>> priceHistory = [];
    final now = DateTime.now();
    final intervalMs = totalDuration.inMilliseconds ~/ dataPoints;
    
    for (int i = 0; i < dataPoints; i++) {
      final timestamp = now.subtract(totalDuration).add(Duration(milliseconds: intervalMs * i));
      // Simple linear interpolation from 70% to 100% of current price
      final progress = i / dataPoints;
      final price = currentPrice * (0.7 + 0.3 * progress);
      
      priceHistory.add({
        'time': timestamp.millisecondsSinceEpoch,
        'price': price.toStringAsFixed(6),
      });
    }
    
    return priceHistory;
  }
  // Sample token data - all available tokens
  final List<Map<String, dynamic>> tokenData = [
    {
      'name': 'Genesis Stone',
      'symbol': 'GENST',
      'image': 'assets/tokens/genisisstone.webp',
      'price': '48,350',
      'change': '+3.7%',
      'isPositive': true,
      'color': Colors.blue,
      'chartData': [
        ChartLine(time: 0, price: 45000),
        ChartLine(time: 1, price: 45500),
        ChartLine(time: 2, price: 46200),
        ChartLine(time: 3, price: 46000),
        ChartLine(time: 4, price: 46800),
        ChartLine(time: 5, price: 47500),
        ChartLine(time: 6, price: 47200),
        ChartLine(time: 7, price: 48000),
        ChartLine(time: 8, price: 48200),
        ChartLine(time: 9, price: 48350),
      ]
    },
    {
      'name': 'Hotdog',
      'symbol': 'HTDG',
      'image': 'assets/tokens/hotdog.webp',
      'price': '15.75',
      'change': '+2.1%',
      'isPositive': true,
      'color': Colors.red.shade400,
      'chartData': [
        ChartLine(time: 0, price: 14.80),
        ChartLine(time: 1, price: 14.95),
        ChartLine(time: 2, price: 15.10),
        ChartLine(time: 3, price: 15.05),
        ChartLine(time: 4, price: 15.25),
        ChartLine(time: 5, price: 15.40),
        ChartLine(time: 6, price: 15.35),
        ChartLine(time: 7, price: 15.55),
        ChartLine(time: 8, price: 15.65),
        ChartLine(time: 9, price: 15.75),
      ]
    },
    {
      'name': 'Cat Token',
      'symbol': 'CAT',
      'image': 'assets/tokens/cat.webp',
      'price': '892.50',
      'change': '+8.4%',
      'isPositive': true,
      'color': Colors.orange,
      'chartData': [
        ChartLine(time: 0, price: 810),
        ChartLine(time: 1, price: 825),
        ChartLine(time: 2, price: 840),
        ChartLine(time: 3, price: 835),
        ChartLine(time: 4, price: 855),
        ChartLine(time: 5, price: 870),
        ChartLine(time: 6, price: 865),
        ChartLine(time: 7, price: 880),
        ChartLine(time: 8, price: 885),
        ChartLine(time: 9, price: 892.50),
      ]
    },
    {
      'name': 'Emerald',
      'symbol': 'EMRLD',
      'image': 'assets/tokens/emerald.webp',
      'price': '12,450',
      'change': '-1.2%',
      'isPositive': false,
      'color': Colors.green.shade700,
      'chartData': [
        ChartLine(time: 0, price: 12600),
        ChartLine(time: 1, price: 12580),
        ChartLine(time: 2, price: 12550),
        ChartLine(time: 3, price: 12530),
        ChartLine(time: 4, price: 12510),
        ChartLine(time: 5, price: 12490),
        ChartLine(time: 6, price: 12480),
        ChartLine(time: 7, price: 12470),
        ChartLine(time: 8, price: 12460),
        ChartLine(time: 9, price: 12450),
      ]
    },
    {
      'name': 'Lila Coin',
      'symbol': 'LILA',
      'image': 'assets/tokens/lila.webp',
      'price': '234.80',
      'change': '+5.6%',
      'isPositive': true,
      'color': Colors.purple,
      'chartData': [
        ChartLine(time: 0, price: 220),
        ChartLine(time: 1, price: 223),
        ChartLine(time: 2, price: 226),
        ChartLine(time: 3, price: 225),
        ChartLine(time: 4, price: 228),
        ChartLine(time: 5, price: 230),
        ChartLine(time: 6, price: 232),
        ChartLine(time: 7, price: 233),
        ChartLine(time: 8, price: 234),
        ChartLine(time: 9, price: 234.80),
      ]
    },
    {
      'name': 'Mineral',
      'symbol': 'MINRL',
      'image': 'assets/tokens/mineral.webp',
      'price': '3,567.25',
      'change': '+12.3%',
      'isPositive': true,
      'color': Colors.grey,
      'chartData': [
        ChartLine(time: 0, price: 3150),
        ChartLine(time: 1, price: 3200),
        ChartLine(time: 2, price: 3280),
        ChartLine(time: 3, price: 3350),
        ChartLine(time: 4, price: 3400),
        ChartLine(time: 5, price: 3450),
        ChartLine(time: 6, price: 3480),
        ChartLine(time: 7, price: 3520),
        ChartLine(time: 8, price: 3540),
        ChartLine(time: 9, price: 3567.25),
      ]
    },
    {
      'name': 'Token Blue',
      'symbol': 'TBLUE',
      'image': 'assets/tokens/token_blue.webp',
      'price': '67.90',
      'change': '-3.8%',
      'isPositive': false,
      'color': Colors.lightBlue,
      'chartData': [
        ChartLine(time: 0, price: 70.50),
        ChartLine(time: 1, price: 70.20),
        ChartLine(time: 2, price: 69.80),
        ChartLine(time: 3, price: 69.50),
        ChartLine(time: 4, price: 69.00),
        ChartLine(time: 5, price: 68.80),
        ChartLine(time: 6, price: 68.50),
        ChartLine(time: 7, price: 68.20),
        ChartLine(time: 8, price: 68.00),
        ChartLine(time: 9, price: 67.90),
      ]
    },
  ];

  // Top movers data
  final List<Map<String, dynamic>> topMoversData = [
    {
      'name': 'Mineral',
      'symbol': 'MINRL',
      'image': 'assets/tokens/mineral.webp',
      'change': '+12.3%',
      'isPositive': true,
    },
    {
      'name': 'Cat Token',
      'symbol': 'CAT',
      'image': 'assets/tokens/cat.webp',
      'change': '+8.4%',
      'isPositive': true,
    },
    {
      'name': 'Lila Coin',
      'symbol': 'LILA',
      'image': 'assets/tokens/lila.webp',
      'change': '+5.6%',
      'isPositive': true,
    },
  ];

  // Top volume data
  final List<Map<String, dynamic>> topVolumeData = [
    {
      'name': 'Genesis Stone',
      'symbol': 'GENST',
      'image': 'assets/tokens/genisisstone.webp',
      'change': '+3.7%',
      'isPositive': true,
    },
    {
      'name': 'Emerald',
      'symbol': 'EMRLD',
      'image': 'assets/tokens/emerald.webp',
      'change': '-1.2%',
      'isPositive': false,
    },
    {
      'name': 'Mineral',
      'symbol': 'MINRL',
      'image': 'assets/tokens/mineral.webp',
      'change': '+12.3%',
      'isPositive': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return bitnetScaffold(
      body: VerticalFadeListView.standardTab(
        child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
        
          // Trending section
          SizedBox(height: AppTheme.cardPadding * 1.5.h),
          
          // Carousel Slider for Trending Tokens
          CarouselSlider.builder(
            options: getStandardizedCarouselOptions(
              autoPlayIntervalSeconds: 4
            ),
            itemCount: tokenData.length,
            itemBuilder: (context, index, _) {
              final token = tokenData[index];
              final chartData = token['chartData'] as List<ChartLine>;
              
              // Wrap in RepaintBoundary for better performance
              return GestureDetector(
                onTap: () {
                  // Navigate to BitcoinScreen with token data
                  if (token['symbol'] == 'BTC') {
                    // For Bitcoin, navigate to normal Bitcoin screen
                    context.push('/wallet/bitcoinscreen');
                  } else {
                    // For tokens, pass token data
                    context.push(
                      '/wallet/bitcoinscreen',
                      extra: {
                        'isToken': true,
                        'tokenSymbol': token['symbol'],
                        'tokenName': token['name'],
                        'priceHistory': _getTokenPriceHistory(token['symbol']),
                        'currentPrice': double.parse(token['price'].replaceAll(',', '')),
                      },
                    );
                  }
                },
                child: RepaintBoundary(
                  child: GlassContainer(
                    width: getStandardizedCardWidth().w,
                    margin: EdgeInsets.symmetric(horizontal: getStandardizedCardMargin().w),
                    customShadow: isDarkMode ? [] : null,
                    child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h, // Increased from 16.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Token logo and name
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 38.h,
                            width: 38.w,
                            child: ClipOval(
                              child: Image.asset(
                                token['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: AppTheme.elementSpacing.w * 0.75), // Increased from 10.w
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                token['symbol'],
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp, // Increased font size
                                ),
                              ),
                              Text(
                                token['name'],
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                  fontSize: 12.sp, // Added specific font size
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      
                      SizedBox(height: 20.h), // Increased from 16.h
                      
                      // Chart - Wrapped in Expanded to prevent overflow
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.symmetric(horizontal: 4.w), // Minimal spacing
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            margin: EdgeInsets.zero,
                            primaryXAxis: CategoryAxis(
                              isVisible: false,
                              majorGridLines: const MajorGridLines(width: 0),
                              majorTickLines: const MajorTickLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              isVisible: false,
                              majorGridLines: const MajorGridLines(width: 0),
                              majorTickLines: const MajorTickLines(width: 0),
                            ),
                            series: <ChartSeries>[
                              // Line series - using correct color based on token performance
                              AreaSeries<ChartLine, double>(
                                dataSource: chartData,
                                animationDuration: 1500,
                                xValueMapper: (ChartLine data, _) => data.time,
                                yValueMapper: (ChartLine data, _) => data.price,
                                color: token['isPositive'] 
                                    ? AppTheme.successColor.withOpacity(0.3)
                                    : AppTheme.errorColor.withOpacity(0.3),
                                borderWidth: 2.5,
                                borderColor: token['isPositive'] 
                                    ? AppTheme.successColor
                                    : AppTheme.errorColor,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: token['isPositive'] 
                                      ? [
                                          AppTheme.successColor.withOpacity(0.3),
                                          AppTheme.successColor.withOpacity(0.05),
                                          Colors.transparent,
                                        ]
                                      : [
                                          AppTheme.errorColor.withOpacity(0.3),
                                          AppTheme.errorColor.withOpacity(0.05),
                                          Colors.transparent,
                                        ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppTheme.elementSpacing.h * 0.5), // Increased from 8.h
                      
                      // Price 
                      Text(
                        "${token['price']}\$",
                        style: Theme.of(context).textTheme.headlineLarge
                      ),
                      SizedBox(height: AppTheme.elementSpacing.h), // Increased from 4.h
                      Row(
                        children: [
                          ColoredPriceWidget(
                            price: (double.parse(token['price'].replaceAll(',', '')) * 0.98).toStringAsFixed(2),
                            isPositive: token['isPositive'],
                          ),
                          SizedBox(width: AppTheme.elementSpacing.w),
                          PercentageChangeWidget(
                            percentage: token['change'],
                            isPositive: token['isPositive'],
                            fontSize: 14,
                          ),
                        ],
                      ),
                      
                      
                      // Price change indicator (using reusable component)
                      ],
                    ),
                  ),
                ),
              ));
            },
          ),
          
          SizedBox(height: AppTheme.cardPadding.h * 1.5),
          
          // Top 3 by Market Cap section with CommonHeading
          CommonHeading(
            headingText: "💰 Top 3 by Market Cap",
            hasButton: true,
            onPress: 'marketcap',
          ),
          
          // A single GlassContainer containing all crypto items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: [
                    // First crypto item with NumberIndicator - Genesis Stone (highest market cap)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to BitcoinScreen with token data
                            context.push(
                              '/wallet/bitcoinscreen',
                              extra: {
                                'isToken': true,
                                'tokenSymbol': 'GENST',
                                'tokenName': 'Genesis Stone',
                                'priceHistory': _getTokenPriceHistory('GENST'),
                                'currentPrice': 48350.0,
                              },
                            );
                          },
                          child: _buildTokenCryptoItem(
                            currency: Currency(
                              code: 'GENST',
                              name: 'Genesis Stone',
                              icon: Image.asset("./assets/tokens/genisisstone.webp"),
                            ),
                            price: '48,350',
                            change: '+3.7%',
                            isPositive: true,
                            chartData: tokenData.firstWhere((t) => t['symbol'] == 'GENST')['chartData'],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 1),
                        ),
                      ],
                    ),
                    // Second crypto item with NumberIndicator - Emerald
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to BitcoinScreen with token data
                            context.push(
                              '/wallet/bitcoinscreen',
                              extra: {
                                'isToken': true,
                                'tokenSymbol': 'EMRLD',
                                'tokenName': 'Emerald',
                                'priceHistory': _getTokenPriceHistory('EMRLD'),
                                'currentPrice': 12450.0,
                              },
                            );
                          },
                          child: _buildTokenCryptoItem(
                            currency: Currency(
                              code: 'EMRLD',
                              name: 'Emerald',
                              icon: Image.asset("./assets/tokens/emerald.webp"),
                            ),
                            price: '12,450',
                            change: '-1.2%',
                            isPositive: false,
                            chartData: tokenData.firstWhere((t) => t['symbol'] == 'EMRLD')['chartData'],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 2),
                        ),
                      ],
                    ),
                    // Third crypto item with NumberIndicator - Mineral
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to BitcoinScreen with token data
                            context.push(
                              '/wallet/bitcoinscreen',
                              extra: {
                                'isToken': true,
                                'tokenSymbol': 'MINRL',
                                'tokenName': 'Mineral',
                                'priceHistory': _getTokenPriceHistory('MINRL'),
                                'currentPrice': 3567.25,
                              },
                            );
                          },
                          child: _buildTokenCryptoItem(
                            currency: Currency(
                              code: 'MINRL',
                              name: 'Mineral',
                              icon: Image.asset("./assets/tokens/mineral.webp"),
                            ),
                            price: '3,567.25',
                            change: '+12.3%',
                            isPositive: true,
                            chartData: tokenData.firstWhere((t) => t['symbol'] == 'MINRL')['chartData'],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Top Movers Today section with CommonHeading
          CommonHeading(
            headingText: "📈 Top Movers Today",
            hasButton: true,
            onPress: 'topmovers',
          ),
          
          // Top Movers list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topMoversData.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final mover = entry.value;
                    final tokenInfo = tokenData.firstWhere((t) => t['symbol'] == mover['symbol']);
                    return Stack(
                      children: [
                        _buildTokenCryptoItem(
                          currency: Currency(
                            code: mover['symbol'],
                            name: mover['name'],
                            icon: Image.asset(mover['image']),
                          ),
                          price: tokenInfo['price'],
                          change: mover['change'],
                          isPositive: mover['isPositive'],
                          chartData: tokenInfo['chartData'],
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: idx + 1),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Top Volume Today section with CommonHeading (Added section)
          CommonHeading(
            headingText: "📊 Top Volume Today",
            hasButton: true,
            onPress: 'topvolume',
          ),
          
          // Top Volume list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topVolumeData.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final volume = entry.value;
                    final tokenInfo = tokenData.firstWhere((t) => t['symbol'] == volume['symbol']);
                    return Stack(
                      children: [
                        _buildTokenCryptoItem(
                          currency: Currency(
                            code: volume['symbol'],
                            name: volume['name'],
                            icon: Image.asset(volume['image']),
                          ),
                          price: tokenInfo['price'],
                          change: volume['change'],
                          isPositive: volume['isPositive'],
                          chartData: tokenInfo['chartData'],
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: idx + 1),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Total Market Cap Today section with CommonHeading (commented out)
          // CommonHeading(
          //   headingText: "💲 Total Market Cap Today",
          //   hasButton: false,
          // ),
          
          // Using our new MarketCapWidget (commented out)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          //   child: MarketCapWidget(
          //     marketCap: '\$2.42T',
          //     changePercentage: '+5.2%',
          //     isPositive: true,
          //     tradingVolume: '\$71.2B', 
          //     btcDominance: '51.3%',
          //     // Sample chart data matching Bitcoin's pattern
          //     chartData: [
          //       ChartLine(time: 0, price: 2300000000000),
          //       ChartLine(time: 1, price: 2320000000000),
          //       ChartLine(time: 2, price: 2350000000000),
          //       ChartLine(time: 3, price: 2330000000000),
          //       ChartLine(time: 4, price: 2370000000000),
          //       ChartLine(time: 5, price: 2390000000000),
          //       ChartLine(time: 6, price: 2410000000000),
          //       ChartLine(time: 7, price: 2420000000000),
          //     ],
          //   ),
          // ),
          
          SizedBox(height: 100.h), // Added extra space at the bottom
        ],
      )), context: context,
    );
  }
  
  // Build custom crypto item widget with token data
  Widget _buildTokenCryptoItem({
    required Currency currency,
    required String price,
    required String change,
    required bool isPositive,
    required List<ChartLine> chartData,
  }) {
    return GlassContainer(
      opacity: 0.0,
      borderThickness: 1,
      height: AppTheme.cardPadding * 2.75,
      borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2.75 / 3),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: AppTheme.cardPadding * 1.75,
                      width: AppTheme.cardPadding * 1.75,
                      child: ClipOval(child: currency.icon),
                    ),
                    SizedBox(width: AppTheme.elementSpacing.w / 1.5),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currency.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$$price",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black60
                                    : AppTheme.white60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: AppTheme.elementSpacing.w / 2),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      plotAreaBorderWidth: 0,
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        edgeLabelPlacement: EdgeLabelPlacement.none,
                        isVisible: false,
                        majorGridLines: const MajorGridLines(width: 0),
                        majorTickLines: const MajorTickLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        plotOffset: 0,
                        edgeLabelPlacement: EdgeLabelPlacement.none,
                        isVisible: false,
                        majorGridLines: const MajorGridLines(width: 0),
                        majorTickLines: const MajorTickLines(width: 0),
                      ),
                      series: <ChartSeries>[
                        LineSeries<ChartLine, double>(
                          dataSource: chartData,
                          animationDuration: 0,
                          xValueMapper: (ChartLine crypto, _) => crypto.time,
                          yValueMapper: (ChartLine crypto, _) => crypto.price,
                          color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: AppTheme.elementSpacing.w / 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PercentageChangeWidget(
                      percentage: change,
                      isPositive: isPositive,
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate to BitcoinScreen with token data
                context.push(
                  '/wallet/bitcoinscreen',
                  extra: {
                    'isToken': true,
                    'tokenSymbol': currency.code,
                    'tokenName': currency.name,
                    'priceHistory': _getTokenPriceHistory(currency.code),
                    'currentPrice': double.parse(price.replaceAll(',', '')),
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}