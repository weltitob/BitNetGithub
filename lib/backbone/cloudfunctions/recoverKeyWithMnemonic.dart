//
// recoverKeyWithMnemonic(String mnemonic, String did) async {
//   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('recoverKeyWithMnemonic');
//   print("Recovering key...");
//
//   final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
//     'mnemonic': mnemonic,
//     'did': did,
//   });
//
//   print("Response: ${response.data}");
//
//   final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
//   final RestResponse callback = RestResponse.fromJson(responseData);
//   print("CloudfunctionCallback: ${callback.toString()}");
//
//   if (callback.statusCode == "200") {
//     print(callback.message);
//     Map<String, dynamic> recoveredKey = callback.data['recoveredKey']; // Extracting the recovered key
//     final privateData = PrivateData.fromJson(callback.data).copyWith(privateKey: recoveredKey.toString());
//     return privateData;
//   } else {
//     throw Exception(callback.message);
//   }
// }
