import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:flutter/material.dart';


class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
              left: AppTheme.cardPadding,),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text("Create Invoice", style: Theme.of(context).textTheme.titleMedium),
              SizedBox(width: AppTheme.elementSpacing / 2,),
              Icon(Icons.help_outline),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppTheme.cardPadding,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          child: AmountWidget(),
        ),
        SizedBox(height: AppTheme.cardPadding * 1,),
        Container(
          width: AppTheme.cardPadding * 12,
          child: FormTextField(
            hintText: "Add a message...",
          ),
        ),
        SizedBox(height: AppTheme.cardPadding * 0.75,),
        LongButtonWidget(
            title: "Generate Invoice",
            customWidth: AppTheme.cardPadding * 12,
            onTap: (){})
      ],
    );
  }
}
