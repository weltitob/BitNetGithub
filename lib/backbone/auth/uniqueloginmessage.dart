


import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

String generateChallenge(String userDid) {
  LoggerService logger = Get.find();
  logger.i("Generating challenge for $userDid");
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  //this somehow is trasg
  //final randomValue = Random.secure().nextInt(1 << 32) - 1; // subtract 1 to ensure it's in the range

  final uniqueMessage = '$timestamp-$userDid';
  logger.i("Unique message: $uniqueMessage");
  return uniqueMessage;
}
