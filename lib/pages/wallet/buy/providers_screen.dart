import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/buy/controller/buy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({Key? key}) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  late BuyController buyController;
  
  @override
  void initState() {
    super.initState();
    buyController = Get.find<BuyController>();
  }
  
  @override
  Widget build(BuildContext context) {
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        hasBackButton: true,
        text: "Payment Providers",
        onTap: () => Navigator.of(context).pop(),
        actions: [
          GetBuilder<BuyController>(
            builder: (_) => Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text("Next quote: ${buyController.quoteTimer.value}s"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text(
                "Choose Payment Provider",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            
            // Stripe
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.05,
                child: BitNetListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                  text: "Stripe",
                  onTap: () {
                    buyController.setProvider(
                      name: "Stripe",
                      id: "stripe",
                    );
                    Navigator.of(context).pop();
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/stripe.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  trailing: GetBuilder<BuyController>(
                    builder: (_) => buyController.providerId.value == "stripe"
                      ? Icon(Icons.check_circle, color: AppTheme.successColor)
                      : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            
            // MoonPay
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.05,
                child: BitNetListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                  text: "MoonPay",
                  onTap: () {
                    buyController.setProvider(
                      name: "MoonPay",
                      id: "moonpay",
                    );
                    Navigator.of(context).pop();
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/moonpay.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  trailing: GetBuilder<BuyController>(
                    builder: (_) {
                      if (buyController.providerId.value == "moonpay") {
                        if (buyController.moonpayQuoteCurrPrice.value > 0) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(buyController.moonpayQuoteCurrPrice.value.toString()),
                                  Icon(getCurrencyIcon(BitcoinUnits.BTC.name))
                                ],
                              ),
                              Text(
                                "= ${buyController.moonpayBaseCurrPrice.value.toStringAsFixed(2)} ${getCurrency(currency ?? 'USD')}")
                            ],
                          );
                        } else {
                          return Icon(Icons.check_circle, color: AppTheme.successColor);
                        }
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}