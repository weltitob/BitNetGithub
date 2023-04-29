import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

Future<IONData?> loginION(String username, String did, String signedMessage, String message) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('loginION');
  print("Logging in with ION...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'username': username,
    'did': did,
    'signedMessage': signedMessage,
    'message': message,
  });

  print("Response: ${response.data}");

  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(response.data);
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200") {
    print(callback.message);
    final mydata = IONData.fromJson(callback.data);
    return mydata;
  } else {
    return null;
  }
}
