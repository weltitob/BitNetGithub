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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> with SingleTickerProviderStateMixin {
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
    controller.timer = Timer.periodic(Duration(seconds: 1), controller.updateTimer);
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
    double glassContainerLeftPosition = _tabController.animation!.value * (MediaQuery.of(context).size.width / 2 - AppTheme.cardPadding * 0.75);

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: "Receive Bitcoin",
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
                  title: "${controller.min.value}:${controller.sec.value}",
                  onTap: () {
                    controller.getInvoice((double.parse(controller.satController.text)).toInt(), "");
                    controller.timer.cancel();
                    controller.duration = Duration(minutes: 20);
                    controller.timer = Timer.periodic(Duration(seconds: 1), controller.updateTimer);
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
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 0),
                      left: glassContainerLeftPosition + AppTheme.elementSpacing,
                      child: GlassContainer(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppTheme.elementSpacing * 0.75, horizontal: AppTheme.elementSpacing * 2.5),
                          child: Text(
                                ReceiveType.Lightning.name,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppTheme.cardPadding * 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _tabController.animateTo(0);
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.bolt),
                                SizedBox(width: AppTheme.cardPadding * 0.25,),
                                Text(
                                  ReceiveType.Lightning.name,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppTheme.cardPadding * 2,),
                          InkWell(
                            onTap: () {
                              _tabController.animateTo(1);
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.bitcoin),
                                SizedBox(width: AppTheme.cardPadding * 0.25,),
                                Text(
                                  ReceiveType.OnChain.name,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
