import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';

dynamic getFees({
  required UserWallet userWallet,
  required String receiver_address,
  required String amount_to_send,
  required String fee_size}) async {
  print("GET FEES WAS TRIGGERED!");
  try {
    HttpsCallable callable =
    FirebaseFunctions.instance.httpsCallable('sendBitcoin');
    final resp = await callable.call(<String, dynamic>{
      'sender_private_key': userWallet.privateKey,
      'sender_address': userWallet.walletAddress,
      'receiver_address': receiver_address,
      'amount_to_send': amount_to_send,
      'fee_size': fee_size,
      'get_fees_only': true,
    });
    print("Das isch deine response: ${resp.data}");
    final mydata = CloudfunctionCallback.fromJson(resp.data);
    print(mydata.status);
    if (mydata.status == "success") {
      print('success message was awnser from getfees');
      var encodedString = jsonDecode(mydata.message);
      print(encodedString);

    } else {
      print('Error: Keine success message wurde als Status von getFees angegeben: ${mydata.message}');
      //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
    }
  } catch (e) {
    print('EIN FEHLR IST BEIM AUFRUF DER GETFEES CLOUD FUNKTION AUFGETRETEN');
    print("Der aufgetretene Error: $e");
  }
}
