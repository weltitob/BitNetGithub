import 'dart:convert';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = FlutterSecureStorage();

Future<void> storeIonData(IONData iondata) async {

  await secureStorage.write(key: '${iondata.did} = ionData', value: json.encode(iondata.toMap()));
}

Future<IONData> getIonData(String DidOrUsername) async {

  final bool isDID = isStringaDID(DidOrUsername);
  late String did;

  if(isDID){
    did = DidOrUsername;
  }
  else {
    //getdid for username in database
    final String username = DidOrUsername;


    did = "test";
  }

  final ionDataJson = await secureStorage.read(key: '${did} = ionData');

  if (ionDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  final ionDataMap = json.decode(ionDataJson);

  return IONData.fromMap(ionDataMap);
}