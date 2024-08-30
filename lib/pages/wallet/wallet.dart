import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';

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
    return const WalletScreen();
  }
}
