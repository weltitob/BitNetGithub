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
import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:bitnet/pages/feed/widgets/fear_and_greed_widget.dart';
import 'package:bitnet/pages/feed/widgets/hashrate_widget.dart';

class TokensTab extends StatefulWidget {
  const TokensTab({super.key});

  @override
  State<TokensTab> createState() => _TokensTabState();
}

class _TokensTabState extends State<TokensTab> {
  // Sample token data
  final List<Map<String, dynamic>> tokenData = [
    {
      'name': 'Bitcoin',
      'symbol': 'BTC',
      'image': 'assets/images/bitcoin.png',
      'price': '48,224.65',
      'change': '+5.2%',
      'isPositive': true,
      'color': AppTheme.colorBitcoin,
      'chartData': [
        ChartLine(time: 0, price: 42000),
        ChartLine(time: 1, price: 42500),
        ChartLine(time: 2, price: 43100),
        ChartLine(time: 3, price: 43050),
        ChartLine(time: 4, price: 44500),
        ChartLine(time: 5, price: 45200),
        ChartLine(time: 6, price: 46100),
        ChartLine(time: 7, price: 45800),
        ChartLine(time: 8, price: 46750),
        ChartLine(time: 9, price: 48200),
      ]
    },
    {
      'name': 'Genesis Stone',
      'symbol': 'GENST',
      'image': 'assets/tokens/genisisstone.webp',
      'price': '0.000142',
      'change': '+3.7%',
      'isPositive': true,
      'color': Colors.blue,
      'chartData': [
        ChartLine(time: 0, price: 0.000120),
        ChartLine(time: 1, price: 0.000125),
        ChartLine(time: 2, price: 0.000130),
        ChartLine(time: 3, price: 0.000128),
        ChartLine(time: 4, price: 0.000133),
        ChartLine(time: 5, price: 0.000138),
        ChartLine(time: 6, price: 0.000135),
        ChartLine(time: 7, price: 0.000140),
        ChartLine(time: 8, price: 0.000142),
        ChartLine(time: 9, price: 0.000142),
      ]
    },
    {
      'name': 'Hotdog',
      'symbol': 'HTDG',
      'image': 'assets/tokens/hotdog.webp',
      'price': '0.000089',
      'change': '+2.1%',
      'isPositive': true,
      'color': Colors.red.shade400,
      'chartData': [
        ChartLine(time: 0, price: 0.000075),
        ChartLine(time: 1, price: 0.000078),
        ChartLine(time: 2, price: 0.000082),
        ChartLine(time: 3, price: 0.000080),
        ChartLine(time: 4, price: 0.000083),
        ChartLine(time: 5, price: 0.000086),
        ChartLine(time: 6, price: 0.000084),
        ChartLine(time: 7, price: 0.000087),
        ChartLine(time: 8, price: 0.000088),
        ChartLine(time: 9, price: 0.000089),
      ]
    },
  ];

  // Top movers data
  final List<Map<String, dynamic>> topMoversData = [
    {
      'name': 'Ordinals',
      'symbol': 'ORD',
      'image': 'assets/tokens/hotdog.webp',
      'change': '+15.8%',
      'isPositive': true,
    },
    {
      'name': 'Lumen',
      'symbol': 'LUM',
      'image': 'assets/tokens/genisisstone.webp',
      'change': '+12.3%',
      'isPositive': true,
    },
    {
      'name': 'Nebula',
      'symbol': 'NEB',
      'image': 'assets/images/bitcoin.png',
      'change': '+9.7%',
      'isPositive': true,
    },
  ];

  // Top volume data
  final List<Map<String, dynamic>> topVolumeData = [
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'image': 'assets/tokens/genisisstone.webp',
      'change': '+7.5%',
      'isPositive': true,
    },
    {
      'name': 'Lightning',
      'symbol': 'LN',
      'image': 'assets/images/lightning.png',
      'change': '+4.2%',
      'isPositive': true,
    },
    {
      'name': 'SolDot',
      'symbol': 'SDT',
      'image': 'assets/tokens/hotdog.webp',
      'change': '-2.8%',
      'isPositive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  // Navigate to Bitcoin screen when clicking on tokens
                  // Use push to maintain navigation history
                  if (token['symbol'] == 'BTC') {
                    context.push('/wallet/bitcoinscreen');
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
                            child: Container(
                              height: 38.h, // Increased from 34.h
                              width: 38.w, // Increased from 34.w
                              padding: const EdgeInsets.all(2),
                              child: Image.asset(token['image']),
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
                              // Line series - now using successColor for all cases
                              AreaSeries<ChartLine, double>(
                                dataSource: chartData,
                                animationDuration: 1500,
                                xValueMapper: (ChartLine data, _) => data.time,
                                yValueMapper: (ChartLine data, _) => data.price,
                                color: AppTheme.successColor.withOpacity(0.3),
                                borderWidth: 2.5,
                                borderColor: AppTheme.successColor,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppTheme.successColor.withOpacity(0.3),
                                    AppTheme.successColor.withOpacity(0.05),
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
              );
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
                    // First crypto item with NumberIndicator
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/wallet/bitcoinscreen'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: 'Hotdog',
                              name: 'Hotdog',
                              icon: Image.asset("./assets/tokens/hotdog.webp"),
                            ),
                            context: context,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 1),
                        ),
                      ],
                    ),
                    // Second crypto item with NumberIndicator
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/wallet/bitcoinscreen'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: 'GENST',
                              name: 'Genisis Stone',
                              icon: Image.asset("./assets/tokens/genisisstone.webp"),
                            ),
                            context: context,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: NumberIndicator(number: 2),
                        ),
                      ],
                    ),
                    // Third crypto item with NumberIndicator
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push('/wallet/bitcoinscreen'),
                          child: CryptoItem(
                            hasGlassContainer: false,
                            currency: Currency(
                              code: 'HTDG',
                              name: 'Hotdog',
                              icon: Image.asset("./assets/tokens/hotdog.webp"),
                            ),
                            context: context,
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
}