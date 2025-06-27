import 'package:flutter/material.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';

class TokenDataService {
  static TokenDataService? _instance;
  static TokenDataService get instance => _instance ??= TokenDataService._();
  TokenDataService._();

  /// Enhanced price data generator with realistic market patterns
  static List<Map<String, dynamic>> _generateRealisticPriceData(
    double currentPrice,
    int dataPoints,
    Duration timeRange,
    double volatility,
    int seed,
  ) {
    List<Map<String, dynamic>> history = [];
    final now = DateTime.now();
    final timeStep = timeRange.inMilliseconds / dataPoints;

    // Create starting price based on timeframe (longer periods show more growth)
    double startMultiplier = 1.0;
    switch (timeRange.inDays) {
      case 1:
        startMultiplier = 0.98;
        break; // 1D: slight variation
      case 7:
        startMultiplier = 0.92;
        break; // 1W: 8% growth
      case 30:
        startMultiplier = 0.75;
        break; // 1M: 33% growth
      case 365:
        startMultiplier = 0.35;
        break; // 1Y: 185% growth
      default:
        startMultiplier = 0.15;
        break; // Max: 567% growth
    }

    double price = currentPrice * startMultiplier;
    int localSeed = seed * 1000 + timeRange.inDays;

    for (int i = 0; i < dataPoints; i++) {
      final time = now.subtract(
          Duration(milliseconds: (timeStep * (dataPoints - 1 - i)).toInt()));

      // Progress through timeframe (0 to 1)
      final progress = i / (dataPoints - 1);

      // Generate pseudo-random number
      localSeed = (localSeed * 1103515245 + 12345) % (1 << 31);
      final random = (localSeed % 10000) / 10000.0;

      // Market-like volatility pattern
      final dailyChange = (random - 0.5) * volatility * 2;

      // Add trend towards current price
      final trendFactor = 0.002 * progress; // Gradual trend
      final targetPrice =
          currentPrice * (startMultiplier + (1 - startMultiplier) * progress);
      final trendAdjustment = (targetPrice - price) * trendFactor;

      // Apply changes
      price = price * (1 + dailyChange) + trendAdjustment;

      // Add realistic market events (pumps, dumps, consolidation)
      if (random > 0.98) {
        // 2% chance of pump
        price *= 1 + (volatility * 3);
      } else if (random < 0.02) {
        // 2% chance of dump
        price *= 1 - (volatility * 2);
      }

      // Ensure we end at current price for the last point
      if (i == dataPoints - 1) {
        price = currentPrice;
      }

      // Ensure price stays positive
      price = price.abs();

      history.add({
        'time': time.millisecondsSinceEpoch.toDouble(),
        'price': price,
      });
    }

    return history;
  }

