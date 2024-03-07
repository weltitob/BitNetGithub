import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/wallet/actions/receive/receive.dart';
import 'package:flutter/material.dart';


class CreateInvoice extends StatelessWidget {
  final ReceiveController controller;
  const CreateInvoice({super.key, required this.controller,});

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
            bitcoinUnit: controller.bitcoinUnit,
            enabled: true,
            amountController: controller.amountController,
            focusNode: controller.myFocusNode,
          ),
        ),
        SizedBox(height: AppTheme.cardPadding * 1,),
        Container(
          width: AppTheme.cardPadding * 12,
          child: FormTextField(
            controller: controller.messageController,
            hintText: "Add a message...",
          ),
        ),
        SizedBox(height: AppTheme.cardPadding * 0.75,),
        LongButtonWidget(
            title: "Generate Invoice",
            customWidth: AppTheme.cardPadding * 12,
            onTap: (){
              controller.getInvoice((double.parse(controller.amountController.text) * 100000000).toInt(), "");
            })
      ],
    );
  }
}
