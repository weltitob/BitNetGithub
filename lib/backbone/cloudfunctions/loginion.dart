import 'package:BitNet/backbone/helper/deepmapcast.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

loginION(String username, String did, String signedMessage, String standardMessage) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('loginION');
  print("Logging in with ION...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'username': username,
    'did': did,
    'signedMessage': signedMessage,
    'standardMessage': standardMessage,
  });

  print("Response: ${response.data}");


  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(responseData);
  print("CloudfunctionCallback: ${callback.toString()}");


  if (callback.statusCode == "200") {
    print(callback.message);
    String customToken = callback.data['customToken']; // Extracting the signed message // Extracting the signed message
    return customToken;
  } else {
    return null;
  }
}