  /// Comprehensive price history for all tokens across all timeframes
  static final Map<String, Map<String, List<Map<String, dynamic>>>>
      _tokenPriceHistory = {
    'GENST': {
      '1D': _generateRealisticPriceData(
          0.000142, 288, Duration(days: 1), 0.02, 1),
      '1W': _generateRealisticPriceData(
          0.000142, 168, Duration(days: 7), 0.05, 2),
      '1M': _generateRealisticPriceData(
          0.000142, 120, Duration(days: 30), 0.08, 3),
      '1Y': _generateRealisticPriceData(
          0.000142, 365, Duration(days: 365), 0.15, 4),
      'Max': _generateRealisticPriceData(
          0.000142, 730, Duration(days: 730), 0.25, 5),
    },
    'CAT': {
      '1D': _generateRealisticPriceData(
          0.000067, 288, Duration(days: 1), 0.025, 6),
      '1W': _generateRealisticPriceData(
          0.000067, 168, Duration(days: 7), 0.06, 7),
      '1M': _generateRealisticPriceData(
          0.000067, 120, Duration(days: 30), 0.09, 8),
      '1Y': _generateRealisticPriceData(
          0.000067, 365, Duration(days: 365), 0.18, 9),
      'Max': _generateRealisticPriceData(
          0.000067, 730, Duration(days: 730), 0.28, 10),
    },
    'HTDG': {
      '1D': _generateRealisticPriceData(
          0.000089, 288, Duration(days: 1), 0.03, 11),
      '1W': _generateRealisticPriceData(
          0.000089, 168, Duration(days: 7), 0.07, 12),
      '1M': _generateRealisticPriceData(
          0.000089, 120, Duration(days: 30), 0.10, 13),
      '1Y': _generateRealisticPriceData(
          0.000089, 365, Duration(days: 365), 0.20, 14),
      'Max': _generateRealisticPriceData(
          0.000089, 730, Duration(days: 730), 0.30, 15),
    },
    'EMRLD': {
      '1D': _generateRealisticPriceData(
          0.000156, 288, Duration(days: 1), 0.02, 16),
      '1W': _generateRealisticPriceData(
          0.000156, 168, Duration(days: 7), 0.05, 17),
      '1M': _generateRealisticPriceData(
          0.000156, 120, Duration(days: 30), 0.08, 18),
      '1Y': _generateRealisticPriceData(
          0.000156, 365, Duration(days: 365), 0.16, 19),
      'Max': _generateRealisticPriceData(
          0.000156, 730, Duration(days: 730), 0.26, 20),
    },
    'LILA': {
      '1D': _generateRealisticPriceData(
          0.000234, 288, Duration(days: 1), 0.025, 21),
      '1W': _generateRealisticPriceData(
          0.000234, 168, Duration(days: 7), 0.06, 22),
      '1M': _generateRealisticPriceData(
          0.000234, 120, Duration(days: 30), 0.09, 23),
      '1Y': _generateRealisticPriceData(
          0.000234, 365, Duration(days: 365), 0.17, 24),
      'Max': _generateRealisticPriceData(
          0.000234, 730, Duration(days: 730), 0.27, 25),
    },
    'MINRL': {
      '1D': _generateRealisticPriceData(
          0.000567, 288, Duration(days: 1), 0.04, 26),
      '1W': _generateRealisticPriceData(
          0.000567, 168, Duration(days: 7), 0.08, 27),
      '1M': _generateRealisticPriceData(
          0.000567, 120, Duration(days: 30), 0.12, 28),
      '1Y': _generateRealisticPriceData(
          0.000567, 365, Duration(days: 365), 0.22, 29),
      'Max': _generateRealisticPriceData(
          0.000567, 730, Duration(days: 730), 0.32, 30),
    },
    'TBLUE': {
      '1D': _generateRealisticPriceData(
          0.000714, 288, Duration(days: 1), 0.03, 31),
      '1W': _generateRealisticPriceData(
          0.000714, 168, Duration(days: 7), 0.07, 32),
      '1M': _generateRealisticPriceData(
          0.000714, 120, Duration(days: 30), 0.10, 33),
      '1Y': _generateRealisticPriceData(
          0.000714, 365, Duration(days: 365), 0.19, 34),
      'Max': _generateRealisticPriceData(
          0.000714, 730, Duration(days: 730), 0.29, 35),
    },
  };

  /// Helper function to convert price history data to ChartLine format
  static List<ChartLine> _convertPriceHistoryToChartLines(
      List<Map<String, dynamic>> priceHistory) {
    return priceHistory
        .map((data) => ChartLine(
              time: data['time'] ?? 0.0,
              price: data['price'] ?? 0.0,
            ))
        .toList();
  }

