import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/token_data_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
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
import 'package:visibility_detector/visibility_detector.dart';

class TokensTabOptimized extends StatefulWidget {
  const TokensTabOptimized({super.key});

  @override
  State<TokensTabOptimized> createState() => _TokensTabOptimizedState();
}

class _TokensTabOptimizedState extends State<TokensTabOptimized>
    with AutomaticKeepAliveClientMixin {
  // Cache data to prevent repeated calculations
  List<Map<String, dynamic>>? _cachedTokenData;
  List<Map<String, dynamic>>? _cachedTopMovers;
  List<Map<String, dynamic>>? _cachedTopVolume;
  
  // Track which carousel items should render charts
  final Map<int, bool> _visibleCharts = {};
  
  // Current carousel index for optimization
  int _currentCarouselIndex = 0;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  
  void _initializeData() {
    // Pre-calculate and cache data
    _cachedTokenData = _calculateTokenData();
    _cachedTopMovers = _calculateTopMovers();
    _cachedTopVolume = _calculateTopVolume();
    
    // Only render the first carousel item initially
    _visibleCharts[0] = true;
  }

  // Get price history for a token using centralized service
  Map<String, dynamic> _getTokenPriceHistory(String symbol) {
    return TokenDataService.instance.getTokenPriceHistory(symbol);
  }

  // Calculate token data once and cache it
  List<Map<String, dynamic>> _calculateTokenData() {
    final tokenService = TokenDataService.instance;
    return tokenService
        .getAllTokenSymbols()
        .map((symbol) => tokenService.getTokenDisplayData(symbol))
        .toList();
  }

  // Use cached token data
  List<Map<String, dynamic>> get tokenData {
    return _cachedTokenData ?? _calculateTokenData();
  }

  // Calculate top movers once and cache
  List<Map<String, dynamic>> _calculateTopMovers() {
    final sortedTokens = List<Map<String, dynamic>>.from(tokenData);
    sortedTokens.sort((a, b) {
      final aChange = double.parse(
          a['change'].toString().replaceAll('%', '').replaceAll('+', ''));
      final bChange = double.parse(
          b['change'].toString().replaceAll('%', '').replaceAll('+', ''));
      return bChange.compareTo(aChange);
    });
    return sortedTokens.take(3).toList();
  }

  // Use cached top movers
  List<Map<String, dynamic>> get topMoversData {
    return _cachedTopMovers ?? _calculateTopMovers();
  }

  // Calculate top volume once and cache
  List<Map<String, dynamic>> _calculateTopVolume() {
    final tokens = tokenData;
    return [
      tokens.firstWhere((token) => token['symbol'] == 'MINRL'),
      tokens.firstWhere((token) => token['symbol'] == 'GENST'),
      tokens.firstWhere((token) => token['symbol'] == 'CAT'),
    ];
  }

  // Use cached top volume
  List<Map<String, dynamic>> get topVolumeData {
    return _cachedTopVolume ?? _calculateTopVolume();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return bitnetScaffold(
      context: context,
      body: VerticalFadeListView.standardTab(
          child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          // Trending section
          SizedBox(height: AppTheme.cardPadding * 1.5.h),

          // Optimized Carousel Slider with lazy rendering
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 250.h,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCarouselIndex = index;
                  // Pre-render next and previous items
                  _visibleCharts[index] = true;
                  if (index > 0) _visibleCharts[index - 1] = true;
                  if (index < tokenData.length - 1) _visibleCharts[index + 1] = true;
                });
              },
            ),
            itemCount: tokenData.length,
            itemBuilder: (context, index, _) {
              final token = tokenData[index];
              
              // Use visibility detector for optimal rendering
              return VisibilityDetector(
                key: Key('carousel_$index'),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction > 0.1 && !_visibleCharts.containsKey(index)) {
                    setState(() {
                      _visibleCharts[index] = true;
                    });
                  }
                },
                child: _buildCarouselItem(context, token, index),
              );
            },
          ),

          SizedBox(height: AppTheme.cardPadding.h * 1.5),

          // Top 3 by Market Cap section with CommonHeading
          CommonHeading(
            headingText: "💰 Top 3 by Market Cap",
            hasButton: true,
            onPress: () => _navigateToTopMarketCapToken(),
          ),

          // Top 3 by Market Cap tokens
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: Column(
              children: tokenData.take(3).map((token) {
                return Padding(
                  key: ValueKey('marketcap_${token['symbol']}'), // Add key for better performance
                  padding: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
                  child: GestureDetector(
                    onTap: () => _navigateToTokenDetails(token),
                    child: CryptoItemWidget(
                      name: token['name'],
                      ticker: token['symbol'],
                      price: token['price'],
                      percentageChange: token['change'],
                      isPositive: token['isPositive'],
                      isNFT: true,
                      suffix: MarketCapWidget(marketCap: token['marketCap']),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h * 1.5),

          // Top Movers section
          CommonHeading(
            headingText: "🚀 Top Movers",
            hasButton: true,
            onPress: () => _navigateToTopMarketCapToken(),
          ),

          // Top movers list with proper keys
          Container(
            height: 110.h,
            child: ListView.separated(
              key: const PageStorageKey('top_movers_list'), // Add page storage key
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              itemCount: topMoversData.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: AppTheme.elementSpacing.w),
              itemBuilder: (context, index) {
                final mover = topMoversData[index];
                return _buildMoverItem(context, mover, index);
              },
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h * 1.5),

          // Top Volume section
          CommonHeading(
            headingText: "📊 Top Volume",
            hasButton: true,
            onPress: () => _navigateToTopMarketCapToken(),
          ),

          Container(
            height: 110.h,
            child: ListView.separated(
              key: const PageStorageKey('top_volume_list'), // Add page storage key
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              itemCount: topVolumeData.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: AppTheme.elementSpacing.w),
              itemBuilder: (context, index) {
                final volume = topVolumeData[index];
                return _buildVolumeItem(context, volume, index);
              },
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h * 2),
        ],
      )),
    );
  }

  // Optimized carousel item builder
  Widget _buildCarouselItem(BuildContext context, Map<String, dynamic> token, int index) {
    final chartData = token['chartData'] as List<ChartLine>;
    final shouldRenderChart = _visibleCharts[index] ?? false;
    
    return GestureDetector(
      onTap: () => _navigateToTokenDetails(token),
      child: RepaintBoundary( // Add RepaintBoundary for better performance
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(AppTheme.cardPadding.w),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: token['isPositive']
                  ? [Colors.green.shade800, Colors.green.shade600]
                  : [Colors.red.shade800, Colors.red.shade600],
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            boxShadow: [
              BoxShadow(
                color: (token['isPositive'] ? Colors.green : Colors.red)
                    .withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    token['name'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing.w,
                        vertical: AppTheme.elementSpacing.h * 0.5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      token['symbol'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              
              // Only render chart if visible
              if (shouldRenderChart) ...[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing.h),
                    child: SfCartesianChart(
                      margin: EdgeInsets.zero,
                      plotAreaBorderWidth: 0,
                      primaryXAxis: NumericAxis(isVisible: false),
                      primaryYAxis: NumericAxis(isVisible: false),
                      // Reduce animation duration for better performance
                      series: <ChartSeries>[
                        FastLineSeries<ChartLine, double>( // Use FastLineSeries for better performance
                          dataSource: chartData,
                          animationDuration: 500, // Reduced from 1500
                          xValueMapper: (ChartLine data, _) => data.time,
                          yValueMapper: (ChartLine data, _) => data.price,
                          color: Colors.white,
                          width: 2.5,
                        )
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Placeholder while chart loads
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.5),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ],

              Text(
                "${token['price']}\$",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppTheme.elementSpacing.h),
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
            ],
          ),
        ),
      ),
    );
  }

  // Build mover item with proper key
  Widget _buildMoverItem(BuildContext context, Map<String, dynamic> mover, int index) {
    return Stack(
      key: ValueKey('mover_${mover['symbol']}_$index'), // Unique key
      children: [
        RepaintBoundary( // Add RepaintBoundary
          child: GlassContainer(
            blur: 10,
            width: 260.w,
            customColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.06)
                : Colors.white.withOpacity(0.8),
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? []
                : [AppTheme.boxShadowSmall],
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mover['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppTheme.elementSpacing.h * 0.5),
                      Text(
                        mover['symbol'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mover['price'],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppTheme.elementSpacing.h * 0.5),
                    PercentageChangeWidget(
                      percentage: mover['change'],
                      isPositive: mover['isPositive'],
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          left: 8.w,
          child: NumberIndicator(number: index + 1),
        ),
      ],
    );
  }

  // Build volume item with proper key
  Widget _buildVolumeItem(BuildContext context, Map<String, dynamic> volume, int index) {
    return Stack(
      key: ValueKey('volume_${volume['symbol']}_$index'), // Unique key
      children: [
        RepaintBoundary( // Add RepaintBoundary
          child: GlassContainer(
            blur: 10,
            width: 260.w,
            customColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.06)
                : Colors.white.withOpacity(0.8),
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? []
                : [AppTheme.boxShadowSmall],
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        volume['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppTheme.elementSpacing.h * 0.5),
                      Text(
                        volume['symbol'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${volume['volume']}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppTheme.elementSpacing.h * 0.5),
                    Text(
                      '24h Volume',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          left: 8.w,
          child: NumberIndicator(number: index + 1),
        ),
      ],
    );
  }

  // Navigation methods
  void _navigateToTokenDetails(Map<String, dynamic> token) {
    final navigationData = {
      'tokenSymbol': token['symbol'],
      'tokenName': token['name'],
      'currentPrice': token['price'],
      'percentageChange': token['change'],
      'isPositive': token['isPositive'],
    };
    
    context.push('/bitcoin', extra: navigationData);
  }

  void _navigateToTopMarketCapToken() {
    // Navigate to token with highest market cap
    final topToken = tokenData.first;
    _navigateToTokenDetails(topToken);
  }
  
  @override
  void dispose() {
    // Clear caches
    _cachedTokenData = null;
    _cachedTopMovers = null;
    _cachedTopVolume = null;
    _visibleCharts.clear();
    super.dispose();
  }
}