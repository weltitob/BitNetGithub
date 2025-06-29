import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TransactionsController extends GetxController {
  // Reactive Variables
  var orderedTransactions = <Widget>[].obs;
  var transactionsLoaded = false.obs;
  var transactionsOrdered = false.obs;
  var isLoadingTransactionGroups = false.obs;
  var loadedActivityItems = 4.obs;

// Additional methods like handling paging can be added here
}
