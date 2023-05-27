import 'package:BitNet/backbone/helper/deepmapcast.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

recoverKey(String did, String d) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('recoverKeyFunction');
  print("Recovering key...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'did': did,
    'd': d,
  });

  print("Response: ${response.data}");

  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(responseData);
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200") {
    print(callback.message);
    Map<String, dynamic> recoveredKey = callback.data['recoveredKey']; // Extracting the recovered key
    return recoveredKey.toString();
  } else {
    throw Exception(callback.message);
  }
}
