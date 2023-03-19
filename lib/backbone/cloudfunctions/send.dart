import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/transaction.dart';

dynamic sendBitcoin({
    required String sender_private_key,
    required String sender_address,
    required String receiver_address,
    required String amount_to_send,
    required String fee_size}) async {
  try {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendBitcoin');
    final resp = await callable.call(<String, dynamic>{
      'sender_private_key': sender_private_key,
      'sender_address': sender_address,
      'receiver_address': receiver_address,
      'amount_to_send': amount_to_send,
      'fee_size': fee_size,
    });
    print("Das isch deine response: ${resp.data}");
    print("noch ist alles gut 1...");
    final mydata = CloudfunctionCallback.fromJson(resp.data);
    print("noch ist alles gut 2...");
    print(mydata.status);
    if (mydata.status == "success") {
      print('success message was awnser');
      var encodedString = jsonDecode(mydata.message);
      print(encodedString);
      final newTransaction = BitcoinTransaction.fromJson(encodedString);
      return newTransaction;
    } else {
      print('Error: Keine success message wurde als Status angegeben: ${mydata.message}');
      //error in der cloudfunktion aufgetreten aber werte korrekt zurückgekommen
      print('Die Antwortnachricht der Cloudfunktion war ein Error.');
      //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
    }
  } catch (e) {
    print('EIN FEHLR IST BEIM AUFRUF DER CLOUD FUNKTION AUFGETRETEN');
    print(e);
  }
}
