import 'dart:io';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/wallet/buy/controller/buy_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  late BuyController buyController;
  
  @override
  void initState() {
    super.initState();
    buyController = Get.find<BuyController>();
  }
  
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        hasBackButton: true,
        text: "Payment Methods",
        onTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
              child: Text(
                "Choose Payment Method",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            
            // Credit/Debit Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.05,
                child: BitNetListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                  text: "Credit or Debit Card",
                  onTap: () {
                    buyController.setPaymentMethod(
                      name: "Credit or Debit Card",
                      id: "credit_debit_card",
                    );
                    context.pop();
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(Icons.wallet_rounded),
                  ),
                  trailing: GetBuilder<BuyController>(
                    builder: (_) => buyController.paymentMethodId.value == "credit_debit_card"
                      ? Icon(Icons.check_circle, color: AppTheme.successColor)
                      : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            
            // Google Pay
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.05,
                child: BitNetListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                  text: "Google Pay",
                  onTap: () {
                    buyController.setPaymentMethod(
                      name: "Google Pay",
                      id: "google_play",
                    );
                    context.pop();
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(FontAwesomeIcons.google),
                  ),
                  trailing: GetBuilder<BuyController>(
                    builder: (_) => buyController.paymentMethodId.value == "google_play"
                      ? Icon(Icons.check_circle, color: AppTheme.successColor)
                      : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            
            // Apple Pay (iOS only)
            if (Platform.isIOS)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                  opacity: 0.05,
                  child: BitNetListTile(
                    contentPadding: EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                    text: "Apple Pay",
                    onTap: () {
                      buyController.setPaymentMethod(
                        name: "Apple Pay",
                        id: "apple_play",
                      );
                      context.pop();
                    },
                    leading: Icon(
                      FontAwesomeIcons.applePay,
                      size: 32,
                    ),
                    trailing: GetBuilder<BuyController>(
                      builder: (_) => buyController.paymentMethodId.value == "apple_play"
                        ? Icon(Icons.check_circle, color: AppTheme.successColor)
                        : SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            
            // PayPal
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.05,
                child: BitNetListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                  text: "PayPal",
                  onTap: () {
                    buyController.setPaymentMethod(
                      name: "PayPal",
                      id: "paypal",
                    );
                    context.pop();
                  },
                  leading: Icon(
                    FontAwesomeIcons.paypal,
                    size: 32,
                  ),
                  trailing: GetBuilder<BuyController>(
                    builder: (_) => buyController.paymentMethodId.value == "paypal"
                      ? Icon(Icons.check_circle, color: AppTheme.successColor)
                      : SizedBox.shrink(),
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