import 'dart:convert';

import 'package:BitNet/backbone/helper/deepmapcast.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:BitNet/models/qr_codes/qr_privatekey.dart';
import 'package:cloud_functions/cloud_functions.dart';

recoverKeyWithMnemonic(String mnemonic) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('recoverKeyWithMnemonic');
  print("Recovering key...");

  final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
    'mnemonic': mnemonic,
  });

  print("Response: ${response.data}");

  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(responseData);
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200") {
    print(callback.message);
    final privateData = PrivateData.fromJson(callback.data);
    return privateData;
  } else {
    throw Exception(callback.message);
  }
}
