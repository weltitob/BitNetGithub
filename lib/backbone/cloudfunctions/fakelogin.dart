import 'dart:convert';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';

fakeLoginION(String fakedid) async {
  HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('old_fake_login');
  print("FAKE LOGIN WHILE ION IS BROKEN..");

  try {
    final HttpsCallableResult<dynamic> response =
        await callable.call(<String, dynamic>{
      'fakedid': fakedid,
    });

    print("Response: ${response.data}");

    // Assuming response.data is a Map, cast it appropriately
    final Map<String, dynamic> responseData =
        deepMapCast(response.data as Map<Object?, Object?>);
    final RestResponse callback = RestResponse.fromJson(responseData);

    print("CloudfunctionCallback: ${callback.toString()}");
    print("Message: ${callback.message}");

    // Parse the message string to a Map
    final Map<String, dynamic> messageData =
        jsonDecode(callback.message) as Map<String, dynamic>;

    // Extract the 'data' field
    if (messageData.containsKey('data')) {
      final Map<String, dynamic> data =
          messageData['data'] as Map<String, dynamic>;

      // Safely extract the customToken from the data
      if (data.containsKey('customToken')) {
        String customToken = data['customToken'] as String;
        print("Custom Token: $customToken");
        return customToken;
      } else {
        print("Custom Token not found in message data.");
        return null;
      }
    } else {
      print("Data field not found in message.");
      return null;
    }
  } catch (e) {
    print("Error during fake login: $e");
    return null;
  }
}
