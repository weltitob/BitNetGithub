// import 'dart:convert';
//
// import 'package:bitnet/models/firebase/restresponse.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:bitnet/models/user/userwallet.dart';
//
// /*
// Creates a new Bitcoin wallet for the given email address by calling a cloud function.
// Returns the new UserWallet object if successful, or null if an error occurs.
//  */
// dynamic createWallet({required String email,}) async {
//   try {
//     // Set up the Cloud Function call
//     print('CALL WALLET...');
//     HttpsCallable callable =
//     FirebaseFunctions.instance.httpsCallable('createWallet');
//     // Call the Cloud Function with the email and a null user ID
//     final resp = await callable.call(<String, dynamic>{
//       'email': "${email}",
//       'useruid': "null",
//     });
//     // Parse the response and return the new UserWallet object
//     final mydata = RestResponse.fromJson(resp.data);
//     if (mydata.statusCode == "success") {
//       var encodedString = jsonDecode(mydata.message);
//       final newWallet = UserWallet.fromJson(encodedString);
//       return newWallet;
//     } else {
//       // Error occurred in the Cloud Function, but valid data was returned
//       print('Die Antwortnachricht der Cloudfunktion war ein Error.');
//     }
//   } catch (e) {
//     // Error occurred when calling the Cloud Function
//     print("Wir konnten keine neue Wallet für dich erstellen: ${e}");
//   }
// }