import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppTheme.cardPadding,
              right: AppTheme.cardPadding,
              top: AppTheme.elementSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // controller.animateTo(1);
                },
              ),
              Text(
                L10n.of(context)!.saveCard,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: 48)
            ],
          ),
        ),
        const SizedBox(height: 15),
        // CardFormField commented out to remove Stripe dependency
        // CardFormField(
        //     style: CardFormStyle(
        //         textColor: Colors.white,
        //         placeholderColor: Colors.white)),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LongButtonWidget(
            title: L10n.of(context)!.saveCard,
            onTap: () {},
            customWidth: double.infinity,
          ),
        )
      ],
    );
  }
}
