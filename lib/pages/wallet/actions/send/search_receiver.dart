import 'dart:ffi';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SearchReceiver extends StatelessWidget {
  final SendController controller;
  const SearchReceiver({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: Column(
        children: [
          SearchFieldWidget(hintText: "Search", isSearchEnabled: true, handleSearch: controller.handleSearch),
          Expanded(
            child: SingleChildScrollView(
              child: Container(), // Ihre scrollbare Liste
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: AppTheme.cardPadding * 4),
            height: 90,
            color: Colors.red,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: AppTheme.cardPadding * 7.5,
                  child: FormTextField(
                    hintText: "Adresse kopieren",
                    // Unfocuses the input field when tapped outside of it
                    onTapOutside: (value) {
                    },
                    // Limits the length of the input to 40 characters
                    maxLength: 40,
                    // Adds a focus node for the input field
                    focusNode: controller.myFocusNodeAdress,
                    // Binds the controller to the text input
                    controller:
                    controller.bitcoinReceiverAdressController,
                    // Validates the address when the text input is submitted
                    onFieldSubmitted: (value) {
                      controller.validateAdress(value);
                    },
                    autofocus: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing, ),
                  child: LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 7.5,
                      onTap: () => VRouter.of(context).to('/wallet/send'),
                    title: 'Scan QR',
                  ),
                ),

                // A GestureDetector widget that navigates to a new page when tapped
                // GestureDetector(
                //     onTap: () => Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) =>
                //         const QrScanner(
                //           //isBottomButtonVisible: true,
                //         ),
                //       ),
                //     ),
                //     child: Container(
                //       width: AppTheme.cardPadding,
                //       height: AppTheme.cardPadding,
                //     )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
