import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class CreateInvoice extends StatefulWidget {
 // final ReceiveController controller;
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}


class _CreateInvoiceState extends State<CreateInvoice> {
  final controller = Get.put(ReceiveController());


  @override
void initState() {
// controller.receiveState.addListener(() {
//   setState((){});
// });
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
        Obx(
           () {
            return Padding(
              padding: const EdgeInsets.only(
                top: AppTheme.cardPadding,
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding,
              ),
              child: AmountWidget(
                context: context,
                bitcoinUnit: controller.bitcoinUnit.value,
                enabled: true,
                btcController: controller.amountController,
                currController: controller.currController,
                focusNode: controller.myFocusNode,
              ),
            );
          }
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
              controller.getInvoice((double.parse(controller.amountController.text)).toInt(), "");
              context.pop();
            })
      ],
    );
  }
}