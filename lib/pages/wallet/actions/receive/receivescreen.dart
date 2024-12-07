import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
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
  final GoRouterState? routerState;
  const ReceiveScreen({Key? key, this.routerState}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen>
    with TickerProviderStateMixin {
  final controller = Get.find<ReceiveController>();
  late TabController _tabController;
  double oldOffset = 0.0;
  late Animation<double> _animation;
  late AnimationController _animationController;
  late StreamSubscription<ReceiveType> receiveTypeSub;
  bool tappedOffset = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    controller.receiveType.value = ReceiveType.Lightning;
    decodeNetwork();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        tappedOffset = true;
        controller.switchReceiveType();
      }
    });
    _tabController.animation?.addListener(() {
      if (_tabController.offset == 0.0 || _tabController.offset == -0.0) {
        if (tappedOffset) {
          tappedOffset = false;
        }
      } else if (tappedOffset) {
      } else if (!_tabController.offset.isNegative &&
          _tabController != 0.0 &&
          _tabController.offset > 0.5) {
        controller.receiveType.value = ReceiveType.OnChain;
      } else if (!_tabController.offset.isNegative &&
          _tabController != 0.0 &&
          _tabController.offset < 0.5) {
        controller.receiveType.value = ReceiveType.Lightning;
      } else if (_tabController.offset.isNegative &&
          _tabController != 0.0 &&
          _tabController.offset < -0.5 &&
          !(_tabController.offset < -1.5)) {
        controller.receiveType.value = ReceiveType.Lightning;
      } else if (_tabController.offset.isNegative &&
          _tabController != 0.0 &&
          _tabController.offset > -0.5) {
        controller.receiveType.value = ReceiveType.OnChain;
      }
    });

    // _tabController.animation?.addListener(() {
    //   setState(() {});
    // });

    controller.btcController = TextEditingController();
    controller.btcController.text = "0.00001";
    controller.satController = TextEditingController();
    controller.satController.text = "0";

    controller.currController = TextEditingController();
    controller.getInvoice(0, "");
    controller.getTaprootAddress();
    //im not sure if the timer should reset each time the page is open or if it is a bug. (assuming it is a bug for now.)
    if ((controller.duration.inSeconds <= 0)) {
      controller.duration = const Duration(minutes: 20);
      controller.timer =
          Timer.periodic(const Duration(seconds: 1), controller.updateTimer);
    }
    _animationController.forward();
    receiveTypeSub = controller.receiveType.listen((data) {
      // Restart the animation whenever the receiveType changes
      _animationController.reset();
      _animationController.forward();
    });

    LoggerService logger = Get.find();

    //Onchain checking for transactions
    subscribeTransactionsStream().listen((restResponse) {
      logger.i("subscribeTransactionsStream got data: $restResponse");
      BitcoinTransaction bitcoinTransaction =
          BitcoinTransaction.fromJson(restResponse.data);
      sendPaymentDataOnchainReceived(restResponse.data);

      if (Get.overlayContext != null && Get.overlayContext!.mounted)
        showOverlayTransaction(
            Get.overlayContext!,
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
        sendPaymentDataInvoiceReceived(restResponse.data);

        logger.i("showOverlay should be triggered now");
        if (Get.overlayContext != null && Get.overlayContext!.mounted)
          showOverlayTransaction(
            Get.overlayContext!,
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
        if (Get.context != null && Get.context!.mounted)
          ReceiveController(Get.context!).getInvoice(0, "Empty invoice");
      } else {
        logger.i(
            "Invoice received but not settled yet: ${receivedInvoice.settled}");
      }
    }, onError: (error) {
      logger.e("Received error for Invoice-stream: $error");
    });
  }

  void decodeNetwork() {
    print("DECODE NETWORK");
    final network = widget.routerState?.pathParameters['network'];

    print('Current route: ${widget.routerState?.path}');
    print('Network: $network');
    //wenn das netzwerk onchain oder lightning is je nachdem den jeweiligen initaltab festlegen
    if (network != null) {
      if (network == "onchain") {
        _tabController.index = 1;
      } else {
        _tabController.index = 0;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    controller.currController.dispose();
    controller.btcController.dispose();
    controller.satController.dispose();
    receiveTypeSub.cancel();

    //controller.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.horizontal,
                  axisAlignment:
                      -1.0, // Adjust to control the direction of the animation
                  child: controller.receiveType.value == ReceiveType.Lightning
                      ? LongButtonWidget(
                          customShadow:
                              Theme.of(context).brightness == Brightness.light
                                  ? []
                                  : null,
                          buttonType: ButtonType.transparent,
                          customHeight: AppTheme.cardPadding * 1.5,
                          customWidth: AppTheme.cardPadding * 4,
                          leadingIcon: controller.createdInvoice.value
                              ? Icon(
                                  FontAwesomeIcons.cancel,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.black60
                                      : AppTheme.white80,
                                )
                              : Icon(
                                  FontAwesomeIcons.refresh,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.black60
                                      : AppTheme.white80,
                                ),
                          title:
                              "${controller.min.value}:${controller.sec.value}",
                          onTap: () {
                            controller.getInvoice(
                                (double.parse(controller.satController.text))
                                    .toInt(),
                                "");
                            controller.timer.cancel();
                            controller.duration = const Duration(minutes: 20);
                            controller.timer = Timer.periodic(
                                const Duration(seconds: 1),
                                controller.updateTimer);
                          },
                        )
                      : RoundedButtonWidget(
                          size: AppTheme.cardPadding * 1.5,
                          buttonType: ButtonType.transparent,
                          iconData: FontAwesomeIcons.refresh,
                          onTap: () {
                            controller.getTaprootAddress();
                          },
                        ),
                ),
              ],
            );
          }),
          const SizedBox(
            width: AppTheme.elementSpacing / 2,
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
              Container(
                height: AppTheme.cardPadding * 2,
                child: TabBar.secondary(
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 2),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  tabs: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.bolt,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.black80
                                  : AppTheme.white80,
                        ),
                        const SizedBox(
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
                        Icon(FontAwesomeIcons.bitcoin,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black80
                                    : AppTheme.white80),
                        const SizedBox(
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
                    borderRadius: AppTheme.cardRadiusMid,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white.withOpacity(1)
                        : Colors.white.withOpacity(0.1),
                  ),
                  unselectedLabelColor: Colors.white,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const LightningReceiveTab(),
                    const OnChainReceiveTab(),
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

  void sendPaymentDataInvoiceReceived(Map<String, dynamic> data) {
    btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').add(data);
  }

  void sendPaymentDataOnchainReceived(Map<String, dynamic> data) {
    btcReceiveRef.doc(Auth().currentUser!.uid).collection('onchain').add(data);
  }
}
