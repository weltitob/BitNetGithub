import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

signMessageFunction(String did, String privateIONKey, String message) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('signMessageFunction');
  print("Signing message...");

  try {
    final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
      'did': did,
      'privateIONKey': privateIONKey,
      'message': message,
    });

    print("Response: ${response.data}");

    final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(response.data);
    print("CloudfunctionCallback: ${callback.toString()}");

    if (callback.statusCode == "200") {
      print(callback.message);
      return callback.data;
    } else {
      print("ELSE STATEMENT TRIGGERED");
      print(callback.statusCode);
      print(callback.data);
      return null;
    }
  } catch (error) {
    print("Error calling signMessageFunction: $error");
    return null;
  }
}
