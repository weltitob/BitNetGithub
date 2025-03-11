import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/futures/cryptochartline.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BitcoinController extends GetxController {
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

  late StreamSubscription sub;

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
  StreamSubscription? pbSub;

  @override
  void onInit() {
    super.onInit();

    var datetime = DateTime.now();
    dateFormat = DateFormat("dd.MM.yyyy");
    timeFormat = DateFormat("HH:mm");
    inital_date = dateFormat.format(datetime);
    inital_time = timeFormat.format(datetime);

    trackBallValuePrice = "-----.--";
    trackBallValueTime = datetime;
    // trackBallValueDate = "${inital_date}";
    trackBallValuePricechange = "+0";
    trackballBehavior = TrackballBehavior(
      lineColor: Colors.grey[400],
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineWidth: 2,
      lineType: TrackballLineType.horizontal,
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
    sub.cancel();
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

    // Call getChartData for each in parallel
    await Future.wait([
      chartClassDay.getChartData(),
      chartClassWeek.getChartData(),
      chartClassMonth.getChartData(),
      chartClassYear.getChartData(),
      chartClassMax.getChartData(),
    ]);

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
    sub = listenToLiveChartData(currency);
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

      maxchart.add(liveChart.value!);
      oneyearchart.add(liveChart.value!);
      onemonthchart.add(liveChart.value!);
      oneweekchart.add(liveChart.value!);
      onedaychart.add(liveChart.value!);

      _latesttimeinit = currentline.value.last.time;
      lastpriceinit =
          double.parse((currentline.value.last.price).toStringAsFixed(2));
      _firstpriceinit =
          double.parse((currentline.value.first.price).toStringAsFixed(2));

      // for custom widget define default value
      //price
      trackBallValuePrice = lastpriceinit.toString();
      //date
      // var datetime = DateTime.fromMillisecondsSinceEpoch(
      //     _latesttimeinit.round(),
      //     isUtc: false);
      // DateFormat dateFormat = DateFormat("dd.MM.yyyy");
      // DateFormat timeFormat = DateFormat("HH:mm");
      // String date = dateFormat.format(datetime);
      // String time = timeFormat.format(datetime);
      // trackBallValueTime = time.toString();
      // trackBallValueDate = date.toString();
      setValues();
      //percent
      double priceChange = currentline.value.first.price == 0 ? 0 :
          (currentline.value.last.price - currentline.value.first.price) /
              currentline.value.first.price;
      overallPriceChange.value = toPercent(priceChange);

      Duration dayDuration = Duration(days: 1);
      Duration weekDuration = Duration(days: 7);
      Duration monthDuration = Duration(days: 30);
      Duration yearDuration = Duration(days: 365);
      int index = 0;
      while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
              onedaychart[index].time.round())) >
          dayDuration) {
        onedaychart.removeAt(index);
        if (onedaychart.isEmpty) {
          break;
        }
      }
      while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
              oneweekchart[index].time.round())) >
          weekDuration) {
        oneweekchart.removeAt(index);
        if (oneweekchart.isEmpty) {
          break;
        }
      }
      while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
              onemonthchart[index].time.round())) >
          monthDuration) {
        onemonthchart.removeAt(index);
        if (onemonthchart.isEmpty) {
          break;
        }
      }
      while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
              oneyearchart[index].time.round())) >
          yearDuration) {
        if (oneyearchart.isEmpty) {
          break;
        }
        oneyearchart.removeAt(index);
      }

      Get.find<LoggerService>().i("live chart data updated...");
    });
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
      return;
    }
    
    pbNew_lastpriceexact = pbCurrentline.value.last.price;
    pbNew_lastimeeexact = pbCurrentline.value.last.time;
    pbNew_lastpricerounded.value =
        double.parse((pbNew_lastpriceexact).toStringAsFixed(2));
    pbNew_firstpriceexact = pbCurrentline.value.first.price;
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

    // Set current chart line to 1D by default
    pbCurrentline.value = pbOnedaychart;
  }

  /// Listen for real-time updates in the Firestore collection
  Future<void> _listenForUpdates(String currency) async {
    String userId = Auth().currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await pbSub?.cancel();
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
  }

  /// Ensure charts stay within their correct timespans and add new data while avoiding duplicates
  void updatepbData(List<DocumentChange> changes) {
    double now = DateTime.now().millisecondsSinceEpoch.toDouble();

    for (var change in changes) {
      if (change.type == DocumentChangeType.added) {
        var newData = ChartLine(
          price: change.doc["price"].toDouble(),
          time: change.doc["timestamp"].toDouble(),
        );

        // Avoid duplicates
        if (!pbMaxchart.any((d) => d.time == newData.time)) {
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
    pbOneyearchart
        .removeWhere((d) => d.time < now - Duration(days: 365).inMilliseconds);
    pbOnemonthchart
        .removeWhere((d) => d.time < now - Duration(days: 30).inMilliseconds);
    pbOneweekchart
        .removeWhere((d) => d.time < now - Duration(days: 7).inMilliseconds);
    pbOnedaychart
        .removeWhere((d) => d.time < now - Duration(days: 1).inMilliseconds);
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
}