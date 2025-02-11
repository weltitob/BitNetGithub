import 'package:bitnet/backbone/services/email_recovery_helper.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

import '../../services/base_controller/logger_service.dart';

Future<bool> setupEmailRecovery(
    String password, String mnemonic, String userId, String email) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'setup_email_recovery_http',
  );
  final logger = Get.find<LoggerService>();

  try {
    String encryptedPassword = await encryptMnemonic(password);
    String encryptedMnemonic = await encryptMnemonic(mnemonic);
    final HttpsCallableResult<dynamic> response =
        await callable.call(<String, dynamic>{
      'password': encryptedPassword,
      'mnemonic': encryptedMnemonic,
      'user_id': userId,
      'email': email
    });

    logger.i("Response: ${response.data}");

    // Ensure response.data is not null and is a Map
    if (response.data != null && response.data is Map) {
      final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data as Map);
      return responseData.containsKey('message') &&
          responseData['message'] == "success";
    } else {
      logger.i("Response data is null or not a Map.");
    }
  } catch (e, stackTrace) {
    logger.e(
      "Error during email recovery setup: $e",
    );
  }
  return false;
}
