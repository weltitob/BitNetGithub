import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/getbalance.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/models/userwallet.dart';

dynamic sendBitcoin({
    required UserWallet userWallet,
    required String receiver_address,
    required String amount_to_send,
    required String fee_size}) async {
  try {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendBitcoin');
    final resp = await callable.call(<String, dynamic>{
      'sender_private_key': userWallet.privateKey,
      'sender_address': userWallet.walletAddress,
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

      print('Now pushing transaction to firestore... $newTransaction');
      String transactionuuid = uuid.v5(userWallet.walletAddress, newTransaction.timestampSent).toString();

      await transactionCollection
          .doc(userWallet.useruid)
          .collection("all")
          .doc(transactionuuid)
          .set(newTransaction.toMap());
      getBalance(userWallet);

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
