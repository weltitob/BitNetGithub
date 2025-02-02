import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/lightning_send_tab.dart';
import 'package:bitnet/pages/wallet/actions/send/onchain_send_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bip21SendTab extends StatefulWidget {
  const Bip21SendTab({super.key});

  @override
  State<Bip21SendTab> createState() => _Bip21SendTabState();
}

class _Bip21SendTabState extends State<Bip21SendTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight * 1.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TabBar(
                padding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 8),
                dividerColor: AppTheme.colorGlassContainer,
                indicator: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                tabs: [
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Onchain",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        "Lightning",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(
              children: [OnChainSendTab(), LightningSendTab()],
            ),
          ),
        ],
      ),
    );
  }
}
