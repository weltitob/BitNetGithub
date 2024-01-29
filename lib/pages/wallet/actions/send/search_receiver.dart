import 'dart:ffi';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';

class SearchReceiver extends StatefulWidget {
  const SearchReceiver({super.key});

  @override
  State<SearchReceiver> createState() => _SearchReceiverState();
}

class _SearchReceiverState extends State<SearchReceiver> {
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;

  TextEditingController bitcoinReceiverAdressController =
  TextEditingController(); // the controller for the Bitcoin receiver address text field

  @override
  void initState() {
    super.initState();
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
  }

  void validateAdress(String value) {
    if (value.isEmpty) {
      displaySnackbar(
          context, "Hmm. Diese Walletadresse scheint nicht zu existieren");
    }
    final isValid = isBitcoinWalletValid(value);
    if (isValid) {
      setState(() {

      });
    } else {
      displaySnackbar(
          context, "Hmm. Diese Walletadresse scheint nicht zu existieren");
    } //to indicate the input is valid
  }

  void handleSearch(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: Column(
        children: [
          SearchFieldWidget(hintText: "Search", isSearchEnabled: true, handleSearch: handleSearch),
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
                    focusNode: myFocusNodeAdress,
                    // Binds the controller to the text input
                    controller:
                    bitcoinReceiverAdressController,
                    // Validates the address when the text input is submitted
                    onFieldSubmitted: (value) {
                      validateAdress(value);
                    },
                    autofocus: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing, ),
                  child: LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 7.5,
                    onTap: () {
                      validateAdress(bitcoinReceiverAdressController.text);
                    },
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
