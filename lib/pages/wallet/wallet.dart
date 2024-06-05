import 'dart:async';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  @override
  void initState() {
    super.initState();


    // WalletsController controller = Get.find<WalletsController>();
  }

  @override
  void dispose() {

    // WalletsController controller = Get.find<WalletsController>();
    // controller.loadMessageError = "";
    // controller.errorCount = 0;
    // controller.loadedFutures = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WalletScreen();
  }


}
