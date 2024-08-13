import 'dart:convert';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';


requestClientSecret(String amount, String currency) async {
  final functions = FirebaseFunctions.instance;
  final callable = functions.httpsCallable(
    'request_stripe_clientsecret',
    options: HttpsCallableOptions(
      timeout: Duration(minutes: 10),  // Increase the timeout duration
      limitedUseAppCheckToken: true,
    ),
  );
  final logger = Get.find<LoggerService>();
  logger.i("Requesting client secret for payment.");

  try {
    final HttpsCallableResult<dynamic> response =
    await callable.call(<String, dynamic>{
      'amount': amount,
      'currency': currency,
    });

    logger.i("Response: ${response.data}");

    // Assuming response.data is a Map, cast it appropriately
    final Map<String, dynamic> responseData =
    deepMapCast(response.data as Map<Object?, Object?>);
    final RestResponse callback = RestResponse.fromJson(responseData);

    logger.i("CloudfunctionCallback: ${callback.toString()}");
    logger.i("Message: ${callback.message}");

    // Parse the message string to a Map
    final Map<String, dynamic> messageData =
    jsonDecode(callback.message) as Map<String, dynamic>;

    // Extract the 'data' field
    if (messageData.containsKey('data')) {
      final Map<String, dynamic> data =
      messageData['data'] as Map<String, dynamic>;

      // Safely extract the customToken from the data
      if (data.containsKey('clientSecret') && data.containsKey('id')) {
        String clientSecret = data['clientSecret'] as String;
        logger.i("clientSecret: $clientSecret");
        String id = data['id'] as String;
        logger.i("id: $id");

        return clientSecret;
      } else {
        logger.e("Custom Token not found in message data.");
        return null;
      }
    } else {
      logger.e("Data field not found in message.");
      return null;
    }
  } catch (e) {
    logger.e("Error during fake login: $e");
    return null;
  }
}
