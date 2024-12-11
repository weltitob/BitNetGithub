import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
import 'package:pointycastle/pointycastle.dart';

ECPrivateKey getUserPrivateKeyFromWIF(String wifPrivateKey) {
  List<int> privateKeyBytes = decodeWIF(wifPrivateKey);
  BigInt privateKeyInt = BigInt.parse(bytesToHex(privateKeyBytes), radix: 16);
  final ECDomainParameters domainParams = ECDomainParameters('secp256k1');
  return ECPrivateKey(privateKeyInt, domainParams);
}