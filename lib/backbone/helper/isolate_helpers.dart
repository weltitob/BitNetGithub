import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';

/// Helper class for running heavy computations in isolates
class IsolateHelpers {
  
  /// Clean old chart data in an isolate
  static Future<List<ChartLine>> cleanChartData({
    required List<ChartLine> chartData,
    required Duration maxAge,
  }) async {
    return await compute(_cleanChartDataIsolate, {
      'chartData': chartData,
      'maxAge': maxAge.inMilliseconds,
    });
  }

  /// Process chart data for display (calculations, averaging, etc.)
  static Future<Map<String, dynamic>> processChartData({
    required List<ChartLine> chartData,
    required String timespan,
  }) async {
    return await compute(_processChartDataIsolate, {
      'chartData': chartData,
      'timespan': timespan,
    });
  }

  /// Calculate transaction statistics in isolate
  static Future<Map<String, dynamic>> calculateTransactionStats({
    required List<dynamic> transactions,
  }) async {
    return await compute(_calculateTransactionStatsIsolate, transactions);
  }
}

// Isolate functions (must be top-level)

List<ChartLine> _cleanChartDataIsolate(Map<String, dynamic> params) {
  final chartData = params['chartData'] as List<ChartLine>;
  final maxAgeMs = params['maxAge'] as int;
  final now = DateTime.now();
  
  return chartData.where((point) {
    final pointTime = DateTime.fromMillisecondsSinceEpoch(point.time.round());
    return now.difference(pointTime).inMilliseconds <= maxAgeMs;
  }).toList();
}

Map<String, dynamic> _processChartDataIsolate(Map<String, dynamic> params) {
  final chartData = params['chartData'] as List<ChartLine>;
  final timespan = params['timespan'] as String;
  
  if (chartData.isEmpty) {
    return {
      'average': 0.0,
      'min': 0.0,
      'max': 0.0,
      'change': 0.0,
      'changePercent': '0%',
    };
  }
  
  // Calculate statistics
  double sum = 0;
  double min = chartData.first.price;
  double max = chartData.first.price;
  
  for (final point in chartData) {
    sum += point.price;
    if (point.price < min) min = point.price;
    if (point.price > max) max = point.price;
  }
  
  final average = sum / chartData.length;
  final firstPrice = chartData.first.price;
  final lastPrice = chartData.last.price;
  final change = lastPrice - firstPrice;
  final changePercent = firstPrice == 0 ? 0 : (change / firstPrice) * 100;
  
  // Reduce data points for better performance
  final reducedData = _reduceDataPoints(chartData, timespan);
  
  return {
    'average': average,
    'min': min,
    'max': max,
    'change': change,
    'changePercent': '${changePercent.toStringAsFixed(2)}%',
    'reducedData': reducedData,
    'firstPrice': firstPrice,
    'lastPrice': lastPrice,
  };
}

List<ChartLine> _reduceDataPoints(List<ChartLine> data, String timespan) {
  if (data.length <= 100) return data;
  
  // Determine target points based on timespan
  int targetPoints;
  switch (timespan) {
    case '1D':
      targetPoints = 96; // Every 15 minutes
      break;
    case '1W':
      targetPoints = 84; // Every 2 hours
      break;
    case '1M':
      targetPoints = 90; // Every 8 hours
      break;
    case '1J':
      targetPoints = 52; // Weekly
      break;
    default:
      targetPoints = 100;
  }
  
  if (data.length <= targetPoints) return data;
  
  // Simple reduction - take every nth point
  final step = (data.length / targetPoints).ceil();
  final reduced = <ChartLine>[];
  
  for (int i = 0; i < data.length; i += step) {
    reduced.add(data[i]);
  }
  
  // Always include the last point
  if (reduced.last != data.last) {
    reduced.add(data.last);
  }
  
  return reduced;
}

Map<String, dynamic> _calculateTransactionStatsIsolate(List<dynamic> transactions) {
  if (transactions.isEmpty) {
    return {
      'totalReceived': 0,
      'totalSent': 0,
      'totalFees': 0,
      'averageTransaction': 0,
      'transactionCount': 0,
      'categoryCounts': <String, int>{},
    };
  }
  
  int totalReceived = 0;
  int totalSent = 0;
  int totalFees = 0;
  final categoryCounts = <String, int>{};
  
  for (final tx in transactions) {
    // Assuming transaction has amount, type, and fee fields
    final amount = tx['amount'] as int? ?? 0;
    final type = tx['type'] as String? ?? 'unknown';
    final fee = tx['fee'] as int? ?? 0;
    
    if (amount > 0) {
      totalReceived += amount;
    } else {
      totalSent += amount.abs();
    }
    
    totalFees += fee;
    categoryCounts[type] = (categoryCounts[type] ?? 0) + 1;
  }
  
  return {
    'totalReceived': totalReceived,
    'totalSent': totalSent,
    'totalFees': totalFees,
    'averageTransaction': (totalReceived + totalSent) ~/ transactions.length,
    'transactionCount': transactions.length,
    'categoryCounts': categoryCounts,
  };
}