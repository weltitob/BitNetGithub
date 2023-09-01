import 'dart:convert';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorage = FlutterSecureStorage();

Future<void> storePrivateData(PrivateData privateData) async {
  try {
    print("Reading secure storage now...");
    final privateDataJson =
        await secureStorage.read(key: 'usersInSecureStorage');

    // Decode the JSON data and map it to a list of IONData objects
    List<PrivateData> usersStored = privateDataJson != null
        ? (jsonDecode(privateDataJson) as List)
            .map((json) => PrivateData.fromMap(json))
            .toList()
        : [];

    // Check if the user is already stored based on their DID
    bool isUserStored = usersStored.any((user) => user.did == privateData.did);

    if (!isUserStored) {
      // Add the new user to the list
      usersStored.add(privateData);

      print("Users getting stored in secure storage now...");
      await secureStorage.write(
        key: 'usersInSecureStorage',
        value: json.encode(
            usersStored.map((privateData) => privateData.toMap()).toList()),
      );
    } else {
      print("User with the same DID already exists in secure storage.");
    }
  } catch (e) {
    print("Error trying to write User to local device...");
    throw Exception(
        "An error occured trying to write to local secure storage: $e");
  }
}

Future<PrivateData> getPrivateData(String DidOrUsername) async {
  final bool isDID = isStringaDID(DidOrUsername);
  late String did;
  //late String username;

  print(isDID);

  if (isDID) {
    did = DidOrUsername;
    //username = await Auth().getUserUsername(did);
  } else {
    //getdid for username in database
    final String username = DidOrUsername;
    did = await Auth().getUserDID(username);
  }

  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<PrivateData> usersStored = (jsonDecode(privateDataJson) as List)
      .map((json) => PrivateData.fromMap(json))
      .toList();

  // Find the IONData object with the matching DID
  final matchingPrivateData = usersStored.firstWhere((user) => user.did == did);

  if (matchingPrivateData == null) {
    throw Exception(
        'Failed to find IONData with the specified DID or username');
  }

  return matchingPrivateData;
}

Future<List<PrivateData>> getAllStoredIonData() async {
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    print('Failed to retrieve IONData from secure storage');
    //return empty list
    return [];
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<PrivateData> usersStored = (jsonDecode(privateDataJson) as List)
      .map((json) => PrivateData.fromMap(json))
      .toList();

  return usersStored;
}

Future<void> deleteUserFromStoredIONData(String did) async {
  // Read the stored data
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<PrivateData> usersStored = (jsonDecode(privateDataJson) as List)
      .map((json) => PrivateData.fromMap(json))
      .toList();

  // Filter out the user with the provided DID
  usersStored = usersStored.where((user) => user.did != did).toList();

  // Store the updated list back in the storage
  await secureStorage.write(
      key: 'usersInSecureStorage',
      value: json.encode(
          usersStored.map((privateData) => privateData.toMap()).toList()));
}
