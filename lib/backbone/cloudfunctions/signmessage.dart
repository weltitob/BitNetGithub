import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

signMessageFunction(String did, Map<String, dynamic> privateKeyJwk, String message) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('signMessageFunction');
  print("Signing message...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'did': did,
    'privateKeyJwk': privateKeyJwk,
    'message': message,
  });

  print("Response: ${response.data}");

  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(response.data);
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200") {
    print(callback.message);
    return callback.data;
  } else {
    return null;
  }
}
