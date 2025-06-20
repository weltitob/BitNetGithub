import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';

/// Enhanced controller for the Mempool page components
/// Now extends BaseController for consistent API client usage and error handling
class MempoolController extends BaseController {
  // Reference to the main controller
  final homeController = Get.find<HomeController>();
  
  // Hashrate data
  final RxList<ChartLine> hashrateChartData = <ChartLine>[].obs;
  final RxList<Difficulty> hashrateChartDifficulty = <Difficulty>[].obs;
  final RxBool hashrateLoading = true.obs;
  final RxString selectedTimePeriod = '1M'.obs;
  
  // Fear & Greed data
  final Rx<FearGearChartModel> fearGreedData = FearGearChartModel().obs;
  final RxBool fearGreedLoading = true.obs;
  final RxString formattedFearGreedDate = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    getHashrateData();
    getFearGreedData();
  }
  
  // ===== Hashrate Methods =====
  
  Future<void> getHashrateData([String period = '1M']) async {
    try {
      hashrateLoading.value = true;
      
      // Use shared dioClient instead of creating new Dio instance
      String url = 'https://mempool.space/api/v1/mining/hashrate/$period';
      final response = await dioClient.get(url: url);

      if (response.statusCode == 200 && response.data != null) {
        List<ChartLine> line = [];
        hashrateChartData.clear();
        hashrateChartDifficulty.clear();

        try {
          HashChartModel hashChartModel = HashChartModel.fromJson(response.data);
          hashrateChartDifficulty.addAll(hashChartModel.difficulty ?? []);

          // Safe iteration with null checks
          if (hashChartModel.hashrates != null) {
            for (int i = 0; i < hashChartModel.hashrates!.length; i++) {
              final hashrate = hashChartModel.hashrates![i];
              if (hashrate.timestamp != null && hashrate.avgHashrate != null) {
                line.add(ChartLine(
                  time: double.parse(hashrate.timestamp.toString()),
                  price: hashrate.avgHashrate!,
                ));
              }
            }
          }

          hashrateChartData.assignAll(line);
        } catch (e) {
          logger.e('Error parsing hashrate data: $e');
        }
      }
    } on DioException catch (e) {
      logger.e('DioException in getHashrateData: $e');
    } catch (e) {
      logger.e('Error in getHashrateData: $e');
    } finally {
      hashrateLoading.value = false;
    }
  }
  
  void updateHashrateTimePeriod(String period) {
    selectedTimePeriod.value = period;
    if (period == '1D') {
      getHashrateData('1D');
    } else if (period == '1W') {
      getHashrateData('1W');
    } else if (period == '1M') {
      getHashrateData('1M');
    } else if (period == '1Y') {
      getHashrateData('1Y');
    } else if (period == 'MAX') {
      getHashrateData('3Y'); // Maximum available data is 3 years
    }
  }
  
  // Cached hashrate info to avoid recalculation
  final RxMap<String, dynamic> _cachedHashrateInfo = <String, dynamic>{}.obs;

  // Get current hashrate value and percentage change with caching
  Map<String, dynamic> getCurrentHashrateInfo() {
    // Return cached value if data hasn't changed
    if (_cachedHashrateInfo.isNotEmpty && 
        _cachedHashrateInfo['dataLength'] == hashrateChartData.length) {
      return _cachedHashrateInfo;
    }

    String currentHashrate = "...";
    String changePercentage = "";
    bool isPositive = true;

    if (hashrateChartData.isNotEmpty) {
      // Get the most recent data point
      final lastPoint = hashrateChartData.last;
      
      // Optimized formatting - avoid string operations
      final hashrateValue = lastPoint.price;
      String hashrateStr;
      
      if (hashrateValue >= 1000) {
        // Convert to EH/s with 1 decimal place
        hashrateStr = "${(hashrateValue / 1000).toStringAsFixed(1)} ZH/s";
      } else if (hashrateValue >= 100) {
        // Show without decimals for 3-digit values
        hashrateStr = "${hashrateValue.toInt()} EH/s";
      } else {
        // Show with 1 decimal for smaller values
        hashrateStr = "${hashrateValue.toStringAsFixed(1)} EH/s";
      }
      currentHashrate = hashrateStr;

      // Calculate change percentage if we have more than one data point
      if (hashrateChartData.length > 10) {
        final previousPoint = hashrateChartData[
            hashrateChartData.length - 10]; // Compare with point ~10 days ago
        final change = (lastPoint.price - previousPoint.price) / previousPoint.price * 100;
        isPositive = change >= 0;
        changePercentage = "${isPositive ? "+" : ""}${change.toStringAsFixed(1)}%";
      }
    }
    
    // Cache the result
    _cachedHashrateInfo.value = {
      'currentHashrate': currentHashrate,
      'changePercentage': changePercentage,
      'isPositive': isPositive,
      'dataLength': hashrateChartData.length,
    };
    
    return _cachedHashrateInfo;
  }
  
  // ===== Fear & Greed Methods =====
  
  Future<void> getFearGreedData() async {
    try {
      fearGreedLoading.value = true;

      // Use shared dioClient with proper headers parameter
      String url = 'https://fear-and-greed-index.p.rapidapi.com/v1/fgi';
      final response = await dioClient.get(
        url: url,
        headers: {
          'X-RapidAPI-Key': 'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff',
          'X-RapidAPI-Host': 'fear-and-greed-index.p.rapidapi.com'
        }
      );

      if (response.statusCode == 200 && response.data != null) {
        try {
          fearGreedData.value = FearGearChartModel.fromJson(response.data);
          
          // Safe date formatting with null checks
          if (fearGreedData.value.lastUpdated?.humanDate != null) {
            try {
              DateTime dateTime = DateTime.parse(fearGreedData.value.lastUpdated!.humanDate!)
                  .toUtc();
              formattedFearGreedDate.value = DateFormat('d MMMM yyyy').format(dateTime);
            } catch (dateError) {
              logger.e('Error parsing date: $dateError');
              formattedFearGreedDate.value = 'Date unavailable';
            }
          }
        } catch (parseError) {
          logger.e('Error parsing Fear & Greed data: $parseError');
        }
      }
    } on DioException catch (e) {
      logger.e('DioException in getFearGreedData: $e');
    } catch (e) {
      logger.e('Error in getFearGreedData: $e');
    } finally {
      fearGreedLoading.value = false;
    }
  }
  
  // Get color based on fear & greed value
  Color getFearGreedColor(int value) {
    if (value <= 25) {
      return Colors.red;
    } else if (value <= 45) {
      return Colors.orange;
    } else if (value <= 55) {
      return Colors.yellow;
    } else if (value <= 75) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }

  // Get current fear & greed value
  int getCurrentFearGreedValue() {
    // Default value if data not loaded
    int currentValue = 50;
    
    if (fearGreedData.value.fgi != null && 
        fearGreedData.value.fgi!.now != null) {
      currentValue = fearGreedData.value.fgi!.now!.value ?? 50;
    }
    
    return currentValue;
  }
}