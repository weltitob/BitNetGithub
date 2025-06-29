import 'package:bitnet/backbone/futures/cryptochartline.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CryptoItemController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late List<ChartLine> onedaychart = <ChartLine>[].obs;
  RxBool loading = true.obs;
  Color animationColor = Colors.transparent;
  RxString currentPriceString = "".obs;
  RxString priceChangeString = "".obs;
  RxDouble firstPrice = 0.0.obs;
  RxDouble currentPrice = 0.0.obs;
  RxDouble priceOneTimestampAgo = 0.0.obs;
  RxDouble priceChange = 0.0.obs;

  late AnimationController controller;
  late Animation<Color?> animation;
  RxBool isBlinking = false.obs;

  @override
  void onInit() {
    super.onInit();

    LoggerService logger = Get.find();

    waitForCurrencyAndFetchLine();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = ColorTween(begin: animationColor, end: Colors.transparent)
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isBlinking.value = false;
          controller.reverse();
          animation = ColorTween(begin: animationColor, end: Colors.transparent)
              .animate(controller);
          controller.reset();
        }
      });
  }

  // This function "awaits" until selectedCurrency is not null
  Future<void> waitForCurrencyAndFetchLine() async {
    final currencyProvider =
        Provider.of<CurrencyChangeProvider>(Get.context!, listen: false);
    while (currencyProvider.selectedCurrency == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    final currency = currencyProvider.selectedCurrency!;
    getChartLine('BTC', currency);
  }

  getChartLine(String crypto, String currency) async {
    if (crypto == "BTC") {
      LoggerService logger = Get.find();
      CryptoChartLine chartClassDay = CryptoChartLine(
        crypto: "bitcoin",
        currency: currency,
        days: "1",
      );
      CryptoChartLine chartClassDayMin = CryptoChartLine(
        crypto: "bitcoin",
        currency: currency,
        days: "1",
      );
      try {
        await chartClassDay.getChartData();
        await chartClassDayMin.getChartData();
        onedaychart = chartClassDay.chartLine;
        currentPrice.value = chartClassDayMin.chartLine.last.price;
        currentPriceString.value = currentPrice.toStringAsFixed(2);
        priceOneTimestampAgo.value =
            double.parse(currentPrice.toStringAsFixed(2));
        firstPrice.value = chartClassDayMin.chartLine.first.price;
        priceChange.value =
            (currentPrice - firstPrice.value) / firstPrice.value;
        priceChangeString.value = toPercent(priceChange.value);
        loading.value = false;
      } catch (e) {
        logger.e(
            "Charts could not be created for cryptoitem resulting in error" +
                e.toString());
        //loading.value = false;
      }
    } else {
      //get the price from firebase get the chart from firebase and show this then
      loading.value = false;
    }
  }

  void colorUpdater() {
    if (currentPrice < priceOneTimestampAgo.value) {
      animationColor = AppTheme.errorColor;
    } else if (currentPrice > priceOneTimestampAgo.value) {
      animationColor = AppTheme.successColor;
    } else {
      animationColor = Colors.transparent;
    }
    //update animation color
  }
}
