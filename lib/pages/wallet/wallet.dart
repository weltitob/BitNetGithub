import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => WalletController();
}

class WalletController extends State<Wallet> {
  late final Future<LottieComposition> compositionSend;
  late final Future<LottieComposition> compositionReceive;
  late OnchainBalance onchainBalance = OnchainBalance(totalBalance: '', confirmedBalance: '', unconfirmedBalance: '', lockedBalance: '', reservedBalanceAnchorChan: '', accountBalance: '');
  late LightningBalance lightningBalance = LightningBalance(balance: '', pendingOpenBalance: '', localBalance: '', remoteBalance: '', unsettledLocalBalance: '', pendingOpenLocalBalance: '', unsettledRemoteBalance: '', pendingOpenRemoteBalance: '');
  bool visible = false;

  @override
  void initState() {
    super.initState();
    fetchOnchainWalletBalance();
    fetchLightingWalletBalance();
    compositionSend = loadComposition('assets/lottiefiles/senden.json');
    compositionReceive = loadComposition('assets/lottiefiles/erhalten.json');
    updatevisibility();
  }

  void updatevisibility() async {
    await compositionSend;
    await compositionReceive;
    var timer = Timer(Duration(milliseconds: 50),
            () {
          setState(() {
            visible = true;
          });
        }
    );
  }

  void fetchOnchainWalletBalance() async {
    try{
      RestResponse onchainBalanceRest = await walletBalance();
      OnchainBalance onchainBalance = OnchainBalance.fromJson(onchainBalanceRest.data);
      setState(() {
        this.onchainBalance = onchainBalance;
      });
    } catch (e) {
      print(e);
    }
  }

  void fetchLightingWalletBalance() async {
    try{
      RestResponse lightningBalanceRest = await channelBalance();
      LightningBalance lightningBalance = LightningBalance.fromJson(lightningBalanceRest.data);
      setState(() {
        this.lightningBalance = lightningBalance;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();

  Future<void> handleRefresh() async {
    // final userData = Provider.of<UserData>(context, listen: false);
    // final userWallet = userData.mainWallet;
    // await getBalance(userWallet);
    // await getTransactions(userWallet);
  }

  @override
  Widget build(BuildContext context) {
    return WalletScreen(controller: this);
  }
}
