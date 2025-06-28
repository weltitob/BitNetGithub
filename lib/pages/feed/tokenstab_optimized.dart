import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/token_data_service.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
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

          // Carousel Slider for Trending Tokens
          CarouselSlider.builder(
            options: getStandardizedCarouselOptions(autoPlayIntervalSeconds: 4),
            itemCount: tokenData.length,
            itemBuilder: (context, index, _) {
              final token = tokenData[index];
              final chartData = token['chartData'] as List<ChartLine>;
              
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
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Bitcoin screen with token chart data
                    final navigationData = {
                      'isToken': true,
                      'tokenSymbol': token['symbol'],
                      'tokenName': token['name'],
                      'priceHistory': _getTokenPriceHistory(token['symbol']),
                      'currentPrice':
                          double.parse(token['price'].replaceAll(',', '')),
                    };

                    context.push(
                      '/wallet/bitcoinscreen',
                      extra: navigationData,
                    );
                  },
                  child: RepaintBoundary(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getStandardizedCardMargin().w),
                      child: GlassContainer(
                        width: getStandardizedCardWidth().w,
                        boxShadow: isDarkMode ? [] : null,
                        child: _buildCarouselContent(context, token, chartData, isDarkMode),
                      ),
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
            onPress: () => _navigateToTopMarketCapToken(),
          ),

          // A single GlassContainer containing all crypto items
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              boxShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: [
                    // First crypto item with NumberIndicator - using tokenData[0] (Genesis Stone)
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.push(
                              '/feed/token_marketplace/GENST/Genesis Stone'),
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
                          onTap: () => context
                              .push('/feed/token_marketplace/CAT/Cat Token'),
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
                          onTap: () => context
                              .push('/feed/token_marketplace/HTDG/Hotdog'),
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
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              boxShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topMoversData.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final mover = entry.value;
                    return Stack(
                      key: ValueKey('mover_${mover['symbol']}_$idx'), // Add key for performance
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
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              boxShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topVolumeData.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final volume = entry.value;
                    return Stack(
                      key: ValueKey('volume_${volume['symbol']}_$idx'), // Add key for performance
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

  // Build carousel content with original UI
  Widget _buildCarouselContent(BuildContext context, Map<String, dynamic> token, List<ChartLine> chartData, bool isDarkMode) {
    final shouldRenderChart = _visibleCharts[tokenData.indexOf(token)] ?? false;
    
    return Padding(
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
                        color:
                            token['color'].withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      )
                    ]),
                child: ClipOval(
                  child: Image.asset(
                    token['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                  width: AppTheme.elementSpacing.w *
                      0.75), // Increased from 10.w
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    token['symbol'],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              18.sp, // Increased font size
                        ),
                  ),
                  Text(
                    token['name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(
                          color: isDarkMode
                              ? AppTheme.white60
                              : AppTheme.black60,
                          fontSize: 12
                              .sp, // Added specific font size
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
              child: shouldRenderChart ? SfCartesianChart(
                plotAreaBorderWidth: 0,
                margin: EdgeInsets.zero,
                primaryXAxis: CategoryAxis(
                  isVisible: false,
                  majorGridLines:
                      const MajorGridLines(width: 0),
                  majorTickLines:
                      const MajorTickLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: false,
                  majorGridLines:
                      const MajorGridLines(width: 0),
                  majorTickLines:
                      const MajorTickLines(width: 0),
                ),
                series: <ChartSeries>[
                  // Line series - using correct color based on token performance
                  AreaSeries<ChartLine, double>(
                    dataSource: chartData,
                    animationDuration: 500, // Reduced for performance
                    xValueMapper: (ChartLine data, _) =>
                        data.time,
                    yValueMapper: (ChartLine data, _) =>
                        data.price,
                    color: token['isPositive']
                        ? AppTheme.successColor
                            .withOpacity(0.3)
                        : AppTheme.errorColor
                            .withOpacity(0.3),
                    borderWidth: 2.5,
                    borderColor: token['isPositive']
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: token['isPositive']
                          ? [
                              AppTheme.successColor
                                  .withOpacity(0.3),
                              AppTheme.successColor
                                  .withOpacity(0.05),
                              Colors.transparent,
                            ]
                          : [
                              AppTheme.errorColor
                                  .withOpacity(0.3),
                              AppTheme.errorColor
                                  .withOpacity(0.05),
                              Colors.transparent,
                            ],
                    ),
                  )
                ],
              ) : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  strokeWidth: 2,
                ),
              ),
            ),
          ),

          SizedBox(
              height: AppTheme.elementSpacing.h *
                  0.5), // Increased from 8.h

          // Price - using actual token price
          Text("${token['price']}\$",
              style:
                  Theme.of(context).textTheme.headlineLarge),
          SizedBox(
              height: AppTheme
                  .elementSpacing.h), // Increased from 4.h
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
    );
  }

  // Navigation methods for top section buttons
  void _navigateToTopMarketCapToken() {
    // Navigate to the top market cap token (first in tokenData)
    final topToken = tokenData[0];
    context.push(
        '/feed/token_marketplace/${topToken['symbol']}/${topToken['name']}');
  }

  void _navigateToTopMover() {
    // Navigate to the top mover token (first in topMoversData)
    final topMover = topMoversData[0];
    context.push(
        '/feed/token_marketplace/${topMover['symbol']}/${topMover['name']}');
  }

  void _navigateToTopVolume() {
    // Navigate to the top volume token (first in topVolumeData)
    final topVolume = topVolumeData[0];
    context.push(
        '/feed/token_marketplace/${topVolume['symbol']}/${topVolume['name']}');
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