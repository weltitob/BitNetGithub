import 'package:bitnet/backbone/helper/theme/theme.dart';

import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final TabController controller = TabController(length: 2, vsync: this);

    return Stack(
      children: [
        TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.elementSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            controller.animateTo(0);
                          },
                        ),
                        Text(
                          L10n.of(context)!.purchaseBitcoin,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                        SizedBox(width: 32)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing * 2,
                  ),
                  Container(
                    height: 400,
                    child: ListView(
                      children: [
                        PaymentCardHorizontalWidget(
                            controller: controller, check: true),
                        SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        PaymentCardHorizontalWidget(
                          controller: controller,
                          forward: false,
                        ),
                        SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        PaymentCardHorizontalWidget(
                          controller: controller,
                          forward: false,
                        ),
                        SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        NewPaymentCardHorizontalWidget(
                            controller: controller)
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.elementSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            controller.animateTo(1);
                          },
                        ),
                        Text(
                          L10n.of(context)!.saveCard,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                        ),
                        SizedBox(width: 48)
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  CardFormField(
                      style: CardFormStyle(
                          textColor: Colors.white,
                          placeholderColor: Colors.white)),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LongButtonWidget(
                      title: L10n.of(context)!.saveCard,
                      onTap: () {},
                      customWidth: double.infinity,
                    ),
                  )
                ],
              )
            ]),
        BottomCenterButton(buttonTitle: "buttonTitle",
            buttonState: ButtonState.disabled,
            onButtonTap: () {})
      ],
    );
  }
}
