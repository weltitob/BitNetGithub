import 'package:flutter/services.dart';

Future<ByteData> loadMacaroonAsset() async {
  return await rootBundle.load('assets/keys/lnd_admin.macaroon');
}

Future<ByteData> loadLoopMacaroonAsset() async {
  return await rootBundle.load('assets/keys/loop.macaroon');
}

Future<ByteData> loadTapdMacaroonAsset() async {
  return await rootBundle.load('assets/keys/tapd_admin.macaroon');
}
