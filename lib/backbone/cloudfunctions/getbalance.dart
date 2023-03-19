import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:provider/provider.dart';

dynamic getBalance(UserWallet userWallet) async {
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