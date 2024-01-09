import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
          child: Text("Create Invoice", style: Theme.of(context).textTheme.titleMedium),
        ),
        SizedBox(height: AppTheme.cardPadding,),
        AmountWidget(),
      ],
    );
  }
}
