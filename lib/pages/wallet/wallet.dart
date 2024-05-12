import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return WalletScreen();
  }
  @override
  void dispose() {
        WalletsController controller = Get.find<WalletsController>();
    controller.loadMessageError = "";
    controller.errorCount = 0;
    controller.loadedFutures=0;

    super.dispose();
  }
}
