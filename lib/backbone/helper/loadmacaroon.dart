import 'package:flutter/services.dart';

Future<ByteData> loadMacaroonAsset() async {
  return await rootBundle.load('assets/keys/lnd_admin.macaroon');
}
