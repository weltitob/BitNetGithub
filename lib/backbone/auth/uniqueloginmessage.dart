

import 'package:bitnet/backbone/helper/logs/logs.dart';

String generateChallenge(String userDid) {
  Logs().w("Generating challenge for $userDid");
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  //this somehow is trasg
  //final randomValue = Random.secure().nextInt(1 << 32) - 1; // subtract 1 to ensure it's in the range

  final uniqueMessage = '$timestamp-$userDid';
  Logs().w("Unique message: $uniqueMessage");
  return uniqueMessage;
}
