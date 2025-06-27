import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

updateAccountBalance(String accountId, String amount, String currency) async {
  final functions = FirebaseFunctions.instance;
  final callable = functions.httpsCallable(
    '.........',
    options: HttpsCallableOptions(
      timeout: const Duration(minutes: 10),
      limitedUseAppCheckToken: true,
    ),
  );
  final logger = Get.find<LoggerService>();
  logger.i("Requesting to update users account balance.");

  try {
    final HttpsCallableResult<dynamic> response =
        await callable.call(<String, dynamic>{
      'amount': amount,
      'accountId': accountId,
      'currency': currency,
    });

    logger.i("Response: ${response.data}");

    // Assuming response.data is a Map, cast it appropriately
    final Map<String, dynamic> responseData = response.data;

    if (responseData.containsKey('account_id') &&
        responseData.containsKey('account_link')) {
      String account_link = responseData['account_link'] as String;
      logger.i("account_link: $account_link");
      String id = responseData['account_id'] as String;
      logger.i("stripe_account_id: $id");

      return account_link;
    } else {
      logger.e("Account ID or Account Link not found in response data.");
      return null;
    }
  } catch (e) {
    logger.e("Error during account creation: $e");
    return null;
  }
}
