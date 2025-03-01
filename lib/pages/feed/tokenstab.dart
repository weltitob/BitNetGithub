import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/items/marketcap_widget.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

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
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          
          // Trending section

          const SizedBox(height: AppTheme.cardPadding),
          
          // Carousel Slider for Trending Tokens
          CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: kDebugMode ? false : true,
              viewportFraction: 0.6, // Changed to match people tab
              enlargeCenterPage: true,
              enlargeFactor: 0.3, // Added to match people tab spacing
              height: 250.h, // Increased from 225.h
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800)
            ),
            itemCount: tokenData.length,
            itemBuilder: (context, index, _) {
              final token = tokenData[index];
              final chartData = token['chartData'] as List<ChartLine>;
              
              return GlassContainer(
                width: size.width - 150.w, // Increased from 200.w
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
                          SizedBox(width: 12.w), // Increased from 10.w
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
                      
                      SizedBox(height: 10.h), // Increased from 8.h
                      
                      // Price 
                      Text(
                        token['price'],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp, // Increased from 20.sp
                        ),
                      ),
                      
                      SizedBox(height: 6.h), // Increased from 4.h
                      
                      // Price change indicator (using reusable component)
                      PercentageChangeWidget(
                        percentage: token['change'],
                        isPositive: token['isPositive'],
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: AppTheme.cardPadding.h * 1.5),
          
          // Top 3 by Market Cap section with CommonHeading
          CommonHeading(
            headingText: 'Top 3 by Market Cap',
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
                    // First crypto item
                    CryptoItem(
                      hasGlassContainer: false,
                      currency: Currency(
                        code: 'Hotdog',
                        name: 'Hotdog',
                        icon: Image.asset("./assets/tokens/hotdog.webp"),
                      ),
                      context: context,
                    ),

                    // Second crypto item
                    CryptoItem(
                      hasGlassContainer: false,
                      currency: Currency(
                        code: 'GENST',
                        name: 'Genisis Stone',
                        icon: Image.asset("./assets/tokens/genisisstone.webp"),
                      ),
                      context: context,
                    ),

                    // Third crypto item
                    CryptoItem(
                      hasGlassContainer: false,
                      currency: Currency(
                        code: 'HTDG',
                        name: 'Hotdog',
                        icon: Image.asset("./assets/tokens/hotdog.webp"),
                      ),
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Top Movers Today section with CommonHeading
          CommonHeading(
            headingText: 'Top Movers Today',
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
                  children: topMoversData.map((mover) {
                    // Use the CryptoItem widget for top movers
                    return CryptoItem(
                      hasGlassContainer: false,
                      currency: Currency(
                        code: mover['symbol'],
                        name: mover['name'],
                        icon: Image.asset(mover['image']),
                      ),
                      context: context,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Top Volume Today section with CommonHeading (Added section)
          CommonHeading(
            headingText: 'Top Volume Today',
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
                  children: topVolumeData.map((volume) {
                    // Use the CryptoItem widget for top volume
                    return CryptoItem(
                      hasGlassContainer: false,
                      currency: Currency(
                        code: volume['symbol'],
                        name: volume['name'],
                        icon: Image.asset(volume['image']),
                      ),
                      context: context,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Total Market Cap Today section with CommonHeading (commented out)
          // CommonHeading(
          //   headingText: 'Total Market Cap Today',
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
      ), context: context,
    );
  }
}