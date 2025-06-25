import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/postsDataModel.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/models/mempool_models/txConfirmDetail.dart';
import 'package:bitnet/models/mempool_models/txPaginationModel.dart';
import 'package:bitnet/pages/transactions/model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

num usdPrice = 0;
Color primaryColor = const Color(0xff24273e);

// Removed global WebSocket - now managed per controller instance

class HomeController extends BaseController {
  // WebSocket management - instance-based instead of global
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  bool _isDisposed = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 5);

  // Loading states
  RxBool loadingDetail = false.obs;
  int? blockHeight;
  RxBool isLoadingPage = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingTx = false.obs;
  RxBool isLoadingMoreTx = false.obs;
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
  RxDouble scrollValue = 1250.0.obs;

  // Data collections with size limits to prevent unbounded growth
  static const int _maxListSize = 1000;
  static const int _maxBlockTransactions = 500;

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
  bool isLoadingPrevious = false;
  int? height;
  RxString highPriority = ''.obs;
  String baseUrl = 'https://mempool.space/api/';
  final GlobalKey containerKey = GlobalKey();
  List<PostsDataModel>? postsDataList = [];

  // Block transactions with bounds checking
  List blockTransactions = [];

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  /// Safe initialization with error handling
  Future<void> _initializeController() async {
    try {
      await allData();
    } catch (e) {
      logger.e('Controller initialization failed: $e');
      // Set error state but don't crash
      isLoading.value = false;
      socketLoading.value = false;
    }
  }

  allData() async {
    try {
      postsDataList = await fetchPosts();

      socketLoading.value = true;
      await getWebSocketData();
      await getData();
      await callApiWithDelay();

      // Safe access to first bitcoin data with null checks
      if (bitcoinData.isNotEmpty && bitcoinData.first.id != null) {
        final firstBlockId = bitcoinData.first.id!;
        await txDetailsConfirmedF(firstBlockId);
        await txDetailsF(firstBlockId, 0);
      } else {
        logger.w('No bitcoin data available for txDetails calls');
      }
    } catch (e) {
      logger.e('Error in allData initialization: $e');
      socketLoading.value = false;
    }
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

    int mid = (text.length / 1.5).toInt();
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

  List<BlockData> removeElementsBefore<BlockData>(
      List<BlockData> list, BlockData element) {
    int index = list.indexWhere((e) => e == element);

    // If the element is found, remove elements before it
    if (index != -1) {
      return list.sublist(index);
    } else {
      // If the element is not found, return the original list
      return list;
    }
  }

  // getDataForHeight(int height) async {
  //   isLoading.value = true;
  //   update();
  //   try {
  //     String url = '${baseUrl}v1/blocks/$height';
  //     final response = await dioClient.get(url: url);
  //     if (isLoadingPrevious) {
  //       bitcoinDataHeight.insertAll(
  //         0,
  //         blockDataFromJson(
  //           jsonEncode(response.data),
  //         ),
  //       );
  //     } else {
  //       for (int i = 0; i < response.data.length; i++) {
  //         bitcoinDataHeight.add(
  //           BlockData.fromJson(
  //             response.data[i],
  //           ),
  //         );
  //       }
  //     }

  //     txDetailsConfirmedF(bitcoinDataHeight.first.id!);
  //     isLoading.value = false;

  //     update();
  //   } on DioException {
  //     isLoading.value = false;
  //     update();
  //   } catch (e) {
  //     isLoading.value = false;
  //     update();
  //   }
  // }

  Future<int?> getDataHeightHash(String height) async {
    try {
      String url = '${baseUrl}v1/block/$height';
      final response = await dioClient.get(url: url);
      return blockHeight = response.data['height'];
    } on DioException {
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
    return null;
  }

  getDataHeight(int height) async {
    update();
    try {
      String url = '${baseUrl}v1/blocks/$height';
      final response = await dioClient.get(url: url);
      for (int i = 0; i < response.data.length; i++) {
        bitcoinData.add(
          BlockData.fromJson(
            response.data[i],
          ),
        );
      }
      isLoading.value = false;

      update();
    } on DioException {
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  getData() async {
    isLoading.value = true;
    update();
    try {
      String url = '${baseUrl}v1/blocks';
      final response = await dioClient.get(url: url);
      height = response.data[0]['height'];
      bitcoinData.clear();
      await getDataHeight(height!);
      await getDataHeight(height! - 15);
      await getDataHeight(height! - 30);
      isLoading.value = false;
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

  /// Safe WebSocket initialization with proper error handling and disposal
  Future<void> getWebSocketData() async {
    if (_isDisposed) return;

    try {
      socketLoading.value = true;
      transactionLoading.value = true;

      // Close existing connection if any
      await _closeWebSocket();

      // Create new WebSocket connection
      _channel = IOWebSocketChannel.connect('wss://mempool.space/api/v1/ws');

      // Set up ping timer for keep-alive
      _pingTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
        _sendSafeMessage('{"action":"ping"}');
      });

      // Initialize connection
      _sendSafeMessage('{"action":"init"}');
      _sendSafeMessage(
          '{"action":"want","data":["blocks","stats","mempool-blocks","live-2h-chart"]}');
      _sendSafeMessage('{"track-rbf-summary":true}');

      // Set up stream listener with proper error handling
      _setupWebSocketListener();
    } catch (e) {
      logger.e('WebSocket initialization failed: $e');
      _handleWebSocketError(e);
    }
  }

  /// Send message safely with null checks
  void _sendSafeMessage(String message) {
    try {
      if (_channel?.sink != null && !_isDisposed) {
        _channel!.sink.add(message);
      }
    } catch (e) {
      logger.e('Failed to send WebSocket message: $e');
    }
  }

  /// Public method to send WebSocket messages
  void sendWebSocketMessage(String message) {
    _sendSafeMessage(message);
  }

  /// Set up WebSocket stream listener with error recovery
  void _setupWebSocketListener() {
    if (_channel?.stream == null || _isDisposed) return;

    _subscription = _channel!.stream.listen(
      (message) {
        if (_isDisposed) return;
        _processWebSocketMessage(message);
      },
      onError: (error) {
        logger.e('WebSocket error: $error');
        _handleWebSocketError(error);
      },
      onDone: () {
        logger.i('WebSocket connection closed');
        if (!_isDisposed) {
          _attemptReconnection();
        }
      },
      cancelOnError: false,
    );
  }

  /// Process WebSocket message safely in isolate to avoid blocking UI
  void _processWebSocketMessage(dynamic message) {
    try {
      // Parse message safely
      if (message == null || message.toString().isEmpty) return;

      Map<String, dynamic> data = jsonDecode(message.toString());

      // Handle projected block transactions with bounds checking
      _handleProjectedBlockTransactions(data);

      // Handle mempool model data
      _handleMempoolModelData(data, message.toString());
    } catch (e) {
      logger.e('Error processing WebSocket message: $e');
    }
  }

  /// Handle projected block transactions with bounds checking
  void _handleProjectedBlockTransactions(Map<String, dynamic> data) {
    try {
      if (data['projected-block-transactions'] != null) {
        final projectedBlockTx = data['projected-block-transactions'];

        // Update block transactions if provided
        if (projectedBlockTx['blockTransactions'] != null) {
          blockTransactions.clear();
          final newTransactions = projectedBlockTx['blockTransactions'];
          if (newTransactions is List) {
            // Apply size limit to prevent unbounded growth
            final limitedTransactions =
                newTransactions.length > _maxBlockTransactions
                    ? newTransactions.sublist(0, _maxBlockTransactions)
                    : newTransactions;
            blockTransactions.addAll(limitedTransactions);
          }
        }

        // Handle delta changes with bounds checking
        if (projectedBlockTx['delta'] != null) {
          final delta = projectedBlockTx['delta'];

          // Handle added transactions with size limit
          if (delta['added'] != null && delta['added'] is List) {
            final toAdd = delta['added'] as List;
            final currentSize = blockTransactions.length;
            final availableSpace = _maxBlockTransactions - currentSize;

            if (availableSpace > 0) {
              final limitedAdd = toAdd.length > availableSpace
                  ? toAdd.sublist(0, availableSpace)
                  : toAdd;
              blockTransactions.addAll(limitedAdd);
            }
          }

          // Handle removed transactions safely
          if (delta['removed'] != null && delta['removed'] is List) {
            final remove = delta['removed'] as List;
            // Remove from the end to avoid index shifting issues
            for (int i = blockTransactions.length - 1; i >= 0; i--) {
              if (i < blockTransactions.length &&
                  blockTransactions[i] is List &&
                  (blockTransactions[i] as List).isNotEmpty) {
                final txData = blockTransactions[i] as List;
                if (txData.isNotEmpty && remove.contains(txData.first)) {
                  blockTransactions.removeAt(i);
                }
              }
            }
          }
        }
      }
    } catch (e) {
      logger.e('Error handling projected block transactions: $e');
    }
  }

  /// Handle mempool model data with safe parsing and null safety
  void _handleMempoolModelData(Map<String, dynamic> data, String rawMessage) {
    try {
      MemPoolModel memPool = MemPoolModel.fromJson(data);

      // Safe transaction position update
      if (memPool.txPosition?.position?.block != null) {
        txPosition.value = memPool.txPosition!.position.block;
      }

      // Safe RBF transaction handling
      if (memPool.rbfTransaction?.txid != null) {
        isRbfTransaction.value = true;
        replacedTx.value = memPool.rbfTransaction!.txid;
      }

      // Safe currency conversion with validation
      if (memPool.conversions?.uSD != null) {
        final usdValue = memPool.conversions!.uSD;
        if (usdValue is num && usdValue > 0) {
          currentUSD.value = usdValue.toInt();
        }
      }

      // Safe mempool blocks update with size limit
      if (memPool.mempoolBlocks != null && memPool.mempoolBlocks!.isNotEmpty) {
        mempoolBlocks.clear();
        final limitedBlocks = memPool.mempoolBlocks!.length > 50
            ? memPool.mempoolBlocks!.sublist(0, 50)
            : memPool.mempoolBlocks!;
        mempoolBlocks.addAll(limitedBlocks);
      }

      // Safe transactions update with size limit
      if (memPool.transactions != null && memPool.transactions!.isNotEmpty) {
        transaction.clear();
        final limitedTransactions = memPool.transactions!.length > 100
            ? memPool.transactions!.sublist(0, 100)
            : memPool.transactions!;
        transaction.addAll(limitedTransactions);
      }

      // Safe fees update
      if (memPool.fees?.fastestFee != null) {
        fees = memPool.fees;
        highPriority.value = memPool.fees!.fastestFee.toString();
      }

      // Safe difficulty adjustment with null checking
      if (memPool.da?.estimatedRetargetDate != null) {
        daLoading.value = true;
        da = memPool.da;
        try {
          DateTime currentDate = DateTime.now();
          DateTime targetDate = DateTime.fromMillisecondsSinceEpoch(
              memPool.da!.estimatedRetargetDate!.toInt());
          Duration difference = targetDate.difference(currentDate);
          days = '${difference.inDays + 1} days';
        } catch (e) {
          logger.e('Error calculating difficulty adjustment date: $e');
          days = 'Unknown';
        }
        daLoading.value = false;
      }

      // Safe RBF summary updates with size limits
      if (memPool.rbfSummary != null && memPool.rbfSummary!.isNotEmpty) {
        transactionReplacements.clear();
        final limitedSummary = memPool.rbfSummary!.length > 50
            ? memPool.rbfSummary!.sublist(0, 50)
            : memPool.rbfSummary!;
        transactionReplacements.addAll(limitedSummary);
      }

      if (memPool.rbfLatestSummary != null &&
          memPool.rbfLatestSummary!.isNotEmpty) {
        transactionReplacements.clear();
        final limitedLatestSummary = memPool.rbfLatestSummary!.length > 50
            ? memPool.rbfLatestSummary!.sublist(0, 50)
            : memPool.rbfLatestSummary!;
        transactionReplacements.addAll(limitedLatestSummary);
      }

      // Update loading states
      socketLoading.value = false;
      transactionLoading.value = false;
    } catch (e) {
      logger.e('Error handling mempool model data: $e');
      // Set error state but don't crash
      socketLoading.value = false;
      transactionLoading.value = false;
    }
  }

  /// Handle WebSocket errors with exponential backoff
  void _handleWebSocketError(dynamic error) {
    logger.e('WebSocket error: $error');
    socketLoading.value = false;
    transactionLoading.value = false;

    if (!_isDisposed) {
      _attemptReconnection();
    }
  }

  /// Attempt WebSocket reconnection with exponential backoff
  void _attemptReconnection() {
    if (_isDisposed || _reconnectAttempts >= _maxReconnectAttempts) {
      logger.w('Max reconnection attempts reached or controller disposed');
      return;
    }

    _reconnectAttempts++;
    final delay =
        Duration(seconds: _reconnectDelay.inSeconds * _reconnectAttempts);

    logger.i(
        'Attempting WebSocket reconnection in ${delay.inSeconds} seconds (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      if (!_isDisposed) {
        getWebSocketData();
      }
    });
  }

  /// Close WebSocket connection safely
  Future<void> _closeWebSocket() async {
    try {
      _reconnectTimer?.cancel();
      _pingTimer?.cancel();

      await _subscription?.cancel();
      _subscription = null;

      await _channel?.sink.close();
      _channel = null;
    } catch (e) {
      logger.e('Error closing WebSocket: $e');
    }
  }

  callApiWithDelay() async {
    if (_isDisposed) return;

    try {
      String url = 'https://mempool.space/api/v1/blocks';
      final response = await dioClient.get(url: url);

      // Null safety and bounds checking
      if (response.data == null || response.data is! List) {
        logger.w('Invalid response data from blocks API');
        isLoading.value = false;
        return;
      }

      bitcoinData.clear();

      // Apply size limit to prevent unbounded growth - only store latest 100 blocks
      final dataList = response.data as List;
      final maxBlocks = 100;
      final limitedData = dataList.length > maxBlocks
          ? dataList.sublist(0, maxBlocks)
          : dataList;

      for (int i = 0; i < limitedData.length; i++) {
        try {
          final blockData = limitedData[i];
          if (blockData != null) {
            bitcoinData.add(BlockData.fromJson(blockData));
          }
        } catch (e) {
          logger.e('Error parsing block data at index $i: $e');
          // Continue with other blocks even if one fails
        }
      }

      dollarRate();
      isLoading.value = false;
      Get.forceAppUpdate();
      update();
    } on DioException catch (e) {
      logger.e('DioException in callApiWithDelay: $e');
      isLoading.value = false;
      update();
    } catch (e) {
      logger.e('Error in callApiWithDelay: $e');
      isLoading.value = false;
      update();
    }
  }

  Future<int?> getBlockHeight(String txId) async {
    loadingDetail.value = true;
    try {
      String url = 'https://mempool.space/api/v1/block/$txId';
      final response = await dioClient.get(url: url);

      // Null safety check for response data
      if (response.data == null) {
        logger.w('Received null response data for getBlockHeight');
        return null;
      }

      // Validate response data structure
      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        logger.w('Invalid response data type for getBlockHeight');
        return null;
      }

      // Check if height field exists and is valid
      if (!responseData.containsKey('height') ||
          responseData['height'] == null) {
        logger.w('Missing or null height field in getBlockHeight response');
        return null;
      }

      // Validate height field type
      final heightValue = responseData['height'];
      if (heightValue is! int && heightValue is! num) {
        logger.w(
            'Invalid height field type in getBlockHeight: ${heightValue.runtimeType}');
        return null;
      }

      // Safely parse the full object if we need it for other purposes
      try {
        txDetailsConfirmed = TransactionConfirmedDetail.fromJson(responseData);
        return txDetailsConfirmed!.height;
      } catch (parseError) {
        logger.e(
            'Error parsing full TransactionConfirmedDetail in getBlockHeight: $parseError');
        // Still return the height even if full parsing fails
        return heightValue is int ? heightValue : (heightValue as num).toInt();
      }
    } on DioException catch (e) {
      logger.e('DioException in getBlockHeight: $e');
    } catch (e) {
      logger.e('Error in getBlockHeight: $e');
    } finally {
      loadingDetail.value = false;
    }
    return null;
  }

  Future<void> txDetailsConfirmedF(String? txId) async {
    if (txId == null || txId.isEmpty) {
      logger.w('txDetailsConfirmedF called with null or empty txId');
      loadingDetail.value = false;
      return;
    }

    loadingDetail.value = true;
    try {
      String url = 'https://mempool.space/api/v1/block/$txId';
      final response = await dioClient.get(url: url);

      // Null safety check for response data
      if (response.data == null) {
        logger.w('Received null response data for txDetailsConfirmedF');
        loadingDetail.value = false;
        isLoading.value = false;
        return;
      }

      // Validate response data structure before parsing
      final responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        logger.w('Invalid response data type for txDetailsConfirmedF');
        loadingDetail.value = false;
        isLoading.value = false;
        return;
      }

      // Check for required fields to prevent null assignment to non-nullable types
      final requiredFields = [
        'id',
        'height',
        'version',
        'timestamp',
        'bits',
        'nonce',
        'difficulty',
        'merkle_root',
        'tx_count',
        'size',
        'weight',
        'previousblockhash',
        'mediantime',
        'extras'
      ];

      for (String field in requiredFields) {
        if (!responseData.containsKey(field) || responseData[field] == null) {
          logger.w(
              'Missing or null required field "$field" in txDetailsConfirmedF response');
          loadingDetail.value = false;
          isLoading.value = false;
          return;
        }
      }

      // Validate specific field types that commonly cause issues
      if (responseData['height'] is! int && responseData['height'] is! num) {
        logger.w(
            'Invalid height field type in txDetailsConfirmedF: ${responseData['height'].runtimeType}');
        loadingDetail.value = false;
        isLoading.value = false;
        return;
      }

      txDetailsConfirmed = TransactionConfirmedDetail.fromJson(responseData);
      isLoading.value = false;
      update();
    } on DioException catch (e) {
      logger.e('DioException in txDetailsConfirmedF: $e');
      txDetailsConfirmed = null; // Reset to null on error
      isLoading.value = false;
      update();
    } catch (e) {
      logger.e('Error in txDetailsConfirmedF: $e');
      logger.e('Error details: ${e.toString()}');
      if (e is TypeError) {
        logger.e('TypeError - likely null assignment to non-nullable field');
      }
      txDetailsConfirmed = null; // Reset to null on error
      isLoading.value = false;
      update();
    } finally {
      loadingDetail.value = false;
    }
  }

  Future<void> txDetailsF(String? txId, int page) async {
    if (txId == null || txId.isEmpty) {
      logger.w('txDetailsF called with null or empty txId');
      return;
    }

    try {
      isLoadingTx.value = true;
      String url = 'https://mempool.space/api/block/$txId/txs/$page';

      final response = await dioClient.get(url: url);

      // Null safety check for response data
      if (response.data == null) {
        logger.w('Received null response data for txDetailsF');
        return;
      }

      final responseData = response.data;
      if (responseData is! List) {
        logger.w('Response data is not a List');
        return;
      }

      txDetails.clear();
      txDetailsFound.clear();
      txDetailsReset.clear();
      opReturns.clear();

      // Safe iteration with null checks
      for (int i = 0; i < responseData.length && i < _maxListSize; i++) {
        final txData = responseData[i];
        if (txData != null) {
          try {
            txDetails.add(TransactionDetailsModel.fromJson(txData));
          } catch (e) {
            logger.e('Error parsing transaction at index $i: $e');
          }
        }
      }

      txDetailsFound = List.from(txDetails);
      txDetailsReset = List.from(txDetails);
      isLoadingTx.value = false;
      update();
    } on DioException catch (e) {
      logger.e('DioException in txDetailsF: $e');
      isLoadingTx.value = false;
      update();
    } catch (e) {
      logger.e('Error in txDetailsF: $e');
      isLoadingTx.value = false;
      update();
    }
  }

  /// Returns amount loaded, if less than 25, we are at the final page.
  /// Returns -1 on error
  Future<int> txDetailsMore(String? txId, int page) async {
    if (txId == null || txId.isEmpty) {
      logger.w('txDetailsMore called with null or empty txId');
      return -1;
    }

    try {
      isLoadingMoreTx.value = true;
      String url = 'https://mempool.space/api/block/$txId/txs/$page';

      final response = await dioClient.get(url: url);

      // Null safety check for response data
      if (response.data == null) {
        logger.w('Received null response data for txDetailsMore');
        isLoadingMoreTx.value = false;
        return -1;
      }

      final responseData = response.data;
      if (responseData is! List) {
        logger.w('Response data is not a List');
        isLoadingMoreTx.value = false;
        return -1;
      }

      int addedCount = 0;
      // Check if we have space for more transactions
      final availableSpace = _maxListSize - txDetails.length;

      for (int i = 0;
          i < responseData.length && addedCount < availableSpace;
          i++) {
        final txData = responseData[i];
        if (txData != null) {
          try {
            txDetails.add(TransactionDetailsModel.fromJson(txData));
            addedCount++;
          } catch (e) {
            logger.e('Error parsing transaction at index $i: $e');
          }
        }
      }

      txDetailsFound = List.from(txDetails);
      txDetailsReset = List.from(txDetails);
      isLoadingMoreTx.value = false;
      update();
      return addedCount;
    } on DioException catch (e) {
      logger.e('DioException in txDetailsMore: $e');
      isLoadingMoreTx.value = false;
      update();
      return -1;
    } catch (e) {
      logger.e('Error in txDetailsMore: $e');
      isLoadingMoreTx.value = false;
      update();
      return -1;
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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createPost(
      String postId,
      bool hasLiked,
      bool hasPrice,
      bool hasLikeButton,
      String nftName,
      String nftMainName,
      String cryptoText) async {
    try {
      // Check if a post with the given postId already exists
      QuerySnapshot existingPost = await firestore
          .collection('postsNew')
          .where('postId', isEqualTo: postId)
          .limit(1)
          .get();

      DocumentReference documentReference;

      if (existingPost.docs.isEmpty) {
        // If no document exists, create a new document reference
        documentReference = firestore.collection('postsNew').doc();
        print('Post added successfully!');
      } else {
        // If the document exists, get the existing document reference
        documentReference = existingPost.docs.first.reference;
        print('Post updated successfully!');
      }

      // Set or update the post with the current time as createdAt
      await documentReference.set(
          {
            'postId': postId,
            'hasLiked': hasLiked,
            'hasPrice': hasPrice,
            'hasLikeButton': hasLikeButton,
            'nftName': nftName,
            'nftMainName': nftMainName,
            'cryptoText': cryptoText,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          },
          SetOptions(
              merge:
                  true)); // Using SetOptions to merge the data instead of overwriting
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<List<PostsDataModel>?> fetchPosts() async {
    try {
      final currentTime = DateTime.now();
      final oneWeekAgo =
          currentTime.subtract(const Duration(days: 7)).millisecondsSinceEpoch;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('postsNew')
          .where('createdAt', isGreaterThanOrEqualTo: oneWeekAgo)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              PostsDataModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> updateHasLiked(String docId, bool hasLiked) async {
    try {
      await firestore.collection('postsNew').doc(docId).update({
        'hasLiked': hasLiked,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
      print('hasLiked updated successfully!');
    } catch (e, tr) {
      print('Error updating hasLiked: $e$tr');
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      // Get the current user's ID
      String userId = Auth().currentUser!.uid;

      // Check if a like with the given postId and userId already exists
      QuerySnapshot existingLike = await firestore
          .collection('postsLike')
          .where('postId', isEqualTo: postId)
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (existingLike.docs.isEmpty) {
        // If no document exists, create a new like
        DocumentReference documentReference =
            firestore.collection('postsLike').doc();
        String likeId = documentReference.id;
        await documentReference.set({
          'likeId': likeId,
          'userId': userId,
          'postId': postId,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
        print('Like added successfully!');
      } else {
        // If a document exists, remove the like
        String docId = existingLike.docs.first.id;
        await firestore.collection('postsLike').doc(docId).delete();
        print('Like removed successfully!');
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  Future<void> deleteLikeByPostId(String postId) async {
    try {
      CollectionReference postsCollection = firestore.collection('postsLike');
      QuerySnapshot postsSnapshot = await postsCollection.limit(1).get();
      if (postsSnapshot.docs.isEmpty) {
        print('The posts collection does not exist.');
        return;
      }
      QuerySnapshot querySnapshot =
          await postsCollection.where('postId', isEqualTo: postId).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.delete();
        print('likes deleted successfully!');
      } else {
        print('No likes found with the given postId.');
      }
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  Future<bool?> fetchHasLiked(String postId, String userId) async {
    try {
      QuerySnapshot collectionSnapshot =
          await firestore.collection('postsLike').limit(1).get();
      if (collectionSnapshot.docs.isEmpty) {
        print('The postLikes collection does not exist.');
        return false;
      }

      QuerySnapshot querySnapshot = await firestore
          .collection('postsLike')
          .where('postId', isEqualTo: postId)
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        print('No matching document found.');
        return false;
      }
    } catch (e) {
      print('Error fetching hasLiked value: $e');
      return false; // Handle the error as needed and return false
    }
  }

  Future<void> createClicks(String postId) async {
    try {
      DocumentReference documentReference =
          firestore.collection('postsClick').doc();
      String clickId = documentReference.id;
      String currentUserId = Auth().currentUser!.uid;

      QuerySnapshot querySnapshot = await firestore
          .collection('postsClick')
          .where('postId', isEqualTo: postId)
          .where('userId', isEqualTo: currentUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference existingDocRef = querySnapshot.docs.first.reference;
        await existingDocRef.update({
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      } else {
        await documentReference.set({
          'clickId': clickId,
          'userId': currentUserId,
          'postId': postId,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      }
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<Map<String, int>> getMostLikedPostIds() async {
    final oneWeekAgo =
        DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('postsLike')
        .where('createdAt', isGreaterThanOrEqualTo: oneWeekAgo)
        .get();

    Map<String, int> likeCountMap = {};

    for (var doc in querySnapshot.docs) {
      String postId = doc['postId'];
      if (postId.isNotEmpty) {
        likeCountMap[postId] = (likeCountMap[postId] ?? 0) + 1;
      }
    }

    return likeCountMap;
  }

  Future<Map<String, int>> getMostClickedPostIds() async {
    final oneWeekAgo =
        DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('postsClick')
        .where('createdAt', isGreaterThanOrEqualTo: oneWeekAgo)
        .get();

    Map<String, int> clickCountMap = {};

    for (var doc in querySnapshot.docs) {
      String postId = doc['postId'];
      if (postId.isNotEmpty) {
        clickCountMap[postId] = (clickCountMap[postId] ?? 0) + 1;
      }
    }

    return clickCountMap;
  }

  Stream<List<PostsDataModel>> getPostsDataStream() async* {
    print('below is like and click data');

    final likeCountMap = await getMostLikedPostIds();
    final clickCountMap = await getMostClickedPostIds();
    // print(likeCountMap);
    // print(clickCountMap);
    print('above is like and click data');

    // Combine and count total interactions
    final totalCountMap = <String, int>{};

    for (var entry in likeCountMap.entries) {
      totalCountMap[entry.key] = (totalCountMap[entry.key] ?? 0) + entry.value;
    }

    for (var entry in clickCountMap.entries) {
      totalCountMap[entry.key] = (totalCountMap[entry.key] ?? 0) + entry.value;
    }

    // Sort by total interactions
    final sortedPostIds = totalCountMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final sortedRelevantPostIds =
        sortedPostIds.map((entry) => entry.key).toList();
    // print(sortedRelevantPostIds);

    if (sortedRelevantPostIds.isEmpty) {
      yield [];
      return;
    }

    final chunkSize = 10; // Firestore's limit for whereIn queries
    List<PostsDataModel> allPosts = [];

    for (var i = 0; i < sortedRelevantPostIds.length; i += chunkSize) {
      var chunk = sortedRelevantPostIds.sublist(
        i,
        i + chunkSize > sortedRelevantPostIds.length
            ? sortedRelevantPostIds.length
            : i + chunkSize,
      );
      // print(chunk);

      final snapshot = await FirebaseFirestore.instance
          .collection('postsNew')
          .where('postId', whereIn: chunk)
          .get();
      allPosts.addAll(snapshot.docs
          .map((doc) => PostsDataModel.fromJson(doc.data()))
          .toList());
      // print(allPosts);
    }

    yield allPosts;
  }

  @override
  void onClose() {
    _isDisposed = true;

    // Clean up WebSocket resources
    _closeWebSocket();

    // Cancel reconnection timers
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();

    // Dispose text controllers
    searchCtrl.dispose();

    // Clear data collections to free memory
    bitcoinData.clear();
    txDetails.clear();
    txDetailsFound.clear();
    txDetailsReset.clear();
    opReturns.clear();
    blockTransactions.clear();
    socketsData.clear();
    mempoolBlocks.clear();
    transaction.clear();
    transactionReplacements.clear();
    postsDataList?.clear();

    logger.i('HomeController disposed successfully');
    super.onClose();
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
