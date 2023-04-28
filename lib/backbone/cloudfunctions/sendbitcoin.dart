import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:BitNet/backbone/cloudfunctions/getbalance.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:BitNet/models/transaction.dart';
import 'package:BitNet/models/userwallet.dart';

/*
The function takes in four required parameters: userWallet, receiver_address, amount_to_send, and fee_size.
If everything is valid it sends Bitcoin to the receiver_address.
 */
Future<CloudfunctionCallback> sendBitcoin({
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
      'get_fees_only': false,
    });

    // print response data
    print("Das isch deine response: ${resp.data}");
    print("noch ist alles gut 1...");

    // parse response data into CloudfunctionCallback object
    final mydata = CloudfunctionCallback.fromJson(resp.data);

    // print status of CloudfunctionCallback object
    print("noch ist alles gut 2...");
    print(mydata.statusCode);

    if (mydata.statusCode == "success") {
      print('success message was awnser');

      // decode message field of CloudfunctionCallback object into BitcoinTransaction object
      var encodedString = jsonDecode(mydata.message);
      print(encodedString);
      final newTransaction = BitcoinTransaction.fromJson(encodedString);

      // push transaction to firestore
      print('Now pushing transaction to firestore... $newTransaction');
      await transactionCollection
          .doc(userWallet.userdid)
          .collection("all")
          .doc(newTransaction.transactionUid)
          .set(newTransaction.toMap());

      // update user's balance after transaction is complete
      await getBalance(userWallet);

      print("Bitcoin senden ist alles erfolgreich durchgelaufen");
      return mydata;
    } else {
      // error in cloudfuntion occurred, but values returned correctly
      print('Error: Keine success message wurde als Status angegeben: ${mydata
          .message}');
      print('Die Antwortnachricht der Cloudfunktion war ein Error.');
      return mydata;
    }
  } catch (e) {
    // error occurred while calling cloud function
    print('EIN FEHLR IST BEIM AUFRUF DER CLOUD FUNKTION AUFGETRETEN');
    print(e);
    return CloudfunctionCallback(statusCode: "error",
        message: 'Ein interer Fehler ist aufgetreten, bitte versuche es später erneut', data: {});
  }
}
