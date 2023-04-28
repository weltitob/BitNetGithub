// Function to store ION data in secure storage
import 'dart:convert';
import 'package:BitNet/models/authION.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> storeIonData(IONData iondata) async {
  final secureStorage = FlutterSecureStorage();

  await secureStorage.write(key: 'did', value: iondata.did);
  await secureStorage.write(key: 'privateIONKey', value: json.encode(iondata.privateIONKey));
  await secureStorage.write(key: 'publicIONKey', value: json.encode(iondata.publicIONKey));
}
