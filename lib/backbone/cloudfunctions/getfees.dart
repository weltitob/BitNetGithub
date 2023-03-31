import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';

// function to get the fees for the transaction
dynamic getFees({
  required UserWallet userWallet,
  required String receiver_address,
  required String amount_to_send,
  required String fee_size
}) async {
  print("GET FEES WAS TRIGGERED!");

  try {
    // Call the Firebase Cloud Function 'sendBitcoin'
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

    // Parse the response from the Cloud Function
    final mydata = CloudfunctionCallback.fromJson(resp.data);
    print(mydata.status);
    if (mydata.status == "success") {
      print('success message was awnser from getfees');

      // Decode the encoded JSON message in the response
      var encodedString = jsonDecode(mydata.message);
      print(encodedString);
    } else {
      // Handle error message from Cloud Function
      print(
          'Error: Keine success message wurde als Status von getFees angegeben: ${mydata
              .message}');
      //displaySnackbar(context, "Ein Fehler bei der Erstellung deiner Bitcoin Wallet ist aufgetreten");
    }
  } catch (e) {
    // Handle errors when calling the Cloud Function
    print('EIN FEHLR IST BEIM AUFRUF DER GETFEES CLOUD FUNKTION AUFGETRETEN');
    print("Der aufgetretene Error: $e");
  }
}