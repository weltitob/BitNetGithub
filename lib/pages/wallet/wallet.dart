import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
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
  late OnchainBalance onchainBalance = OnchainBalance(totalBalance: '0', confirmedBalance: '0', unconfirmedBalance: '0', lockedBalance: '0', reservedBalanceAnchorChan: '', accountBalance: '');
  late LightningBalance lightningBalance = LightningBalance(balance: '0', pendingOpenBalance: '0', localBalance: '0', remoteBalance: '0', unsettledLocalBalance: '0', pendingOpenLocalBalance: '', unsettledRemoteBalance: '', pendingOpenRemoteBalance: '');
  bool visible = false;

  String totalBalanceStr = "0";

  changeTotalBalanceStr(){
    // Assuming both values are strings and represent numerical values
    String confirmedBalanceStr = onchainBalance.confirmedBalance;
    String balanceStr = lightningBalance.balance;

    double confirmedBalance = double.parse(confirmedBalanceStr);
    double balance = double.parse(balanceStr);

    double totalBalance = confirmedBalance + balance;
    setState(() {
      this.totalBalanceStr = totalBalance.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchOnchainWalletBalance();
    fetchLightingWalletBalance();
  }

  void fetchOnchainWalletBalance() async {
    try{
      RestResponse onchainBalanceRest = await walletBalance();
      OnchainBalance onchainBalance = OnchainBalance.fromJson(onchainBalanceRest.data);
      setState(() {
        this.onchainBalance = onchainBalance;
      });
      changeTotalBalanceStr();
    } catch (e) {
      print(e);
    }
  }

  void showOverlay(BuildContext context) {
      var overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: AnimationController(
                  duration: const Duration(milliseconds: 300),
                  vsync: Navigator.of(context),
                )..forward(),
                curve: Curves.easeOut,
              ),
            ),
            child: Material(
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.green,
                child: Text(
                  'Transaction received!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );

      // Add the overlay entry to the overlay
      Overlay.of(context)?.insert(overlayEntry);

      // Remove the overlay entry after duration
      Future.delayed(Duration(seconds: 3), () {
        overlayEntry.remove();
      });
  }

  void fetchLightingWalletBalance() async {
    try{
      RestResponse lightningBalanceRest = await channelBalance();
      LightningBalance lightningBalance = LightningBalance.fromJson(lightningBalanceRest.data);
      setState(() {
        this.lightningBalance = lightningBalance;
      });
      changeTotalBalanceStr();
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


  @override
  Widget build(BuildContext context) {
    return WalletScreen(controller: this);
  }
}
