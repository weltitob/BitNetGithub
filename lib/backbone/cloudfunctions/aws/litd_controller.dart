import 'package:flutter/material.dart';

//

//make a getx controller to use in the application

//having a check if the app is in test / debug mode and ifg so use our custom testbackend (edwins sever)

import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/listswaps.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LitdController extends BaseController {
  RxBool hideBalance = false.obs;
  RxBool showInfo = false.obs;
  RxBool coin = false.obs;
  final arguments = Get.arguments;
  RxString? selectedCurrency;

  RxString litd_baseurl= '${AppTheme.baseUrlLightningTerminal}'.obs;


  void setHideBalance({bool? hide}) {

  }


  void setSelectedCard(String card) {

  }

  void setAmtWidgetReversed(bool val) {

  }


  // Method to update the first currency and its corresponding Firestore document
  void setCurrencyType(bool type, {bool updateDatabase = true}) {

  }
  // Method to update the first currency and its corresponding Firestore document
  void setFirstCurrencyInDatabase(String currency) {

  }


  void handleFuturesCompleted(BuildContext context) {

  }


  @override
  void onInit() {

  }

  @override
  void dispose() {

  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}


