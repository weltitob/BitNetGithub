import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:provider/provider.dart';

bool _canCallFunction = true;

dynamic getBalance(UserWallet userWallet) async {
  if (!_canCallFunction) {
    return; // exit if the function can't be called yet
  } else{
    try {
      print('CALL GET BALANCE...');
      HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('getBalance');
      final resp = await callable.call(<String, dynamic>{
        'address': userWallet.walletAddress,
      });
      final mydata = CloudfunctionCallback.fromJson(resp.data);
      //pushing to firebase
      await usersCollection.doc(userWallet.useruid).update({
        "walletBalance": "${mydata.message}",
      });
      final test = Auth().currentUser;
      print('You successfully updatet the userbalance: ${mydata.message}');
    } catch (e) {
      print("Wir konnten die Balance nicht aktualisieren: ${e}");
    }
  }
  _canCallFunction = false;
  // start a Timer that will set the flag back to true after 5 seconds
  Timer(Duration(seconds: 5), () {
    _canCallFunction = true;
  });
}