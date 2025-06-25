import 'dart:convert';
import 'package:bitnet/models/bitcoin/fees.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';

// function to get the fees for the transaction
dynamic getFees({
  required String sender_address,
}) async {
  print("GET FEES WAS TRIGGERED!");

  try {
    // Call the Firebase Cloud Function 'sendBitcoin'
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendBitcoin');
    final resp = await callable.call(<String, dynamic>{
      'sender_private_key': "",
      'sender_address': sender_address,
      'receiver_address': "",
      'amount_to_send': "",
      'fee_size': "Niedrig",
      'get_fees_only': true,
    });

    // Parse the response from the Cloud Function
    final mydata = RestResponse.fromJson(resp.data);
    print(mydata.statusCode);
    if (mydata.statusCode == "success") {
      print('success message was awnser from getfees');
      // Decode the encoded JSON message in the response
      var encodedString = jsonDecode(mydata.message);
      print(encodedString);
      final fees = Fees.fromJson(encodedString);
      return fees;
    } else {
      // Handle error message from Cloud Function
      print(
          'Error: Keine success message wurde als Status von getFees angegeben: ${mydata.message}');
      return null;
    }
  } catch (e) {
    // Handle errors when calling the Cloud Function
    print('EIN FEHLR IST BEIM AUFRUF DER GETFEES CLOUD FUNKTION AUFGETRETEN');
    print("Der aufgetretene Error: $e");
    return null;
  }
}
