import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class CreateInvoice extends GetWidget<ReceiveController> {
  bool onChain;
  CreateInvoice({this.onChain = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: AppTheme.cardPadding,
          ),
          alignment: Alignment.centerLeft,
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.only(
              top: AppTheme.cardPadding * 2,
              left: AppTheme.cardPadding,
              right: AppTheme.cardPadding,
            ),
            child: AmountWidget(
              context: context,
              bitcoinUnit: controller.bitcoinUnit.value,
              enabled: ()=>true,
              btcController: onChain ? controller.btcControllerOnChain : controller.btcController,
              satController:  onChain ? controller.satControllerOnChain : controller.satController,
              currController: controller.currController,
              autoConvert: true,
              focusNode: controller.myFocusNode,
                swapped: Get.find<WalletsController>().reversed.value,
            ),
          );
        }),
        const SizedBox(
          height: AppTheme.cardPadding * 1,
        ),
        Container(
          width: AppTheme.cardPadding * 12,
          child: FormTextField(
            controller: controller.messageController,
            hintText: L10n.of(context)!.addAMessage,
          ),
        ),
        const SizedBox(
          height: AppTheme.cardPadding * 0.75,
        ),
        LongButtonWidget(
            title: L10n.of(context)!.generateInvoice,
            customWidth: AppTheme.cardPadding * 12,
            onTap: () {
             controller.getBtcAddress();

              if(onChain){
                controller.getInvoice(
                    (double.parse(controller.satControllerOnChain.text)).toInt(), "");
              } else {
                controller.getInvoice(
                    (double.parse(controller.satController.text)).toInt(), "");
              }

              context.pop(true);


            })
      ],
    );
  }
}
