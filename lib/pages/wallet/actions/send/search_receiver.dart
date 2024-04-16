import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:go_router/go_router.dart';


class SearchReceiver extends StatelessWidget {
  final SendController controller;

  const SearchReceiver({super.key, required this.controller});



  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      appBar: bitnetAppBar(
        text: "Choose Recipient",
        context: context,
        onTap: () {
          context.pop();
        },
      ),
      context: context,
      body: Column(
        children: [
          SearchFieldWidget(
            hintText: "Empfänger suchen",
            isSearchEnabled: true,
            handleSearch: controller.handleSearch,
          ),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  // Ihre scrollbare Liste oder andere Widgets
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: AppTheme.cardPadding * 4),
            height: 85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: AppTheme.cardPadding * 7,
                  child: FormTextField(
                    hintText: "Kopieren",
                    onTapOutside: (value) {
                      // Unfocuses the input field when tapped outside of it
                    },
                    maxLength: 40,
                    focusNode: controller.myFocusNodeAdress,
                    controller: controller.bitcoinReceiverAdressController,
                    onFieldSubmitted: (value) {
                      Logs().w("Adress: $value");
                      controller.onQRCodeScanned(value, context);
                      //controller.validateAdress(value);
                    },
                    autofocus: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing),
                  child: LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 7,
                    onTap: () => context.go("/qrscanner"),
                    title: 'Scan QR',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
