import 'dart:convert';

import 'package:BitNet/backbone/helper/deepmapcast.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:BitNet/models/keys/privateionkey.dart';
import 'package:cloud_functions/cloud_functions.dart';

signMessageFunction(String did, String privateIONKey, String message,) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('signMessageFunction');
  print("Signing message...");

  print(privateIONKey);
  print(did);
  print(message);

// Remove the curly braces
  String privateKeyPairs = privateIONKey.substring(1, privateIONKey.length - 1);

// Split the pairs into key-value strings
  List<String> privateKeyList = privateKeyPairs.split(', ');

// Create a map from the key-value strings
  Map<String, dynamic> privateKeyMap = {};
  for (String pair in privateKeyList) {
    List<String> keyValue = pair.split(': ');
    String key = keyValue[0];
    String value = keyValue[1];
    privateKeyMap[key] = value;
  }

// Create the model instance
  PrivateIONKey privateKey = PrivateIONKey.fromJson(privateKeyMap);

  print(json.encode(privateKeyMap));

  try {
    final HttpsCallableResult<dynamic> response = await callable.call(<String, dynamic>{
      'did': did,
      'privateIONKey': json.encode(privateKeyMap),
      'message': message,
    });

    print("Response: ${response.data}");

    final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);
    final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(responseData);
    print("CloudfunctionCallback: ${callback.toString()}");

    if (callback.statusCode == "200") {
      print(callback.message);
      String signedMessage = callback.data['signedMessage']; // Extracting the signed message // Extracting the signed message
      return signedMessage;
    } else {
      print("ELSE STATEMENT TRIGGERED");
      throw Exception("${callback.statusCode}: ${callback.message}");
    }
  } catch (error) {
    throw Exception("Error calling signMessageFunction: $error");
  }
}
