import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/lightning_receive_tab.dart';
import 'package:bitnet/pages/wallet/actions/receive/onchain_receive_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<ReceiveController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        controller.switchReceiveType();
      }
    });

    _tabController.animation?.addListener(() {
      setState(() {});
    });

    controller.btcController = TextEditingController();
    controller.btcController.text = "0.00001";
    controller.satController = TextEditingController();
    controller.satController.text = "0";

    controller.currController = TextEditingController();
    controller.getInvoice(0, "");
    controller.getTaprootAddress();
    controller.duration = Duration(minutes: 20);
    controller.timer =
        Timer.periodic(Duration(seconds: 1), controller.updateTimer);

    LoggerService logger = Get.find();

    //Onchain checking for transactions
    subscribeTransactionsStream().listen((restResponse) {
      logger.i("subscribeTransactionsStream got data: $restResponse");
      BitcoinTransaction bitcoinTransaction =
          BitcoinTransaction.fromJson(restResponse.data);

      showOverlayTransaction(
          context,
          "Onchain transaction settled",
          TransactionItemData(
            amount: bitcoinTransaction.amount.toString(),
            timestamp: bitcoinTransaction.timeStamp,
            type: TransactionType.onChain,
            fee: 0,
            status: TransactionStatus.confirmed,
            direction: TransactionDirection.received,
            receiver: bitcoinTransaction.destAddresses[0],
            txHash: bitcoinTransaction.txHash ?? 'null',
          ));
      //});
    }, onError: (error) {
      logger.e("Received error for Transactions-stream: $error");
    });
    //LIGHTNING
    //Lightning payments
    subscribeInvoicesStream().listen((restResponse) {
      logger.i("Received data from Invoice-stream: $restResponse");
      final result = restResponse.data["result"];
      logger.i("Result: $result");
      ReceivedInvoice receivedInvoice = ReceivedInvoice.fromJson(result);
      if (receivedInvoice.settled == true) {
        logger.i("showOverlay should be triggered now");
        showOverlayTransaction(
          context,
          "Lightning invoice settled",
          TransactionItemData(
            amount: receivedInvoice.amtPaidSat.toString(),
            timestamp: receivedInvoice.settleDate,
            type: TransactionType.lightning,
            fee: 0,
            status: TransactionStatus.confirmed,
            direction: TransactionDirection.received,
            receiver: receivedInvoice.paymentRequest ?? "Yourself",
            txHash: receivedInvoice.rHash ?? "forwarded trough lightning",
          ),
        );
        //generate a new invoice for the user with 0 amount
        logger.i("Generating new empty invoice for user");
        ReceiveController(context).getInvoice(0, "Empty invoice");
      } else {
        logger.i(
            "Invoice received but not settled yet: ${receivedInvoice.settled}");
      }
    }, onError: (error) {
      logger.e("Received error for Invoice-stream: $error");
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.currController.dispose();
    controller.btcController.dispose();
    controller.satController.dispose();
    controller.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double glassContainerLeftPosition = _tabController.animation!.value *
        (MediaQuery.of(context).size.width / 2.5 - AppTheme.cardPadding * .5);

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: L10n.of(context)!.receiveBitcoin,
        onTap: () {
          context.go('/feed');
        },
        actions: [
          Obx(() {
            return controller.receiveType == ReceiveType.Lightning
                ? Obx(() {
                    return LongButtonWidget(
                        buttonType: ButtonType.transparent,
                        customHeight: AppTheme.cardPadding * 1.5,
                        customWidth: AppTheme.cardPadding * 4,
                        leadingIcon: controller.createdInvoice.value
                            ? Icon(FontAwesomeIcons.cancel,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppTheme.black60
                                    : AppTheme.white80)
                            : Icon(FontAwesomeIcons.refresh,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppTheme.black60
                                    : AppTheme.white80),
                        title:
                            "${controller.min.value}:${controller.sec.value}",
                        onTap: () {
                          controller.getInvoice(
                              (double.parse(controller.satController.text))
                                  .toInt(),
                              "");
                          controller.timer.cancel();
                          controller.duration = Duration(minutes: 20);
                          controller.timer = Timer.periodic(
                              Duration(seconds: 1), controller.updateTimer);
                        });
                  })
                : RoundedButtonWidget(
                    size: AppTheme.cardPadding * 1.5,
                    buttonType: ButtonType.transparent,
                    iconData: FontAwesomeIcons.refresh,
                    onTap: () {
                      controller.getTaprootAddress();
                    });
          }),
          SizedBox(
            width: AppTheme.elementSpacing,
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go('/feed');
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding.h * 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Container(
                  height: AppTheme.cardPadding * 2,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bolt),
                          SizedBox(
                            width: AppTheme.cardPadding * 0.25,
                          ),
                          Text(
                            ReceiveType.Lightning.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bitcoin),
                          SizedBox(
                            width: AppTheme.cardPadding * 0.25,
                          ),
                          Text(
                            ReceiveType.OnChain.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                    labelStyle: Theme.of(context).textTheme.headlineSmall,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    unselectedLabelColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LightningReceiveTab(),
                    OnChainReceiveTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      context: context,
    );
  }
}
