import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
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
              viewportFraction: 0.70, // Increased from 0.6 to 0.7 to make items larger
              enlargeCenterPage: true,
              height: 250.h, // Increased from 225.h
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800)
            ),
            itemCount: tokenData.length,
            itemBuilder: (context, index, _) {
              final token = tokenData[index];
              final chartData = token['chartData'] as List<ChartLine>;
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GlassContainer(
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
                        
                        // Price change indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              token['isPositive'] 
                                  ? Icons.arrow_upward 
                                  : Icons.arrow_downward,
                              color: token['isPositive'] ? AppTheme.successColor : AppTheme.errorColor,
                              size: 18, // Increased from 16
                            ),
                            SizedBox(width: 6.w), // Increased from 5.w
                            Text(
                              token['change'],
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp, // Added specific font size
                                color: token['isPositive'] ? AppTheme.successColor : AppTheme.errorColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: AppTheme.cardPadding.h * 1.5),
          
          // Top 3 by Market Cap section with arrow button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top 3 by Market Cap',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                GlassContainer(
                  customShadow: isDarkMode ? [] : null,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
                  child: InkWell(
                    onTap: () {
                      // Handle navigation
                    },
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: isDarkMode ? AppTheme.white70 : AppTheme.black70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          
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
          
          // Top Movers Today section with arrow button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Movers Today',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                GlassContainer(
                  customShadow: isDarkMode ? [] : null,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
                  child: InkWell(
                    onTap: () {
                      // Handle navigation
                    },
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: isDarkMode ? AppTheme.white70 : AppTheme.black70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          
          // Top Movers list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topMoversData.map((mover) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing,
                        vertical: AppTheme.elementSpacing * 0.5,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.successColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                              ]
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(mover['image']),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${mover['symbol']}',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  mover['name'],
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.successColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                            ),
                            child: Text(
                              mover['change'],
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Total Market Cap Today section - redesigned
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              'Total Market Cap Today',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.sp, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          // Redesigned Total Market Cap widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.all(AppTheme.cardPadding * 0.75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with value and percentage
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Market cap value
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$2.42T',
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Global crypto market cap',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Percentage change badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: AppTheme.successColor,
                                size: 18,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '5.24%',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Chart
                    SizedBox(
                      height: 100.h,
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
                          // Line series
                          AreaSeries<ChartLine, double>(
                            dataSource: [
                              ChartLine(time: 0, price: 42000),
                              ChartLine(time: 1, price: 42800),
                              ChartLine(time: 2, price: 43500),
                              ChartLine(time: 3, price: 43200),
                              ChartLine(time: 4, price: 45000),
                              ChartLine(time: 5, price: 44800),
                              ChartLine(time: 6, price: 46500),
                              ChartLine(time: 7, price: 47200),
                              ChartLine(time: 8, price: 46800),
                              ChartLine(time: 9, price: 48200),
                            ],
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
                    
                    SizedBox(height: 20.h),
                    
                    // Additional stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 24h Volume
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '24h Volume',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '\$98.2B',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // BTC Dominance
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BTC Dominance',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '52.3%',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // ETH Dominance
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ETH Dominance',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '18.7%',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h),
        ],
      ),
      context: context,
    );
  }
}