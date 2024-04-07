import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/wallet/actions/receive/receive.dart';
import 'package:flutter/material.dart';


class CreateInvoice extends StatefulWidget {
  final ReceiveController controller;
  const CreateInvoice({super.key, required this.controller,});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}


class _CreateInvoiceState extends State<CreateInvoice> {

  @override
void initState() {
widget.controller.receiveState.addListener(() {
  setState((){});
});
super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
              left: AppTheme.cardPadding,),
          alignment: Alignment.centerLeft,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppTheme.cardPadding,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          child: AmountWidget(
            context: context,
            bitcoinUnit: widget.controller.bitcoinUnit,
            enabled: true,
            btcController: widget.controller.amountController,
            currController: TextEditingController(),
            focusNode: widget.controller.myFocusNode,
          ),
        ),
        SizedBox(height: AppTheme.cardPadding * 1,),
        Container(
          width: AppTheme.cardPadding * 12,
          child: FormTextField(
            controller: widget.controller.messageController,
            hintText: "Add a message...",
          ),
        ),
        SizedBox(height: AppTheme.cardPadding * 0.75,),
        LongButtonWidget(
            title: "Generate Invoice",
            customWidth: AppTheme.cardPadding * 12,
            onTap: (){
              widget.controller.getInvoice((double.parse(widget.controller.amountController.text)).toInt(), "");
            })
      ],
    );
  }
}
