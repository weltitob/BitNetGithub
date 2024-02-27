import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matrix/matrix.dart';

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


  StreamSubscription<List<ReceivedInvoice>>? _invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? _transactionsSubscription;

  String totalBalanceStr = "0";




  @override
  void initState() {
    super.initState();
    subscribeInvoicesStream().listen((data) {
      Logs().w("Invoice-stream received data: $data");
      showOverlay(context, "Lightning invoice received");
    }, onError: (error) {
      Logs().e("Received error for Invoice-stream: $error");
    });

    subscribeTransactionsStream().listen((data) {
      Logs().w("Transactions-stream received data: $data");
    }, onError: (error) {
      Logs().e("Received error for Transactions-stream: $error");
    });
    fetchOnchainWalletBalance();
    fetchLightingWalletBalance();
  }


  void subscribeToInvoices() {
    _invoicesSubscription = subscribeInvoicesStream().map((restResponse) {
      ReceivedInvoicesList receivedInvoicesList = ReceivedInvoicesList.fromJson(restResponse.data);

      List<ReceivedInvoice> settledInvoices = receivedInvoicesList.invoices
          //.where((invoice) => invoice.settled)
          .toList();

      Logs().w("Setteled Invoices: $settledInvoices");

      return settledInvoices;
    }).listen((invoices) {
        setState(() {
        Logs().w("Updating lightning invoices...");
      });
    }, onError: (error) {
      print("Error subscribing to invoices: $error");
      setState(() {});
    });
  }

  void subscribeToTransactions() {
    // Assuming `subscribeTransactionsStream` is your method that returns a Stream<RestResponse>
    _transactionsSubscription =
        subscribeTransactionsStream().map((restResponse) {
          // Parse the `restResponse.data` to extract `List<BitcoinTransaction>`
          BitcoinTransactionsList bitcoinTransactionsList =
          BitcoinTransactionsList.fromJson(restResponse.data);
          return bitcoinTransactionsList.transactions;
        }).listen((transactions) {
          setState(() {
            Logs().w("Updating onChain transactions...");
            showOverlay(context, "New transaction received");
          });
        }, onError: (error) {
          Logs().e("Error subscribing to transactions: $error");
        });
    setState(() {});
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
  void dispose() {
    _invoicesSubscription?.cancel();
    _transactionsSubscription?.cancel();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return WalletScreen(controller: this);
  }
}
