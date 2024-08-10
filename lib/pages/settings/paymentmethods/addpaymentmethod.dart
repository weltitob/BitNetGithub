import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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
                  // controller.animateTo(1);
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
    );
  }
}
