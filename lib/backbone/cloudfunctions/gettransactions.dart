import 'dart:convert';

import 'package:bitnet/models/bitcoin/transaction.dart';
import 'package:bitnet/models/firebase/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/models/user/userwallet.dart';

bool _canCallFunction = true; // Flag to check whether function can be called or not

// function that gets the transaction
dynamic getTransactions(UserWallet userWallet) async {
  if (!_canCallFunction) { // Check if function can be called
    print("CALL GET BALANCE CAN'T BE CALLED BECAUSE OF 10S TIMER");
    return; // Exit if function can't be called yet
  } else {
    try {
      print('CALL GET TRANSACTIONS...');
      HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('getTransactions');
      final resp = await callable.call(<String, dynamic>{
        'address': userWallet.walletAddress,
      });
      final mydata = CloudfunctionCallback.fromJson(resp.data);
      if (mydata.statusCode == "success") { // Check if response was successful
        var encodedString = jsonDecode(mydata.message);
        print("Encoded get Transactions response: $encodedString");

        encodedString.forEach((element) async {
          final newTransaction = BitcoinTransaction.fromJson(element);
          //pushing to firebase
          await transactionCollection
              .doc(userWallet.userdid)
              .collection("all")
              .doc(newTransaction.transactionUid)
              .set(newTransaction.toMap());
        });
      } else {
        //mydata.status == error
        print('Die Antwortnachricht der Cloudfunktion war ein Error.');
        print(
            'Error: Keine success message wurde als Status angegeben: ${mydata
                .message}');
        //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
      }
    } catch (e) {
      print("Wir konnten die Balance nicht aktualisieren: ${e}");
    }
  }
  _canCallFunction = false; // Set the flag to false
  // Start a Timer that will set the flag back to true after 10 seconds
  Timer(Duration(seconds: 10), () {
    _canCallFunction = true;
  });
}