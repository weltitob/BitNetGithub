import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/models/firebase/postsDataModel.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/models/mempool_models/txConfirmDetail.dart';
import 'package:bitnet/models/mempool_models/txPaginationModel.dart';
import 'package:bitnet/pages/transactions/model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
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
  int? blockHeight;
  RxBool isLoadingPage = false.obs;
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
  RxDouble scrollValue = 1250.0.obs;
  List<BlockData> bitcoinData = [];
  // List<BlockData> bitcoinDataHeight = [];
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

  @override
  void onInit() {
    super.onInit();
    allData();
  }

  allData() async {
    // for (int i = 0; i < 3; i++) {
    //   createPost(
    //       true, true, true, 'nftName$i', 'nftMainName$i', 'cryptoText$i');
    // }
    postsDataList = await fetchPosts();

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

  callApiWithDelay() async {
    print('callapi with delay called ');

    // timer =
    //     Timer.periodic(Duration(seconds: kDebugMode ? 1000 : 5), (timer) async {
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
    // });
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
      isLoading.value = false;
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
          currentTime.subtract(Duration(days: 7)).millisecondsSinceEpoch;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('postsNew')
          .where('createdAt', isGreaterThanOrEqualTo: oneWeekAgo)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              PostsDataModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e, tr) {
      print(e);
      print(tr);
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
        DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch;

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
        DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch;

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
    print(likeCountMap);
    print(clickCountMap);
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
    print(sortedRelevantPostIds);

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
      print(chunk);

      final snapshot = await FirebaseFirestore.instance
          .collection('postsNew')
          .where('postId', whereIn: chunk)
          .get();
      allPosts.addAll(snapshot.docs
          .map((doc) => PostsDataModel.fromJson(doc.data()))
          .toList());
      print(allPosts);
    }

    yield allPosts;
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
