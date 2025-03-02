import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';

/// Enhanced controller for the Mempool page components
/// This extends the functionality of the HomeController with additional
/// features specific to the components we've extracted
class MempoolController extends GetxController {
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

      var dio = Dio();
      var response = await dio.get('https://mempool.space/api/v1/mining/hashrate/$period');

      if (response.statusCode == 200) {
        List<ChartLine> line = [];
        hashrateChartData.clear();
        hashrateChartDifficulty.clear();

        HashChartModel hashChartModel = HashChartModel.fromJson(response.data);
        hashrateChartDifficulty.addAll(hashChartModel.difficulty ?? []);

        for (int i = 0; i < hashChartModel.hashrates!.length; i++) {
          line.add(ChartLine(
            time: double.parse(hashChartModel.hashrates![i].timestamp.toString()),
            price: hashChartModel.hashrates![i].avgHashrate!,
          ));
        }

        hashrateChartData.assignAll(line);
        hashrateLoading.value = false;
      }
    } catch (e) {
      print('Hashrate error: $e');
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
  
  // Get current hashrate value and percentage change
  Map<String, dynamic> getCurrentHashrateInfo() {
    String currentHashrate = "...";
    String changePercentage = "";
    bool isPositive = true;

    if (hashrateChartData.isNotEmpty) {
      // Get the most recent data point
      final lastPoint = hashrateChartData.last;
      // Format hashrate value - convert to EH/s (Exahash per second)
      final hashrateParsed = double.parse(lastPoint.price.toString().substring(
          0,
          lastPoint.price.toString().length > 3
              ? 3
              : lastPoint.price.toString().length));
      currentHashrate = "$hashrateParsed EH/s";

      // Calculate change percentage if we have more than one data point
      if (hashrateChartData.length > 10) {
        final previousPoint = hashrateChartData[
            hashrateChartData.length - 10]; // Compare with point ~10 days ago
        final change = (lastPoint.price - previousPoint.price) / previousPoint.price * 100;
        isPositive = change >= 0;
        changePercentage = "${isPositive ? "+" : ""}${change.toStringAsFixed(1)}%";
      }
    }
    
    return {
      'currentHashrate': currentHashrate,
      'changePercentage': changePercentage,
      'isPositive': isPositive,
    };
  }
  
  // ===== Fear & Greed Methods =====
  
  Future<void> getFearGreedData() async {
    try {
      fearGreedLoading.value = true;

      var dio = Dio();
      var response = await dio.get('https://fear-and-greed-index.p.rapidapi.com/v1/fgi',
          options: Options(headers: {
            'X-RapidAPI-Key': 'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff',
            'X-RapidAPI-Host': 'fear-and-greed-index.p.rapidapi.com'
          }));

      if (response.statusCode == 200) {
        fearGreedData.value = FearGearChartModel.fromJson(response.data);
        if (fearGreedData.value.lastUpdated != null) {
          DateTime dateTime = DateTime.parse(fearGreedData.value.lastUpdated!.humanDate!)
              .toUtc();
          formattedFearGreedDate.value = DateFormat('d MMMM yyyy').format(dateTime);
        }
        fearGreedLoading.value = false;
      }
    } catch (e) {
      print('Fear and Greed error: $e');
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