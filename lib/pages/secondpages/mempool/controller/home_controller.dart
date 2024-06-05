import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/models/mempool_models/txConfirmDetail.dart';
import 'package:bitnet/models/mempool_models/txPaginationModel.dart';
import 'package:bitnet/pages/transactions/model/transaction_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:web_socket_channel/io.dart';

num usdPrice = 0;
Color primaryColor = const Color(0xff24273e);

final channel = IOWebSocketChannel.connect('wss://mempool.space/api/v1/ws');
var subscription;

class HomeController extends BaseController {
  RxBool loadingDetail = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingTx = false.obs;
  RxBool socketLoading = false.obs;
  RxBool transactionLoading = false.obs;
  RxBool isBTC = false.obs;
  RxBool showNextBlock = false.obs;
  RxBool showBlock = false.obs;
  RxInt indexShowBlock = 0.obs;
  RxInt indexBlock = 0.obs;
  int selectedIndex = -1;
  int selectedIndexData = -1;
  RxBool daLoading = false.obs;
  List<BlockData> bitcoinData = [];
  List<TransactionDetailsModel> txDetails = [];
  List<TransactionDetailsModel> txDetailsFound = [];
  List<TransactionDetailsModel> txDetailsReset = [];
  TransactionConfirmedDetail? txDetailsConfirmed;
  List opReturns = [];
  RxList socketsData = [].obs;
  TextEditingController searchCtrl = TextEditingController();

  RxList<MempoolBlocks> mempoolBlocks = <MempoolBlocks>[].obs;
  RxList<Transactions> transaction = <Transactions>[].obs;
  RxList<RbfSummary> transactionReplacements = <RbfSummary>[].obs;
  TransactionModel? transactionModel;
  Fees? fees;
  Da? da;
  String? days, time;

