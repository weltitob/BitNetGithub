import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:BitNet/models/userwallet.dart';

bool _canCallFunction = true;

// function to get the balance of the user's wallet
dynamic getBalance(UserWallet userWallet) async {
  if (!_canCallFunction) {
    // if the function can't be called yet, exit the function
    print("CALL GET BALANCE CAN'T BE CALLED BECAUSE OF 10S TIMER");
    return;
  } else {
    try {
      // call the cloud function
      print('CALL GET BALANCE...');
      HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('getBalance');
      final resp = await callable.call(<String, dynamic>{
        'address': userWallet.walletAddress,
      });
      // parse the response data into a CloudfunctionCallback object
      final mydata = CloudfunctionCallback.fromJson(resp.data);

      // update the user's wallet balance in Firebase
      await usersCollection.doc(userWallet.userdid).update({
        "walletBalance": "${mydata.message}",
      });
      // log that the balance has been updated
      print('You successfully updatet the userbalance: ${mydata.message}');
    } catch (e) {
      // log any errors that occur while getting the balance
      print("Wir konnten die Balance nicht aktualisieren: ${e}");
    }
  }
  // set the flag to false so that the function can't be called again for 10 seconds
  _canCallFunction = false;

  // start a Timer that will set the flag back to true after 10 seconds
  Timer(Duration(seconds: 10), () {
    _canCallFunction = true;
  });
}