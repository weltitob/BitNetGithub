import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

final secureStorage = const FlutterSecureStorage();

Future<void> storePrivateData(PrivateData privateData) async {
  try {
    print("Reading secure storage now...");
    final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

    // Decode the JSON data and map it to a list of IONData objects
    List<PrivateData> usersStored =
        privateDataJson != null ? (jsonDecode(privateDataJson) as List).map((json) => PrivateData.fromMap(json)).toList() : [];

    // Check if the user is already stored based on their DID
    bool isUserStored = usersStored.any((user) => user.did == privateData.did);

    if (!isUserStored) {
      // Add the new user to the list
      usersStored.add(privateData);

      print("Users getting stored in secure storage now...");
      await secureStorage.write(
        key: 'usersInSecureStorage',
        value: json.encode(usersStored.map((privateData) => privateData.toMap()).toList()),
      );
    } else {
      print("User with the same DID already exists in secure storage.");
    }
  } catch (e) {
    print("Error trying to write User to local device...");
    throw Exception("An error occured trying to write to local secure storage: $e");
  }
}

Future<PrivateData> getPrivateData(String didOrUsername) async {
  // Assuming you have a logger instance set up
  LoggerService logger = Get.find();

  final bool isDID = isStringaDID(didOrUsername);
  late String did;
  //late String username;

  logger.d('Input DidOrUsername: $didOrUsername');
  logger.d('Is input a DID: $isDID');

  if (isDID) {
    did = didOrUsername;
    logger.d('Using DID directly: $did');
    //username = await Auth().getUserUsername(did);
  } else {
    // Get DID for username from database
    final String username = didOrUsername;
    logger.d('Input is a username: $username');
    try {
      did = await Auth().getUserDID(username);
      logger.d('Retrieved DID for username $username: $did');
    } catch (e, stackTrace) {
      logger.e('Error retrieving DID for username $username, $e');
      throw Exception('Failed to retrieve DID for username $username');
    }
  }

  logger.d('Attempting to read private data from secure storage');
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    logger.e('No private data found in secure storage for key usersInSecureStorage');
    throw Exception('Failed to retrieve private data from secure storage');
  }

  // Decode the JSON data and map it to a list of PrivateData objects
  List<PrivateData> usersStored;
  try {
    usersStored = (jsonDecode(privateDataJson) as List)
        .map((json) => PrivateData.fromMap(json))
        .toList();
    logger.d('Decoded private data JSON into PrivateData objects');
  } catch (e, stackTrace) {
    logger.e('Error decoding private data JSON $e');
    throw Exception('Failed to decode private data');
  }

  // Find the PrivateData object with the matching DID
  try {
    final matchingPrivateData = usersStored.firstWhere(
          (user) => user.did == did,
      orElse: () {
        logger.e('No matching private data found for DID $did');
        throw Exception('No private data found for DID $did');
      },
    );
    logger.d('Found matching private data for DID $did');
    return matchingPrivateData;
  } catch (e, stackTrace) {
    logger.e('Error searching for matching private data $e');
    throw Exception('Error retrieving private data for DID $did');
  }
}

Future<List<PrivateData>> getAllStoredIonData() async {
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    print('Failed to retrieve IONData from secure storage');
    //return empty list
    return [];
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<PrivateData> usersStored = (jsonDecode(privateDataJson) as List).map((json) => PrivateData.fromMap(json)).toList();

  return usersStored;
}

Future<void> deleteUserFromStoredIONData(String did) async {
  // Read the stored data
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    throw Exception('Failed to retrieve IONData from secure storage');
  }

  // Decode the JSON data and map it to a list of IONData objects
  List<PrivateData> usersStored = (jsonDecode(privateDataJson) as List).map((json) => PrivateData.fromMap(json)).toList();

  // Filter out the user with the provided DID
  usersStored = usersStored.where((user) => user.did != did).toList();

  // Store the updated list back in the storage
  await secureStorage.write(
      key: 'usersInSecureStorage', value: json.encode(usersStored.map((privateData) => privateData.toMap()).toList()));
}
