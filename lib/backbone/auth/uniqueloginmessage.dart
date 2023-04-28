import 'dart:math';

String generateUniqueLoginMessage(String userDid) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final randomValue = Random.secure().nextInt(1 << 32);
  final uniqueMessage = '$timestamp-$randomValue-$userDid';
  return uniqueMessage;
}