import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';

import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';

import 'package:bitnet/pages/wallet/actions/receive/widgets/address_listtile.dart';
import 'package:bitnet/pages/wallet/actions/receive/widgets/amount_listtile.dart';
import 'package:bitnet/pages/wallet/actions/receive/widgets/receive_qr.dart';
import 'package:bitnet/pages/wallet/actions/receive/widgets/receivetype_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
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
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final controller = Get.find<ReceiveController>();
  final logger = Get.find<LoggerService>();

  late Animation<double> _animation;
  late AnimationController _animationController;
  late StreamSubscription<ReceiveType> receiveTypeSub;

  @override
  void initState() {
    super.initState();

    // Get.put(ReceiveController(), permanent: true);

    final logger = Get.find<LoggerService>();

    controller.receiveType.listen((value) {
      logger.i('ReceiveType wurde aktualisiert: $value');
    });

    decodeNetwork();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Adjust duration as needed
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    controller.btcController = TextEditingController();
    controller.btcController.text = "0.00001";
    controller.satController = TextEditingController();
    controller.satController.text = "0";

    controller.currController = TextEditingController();
    controller.getInvoice(0, "");
    controller.getInvoiceCombined(0, "");
    controller.getBtcAddress();
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
  }

  void decodeNetwork() {
    // final logger = Get.find<LoggerService>();
    // final network = widget.routerState?.pathParameters['network'];
    //
    // logger.i('Current route: ${widget.routerState?.path}');
    // logger.i('Network: $network');
    //wenn das netzwerk onchain oder lightning is je nachdem den jeweiligen initaltab festlegen
    // if (network != null) {
    //   if (network == "onchain") {
    //     controller.receiveType.value == ReceiveType.OnChain_taproot;
    //   } else {
    //     controller.receiveType.value = ReceiveType.Lightning_b11;
    //     ;
    //   }
    // }
  }

  @override
  void dispose() {
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
    super.build(context);
    return Obx(() {
      final currentType = controller.receiveType.value;
      logger.i("ReceiveScreen: currentType: $currentType");

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
                    child: controller.receiveType ==
                            ReceiveType.Combined_b11_taproot
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
                                    size: AppTheme.elementSpacing * 1.5,
                                  ),
                            title:
                                "${controller.min.value}:${controller.sec.value}",
                            onTap: () {
                              controller.getBtcAddress();

                              controller.getInvoiceCombined(
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
                        : controller.receiveType == ReceiveType.Lightning_b11
                            ? LongButtonWidget(
                                customShadow: Theme.of(context).brightness ==
                                        Brightness.light
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
                                        size: AppTheme.elementSpacing * 1.5,
                                      ),
                                title:
                                    "${controller.min.value}:${controller.sec.value}",
                                onTap: () {
                                  controller.getInvoice(
                                      (double.parse(
                                              controller.satController.text))
                                          .toInt(),
                                      "");
                                  controller.timer.cancel();
                                  controller.duration =
                                      const Duration(minutes: 20);
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
                                  controller.getBtcAddress();
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
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding.h * 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: SingleChildScrollView(
                        child: controller.isUnlocked.value
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                //mainAxisSize: MainAxisSize.min,
                                // The contents of the screen are centered vertically
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: AppTheme.cardPadding * 2,
                                  ),
                                  ReceiveQRCode(),
                                  const SizedBox(
                                    height: AppTheme.cardPadding,
                                  ),
                                  AddressListTile(),
                                  AmountSpecifierListTile(),
                                  BitNetBottomSheetReceiveType(),
                                  const SizedBox(
                                    height: AppTheme.cardPadding * 2,
                                  ),
                                ],
                              )
                            : Container(
                                child: Text(
                                    "View with turbo channel to enable lightning recieve minimum send amount first time and fee."))),
                  ),
                ],
              ),
            ),
          ),
        ),
        context: context,
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
