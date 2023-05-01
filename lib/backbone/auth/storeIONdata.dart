import 'dart:convert';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = FlutterSecureStorage();

Future<void> storeIonData(IONData iondata) async {
  print("Reading secure Stoage now...");
  final ionDataJson = await secureStorage.read(key: 'usersInLocalStorage');

  // Decode the JSON data and map it to a list of IONData objects
  List<IONData> usersStored = ionDataJson != null
      ? (jsonDecode(ionDataJson) as List)
      .map((json) => IONData.fromMap(json))
      .toList()
      : [];

  usersStored.add(iondata);

  print("Users getting stored in secure Stoage now...");
  await secureStorage.write(key: 'usersInLocalStorage', value: json.encode(usersStored.map((ionData) => ionData.toMap()).toList()));
}

Future<IONData> getIonData(String DidOrUsername) async {
  final bool isDID = isStringaDID(DidOrUsername);
  late String did;

  if (isDID) {
    did = DidOrUsername;
  } else {
    //getdid for username in database
    final String username = DidOrUsername;

    did = "test";
  }

  final ionDataJson = await secureStorage.read(key: 'usersInLocalStorage');

  if (ionDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<IONData> usersStored = (jsonDecode(ionDataJson) as List)
      .map((json) => IONData.fromMap(json))
      .toList();

  // Find the IONData object with the matching DID
  final matchingIonData = usersStored.firstWhere((user) => user.did == did);

  if (matchingIonData == null) {
    throw Exception('Failed to find IONData with the specified DID or username');
  }

  return matchingIonData;
}

Future<List<IONData>> getAllStoredIonData() async {
  final ionDataJson = await secureStorage.read(key: 'usersInLocalStorage');

  if (ionDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<IONData> usersStored = (jsonDecode(ionDataJson) as List)
      .map((json) => IONData.fromMap(json))
      .toList();

  return usersStored;
}
