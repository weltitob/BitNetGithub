import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

loginION(String did, String signedMessage,) async {
  final logger = Get.find<LoggerService>();
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('loginION');
  logger.i("Logging in with ION...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'did': did,
    'signedMessage': signedMessage,
  });

  logger.i(("Response loginION: ${response.data}");

  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
  final RestResponse callback = RestResponse.fromJson(responseData);
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200") {

    logger.i("LoginIon ${callback.message}");
    String customToken = callback.data['customToken']; // Extracting the signed message // Extracting the signed message
    return customToken;
  } else {
    return null;
  }
}
