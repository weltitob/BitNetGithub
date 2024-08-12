import 'dart:convert';

import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';

fakeLoginION(
  String fakedid,
) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('old_fake_login');
  print("FAKE LOGIN WHILE ION IS BROKEN..");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'fakedid': fakedid,
  });

  print("Response: ${response.data}");

  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
  final RestResponse callback = RestResponse.fromJson(responseData);
  print("CloudfunctionCallback: ${callback.toString()}");
  dynamic callbackResponse = jsonDecode(callback.message);
  if (callbackResponse['statusCode'] == 200) {
    print(callback.message);
    String customToken = callbackResponse['data']['customToken']; // Extracting the signed message // Extracting the signed message
    return customToken;
  } else {
    return null;
  }
}