  // Centralized token chart data with expanded data points for better visualization
  static final Map<String, List<ChartLine>> _tokenChartData = {
    'GENST':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['GENST']!['1W']!),
    'CAT': _convertPriceHistoryToChartLines(_tokenPriceHistory['CAT']!['1W']!),
    'HTDG':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['HTDG']!['1W']!),
    'EMRLD':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['EMRLD']!['1W']!),
    'LILA':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['LILA']!['1W']!),
    'MINRL':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['MINRL']!['1W']!),
    'TBLUE':
        _convertPriceHistoryToChartLines(_tokenPriceHistory['TBLUE']!['1W']!),
  };

  // Token metadata
  static final Map<String, Map<String, dynamic>> _tokenMetadata = {
    'GENST': {
      'name': 'Genesis Stone',
      'image': 'assets/tokens/genisisstone.webp',
      'color': Colors.blue,
    },
    'CAT': {
      'name': 'Cat Token',
      'image': 'assets/tokens/cat.webp',
      'color': Colors.red.shade400,
    },
    'HTDG': {
      'name': 'Hotdog',
      'image': 'assets/tokens/hotdog.webp',
      'color': Colors.orange.shade400,
    },
    'EMRLD': {
      'name': 'Emerald',
      'image': 'assets/tokens/emerald.webp',
      'color': Colors.green.shade400,
    },
    'LILA': {
      'name': 'Lila Token',
      'image': 'assets/tokens/lila.webp',
      'color': Colors.purple.shade400,
    },
    'MINRL': {
      'name': 'Mineral',
      'image': 'assets/tokens/mineral.webp',
      'color': Colors.grey.shade400,
    },
    'TBLUE': {
      'name': 'Token Blue',
      'image': 'assets/tokens/token_blue.webp',
      'color': Colors.blue.shade300,
    },
  };

  /// Get chart data for a specific token
  List<ChartLine> getTokenChartData(String symbol) {
    return _tokenChartData[symbol] ?? [];
  }

  /// Get latest price for a token from its chart data
  String getLatestPrice(String symbol) {
    final chartData = getTokenChartData(symbol);
    if (chartData.isEmpty) return '0.000000';
    return chartData.last.price.toStringAsFixed(6);
  }

  /// Alias method for compatibility - get latest price from chart data
  String getLatestPriceFromChart(List<ChartLine> chartData) {
    if (chartData.isEmpty) return '0.000000';
    final latestPrice = chartData.last.price;
    return latestPrice.toStringAsFixed(6);
  }

  /// Calculate price change percentage for a token
  String calculatePriceChange(String symbol) {
    final chartData = getTokenChartData(symbol);
    if (chartData.length < 2) return '+0.0%';
    final firstPrice = chartData.first.price;
    final lastPrice = chartData.last.price;
    final change = ((lastPrice - firstPrice) / firstPrice) * 100;
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }

  /// Alias method for compatibility - calculate price change from chart data
  String calculatePriceChangeFromChart(List<ChartLine> chartData) {
    if (chartData.length < 2) return '+0.0%';
    final firstPrice = chartData.first.price;
    final lastPrice = chartData.last.price;
    final change = ((lastPrice - firstPrice) / firstPrice) * 100;
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }

  /// Check if price is positive (increased)
  bool isPricePositive(String symbol) {
    final chartData = getTokenChartData(symbol);
    if (chartData.length < 2) return true;
    return chartData.last.price >= chartData.first.price;
  }

  /// Get token metadata
  Map<String, dynamic>? getTokenMetadata(String symbol) {
    return _tokenMetadata[symbol];
  }

  /// Get complete token data for UI display
  Map<String, dynamic> getTokenDisplayData(String symbol) {
    final metadata = getTokenMetadata(symbol);
    final chartData = getTokenChartData(symbol);

    if (metadata == null) return {};

    return {
      'name': metadata['name'],
      'symbol': symbol,
      'image': metadata['image'],
      'price': getLatestPrice(symbol),
      'change': calculatePriceChange(symbol),
      'isPositive': isPricePositive(symbol),
      'color': metadata['color'],
      'chartData': chartData,
    };
  }

  /// Get all available token symbols
  List<String> getAllTokenSymbols() {
    return _tokenChartData.keys.toList();
  }

  /// Generate price history for different time periods using the pre-generated data
  Map<String, dynamic> getTokenPriceHistory(String symbol) {
    return _tokenPriceHistory[symbol] ?? {};
  }
}
