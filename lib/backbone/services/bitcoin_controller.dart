import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/futures/cryptochartline.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/api_rate_limiter.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BitcoinController extends GetxController {
  LoggerService logger = Get.find();
  
  late TrackballBehavior trackballBehavior;
  late List<ChartLine> chartData;
  late List<ChartLine> maxchart;
  late List<ChartLine> oneyearchart;
  late List<ChartLine> onemonthchart;
  late List<ChartLine> oneweekchart;
  late List<ChartLine> onedaychart;
  Rx<List<ChartLine>> currentline = Rx([]);
  late double lastpriceinit;
  late double _firstpriceinit;
  late double _latesttimeinit;

  late double new_lastpriceexact;
  late double new_lastimeeexact;
  RxDouble new_lastpricerounded = 0.0.obs;
  late double new_firstpriceexact;

  late DateFormat dateFormat;
  late DateFormat timeFormat;
  late String inital_date;
  late String inital_time;

  late String trackBallValuePrice;
  late DateTime trackBallValueTime;
  RxString overallPriceChange = "+0".obs;
  late String trackBallValuePricechange;

  // List to track all subscriptions for proper memory management
  final List<StreamSubscription> _subscriptions = [];
  StreamSubscription? sub;

  Rx<ChartLine?> liveChart = Rx<ChartLine?>(null);
  RxBool loading = true.obs;

  RxString selectedtimespan = "1D".obs;

  List<String> timespans = ["1D", "1W", "1M", "1J", "Max"];
  ChartSeriesController? chartSeriesController;

//Personal Balance Chart Values
  Rx<List<ChartLine>> pbCurrentline = Rx([]);
  RxString pbSelectedtimespan = "1D".obs;
  late List<ChartLine> pbMaxchart;
  late List<ChartLine> pbOneyearchart;
  late List<ChartLine> pbOnemonthchart;
  late List<ChartLine> pbOneweekchart;
  late List<ChartLine> pbOnedaychart;
  late double pbNew_lastpriceexact;
  late double pbNew_firstpriceexact;
  late double pbNew_lastimeeexact;
  RxDouble pbNew_lastpricerounded = 0.0.obs;
  RxInt pbChartPing = 0.obs;

  RxString pbOverallPriceChange = "+0".obs;
  // Add reactive variables for UI calculations to avoid re-computing in build methods
  RxBool isPriceChangePositive = true.obs;
  RxString formattedPriceChange = "0.00".obs;
  RxString formattedPricePercentage = "0%".obs;
  StreamSubscription? pbSub;

  @override
  void onInit() {
    super.onInit();

    var datetime = DateTime.now();
    dateFormat = DateFormat("dd.MM.yyyy");
    timeFormat = DateFormat("HH:mm");
    inital_date = dateFormat.format(datetime);
    inital_time = timeFormat.format(datetime);

    // Initialize chart data with empty lists to prevent LateInitializationError
    chartData = [];
    maxchart = [];
    oneyearchart = [];
    onemonthchart = [];
    oneweekchart = [];
    onedaychart = [];
    currentline.value = [];
    
    // Initialize personal balance chart data
    pbMaxchart = [];
    pbOneyearchart = [];
    pbOnemonthchart = [];
    pbOneweekchart = [];
    pbOnedaychart = [];
    pbCurrentline.value = [];

    // Initialize late variables to prevent LateInitializationError
    lastpriceinit = 0;
    _firstpriceinit = 0;
    _latesttimeinit = datetime.millisecondsSinceEpoch.toDouble();
    
    new_lastpriceexact = 0;
    new_lastimeeexact = datetime.millisecondsSinceEpoch.toDouble();
    new_firstpriceexact = 0;
    
    pbNew_lastpriceexact = 0;
    pbNew_lastimeeexact = datetime.millisecondsSinceEpoch.toDouble();
    pbNew_firstpriceexact = 0;

    trackBallValuePrice = "-----.--";
    trackBallValueTime = datetime;
    // trackBallValueDate = "${inital_date}";
    trackBallValuePricechange = "+0";
    trackballBehavior = TrackballBehavior(
      lineColor: Colors.grey[400],
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineWidth: 2,
      lineType: TrackballLineType.vertical,
      tooltipSettings: const InteractiveTooltip(enable: false),
      markerSettings: const TrackballMarkerSettings(
          color: Colors.white,
          borderColor: Colors.white,
          markerVisibility: TrackballVisibilityMode.visible),
    );
  }

  @override
  void onClose() {
    super.onClose();
    
    // Cancel all tracked subscriptions to prevent memory leaks
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    
    // Cancel individual subscriptions as well for safety
    sub?.cancel();
    pbSub?.cancel();
  }

  void setValues() {
    // Check if currentline is empty before accessing elements
    if (currentline.value.isEmpty) {
      // Set default values when no data is available
      new_lastpriceexact = 0;
      new_lastimeeexact = DateTime.now().millisecondsSinceEpoch.toDouble();
      new_lastpricerounded.value = 0;
      new_firstpriceexact = 0;
      return;
    }
    
    new_lastpriceexact = currentline.value.last.price;
    new_lastimeeexact = currentline.value.last.time;
    new_lastpricerounded.value =
        double.parse((new_lastpriceexact).toStringAsFixed(2));
    new_firstpriceexact = currentline.value.first.price;
  }

  getChartLine(String currency) async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "1",
    );
    CryptoChartLine chartClassWeek = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "7",
    );
    CryptoChartLine chartClassMonth = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "30",
    );
    CryptoChartLine chartClassYear = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "365",
    );
    CryptoChartLine chartClassMax = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "max",
    );

    // Call getChartData sequentially to prevent API rate limits
    logger.i('🔄 Starting sequential chart data loading to prevent API rate limits');
    
    final charts = [
      {'chart': chartClassDay, 'period': '1D'},
      {'chart': chartClassWeek, 'period': '1W'}, 
      {'chart': chartClassMonth, 'period': '1M'},
      {'chart': chartClassYear, 'period': '1Y'},
      {'chart': chartClassMax, 'period': 'MAX'},
    ];
    
    for (int i = 0; i < charts.length; i++) {
      final chartInfo = charts[i];
      final chart = chartInfo['chart'] as dynamic;
      final period = chartInfo['period'] as String;
      
      logger.d('📊 Loading chart data for period: $period (${i + 1}/${charts.length})');
      
      try {
        await chart.getChartData();
        logger.d('✅ Successfully loaded chart data for period: $period');
        
        // Add delay between requests to prevent rate limiting
        if (i < charts.length - 1) {
          await Future.delayed(const Duration(milliseconds: 200));
          logger.d('⏱️  Applied 200ms delay before next chart request');
        }
      } catch (e) {
        logger.e('❌ Failed to load chart data for period $period: $e');
        // Continue with other periods even if one fails
      }
    }
    
    logger.i('🏁 Completed sequential chart data loading');

    if (chartClassDay.chartLine.isNotEmpty) {
      Get.find<CryptoItemController>().firstPrice.value =
          chartClassDay.chartLine.first.price;

      Get.find<WalletsController>().chartLines.value =
          chartClassDay.chartLine.last;
    }
    final maxchartunfinished = chartClassMax.chartLine.toSet().toList();
    final oneyearchartunfinished = chartClassYear.chartLine.toSet().toList();
    final onemonthchartunfinished = chartClassMonth.chartLine.toSet().toList();
    final oneweekchartunfinished = chartClassWeek.chartLine.toSet().toList();

    onedaychart = chartClassDay.chartLine.toSet().toList();
    //get latest price from onedaychart
    List<ChartLine> onedaychartlast = [onedaychart.last];
    //add latest price to every chart
    maxchart = maxchartunfinished + onedaychartlast;
    oneyearchart = oneyearchartunfinished + onedaychartlast;
    onemonthchart = onemonthchartunfinished + onedaychartlast;
    oneweekchart = oneweekchartunfinished + onedaychartlast;
    //standard current line should be onedaychart
    currentline.value = onedaychart;
    liveChart.value = onedaychart.last;
    
    // Cancel existing subscription if any
    sub?.cancel();
    // Create new subscription and add to tracked list
    sub = listenToLiveChartData(currency);
    _subscriptions.add(sub!);
    
    _latesttimeinit = currentline.value.last.time;
    lastpriceinit =
        double.parse((currentline.value.last.price).toStringAsFixed(2));
    _firstpriceinit =
        double.parse((currentline.value.first.price).toStringAsFixed(2));

    // for custom widget define default value
    //price
    trackBallValuePrice = lastpriceinit.toString();
    //date
    var datetime = DateTime.fromMillisecondsSinceEpoch(_latesttimeinit.round(),
        isUtc: false);
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    String date = dateFormat.format(datetime);
    String time = timeFormat.format(datetime);
    trackBallValueTime = datetime;
    // trackBallValueDate = date.toString();

    setValues();
    //percent
    double priceChange = currentline.value.first.price == 0 ? 0 :
        (currentline.value.last.price - currentline.value.first.price) /
            currentline.value.first.price;
    overallPriceChange.value = toPercent(priceChange);

    loading.value = false;
  }

  StreamSubscription listenToLiveChartData(String currency) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Reference to the specific document in Firestore
    return firestore
        .collection('chart_data')
        .doc(currency.toUpperCase())
        .collection('live')
        .doc('data')
        .snapshots()
        .listen((data) {
      liveChart.value = ChartLine(
          time: data['time'],
          price: data['price'] is int
              ? double.parse(data['price'].toString())
              : data['price']);

      // Only add data to the timeframes where it belongs
      // This prevents excessive memory usage from duplication
      DateTime currentTime = DateTime.now();
      DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(
          liveChart.value!.time.round());
      
      // Add to all timeframes but limit their sizes
      maxchart.add(liveChart.value!);
      
      if (currentTime.difference(dataTime) <= Duration(days: 365)) {
        oneyearchart.add(liveChart.value!);
      }
      
      if (currentTime.difference(dataTime) <= Duration(days: 30)) {
        onemonthchart.add(liveChart.value!);
      }
      
      if (currentTime.difference(dataTime) <= Duration(days: 7)) {
        oneweekchart.add(liveChart.value!);
      }
      
      if (currentTime.difference(dataTime) <= Duration(days: 1)) {
        onedaychart.add(liveChart.value!);
      }

      // Limit chart sizes to prevent memory bloat
      _limitChartSize(maxchart, 500);
      _limitChartSize(oneyearchart, 365);
      _limitChartSize(onemonthchart, 200);
      _limitChartSize(oneweekchart, 168); // 24*7 hours
      _limitChartSize(onedaychart, 96);  // 24*4 data points per day

      _latesttimeinit = currentline.value.last.time;
      lastpriceinit =
          double.parse((currentline.value.last.price).toStringAsFixed(2));
      _firstpriceinit =
          double.parse((currentline.value.first.price).toStringAsFixed(2));

      // for custom widget define default value
      //price
      trackBallValuePrice = lastpriceinit.toString();
      setValues();
      
      //percent
      double priceChange = currentline.value.first.price == 0 ? 0 :
          (currentline.value.last.price - currentline.value.first.price) /
              currentline.value.first.price;
      overallPriceChange.value = toPercent(priceChange);

      // Clean up old data points that are outside their timeframe
      Duration dayDuration = Duration(days: 1);
      Duration weekDuration = Duration(days: 7);
      Duration monthDuration = Duration(days: 30);
      Duration yearDuration = Duration(days: 365);
      int index = 0;
      
      // Process one-day chart
      while (onedaychart.isNotEmpty && index < onedaychart.length && 
             currentTime.difference(DateTime.fromMillisecondsSinceEpoch(
                onedaychart[index].time.round())) > dayDuration) {
        onedaychart.removeAt(index);
      }
      
      // Process one-week chart
      index = 0;
      while (oneweekchart.isNotEmpty && index < oneweekchart.length &&
             currentTime.difference(DateTime.fromMillisecondsSinceEpoch(
                oneweekchart[index].time.round())) > weekDuration) {
        oneweekchart.removeAt(index);
      }
      
      // Process one-month chart
      index = 0;
      while (onemonthchart.isNotEmpty && index < onemonthchart.length &&
             currentTime.difference(DateTime.fromMillisecondsSinceEpoch(
                onemonthchart[index].time.round())) > monthDuration) {
        onemonthchart.removeAt(index);
      }
      
      // Process one-year chart
      index = 0;
      while (oneyearchart.isNotEmpty && index < oneyearchart.length &&
             currentTime.difference(DateTime.fromMillisecondsSinceEpoch(
                oneyearchart[index].time.round())) > yearDuration) {
        oneyearchart.removeAt(index);
      }

      Get.find<LoggerService>().i("live chart data updated...");
    });
  }
  
  /// Helper method to limit chart size and prevent memory bloat
  void _limitChartSize(List<ChartLine> chart, int maxSize) {
    if (chart.length <= maxSize) return;
    
    // Use downsample algorithm if chart has too many points
    chart = _downsampleChartData(chart, maxSize);
  }

  //personal balance functions
  void pbSetValues() {
    // Check if pbCurrentline is empty before accessing elements
    if (pbCurrentline.value.isEmpty) {
      // Set default values when no data is available
      pbNew_lastpriceexact = 0;
      pbNew_lastimeeexact = DateTime.now().millisecondsSinceEpoch.toDouble();
      pbNew_lastpricerounded.value = 0;
      pbNew_firstpriceexact = 0;
      
      // Also reset derived values
      isPriceChangePositive.value = true;
      formattedPriceChange.value = "0.00";
      formattedPricePercentage.value = "0%";
      pbOverallPriceChange.value = "0%";
      return;
    }
    
    pbNew_lastpriceexact = pbCurrentline.value.last.price;
    pbNew_lastimeeexact = pbCurrentline.value.last.time;
    pbNew_lastpricerounded.value =
        double.parse((pbNew_lastpriceexact).toStringAsFixed(2));
    pbNew_firstpriceexact = pbCurrentline.value.first.price;
    
    // Calculate derived values for UI
    updateDerivedValues();
  }
  
  // Calculate all derived values in one place to avoid redundant calculations in UI
  void updateDerivedValues() {
    // Calculate price difference
    double diff = pbNew_lastpricerounded.value - pbNew_firstpriceexact;
    
    // Check if the price change is positive or near zero
    isPriceChangePositive.value = diff >= 0 || diff.abs() < 0.001;
    
    // Format the price change
    if (diff.abs() < 0.01) {
      // Treat very small changes as zero
      formattedPriceChange.value = "0.00";
    } else if (diff.abs() > 9999) {
      // For large numbers, use K notation
      formattedPriceChange.value = (diff / 1000).toStringAsFixed(1) + 'K';
    } else {
      formattedPriceChange.value = diff.toStringAsFixed(2);
    }
    
    // Calculate percentage change
    double priceChange;
    if (pbNew_firstpriceexact == 0) {
      priceChange = (pbNew_lastpriceexact - pbNew_firstpriceexact) / 1;
    } else {
      priceChange = (pbNew_lastpriceexact - pbNew_firstpriceexact) / pbNew_firstpriceexact;
    }
    
    // Format percentage change
    pbOverallPriceChange.value = toPercent(priceChange);
    
    // Ensure consistency - if value is -0%, treat as positive
    if (pbOverallPriceChange.value.trim() == "-0%" || 
        pbOverallPriceChange.value.trim() == "0%") {
      pbOverallPriceChange.value = "0%";
      isPriceChangePositive.value = true;
    }
    
    formattedPricePercentage.value = pbOverallPriceChange.value;
  }

  Future<void> getpbChartline(String currency) async {
    try {
      String userId = Auth().currentUser!.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get data from Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection("balance_chart")
          .doc(userId)
          .collection("data")
          .doc(currency)
          .collection("data_points")
          .orderBy("timestamp", descending: false)
          .get();

      List<ChartLine> chartData = snapshot.docs.map((doc) {
        return ChartLine(
          price: doc["price"].toDouble(),
          time: doc["timestamp"].toDouble(), // Ensure timestamp is double
        );
      }).toList();

      // Partition data into different timespans
      _partitionChartData(chartData);
      pbSetValues();

      // Compute overall price change
      if (pbCurrentline.value.isNotEmpty) {
        double firstPrice = pbCurrentline.value.first.price;
        double lastPrice = pbCurrentline.value.last.price;

        double priceChange;
        if (firstPrice == 0) {
          priceChange = (lastPrice - firstPrice) / 1;
        } else {
          priceChange = (lastPrice - firstPrice) / firstPrice;
        }

        pbOverallPriceChange.value = toPercent(priceChange);
      }

      // Listen for real-time updates
      _listenForUpdates(currency);
    } catch (e) {
      print("Error fetching chart data: $e");
    }
  }

  /// Partition chart data into different timeframes
  void _partitionChartData(List<ChartLine> data) {
    double now = DateTime.now().millisecondsSinceEpoch.toDouble();

    // Make sure we have data to work with
    if (data.isEmpty) {
      // Create a fallback data point if there's no data
      ChartLine fallbackPoint = ChartLine(
        price: 0, 
        time: now
      );
      data = [fallbackPoint];
    }

    pbMaxchart = List.from(data);
    pbOneyearchart = data
        .where((d) => d.time > now - Duration(days: 365).inMilliseconds)
        .toList();
    pbOnemonthchart = data
        .where((d) => d.time > now - Duration(days: 30).inMilliseconds)
        .toList();
    pbOneweekchart = data
        .where((d) => d.time > now - Duration(days: 7).inMilliseconds)
        .toList();
    pbOnedaychart = data
        .where((d) => d.time > now - Duration(days: 1).inMilliseconds)
        .toList();
        
    // For timeframes with no data, use at least the most recent data point
    // This ensures charts always have at least one point
    if (pbOnedaychart.isEmpty && !data.isEmpty) {
      pbOnedaychart = [data.last]; // Use most recent data point
    }
    if (pbOneweekchart.isEmpty && !data.isEmpty) {
      pbOneweekchart = [data.last];
    }
    if (pbOnemonthchart.isEmpty && !data.isEmpty) {
      pbOnemonthchart = [data.last];
    }
    if (pbOneyearchart.isEmpty && !data.isEmpty) {
      pbOneyearchart = [data.last];
    }

    // Set current chart line to 1D by default
    pbCurrentline.value = pbOnedaychart;
  }

  /// Listen for real-time updates in the Firestore collection
  Future<void> _listenForUpdates(String currency) async {
    String userId = Auth().currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Cancel existing subscription to avoid memory leaks
    if (pbSub != null) {
      pbSub!.cancel();
      _subscriptions.remove(pbSub);
    }
    
    // Create new subscription
    pbSub = firestore
        .collection("balance_chart")
        .doc(userId)
        .collection("data")
        .doc(currency)
        .collection("data_points")
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docChanges.isNotEmpty) {
        Get.find<LoggerService>()
            .i("listening for updates for pb chart: updating....");
        updatepbData(snapshot.docChanges);
      }
    });
    
    // Add to tracked subscriptions
    _subscriptions.add(pbSub!);
  }

  /// Ensure charts stay within their correct timespans and add new data while avoiding duplicates
  /// Also implements data point optimization to prevent memory bloat
  void updatepbData(List<DocumentChange> changes) {
    double now = DateTime.now().millisecondsSinceEpoch.toDouble();

    // Define maximum data points for each timeframe to prevent memory bloat
    const int maxPointsPerTimeframe = 300;
    bool dataChanged = false;

    for (var change in changes) {
      if (change.type == DocumentChangeType.added) {
        var newData = ChartLine(
          price: change.doc["price"].toDouble(),
          time: change.doc["timestamp"].toDouble(),
        );

        // Avoid duplicates
        if (!pbMaxchart.any((d) => d.time == newData.time)) {
          dataChanged = true;
          pbMaxchart.add(newData);

          if (newData.time > now - Duration(days: 365).inMilliseconds)
            pbOneyearchart.add(newData);
          if (newData.time > now - Duration(days: 30).inMilliseconds)
            pbOnemonthchart.add(newData);
          if (newData.time > now - Duration(days: 7).inMilliseconds)
            pbOneweekchart.add(newData);
          if (newData.time > now - Duration(days: 1).inMilliseconds)
            pbOnedaychart.add(newData);
        }
      }
    }
    
    // Remove outdated data points
    pbOneyearchart
        .removeWhere((d) => d.time < now - Duration(days: 365).inMilliseconds);
    pbOnemonthchart
        .removeWhere((d) => d.time < now - Duration(days: 30).inMilliseconds);
    pbOneweekchart
        .removeWhere((d) => d.time < now - Duration(days: 7).inMilliseconds);
    pbOnedaychart
        .removeWhere((d) => d.time < now - Duration(days: 1).inMilliseconds);
        
    // Optimize chart data point count to prevent memory bloat
    if (dataChanged) {
      // Downsample data if we have too many points
      if (pbMaxchart.length > maxPointsPerTimeframe * 2) {
        pbMaxchart = _downsampleChartData(pbMaxchart, maxPointsPerTimeframe);
      }
      if (pbOneyearchart.length > maxPointsPerTimeframe) {
        pbOneyearchart = _downsampleChartData(pbOneyearchart, maxPointsPerTimeframe);
      }
      if (pbOnemonthchart.length > maxPointsPerTimeframe) {
        pbOnemonthchart = _downsampleChartData(pbOnemonthchart, maxPointsPerTimeframe);
      }
      if (pbOneweekchart.length > maxPointsPerTimeframe / 2) {
        pbOneweekchart = _downsampleChartData(pbOneweekchart, maxPointsPerTimeframe ~/ 2);
      }
      // Keep more points for 1D chart for better detail
      if (pbOnedaychart.length > maxPointsPerTimeframe / 4) {
        pbOnedaychart = _downsampleChartData(pbOnedaychart, maxPointsPerTimeframe ~/ 4);
      }
    }
    switch (pbSelectedtimespan.value) {
      case "1D":
        pbCurrentline.value = pbOnedaychart;
        break;
      case "1W":
        pbCurrentline.value = pbOneweekchart;
        break;
      case "1M":
        pbCurrentline.value = pbOnemonthchart;
        break;
      case "1J":
        pbCurrentline.value = pbOneyearchart;
        break;
      case "Max":
        pbCurrentline.value = pbMaxchart;
        break;
    }
    // Recalculate overall price change
    if (pbCurrentline.value.isNotEmpty) {
      double firstPrice = pbCurrentline.value.first.price;
      double lastPrice = pbCurrentline.value.last.price;
      pbSetValues();
      double priceChange;
      if (firstPrice == 0) {
        priceChange = (lastPrice - firstPrice) / 1;
      } else {
        priceChange = (lastPrice - firstPrice) / firstPrice;
      }

      pbOverallPriceChange.value = toPercent(priceChange);
    }
    pbChartPing.value += 1;
  }
  
  /// Downsample chart data to reduce memory usage and improve performance
  /// Uses Douglas-Peucker algorithm-inspired approach to maintain visual fidelity
  List<ChartLine> _downsampleChartData(List<ChartLine> data, int targetPointCount) {
    if (data.length <= targetPointCount) return data;
    
    // Always keep first and last points for accurate price change calculation
    List<ChartLine> result = [data.first];
    
    // For very few points, just use regular interval sampling
    if (data.length < targetPointCount * 3) {
      // Simple interval-based sampling
      double interval = data.length / (targetPointCount - 2);
      for (int i = 1; i < targetPointCount - 1; i++) {
        int index = (i * interval).round();
        if (index < data.length - 1) {
          result.add(data[index]);
        }
      }
    } else {
      // For more points, use a more sophisticated approach that preserves important features
      // Divide data into segments and for each segment, keep the min, max and middle points
      int segmentCount = (targetPointCount - 2) ~/ 3;
      int pointsPerSegment = data.length ~/ segmentCount;
      
      for (int i = 0; i < segmentCount; i++) {
        int startIdx = 1 + i * pointsPerSegment;
        int endIdx = (i == segmentCount - 1) ? data.length - 1 : startIdx + pointsPerSegment;
        
        if (startIdx >= endIdx) continue;
        
        List<ChartLine> segment = data.sublist(startIdx, endIdx);
        
        // Find min and max points in segment
        ChartLine minPoint = segment.reduce((a, b) => a.price < b.price ? a : b);
        ChartLine maxPoint = segment.reduce((a, b) => a.price > b.price ? a : b);
        
        // Add middle point for time perspective
        ChartLine midPoint = segment[(segment.length / 2).floor()];
        
        // Add the points, ensuring no duplicates
        if (!result.contains(minPoint)) result.add(minPoint);
        if (!result.contains(midPoint) && midPoint != minPoint && midPoint != maxPoint) 
          result.add(midPoint);
        if (!result.contains(maxPoint) && maxPoint != minPoint) 
          result.add(maxPoint);
      }
    }
    
    // Add last point if not already present
    if (result.last != data.last) {
      result.add(data.last);
    }
    
    // Sort by time to ensure proper order
    result.sort((a, b) => a.time.compareTo(b.time));
    
    return result;
  }

  /// Rate-limited version of chart loading for scenarios with potential loop-in-loop API calls
  Future<void> getChartLineWithRateLimit(String currency) async {
    logger.i('🚦 Starting rate-limited chart data loading');
    
    final rateLimiter = ApiRateLimiter.to;
    
    // Create chart classes for each timeframe
    final chartConfigs = [
      {'period': '1D', 'days': '1'},
      {'period': '1W', 'days': '7'},
      {'period': '1M', 'days': '30'},
      {'period': '1Y', 'days': '365'},
      {'period': 'MAX', 'days': 'max'},
    ];
    
    List<CryptoChartLine> chartClasses = [];
    for (var config in chartConfigs) {
      chartClasses.add(CryptoChartLine(
        crypto: "bitcoin",
        currency: currency,
        days: config['days']!,
      ));
    }
    
    // Queue all chart data requests with rate limiting
    logger.i('📋 Queueing ${chartClasses.length} chart data requests with rate limiting');
    
    final futures = <Future<void>>[];
    for (int i = 0; i < chartClasses.length; i++) {
      final chartClass = chartClasses[i];
      final period = chartConfigs[i]['period']!;
      
      final future = rateLimiter.enqueue<void>(
        request: () async {
          logger.d('📊 Fetching chart data for period: $period');
          await chartClass.getChartData();
          logger.d('✅ Completed chart data for period: $period');
        },
        endpoint: '/coins/bitcoin/market_chart',
        apiProvider: 'coingecko',
        priority: 1,
      );
      
      futures.add(future);
    }
    
    // Wait for all requests to complete
    try {
      await Future.wait(futures);
      logger.i('🎉 All rate-limited chart data requests completed successfully');
      
      // Process the loaded data similar to the original method
      if (chartClasses[0].chartLine.isNotEmpty) {
        Get.find<CryptoItemController>().firstPrice.value =
            chartClasses[0].chartLine.first.price;

        Get.find<WalletsController>().chartLines.value =
            chartClasses[0].chartLine.last;

        onedaychart = chartClasses[0].chartLine;
        oneweekchart = chartClasses[1].chartLine;
        onemonthchart = chartClasses[2].chartLine;
        oneyearchart = chartClasses[3].chartLine;
        maxchart = chartClasses[4].chartLine;
        
        // Standard processing
        currentline.value = onedaychart;
        liveChart.value = onedaychart.last;
        setValues();
        
        double priceChange = currentline.value.first.price == 0 ? 0 :
            (currentline.value.last.price - currentline.value.first.price) /
                currentline.value.first.price;
        overallPriceChange.value = toPercent(priceChange);

        loading.value = false;
        
        logger.i('🔄 Chart data processing completed');
      }
    } catch (e) {
      logger.e('❌ Rate-limited chart loading failed: $e');
      throw e;
    }
    
    // Log rate limiter status for debugging
    final queueStatus = rateLimiter.getQueueStatus();
    logger.d('📊 Rate limiter status: $queueStatus');
  }
}