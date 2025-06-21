import 'package:flutter/material.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';

class TokenDataService {
  static TokenDataService? _instance;
  static TokenDataService get instance => _instance ??= TokenDataService._();
  TokenDataService._();

  // Centralized token chart data with consistent values across the app
  static final Map<String, List<ChartLine>> _tokenChartData = {
    'GENST': [
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
    ],
    'CAT': [
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
    ],
    'HTDG': [
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
    ],
    'EMRLD': [
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
    ],
    'LILA': [
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
    ],
    'MINRL': [
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
    ],
    'TBLUE': [
      ChartLine(time: 0.0, price: 0.000690),
      ChartLine(time: 1.0, price: 0.000695),
      ChartLine(time: 2.0, price: 0.000700),
      ChartLine(time: 3.0, price: 0.000698),
      ChartLine(time: 4.0, price: 0.000705),
      ChartLine(time: 5.0, price: 0.000708),
      ChartLine(time: 6.0, price: 0.000710),
      ChartLine(time: 7.0, price: 0.000712),
      ChartLine(time: 8.0, price: 0.000713),
      ChartLine(time: 9.0, price: 0.000714),
    ],
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

  /// Generate price history for different time periods using the centralized chart data
  Map<String, dynamic> getTokenPriceHistory(String symbol) {
    final baseChartData = getTokenChartData(symbol);
    if (baseChartData.isEmpty) return {};

    final currentPrice = baseChartData.last.price;
    
    return {
      '1D': _generatePriceHistory(currentPrice, 24, Duration(days: 1)),
      '1W': _generatePriceHistory(currentPrice, 7 * 24, Duration(days: 7)),
      '1M': _generatePriceHistory(currentPrice, 30 * 24, Duration(days: 30)),
      '1J': _generatePriceHistory(currentPrice, 365, Duration(days: 365)),
      'Max': _generatePriceHistory(currentPrice, 730, Duration(days: 730)),
    };
  }

  List<Map<String, dynamic>> _generatePriceHistory(
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
}