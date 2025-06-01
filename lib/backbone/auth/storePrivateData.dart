import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

final secureStorage = const FlutterSecureStorage();

/// Check if input is a DID (any supported format)
bool isDID(String input) {
  LoggerService logger = Get.find();
  
  logger.d('🔍 Checking if "$input" is a DID...');
  
  // Check for recovery DID format: did:mnemonic:xxxxx
  if (RecoveryIdentity.isValidRecoveryDid(input)) {
    logger.d('✅ Matched recovery DID format');
    return true;
  }
  
  // Check for Lightning DID format: did:xxxxxxxx (16 hex chars after 'did:')
  if (input.startsWith('did:') && input.length == 20) {
    String hash = input.substring(4);
    RegExp hexPattern = RegExp(r'^[a-f0-9]{16}$');
    if (hexPattern.hasMatch(hash)) {
      logger.d('✅ Matched Lightning DID format');
      return true;
    }
  }
  
  // Check for BIP39 DID format: did_xxxxx
  if (Bip39DidGenerator.isValidBip39Did(input)) {
    logger.d('✅ Matched BIP39 DID format');
    return true;
  }
  
  // Check for compressed public key format (legacy DID)
  if (isCompressedPublicKey(input)) {
    logger.d('✅ Matched compressed public key format');
    return true;
  }
  
  logger.d('❌ No DID format matched for "$input"');
  return false;
}

// Store userId, accountId and macaroon in secure storage
Future<void> storeLitdAccountData(
    String userId, String accountId, String macaroon) async {
  try {
    print("Reading LITD accounts from secure storage...");
    final accountsJson =
        await secureStorage.read(key: 'litdAccountsInSecureStorage');

    // Decode existing data
    List<Map<String, dynamic>> accountsStored = accountsJson != null
        ? (jsonDecode(accountsJson) as List)
            .map((json) => Map<String, dynamic>.from(json))
            .toList()
        : [];

    // Check if user already stored
    bool isUserStored = accountsStored.any((acc) => acc['userId'] == userId);

    if (!isUserStored) {
      // Add new user with account info
      accountsStored.add({
        'userId': userId,
        'accountId': accountId,
        'macaroon': macaroon,
      });
    } else {
      // Update existing user account info
      accountsStored = accountsStored.map((acc) {
        if (acc['userId'] == userId) {
          acc['accountId'] = accountId;
          acc['macaroon'] = macaroon;
        }
        return acc;
      }).toList();
    }

    print("Storing LITD accounts in secure storage now...");
    await secureStorage.write(
      key: 'litdAccountsInSecureStorage',
      value: json.encode(accountsStored),
    );
  } catch (e) {
    print("Error trying to write LITD account data to local device...");
    throw Exception(
        "An error occurred trying to write LITD account data to secure storage: $e");
  }
}

Future<Map<String, dynamic>?> getLitdAccountData(String userId) async {
  final accountsJson =
      await secureStorage.read(key: 'litdAccountsInSecureStorage');

  if (accountsJson == null) {
    print('No LITD accounts found in secure storage');
    return null;
  }

  Map<String, dynamic>? account;
  try {
    account = (jsonDecode(accountsJson) as List)
        .map((json) => Map<String, dynamic>.from(json))
        .firstWhere(
          (json) => json['userId'] == userId,
          orElse: () => <String, dynamic>{},
        );
    
    if (account.isEmpty) {
      print('No LITD account found for userId: $userId');
      return null;
    }
  } catch (e) {
    print('Error searching for LITD account: $e');
    return null;
  }
  return account;
}

// Retrieve list of all LITD accounts
Future<List<Map<String, dynamic>>> getLitdAccountsData() async {
  final accountsJson =
      await secureStorage.read(key: 'litdAccountsInSecureStorage');

  if (accountsJson == null) {
    print('No LITD accounts found in secure storage');
    return [];
  }

  List<Map<String, dynamic>> accountsStored = (jsonDecode(accountsJson) as List)
      .map((json) => Map<String, dynamic>.from(json))
      .toList();

  return accountsStored;
}

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

