import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';

dynamic createWallet() async {
  final User? currentuser = Auth().currentUser;
  try {
    print('CALL WALLET...');
    HttpsCallable callable =
    FirebaseFunctions.instance.httpsCallable('createWallet');
    print("${currentuser!.email.toString()}"
        " und ${currentuser.uid.toString()} werden createWallet übergeben");
    final resp = await callable.call(<String, dynamic>{
      'email': "${currentuser.email.toString()}",
      'useruid': "${currentuser.uid.toString()}",
    });
    final mydata = CloudfunctionCallback.fromJson(resp.data);

    if (mydata.status == "success") {
      var encodedString = jsonDecode(mydata.message);
      final newWallet = UserWallet.fromJson(encodedString);
      await usersCollection.doc(currentuser.uid).set(newWallet.toMap());
      print('Successfully deployed wallet: ${newWallet.toMap()}');
      return newWallet;
    } else {
      //error in der cloudfunktion aufgetreten aber werte korrekt zurückgekommen
      print('Die Antowrtnachricht der Cloudfunktion war ein Error.');
      //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
    }
  } catch (e) {
    //error beim callen der cloudfunktion
    print("Wir konnten keine neue Wallet für dich erstellen: ${e}");
  }
}