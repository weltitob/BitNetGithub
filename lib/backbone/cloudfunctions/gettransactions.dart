import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/models/userwallet.dart';

bool _canCallFunction = true;

dynamic getTransactions(UserWallet userWallet) async {
  if (!_canCallFunction) {
    print("CALL GET BALANCE CAN'T BE CALLED BECAUSE OF 10S TIMER");
    return; // exit if the function can't be called yet
  } else {
    try {
      print('CALL GET TRANSACTIONS...');
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('getTransactions');
      final resp = await callable.call(<String, dynamic>{
        'address': userWallet.walletAddress,
      });
      final mydata = CloudfunctionCallback.fromJson(resp.data);
      if (mydata.status == "success") {
        var encodedString = jsonDecode(mydata.message);
        print(encodedString);

        encodedString.forEach((element) async {
          final newTransaction = BitcoinTransaction.fromJson(element);
          //pushing to firebase
          await transactionCollection
              .doc(userWallet.useruid)
              .collection("all")
              .doc(newTransaction.transactionUid)
              .set(newTransaction.toMap());
        });
      } else {
        //mydata.status == error
        print('Die Antwortnachricht der Cloudfunktion war ein Error.');
        print(
            'Error: Keine success message wurde als Status angegeben: ${mydata.message}');
        //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
      }
    } catch (e) {
      print("Wir konnten die Balance nicht aktualisieren: ${e}");
    }
  }
  _canCallFunction = false;
  // start a Timer that will set the flag back to true after 5 seconds
  Timer(Duration(seconds: 10), () {
    _canCallFunction = true;
  });
}