  RxString highPriority = ''.obs;
  String baseUrl = 'https://mempool.space/api/';
  final GlobalKey containerKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    allData();
  }

  allData() async {
    socketLoading.value = true;
    await getWebSocketData();
    await getData();
    await callApiWithDelay();
    await txDetailsConfirmedF(bitcoinData.first.id!);
    await txDetailsF(bitcoinData.first.id!, 0);
  }

  String formatAmount(String price) {
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  RxInt currentUSD = 0.obs;
  NumberFormat numberFormat = NumberFormat.decimalPattern('en_US');

  String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }

    int mid = text.length ~/ 1.5;
    String truncatedString =
        "${text.substring(0, mid - 1)}...${text.substring(mid + 2)}";
    return truncatedString;
  }

  int getTotalTxOutput(TransactionDetailsModel tx) {
    return tx.vout
        .map((Vout v) =>
            v.value ??
            0) // Use the null-aware operator ?? to handle null values
        .reduce((int a, int b) => a + b);
  }

  String hex2ascii(String string) {
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < string.length; i += 2) {
      String hexSubstring = string.substring(i, i + 2);
      int charCode = int.parse(hexSubstring, radix: 16);
      buffer.writeCharCode(charCode);
    }
    return buffer.toString();
  }

  dollarRate() async {
    DateTime now = DateTime.now();

    int timestamp = now.millisecondsSinceEpoch;

    String url = '${baseUrl}v1/historical-price?timestamp=$timestamp';

    final response = await dioClient.get(url: url);
    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> prices = data['prices'];
      if (prices.isNotEmpty) {
        final latestPrice = prices.last;
        currentUSD.value = latestPrice['USD'];
        usdPrice = latestPrice['USD'];
      }
      isLoading.value = false;
    } else {
      throw Exception('Failed to load historical price');
    }
  }

  RxDouble dollarPerRate = 0.0.obs;
  double dollarConversion(num fee) {
    dollarPerRate.value = currentUSD.value * ((fee * (560 / 4) / 100000000));
    return dollarPerRate.value;
  }

  getData() async {
    isLoading.value = true;
    update();
    try {
      String url = '${baseUrl}v1/blocks';
      final response = await dioClient.get(url: url);
      response.data.length;
      for (int i = 0; i < response.data.length; i++) {
        bitcoinData.add(
          BlockData.fromJson(
            response.data[i],
          ),
        );
      }
      update();
    } on DioException {
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  RxBool isRbfTransaction = false.obs;
  RxBool txConfirmed = false.obs;
  RxString replacedTx = ''.obs;
  RxInt txPosition = 0.obs;
  RbfTransaction? rbfTransaction;
  List blockTransactions = [];

  getWebSocketData() async {
    socketLoading.value = true;
    transactionLoading.value = true;
    update();
    channel.sink.add('{"action":"init"}');
    channel.sink.add(
        '{"action":"want","data":["blocks","stats","mempool-blocks","live-2h-chart"]}');
    channel.sink.add('{"track-rbf-summary":true}');
    Future.delayed(
      const Duration(minutes: 5),
      () {
        channel.sink.add('{"action":"ping"}');
      },
    );
    subscription = channel.stream.asBroadcastStream().listen((message) {
      Map<String, dynamic> data = jsonDecode(message);
      if (data['projected-block-transactions'] != null) {
        if (data['projected-block-transactions']['blockTransactions'] != null) {
          blockTransactions.clear();
          blockTransactions =
              data['projected-block-transactions']['blockTransactions'];
          print(
              'message+3 ${data['projected-block-transactions']['blockTransactions']}');
        }
        if (data['projected-block-transactions']['delta']['added'] != null) {
          blockTransactions
              .addAll(data['projected-block-transactions']['delta']['added']);
        }

        if (data['projected-block-transactions']['delta']['removed'] != null) {
          List remove =
              data['projected-block-transactions']['delta']['removed'];
          for (int i = 0; i < blockTransactions.length; i++) {
            String e = blockTransactions[i].first;
            print(remove.contains(e));
            if (remove.contains(e)) {
              print('remove');
              blockTransactions.removeAt(i);
            }
          }
        }
      }

      MemPoolModel memPool = MemPoolModel.fromJson(json.decode(message));
      if (memPool.txPosition != null) {
        txPosition.value = memPool.txPosition!.position.block;
      }

      if (memPool.rbfTransaction != null) {
        isRbfTransaction.value = true;
        replacedTx.value = memPool.rbfTransaction!.txid;
      }
      if (memPool.conversions != null) {
        currentUSD.value = int.parse(memPool.conversions!.uSD.toString());
      }
      if (memPool.mempoolBlocks != null) {
        mempoolBlocks.clear();
        mempoolBlocks.addAll(memPool.mempoolBlocks!);
      }

      if (memPool.transactions != null) {
        transaction.clear();
        transaction.addAll(memPool.transactions!);
      }
      if (memPool.fees != null) {
        fees = memPool.fees;
        highPriority.value = fees!.fastestFee.toString();
      }

      if (memPool.da != null) {
        daLoading.value = true;
        da = memPool.da;
        DateTime currentDate = DateTime.now();
        DateTime targetDate = DateTime.fromMillisecondsSinceEpoch(
            da!.estimatedRetargetDate!.toInt());
        Duration difference = targetDate.difference(currentDate);
        days = '${difference.inDays + 1} days';
        daLoading.value = false;
      }
      if (memPool.rbfSummary != null) {
        transactionReplacements.clear();
        transactionReplacements.addAll(memPool.rbfSummary!);
      }

      if (memPool.rbfLatestSummary != null) {
        transactionReplacements.clear();
        transactionReplacements.addAll(memPool.rbfLatestSummary!);
      }

      socketLoading.value = false;
      transactionLoading.value = false;
      update();
    }, onError: (error) {
      socketLoading.value = false;
      transactionLoading.value = false;
      update();
      print('WebSocket error: $error');
    });
  }

  late Timer timer;
  callApiWithDelay() {
    print('callapi with delay called ');

    timer =
        Timer.periodic(Duration(seconds: kDebugMode ? 1000 : 5), (timer) async {
      try {
        String url = 'https://mempool.space/api/v1/blocks';
        final response = await dioClient.get(url: url);
        response.data.length;
        bitcoinData.clear();

        for (int i = 0; i < response.data.length; i++) {
          bitcoinData.add(
            BlockData.fromJson(
              response.data[i],
            ),
          );
        }
        dollarRate();
        isLoading.value = false;
        Get.forceAppUpdate();
        update();
      } on DioException {
        isLoading.value = false;
        update();
      } catch (e) {
        isLoading.value = false;
        update();
      }
    });
  }

  Future<int?> getBlockHeight(String txId) async {
    loadingDetail.value = true;
    try {
      String url = 'https://mempool.space/api/v1/block/$txId';
      final response = await dioClient.get(url: url);
      txDetailsConfirmed = TransactionConfirmedDetail.fromJson(
        jsonDecode(
          jsonEncode(response.data),
        ),
      );
      print(txDetailsConfirmed!.height);
      return txDetailsConfirmed!.height;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> txDetailsConfirmedF(String txId) async {
    loadingDetail.value = true;
    try {
      String url = 'https://mempool.space/api/v1/block/$txId';
      final response = await dioClient.get(url: url);
      txDetailsConfirmed = TransactionConfirmedDetail.fromJson(
        jsonDecode(
          jsonEncode(response.data),
        ),
      );
      // isLoading.value = false;
      update();
    } on DioException {
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
    loadingDetail.value = false;
    return null;
  }

  Future<void> txDetailsF(String txId, int page) async {
    try {
      isLoadingTx.value = true;
      String url = 'https://mempool.space/api/block/$txId/txs/$page';

      final response = await dioClient.get(url: url);

      response.data.length;
      txDetails.clear();
      txDetailsFound.clear();
      txDetailsReset.clear();
      opReturns.clear();
      for (int i = 0; i < response.data.length; i++) {
        txDetails.add(TransactionDetailsModel.fromJson(response.data[i]));
      }
      txDetailsFound = txDetails;
      txDetailsReset = txDetails;
      isLoadingTx.value = false;
      update();
    } on DioException {
      isLoadingTx.value = false;
      update();
    } catch (e) {
      isLoadingTx.value = false;
      update();
    }
  }

  String formatTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  String timeFormat(int millisecondsString, int median) {
    DateTime medianDate = DateTime.now();
    DateTime targetDate =
        DateTime.fromMicrosecondsSinceEpoch(millisecondsString);
    Duration difference = targetDate.difference(medianDate);
    return formatTimeAgo(targetDate);
  }
}

String formatPrice(price) {
  final format = NumberFormat("#,##0", "en_US");
  return format.format(price);
}

String formatPriceDecimal(price) {
  final format = NumberFormat("#,##0.00", "en_US");
  return format.format(price);
}
