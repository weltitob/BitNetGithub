import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
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
  double totalBalanceSAT = 0;

  @override
  void initState() {
    super.initState();

    subscribeInvoicesStream().listen((restResponse) {
      Logs().w("Received data from Invoice-stream: $restResponse");
      ReceivedInvoice receivedInvoice = ReceivedInvoice.fromJson(restResponse.data);
      if (receivedInvoice.settled == true) {
        showOverlayTransaction(context, "Lightning invoice settled", TransactionItemData(
          amount: receivedInvoice.amtPaidSat.toString(),
          timestamp: receivedInvoice.settleDate,
          type: TransactionType.lightning,
          status: TransactionStatus.confirmed,
          direction: TransactionDirection.received,
          receiver: receivedInvoice.paymentRequest,
          txHash: receivedInvoice.rHash,
        ));
      } else {
        Logs().w("Invoice received but not settled yet: ${receivedInvoice.settled}");
      }
    }, onError: (error) {
      Logs().e("Received error for Invoice-stream: $error");
    });

    subscribeTransactionsStream().listen((restResponse) {
      BitcoinTransaction bitcoinTransaction = BitcoinTransaction.fromJson(restResponse.data);
      showOverlayTransaction(context, "Onchain transaction settled", TransactionItemData(
        amount: bitcoinTransaction.amount.toString(),
        timestamp: bitcoinTransaction.timeStamp,
        type: TransactionType.onChain,
        status: TransactionStatus.confirmed,
        direction: TransactionDirection.received,
        receiver: bitcoinTransaction.destAddresses[0],
        txHash: bitcoinTransaction.txHash,
      ));
      //});
    }, onError: (error) {
      Logs().e("Received error for Transactions-stream: $error");
    });

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

    double confirmedBalanceSAT = double.parse(confirmedBalanceStr);
    double balanceSAT = double.parse(balanceStr);

    totalBalanceSAT = confirmedBalanceSAT + balanceSAT;

    BitcoinUnitModel bitcoinUnit = CurrencyConverter.convertToBitcoinUnit(totalBalanceSAT, BitcoinUnits.SAT);
    final balance = bitcoinUnit.amount;
    final unit = bitcoinUnit.bitcoinUnitAsString;

    setState(() {
      this.totalBalanceStr = balance.toString() + " " + unit;
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
