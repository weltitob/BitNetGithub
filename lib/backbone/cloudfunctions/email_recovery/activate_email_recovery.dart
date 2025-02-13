import 'package:bitnet/backbone/services/email_recovery_helper.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

import '../../services/base_controller/logger_service.dart';

Future<String?> activateEmailRecovery(String password, String email) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'activate_email_recovery_http',
  );
  final logger = Get.find<LoggerService>();

  try {
    String encryptedPassword = await encryptMnemonic(password);
    final HttpsCallableResult<dynamic> response = await callable
        .call(<String, dynamic>{'password': encryptedPassword, 'email': email});

    logger.i("Response: ${response.data}");

    // Ensure response.data is not null and is a Map
    if (response.data != null && response.data is Map) {
      final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data as Map);
      if (responseData.containsKey('mnemonic')) {
        return await decryptMnemonic(responseData['mnemonic']);
      }
      return null;
    } else {
      logger.i("Response data is null or not a Map.");
    }
  } catch (e, stackTrace) {
    logger.e(
      "Error during email recovery setup: $e",
    );
  }
  return null;
}