Future<PrivateData> getPrivateData(String didOrUsername) async {
  // Assuming you have a logger instance set up
  LoggerService logger = Get.find();

  final bool isInputDID = isDID(didOrUsername);
  late String did;
  //late String username;

  logger.d('Input DidOrUsername: $didOrUsername');
  logger.d('Is input a DID: $isInputDID');

  if (isInputDID) {
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

  logger.d('Raw secure storage content: ${privateDataJson?.substring(0, 100) ?? '(NULL)'}...');

  if (privateDataJson == null) {
    logger.e(
        'No private data found in secure storage for key usersInSecureStorage');
    throw Exception('Failed to retrieve private data from secure storage');
  }

  // Decode the JSON data and map it to a list of PrivateData objects
  List<PrivateData> usersStored;
  try {
    logger.d('Attempting to decode JSON...');
    final decoded = jsonDecode(privateDataJson);
    logger.d('JSON decoded successfully, type: ${decoded.runtimeType}');
    
    if (decoded is! List) {
      logger.e('Decoded JSON is not a List, it is: ${decoded.runtimeType}');
      throw Exception('Private data JSON is not a List');
    }
    
    logger.d('JSON is a List with ${decoded.length} items');
    usersStored = decoded
        .map((json) => PrivateData.fromMap(json))
        .toList();
    logger.d('Decoded private data JSON into ${usersStored.length} PrivateData objects');
  } catch (e, stackTrace) {
    logger.e('Error decoding private data JSON $e');
    logger.e('Stack trace: $stackTrace');
    throw Exception('Failed to decode private data');
  }

  // Find the PrivateData object with the matching DID
  try {
    logger.d('Searching for DID $did in ${usersStored.length} stored users');
    for (int i = 0; i < usersStored.length; i++) {
      String storedDid = usersStored[i].did;
      String calculatedDid = Bip39DidGenerator.generateDidFromLightningMnemonic(usersStored[i].mnemonic);
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(usersStored[i].mnemonic);
      logger.d('User $i:');
      logger.d('  - Stored DID: $storedDid');
      logger.d('  - Calculated DID: $calculatedDid');
      logger.d('  - Recovery DID: $recoveryDid');
      logger.d('  - Target DID: $did');
      logger.d('  - Stored match: ${storedDid == did}');
      logger.d('  - Calculated match: ${calculatedDid == did}');
      logger.d('  - Recovery match: ${recoveryDid == did}');
    }
    
    final matchingPrivateData = usersStored.firstWhere(
      // Try multiple DID formats for compatibility:
      // 1. Stored DID (original format)
      // 2. Old Lightning-generated DID (legacy format): did:hash
      // 3. Recovery DID (new format): did:mnemonic:hash  
      (user) => 
        user.did == did || 
        Bip39DidGenerator.generateDidFromLightningMnemonic(user.mnemonic) == did ||
        RecoveryIdentity.generateRecoveryDid(user.mnemonic) == did,
    );
    logger.d('Found matching private data for DID $did');
    return matchingPrivateData;
  } on StateError catch (e) {
    logger.e('No matching private data found for DID $did (StateError: firstWhere found no elements)');
    logger.e('Available DIDs in storage:');
    for (var user in usersStored) {
      String lightningDid = Bip39DidGenerator.generateDidFromLightningMnemonic(user.mnemonic);
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(user.mnemonic);
      logger.e('  - Lightning: $lightningDid');
      logger.e('  - Recovery: $recoveryDid');
      logger.e('  - Stored: ${user.did}');
    }
    throw Exception('No private data found for DID $did');
  } catch (e, stackTrace) {
    logger.e('Error searching for matching private data $e');
    logger.e('Stack trace: $stackTrace');
    throw Exception('Error retrieving private data for DID $did');
  }
}

// Main method that’s called by your code
Future<List<PrivateData>> getAllStoredIonData() async {
  // 1) Read the raw JSON as a string (async I/O)
  final privateDataJson = await secureStorage.read(key: 'usersInSecureStorage');

  if (privateDataJson == null) {
    print('Failed to retrieve IONData from secure storage');
    return [];
  }

  // 2) Parse the JSON in a background isolate using compute
  final parsedList = await compute(_parsePrivateDataList, privateDataJson);
  return parsedList;
}

// Helper function that runs on a separate isolate (via `compute`)
List<PrivateData> _parsePrivateDataList(String data) {
  final List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
  return jsonList.map((item) => PrivateData.fromMap(item)).toList();
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
  // Check all DID formats for compatibility (same as getPrivateData function)
  usersStored = usersStored
      .where((user) => 
        user.did != did && 
        Bip39DidGenerator.generateDidFromLightningMnemonic(user.mnemonic) != did &&
        RecoveryIdentity.generateRecoveryDid(user.mnemonic) != did)
      .toList();

  // Store the updated list back in the storage
  await secureStorage.write(
      key: 'usersInSecureStorage',
      value: json.encode(
          usersStored.map((privateData) => privateData.toMap()).toList()));
}
