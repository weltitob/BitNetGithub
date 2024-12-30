import 'dart:async';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

class TransactionsController extends GetxController {
  // Reactive Variables
  var orderedTransactions = <Widget>[].obs;
  var transactionsLoaded = false.obs;
  var transactionsOrdered = false.obs;
  var isLoadingTransactionGroups = false.obs;
  var loadedActivityItems = 4.obs;

// Additional methods like handling paging can be added here
}
