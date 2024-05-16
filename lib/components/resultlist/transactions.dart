import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:matrix/matrix.dart';

class Transactions extends StatefulWidget {
  bool fullList;
  Transactions({Key? key, this.fullList = false}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(WalletFilterController());

  bool transactionsLoaded = false;
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  final searchCtrl = TextEditingController();

  Future<bool> getOnchainTransactions() async {
    try {
    Logs().w("Getting onchain transactions");
    RestResponse restBitcoinTransactions = await getTransactions();
    BitcoinTransactionsList bitcoinTransactions =
        BitcoinTransactionsList.fromJson(restBitcoinTransactions.data);
    onchainTransactions = bitcoinTransactions.transactions;
    setState(() {});

    } on Error catch(_) {
      return false;
    } catch(e) {
      return false;
    }
    return true;
  }

  //what i sent on the lightning network
  Future<bool> getLightningPayments() async {
    try {
    Logs().w("Getting lightning payments");
    RestResponse restLightningPayments = await listPayments();
    LightningPaymentsList lightningPayments =
        LightningPaymentsList.fromJson(restLightningPayments.data);
    this.lightningPayments = lightningPayments.payments;
    setState(() {});

    } on Error catch(_) {
      return false;
    } catch(e) {
      return false;
    }
    return true;
  }

  //what I received on the lightning network
  Future<bool> getLightningInvoices() async {
    Logs().w("Getting lightning invoices");
    try {

  RestResponse restLightningInvoices = await listInvoices();
    ReceivedInvoicesList lightningInvoices =
        ReceivedInvoicesList.fromJson(restLightningInvoices.data);
    List<ReceivedInvoice> settledInvoices =
        lightningInvoices.invoices.where((invoice) => invoice.settled).toList();
    this.lightningInvoices = settledInvoices;
    setState(() {});

    }on Error catch(_) {
      return false;
    } catch(e) {
      return false;
    } 
    return true;
  
  }

  // Subscriptions

  @override
  void initState() {
    Logs().i("Initializing transactions page");
    super.initState();
    setState(() {
      transactionsLoaded = false;
    });
    int futuresCompleted = 0;
    int errorCount=0;
    String errorMessage = "";
    getOnchainTransactions().then((value) {
      futuresCompleted++;
      if(!value) {
        errorCount++;
        errorMessage = "Failed to load Onchain Transactions";
        }
       
      if(futuresCompleted == 3) {
         setState(() {
      transactionsLoaded = true;
    });      
          handlePageLoadErrors(errorCount, errorMessage, context);
          }
      

    });


    getLightningPayments().then((value) {
                      futuresCompleted++;
      if(!value) {
        errorCount++;
        errorMessage = "Failed to load Lightning Payments";
        }
       
      if(futuresCompleted == 3) {
         setState(() {
      transactionsLoaded = true;
    });      
          handlePageLoadErrors(errorCount, errorMessage, context);
          }
      
    });

 
     
    getLightningInvoices().then((value) {
                futuresCompleted++;
      if(!value) {
        errorCount++;
        errorMessage = "Failed to load Lightning Invoices";
        }
       
      if(futuresCompleted == 3) {
         setState(() {
      transactionsLoaded = true;
    });      
          handlePageLoadErrors(errorCount, errorMessage, context);
          }
      
    });

   

  }
    void handlePageLoadErrors(int errorCount, String errorMessage, BuildContext context) {
      if(errorCount == 1) {
        showOverlay(context, errorMessage, color: AppTheme.errorColor);
      } else if(errorCount > 1) {
        showOverlay(context, "Failed to load certain data in this page, please try again later", color: AppTheme.errorColor);
      }
    }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var combinedTransactions = controller.selectedFilters.contains('Lightning')
        ? [
            ...lightningInvoices.map((transaction) => TransactionItem(
                context: context,
                data: TransactionItemData(
                  timestamp: transaction.settleDate,
                  type: TransactionType.lightning,
                  direction: TransactionDirection.received,
                  receiver: transaction.paymentRequest.toString(),
                  txHash: transaction.value.toString(),
                  amount: "+" + transaction.amtPaid.toString(),
                  fee: 0,
                  status: transaction.settled
                      ? TransactionStatus.confirmed
                      : TransactionStatus.failed,

                  // other properties
                ))),
            ...lightningPayments.map((transaction) => TransactionItem(
                context: context,
                data: TransactionItemData(
                  timestamp: transaction.creationDate,
                  type: TransactionType.lightning,
                  direction: TransactionDirection.sent,
                  receiver: transaction.paymentHash.toString(),
                  txHash: transaction.paymentHash.toString(),
                  amount: "-" + transaction.valueSat.toString(),
                  fee: transaction.fee,
                  status: transaction.status == "SUCCEEDED"
                      ? TransactionStatus.confirmed
                      : transaction.status == "FAILED"
                          ? TransactionStatus.failed
                          : TransactionStatus.pending,
                ))),
          ].toList()
        : controller.selectedFilters.contains('Onchain')
            ? [
                ...onchainTransactions.map((transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.timeStamp,
                      status: transaction.numConfirmations > 0
                          ? TransactionStatus.confirmed
                          : TransactionStatus.pending,
                      type: TransactionType.onChain,
                      direction: transaction.amount.contains("-")
                          ? TransactionDirection.sent
                          : TransactionDirection.received,
                      receiver: transaction.amount.contains("-")
                          ? transaction.destAddresses.last.toString()
                          : transaction.destAddresses.first.toString(),
                      txHash: transaction.txHash.toString(),
                      fee: 0,
                      amount: transaction.amount.contains("-")
                          ? transaction.amount.toString()
                          : "+" + transaction.amount.toString(),
                    ))),
              ].toList()
            : [
                ...lightningInvoices.map((transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.settleDate,
                      type: TransactionType.lightning,
                      direction: TransactionDirection.received,
                      receiver: transaction.paymentRequest.toString(),
                      txHash: transaction.value.toString(),
                      amount: "+" + transaction.amtPaid.toString(),
                      fee: 0,
                      status: transaction.settled
                          ? TransactionStatus.confirmed
                          : TransactionStatus.failed,

                      // other properties
                    ))),
                ...lightningPayments.map((transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.creationDate,
                      type: TransactionType.lightning,
                      direction: TransactionDirection.sent,
                      receiver: transaction.paymentHash.toString(),
                      txHash: transaction.paymentHash.toString(),
                      amount: "-" + transaction.valueSat.toString(),
                      fee: transaction.fee,
                      status: transaction.status == "SUCCEEDED"
                          ? TransactionStatus.confirmed
                          : transaction.status == "FAILED"
                              ? TransactionStatus.failed
                              : TransactionStatus.pending,
                    ))),
                ...onchainTransactions.map((transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.timeStamp,
                      status: transaction.numConfirmations > 0
                          ? TransactionStatus.confirmed
                          : TransactionStatus.pending,
                      type: TransactionType.onChain,
                      direction: transaction.amount.contains("-")
                          ? TransactionDirection.sent
                          : TransactionDirection.received,
                      receiver: transaction.amount.contains("-")
                          ? transaction.destAddresses.last.toString()
                          : transaction.destAddresses.first.toString(),
                      txHash: transaction.txHash.toString(),
                      fee: 0,
                      amount: transaction.amount.contains("-")
                          ? transaction.amount.toString()
                          : "+" + transaction.amount.toString(),
                    ))),
              ].toList();

    combinedTransactions
        .sort((a, b) => a.data.timestamp.compareTo(b.data.timestamp));
    combinedTransactions = combinedTransactions.reversed.toList();

    return transactionsLoaded
        ? widget.fullList
            ? bitnetScaffold(
                context: context,
                extendBodyBehindAppBar: true,
                appBar: bitnetAppBar(
                  context: context,
                  text: 'Activity',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      //SizedBox(height: 80,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        child: SearchFieldWidget(
                          // controller: searchCtrl,
                          hintText: 'Search',
                          handleSearch: (v) {
                            setState(() {
                              searchCtrl.text = v;
                            });
                          },
                          suffixIcon: IconButton(
                              // size: AppTheme.cardPadding * 1.25,
                              // buttonType: ButtonType.transparent,
                              icon: Icon(FontAwesomeIcons.filter),
                              onPressed: () async {
                                await BitNetBottomSheet(
                                    context: context,
                                    child: WalletFilterScreen());
                                setState(() {});
                              }),
                          isSearchEnabled: true,
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: combinedTransactions.length,
                              itemBuilder: (context, index) {
                                print(controller.selectedFilters.toJson());
                                if (controller.selectedFilters
                                    .contains('Sent') && controller.selectedFilters
                                    .contains('Received')) {
                                  return combinedTransactions[index];
                                }
                                if (controller.selectedFilters
                                    .contains('Sent')) {
                                  return combinedTransactions[index]
                                          .data
                                          .amount
                                          .contains('-')
                                      ? combinedTransactions[index]
                                      : SizedBox();
                                }
                                if (controller.selectedFilters
                                    .contains('Received')) {
                                  return combinedTransactions[index]
                                          .data
                                          .amount
                                          .contains('+')
                                      ? combinedTransactions[index]
                                      : SizedBox();
                                }
                                return combinedTransactions[index]
                                        .data
                                        .receiver
                                        .contains(searchCtrl.text.toLowerCase())
                                    ? combinedTransactions[index]
                                    : SizedBox();
                              }))
                    ],
                  ),
                ))
            : Container(
                height: AppTheme.cardPadding * 18,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: combinedTransactions.length > 5
                        ? 5
                        : combinedTransactions.length,
                    itemBuilder: (context, index){
                      print(controller.selectedFilters.toJson());
                      if (controller.selectedFilters
                          .contains('Sent') && controller.selectedFilters
                          .contains('Received')) {
                        return combinedTransactions[index];
                      }
                      if (controller.selectedFilters
                          .contains('Sent')) {
                        return combinedTransactions[index]
                            .data
                            .amount
                            .contains('-')
                            ? combinedTransactions[index]
                            : SizedBox();
                      }
                      if (controller.selectedFilters
                          .contains('Received')) {
                        return combinedTransactions[index]
                            .data
                            .amount
                            .contains('+')
                            ? combinedTransactions[index]
                            : SizedBox();
                      }
                      return combinedTransactions[index]
                          .data
                          .receiver
                          .contains(searchCtrl.text.toLowerCase())
                          ? combinedTransactions[index]
                          : SizedBox();
                    }))
        : Container(
            height: AppTheme.cardPadding * 18,
            child: dotProgress(context),
          );
  }
  
 
}
