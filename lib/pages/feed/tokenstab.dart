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
    Duration timeRange,
  ) {
    List<Map<String, dynamic>> history = [];
    final now = DateTime.now();
    final timeStep = timeRange.inMilliseconds / dataPoints;

    for (int i = 0; i < dataPoints; i++) {
      final time = now.subtract(Duration(milliseconds: (timeStep * (dataPoints - 1 - i)).toInt()));
      
      // Generate realistic price variations
      final variation = (i / dataPoints - 0.5) * 0.1; // +/- 5% variation
      final randomFactor = (DateTime.now().millisecondsSinceEpoch % 100) / 1000; // Small random component
      final price = currentPrice * (1 + variation + randomFactor);
      
      history.add({
        'time': time.millisecondsSinceEpoch.toDouble(),
        'price': price,
      });
    }
    
    return history;
  }
  
  // Sample token data with realistic chart patterns - using only available token images
  final List<Map<String, dynamic>> tokenData = [
    {
      'name': 'Genesis Stone',
      'symbol': 'GENST',
      'image': 'assets/tokens/genisisstone.webp',
      'price': '0.000142',
      'change': '+3.7%',
      'isPositive': true,
      'color': Colors.blue,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000120),
        ChartLine(time: 1.0, price: 0.000125),
        ChartLine(time: 2.0, price: 0.000130),
        ChartLine(time: 3.0, price: 0.000128),
        ChartLine(time: 4.0, price: 0.000133),
        ChartLine(time: 5.0, price: 0.000138),
        ChartLine(time: 6.0, price: 0.000135),
        ChartLine(time: 7.0, price: 0.000140),
        ChartLine(time: 8.0, price: 0.000141),
        ChartLine(time: 9.0, price: 0.000142),
      ]
    },
    {
      'name': 'Cat Token',
      'symbol': 'CAT',
      'image': 'assets/tokens/cat.webp',
      'price': '0.000067',
      'change': '-2.8%',
      'isPositive': false,
      'color': Colors.red.shade400,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000075),
        ChartLine(time: 1.0, price: 0.000073),
        ChartLine(time: 2.0, price: 0.000071),
        ChartLine(time: 3.0, price: 0.000072),
        ChartLine(time: 4.0, price: 0.000070),
        ChartLine(time: 5.0, price: 0.000068),
        ChartLine(time: 6.0, price: 0.000069),
        ChartLine(time: 7.0, price: 0.000067),
        ChartLine(time: 8.0, price: 0.000066),
        ChartLine(time: 9.0, price: 0.000067),
      ]
    },
    {
      'name': 'Hotdog',
      'symbol': 'HTDG',
      'image': 'assets/tokens/hotdog.webp',
      'price': '0.000089',
      'change': '+2.1%',
      'isPositive': true,
      'color': Colors.orange.shade400,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000082),
        ChartLine(time: 1.0, price: 0.000083),
        ChartLine(time: 2.0, price: 0.000085),
        ChartLine(time: 3.0, price: 0.000084),
        ChartLine(time: 4.0, price: 0.000086),
        ChartLine(time: 5.0, price: 0.000087),
        ChartLine(time: 6.0, price: 0.000088),
        ChartLine(time: 7.0, price: 0.000087),
        ChartLine(time: 8.0, price: 0.000088),
        ChartLine(time: 9.0, price: 0.000089),
      ]
    },
    {
      'name': 'Emerald',
      'symbol': 'EMRLD',
      'image': 'assets/tokens/emerald.webp',
      'price': '0.000156',
      'change': '+7.9%',
      'isPositive': true,
      'color': Colors.green.shade400,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000135),
        ChartLine(time: 1.0, price: 0.000140),
        ChartLine(time: 2.0, price: 0.000145),
        ChartLine(time: 3.0, price: 0.000143),
        ChartLine(time: 4.0, price: 0.000148),
        ChartLine(time: 5.0, price: 0.000151),
        ChartLine(time: 6.0, price: 0.000153),
        ChartLine(time: 7.0, price: 0.000154),
        ChartLine(time: 8.0, price: 0.000155),
        ChartLine(time: 9.0, price: 0.000156),
      ]
    },
    {
      'name': 'Lila Token',
      'symbol': 'LILA',
      'image': 'assets/tokens/lila.webp',
      'price': '0.000234',
      'change': '+4.5%',
      'isPositive': true,
      'color': Colors.purple.shade400,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000210),
        ChartLine(time: 1.0, price: 0.000215),
        ChartLine(time: 2.0, price: 0.000220),
        ChartLine(time: 3.0, price: 0.000218),
        ChartLine(time: 4.0, price: 0.000225),
        ChartLine(time: 5.0, price: 0.000228),
        ChartLine(time: 6.0, price: 0.000230),
        ChartLine(time: 7.0, price: 0.000232),
        ChartLine(time: 8.0, price: 0.000233),
        ChartLine(time: 9.0, price: 0.000234),
      ]
    },
    {
      'name': 'Mineral',
      'symbol': 'MINRL',
      'image': 'assets/tokens/mineral.webp',
      'price': '0.000567',
      'change': '-1.2%',
      'isPositive': false,
      'color': Colors.brown.shade400,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000590),
        ChartLine(time: 1.0, price: 0.000585),
        ChartLine(time: 2.0, price: 0.000580),
        ChartLine(time: 3.0, price: 0.000575),
        ChartLine(time: 4.0, price: 0.000570),
        ChartLine(time: 5.0, price: 0.000568),
        ChartLine(time: 6.0, price: 0.000569),
        ChartLine(time: 7.0, price: 0.000567),
        ChartLine(time: 8.0, price: 0.000566),
        ChartLine(time: 9.0, price: 0.000567),
      ]
    },
    {
      'name': 'Token Blue',
      'symbol': 'TBLUE',
      'image': 'assets/tokens/token_blue.webp',
      'price': '0.000079',
      'change': '+6.3%',
      'isPositive': true,
      'color': Colors.blue.shade600,
      'chartData': [
        ChartLine(time: 0.0, price: 0.000068),
        ChartLine(time: 1.0, price: 0.000070),
        ChartLine(time: 2.0, price: 0.000072),
        ChartLine(time: 3.0, price: 0.000074),
        ChartLine(time: 4.0, price: 0.000075),
        ChartLine(time: 5.0, price: 0.000076),
        ChartLine(time: 6.0, price: 0.000077),
        ChartLine(time: 7.0, price: 0.000078),
        ChartLine(time: 8.0, price: 0.000078),
        ChartLine(time: 9.0, price: 0.000079),
      ]
    },
  ];

  // Top movers data - using available token images
  final List<Map<String, dynamic>> topMoversData = [
    {
      'name': 'Emerald',
      'symbol': 'EMRLD',
      'image': 'assets/tokens/emerald.webp',
      'change': '+7.9%',
      'isPositive': true,
      'price': '0.000156',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000135),
        ChartLine(time: 1.0, price: 0.000140),
        ChartLine(time: 2.0, price: 0.000145),
        ChartLine(time: 3.0, price: 0.000143),
        ChartLine(time: 4.0, price: 0.000148),
        ChartLine(time: 5.0, price: 0.000151),
        ChartLine(time: 6.0, price: 0.000153),
        ChartLine(time: 7.0, price: 0.000154),
        ChartLine(time: 8.0, price: 0.000155),
        ChartLine(time: 9.0, price: 0.000156),
      ]
    },
    {
      'name': 'Token Blue',
      'symbol': 'TBLUE',
      'image': 'assets/tokens/token_blue.webp',
      'change': '+6.3%',
      'isPositive': true,
      'price': '0.000079',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000068),
        ChartLine(time: 1.0, price: 0.000070),
        ChartLine(time: 2.0, price: 0.000072),
        ChartLine(time: 3.0, price: 0.000074),
        ChartLine(time: 4.0, price: 0.000075),
        ChartLine(time: 5.0, price: 0.000076),
        ChartLine(time: 6.0, price: 0.000077),
        ChartLine(time: 7.0, price: 0.000078),
        ChartLine(time: 8.0, price: 0.000078),
        ChartLine(time: 9.0, price: 0.000079),
      ]
    },
    {
      'name': 'Lila Token',
      'symbol': 'LILA',
      'image': 'assets/tokens/lila.webp',
      'change': '+4.5%',
      'isPositive': true,
      'price': '0.000234',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000210),
        ChartLine(time: 1.0, price: 0.000215),
        ChartLine(time: 2.0, price: 0.000220),
        ChartLine(time: 3.0, price: 0.000218),
        ChartLine(time: 4.0, price: 0.000225),
        ChartLine(time: 5.0, price: 0.000228),
        ChartLine(time: 6.0, price: 0.000230),
        ChartLine(time: 7.0, price: 0.000232),
        ChartLine(time: 8.0, price: 0.000233),
        ChartLine(time: 9.0, price: 0.000234),
      ]
    },
  ];

  // Top volume data - using available token images
  final List<Map<String, dynamic>> topVolumeData = [
    {
      'name': 'Mineral',
      'symbol': 'MINRL',
      'image': 'assets/tokens/mineral.webp',
      'change': '-1.2%',
      'isPositive': false,
      'price': '0.000567',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000590),
        ChartLine(time: 1.0, price: 0.000585),
        ChartLine(time: 2.0, price: 0.000580),
        ChartLine(time: 3.0, price: 0.000575),
        ChartLine(time: 4.0, price: 0.000570),
        ChartLine(time: 5.0, price: 0.000568),
        ChartLine(time: 6.0, price: 0.000569),
        ChartLine(time: 7.0, price: 0.000567),
        ChartLine(time: 8.0, price: 0.000566),
        ChartLine(time: 9.0, price: 0.000567),
      ]
    },
    {
      'name': 'Genesis Stone',
      'symbol': 'GENST',
      'image': 'assets/tokens/genisisstone.webp',
      'change': '+3.7%',
      'isPositive': true,
      'price': '0.000142',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000120),
        ChartLine(time: 1.0, price: 0.000125),
        ChartLine(time: 2.0, price: 0.000130),
        ChartLine(time: 3.0, price: 0.000128),
        ChartLine(time: 4.0, price: 0.000133),
        ChartLine(time: 5.0, price: 0.000138),
        ChartLine(time: 6.0, price: 0.000135),
        ChartLine(time: 7.0, price: 0.000140),
        ChartLine(time: 8.0, price: 0.000141),
        ChartLine(time: 9.0, price: 0.000142),
      ]
    },
    {
      'name': 'Cat Token',
      'symbol': 'CAT',
      'image': 'assets/tokens/cat.webp',
      'change': '-2.8%',
      'isPositive': false,
      'price': '0.000067',
      'chartData': [
        ChartLine(time: 0.0, price: 0.000075),
        ChartLine(time: 1.0, price: 0.000073),
        ChartLine(time: 2.0, price: 0.000071),
        ChartLine(time: 3.0, price: 0.000072),
        ChartLine(time: 4.0, price: 0.000070),
        ChartLine(time: 5.0, price: 0.000068),
        ChartLine(time: 6.0, price: 0.000069),
        ChartLine(time: 7.0, price: 0.000067),
        ChartLine(time: 8.0, price: 0.000066),
        ChartLine(time: 9.0, price: 0.000067),
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return bitnetScaffold(
      context: context,
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
                  // Navigate to token marketplace for all tokens
                  context.push('/feed/token_marketplace/${token['symbol']}/${token['name']}');
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: token['color'].withOpacity(0.3),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
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
                      
                      // Price - using actual token price
                      Text(
                        "${token['price']}\$",
                        style: Theme.of(context).textTheme.headlineLarge
                      ),
                      SizedBox(height: AppTheme.elementSpacing.h), // Increased from 4.h
                      Row(
                        children: [
                          ColoredPriceWidget(
                            price: token['price'],
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
            onPress: () => _navigateToTopMarketCapToken(),
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
                    // First crypto item with NumberIndicator - using tokenData[0] (Genesis Stone)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/feed/token_marketplace/GENST/Genesis Stone'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: tokenData[0]['symbol'],
                              name: tokenData[0]['name'],
                              icon: Image.asset(tokenData[0]['image']),
                            ),
                            context: context,
                            tokenChartData: tokenData[0]['chartData'],
                            tokenPrice: tokenData[0]['price'],
                            tokenPriceChange: tokenData[0]['change'],
                            tokenIsPositive: tokenData[0]['isPositive'],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 1),
                        ),
                      ],
                    ),
                    // Second crypto item with NumberIndicator - using tokenData[1] (Cat Token)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/feed/token_marketplace/CAT/Cat Token'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: tokenData[1]['symbol'],
                              name: tokenData[1]['name'],
                              icon: Image.asset(tokenData[1]['image']),
                            ),
                            context: context,
                            tokenChartData: tokenData[1]['chartData'],
                            tokenPrice: tokenData[1]['price'],
                            tokenPriceChange: tokenData[1]['change'],
                            tokenIsPositive: tokenData[1]['isPositive'],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 2),
                        ),
                      ],
                    ),
                    // Third crypto item with NumberIndicator - using tokenData[2] (Hotdog)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/feed/token_marketplace/HTDG/Hotdog'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: tokenData[2]['symbol'],
                              name: tokenData[2]['name'],
                              icon: Image.asset(tokenData[2]['image']),
                            ),
                            context: context,
                            tokenChartData: tokenData[2]['chartData'],
                            tokenPrice: tokenData[2]['price'],
                            tokenPriceChange: tokenData[2]['change'],
                            tokenIsPositive: tokenData[2]['isPositive'],
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
            onPress: () => _navigateToTopMover(),
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
                    return Stack(
                      children: [
                        CryptoItem(
                          hasGlassContainer: false,
                          currency: Currency(
                            code: mover['symbol'],
                            name: mover['name'],
                            icon: Image.asset(mover['image']),
                          ),
                          context: context,
                          tokenChartData: mover['chartData'],
                          tokenPrice: mover['price'],
                          tokenPriceChange: mover['change'],
                          tokenIsPositive: mover['isPositive'],
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
            onPress: () => _navigateToTopVolume(),
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
                    return Stack(
                      children: [
                        CryptoItem(
                          hasGlassContainer: false,
                          currency: Currency(
                            code: volume['symbol'],
                            name: volume['name'],
                            icon: Image.asset(volume['image']),
                          ),
                          context: context,
                          tokenChartData: volume['chartData'],
                          tokenPrice: volume['price'],
                          tokenPriceChange: volume['change'],
                          tokenIsPositive: volume['isPositive'],
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
          
          SizedBox(height: 100.h), // Added extra space at the bottom
        ],
      )),
    );
  }

  // Navigation methods for top section buttons
  void _navigateToTopMarketCapToken() {
    // Navigate to the top market cap token (first in tokenData)
    final topToken = tokenData[0];
    context.push('/feed/token_marketplace/${topToken['symbol']}/${topToken['name']}');
  }

  void _navigateToTopMover() {
    // Navigate to the top mover token (first in topMoversData)
    final topMover = topMoversData[0];
    context.push('/feed/token_marketplace/${topMover['symbol']}/${topMover['name']}');
  }

  void _navigateToTopVolume() {
    // Navigate to the top volume token (first in topVolumeData)
    final topVolume = topVolumeData[0];
    context.push('/feed/token_marketplace/${topVolume['symbol']}/${topVolume['name']}');
  }
}