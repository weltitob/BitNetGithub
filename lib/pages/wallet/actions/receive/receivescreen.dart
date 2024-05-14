import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/lightning_receive_tab.dart';
import 'package:bitnet/pages/wallet/actions/receive/onchain_receive_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// This class is a StatefulWidget which displays a screen where a user can receive bitcoin
class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  // This method builds the UI for the ReceiveScreen
  final controller = Get.find<ReceiveController>();

  @override
  void initState() {
    super.initState();
    controller.amountController = TextEditingController();
    controller.amountController.text = "1000";
    controller.currController = TextEditingController();
    // Listen for changes
    controller.amountController.addListener(controller.updateAmountDisplay);
    //probably need to check if other keysend invoice is still available and if not create a new one make the logic unflawed
    controller.getInvoice(0, "");
    controller.getTaprootAddress();
    controller.duration = Duration(minutes: 20);
    controller.timer =
        Timer.periodic(Duration(seconds: 1), controller.updateTimer);
  }

  @override
  void dispose() {
    controller.amountController.removeListener(controller.updateAmountDisplay);
    controller.currController.dispose();
    controller.amountController.dispose();
    controller.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: "Bitcoin empfangen",
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
                            ? Icon(FontAwesomeIcons.cancel)
                            : Icon(FontAwesomeIcons.refresh),
                        title:
                            "${controller.min.value}:${controller.sec.value}",
                        onTap: () {
                          controller.getInvoice(
                              (double.parse(controller.amountController.text))
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
                      // Logs().w(
                      //     "Refresh button pressed: New Bitcoin Adress should be generated // not implemented yet");
                    });
          }),
          SizedBox(
            width: AppTheme.elementSpacing,
          ),
        ],
      ),
      // The screen's body
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go('/feed');
          print('ppop scope receive');
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          // The screen background is a gradient
          // Padding around the screen's contents
          child: Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 3.5,
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      controller.receiveType == ReceiveType.Lightning
                          ? GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                child: Text(
                                  ReceiveType.Lightning.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                controller.switchReceiveType();
                              },
                              child: Text(
                                ReceiveType.Lightning.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                      SizedBox(width: AppTheme.cardPadding),
                      controller.receiveType == ReceiveType.OnChain
                          ? GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                child: Text(
                                  ReceiveType.OnChain.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                controller.switchReceiveType();
                              },
                              child: Text(
                                ReceiveType.OnChain.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                    ],
                  ),
                );
              }),
              Expanded(
                child: Obx(() {
                  return controller.receiveType == ReceiveType.Lightning
                      ? LightningReceiveTab()
                      : OnChainReceiveTab();
                }),
              ),
            ],
          ),
        ),
      ),
      context: context,
    );
  }
}
