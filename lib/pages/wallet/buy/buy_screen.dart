import 'dart:async';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/cloudfunctions/moonpay/moonpay_quote_price.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/buy/controller/buy_controller.dart';
import 'package:bitnet/pages/wallet/buy/payment_methods_screen.dart';
import 'package:bitnet/pages/wallet/buy/providers_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:bitnet/services/moonpay.dart'
    if (dart.library.html) 'package:bitnet/services/moonpay_web.dart';
import 'package:provider/provider.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late BuyController buyController;

  @override
  void initState() {
    super.initState();
    // Initialize controller if not already injected
    if (!Get.isRegistered<BuyController>()) {
      Get.put(BuyController());
    }
    buyController = Get.find<BuyController>();
  }

  @override
  void dispose() {
    // Make sure timer is canceled when screen is disposed
    if (Get.isRegistered<BuyController>()) {
      Get.delete<BuyController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        hasBackButton: true,
        text: L10n.of(context)!.buy,
        onTap: () {
          // Use pop to go back to previous screen
          context.pop();
        },
        actions: [
          GetBuilder<BuyController>(
            builder: (_) => Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text("Next quote: ${buyController.quoteTimer.value}s"),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: AppTheme.cardPadding * 2),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: AmountWidget(
                    enabled: () => true,
                    btcController: buyController.btcController,
                    satController: buyController.satController,
                    currController: buyController.currController,
                    focusNode: buyController.focusNode,
                    context: context,
                    autoConvert: true,
                  ),
                ),
                SizedBox(height: 30),

                // Payment Method Selection
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Method",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      GetBuilder<BuyController>(
                        builder: (_) => GlassContainer(
                          opacity: 0.05,
                          child: BitNetListTile(
                            contentPadding: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 16.0),
                            text: buyController.paymentMethodName.value,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentMethodsScreen(),
                              ),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _getPaymentMethodIcon(
                                  buyController.paymentMethodId.value),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Provider Selection
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Provider",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      GetBuilder<BuyController>(
                        builder: (_) => GlassContainer(
                          opacity: 0.05,
                          child: BitNetListTile(
                            contentPadding: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 16.0),
                            text: buyController.providerName.value,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProvidersScreen(),
                              ),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _getProviderIcon(
                                  buyController.providerId.value),
                            ),
                            trailing: buyController.providerId.value ==
                                        "moonpay" &&
                                    buyController.moonpayQuoteCurrPrice.value >
                                        0
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(buyController
                                              .moonpayQuoteCurrPrice.value
                                              .toString()),
                                          Icon(getCurrencyIcon(
                                              BitcoinUnits.BTC.name))
                                        ],
                                      ),
                                      Text(
                                          "= ${buyController.moonpayBaseCurrPrice.value.toStringAsFixed(2)} ${getCurrency(currency ?? 'USD')}")
                                    ],
                                  )
                                : Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100), // Space for the button at bottom
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GetBuilder<BuyController>(
                builder: (_) => LongButtonWidget(
                  customWidth: MediaQuery.of(context).size.width * 0.9,
                  title: "Buy Bitcoin",
                  onTap: () async {
                    if (buyController.providerId.value == "stripe") {
                      // Stripe implementation
                    } else {
                      String lang =
                          Provider.of<LocalProvider>(context, listen: false)
                              .locale
                              .languageCode;
                      double btcAmount =
                          double.tryParse(buyController.btcController.text) ??
                              0.0;
                      btcAmount = double.tryParse(btcAmount
                              .toStringAsFixed(5)
                              .replaceFirst(RegExp(r'\.?0+$'), '')) ??
                          0.0;

                      MoonpayFlutter().showMoonPay(
                          await getBtcAddress(),
                          btcAmount,
                          lang,
                          "btc",
                          0.0,
                          buyController.paymentMethodId.value);
                    }
                  },
                  buttonType: ButtonType.solid,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getPaymentMethodIcon(String methodId) {
    switch (methodId) {
      case "credit_debit_card":
        return Icon(Icons.wallet_rounded);
      case "google_play":
        return Icon(FontAwesomeIcons.google);
      case "apple_play":
        return Icon(FontAwesomeIcons.applePay, size: 32);
      case "paypal":
        return Icon(FontAwesomeIcons.paypal, size: 32);
      default:
        return Icon(Icons.payment);
    }
  }

  Widget _getProviderIcon(String providerId) {
    switch (providerId) {
      case "stripe":
        return Image.asset(
          'assets/images/stripe.png',
          width: 32,
          height: 32,
        );
      case "moonpay":
        return Image.asset(
          'assets/images/moonpay.png',
          width: 32,
          height: 32,
        );
      default:
        return Icon(Icons.account_balance);
    }
  }

  Future<String> getBtcAddress() async {
    String? addr = await nextAddr(Auth().currentUser!.uid);
    if (addr == null) {
      throw Exception("Failed to generate Bitcoin address");
    }
    BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
    Get.find<WalletsController>().btcAddresses.add(address.addr);
    LocalStorage.instance.setStringList(
        Get.find<WalletsController>().btcAddresses,
        "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");
    return address.addr;
  }
}
