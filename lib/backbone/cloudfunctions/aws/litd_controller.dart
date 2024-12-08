
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/stop_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/serverstate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bip39/bip39.dart' as bip39;

class LitdController extends GetxController {
  RxString litd_baseurl = '${AppTheme.baseUrlLightningTerminal}'.obs;
  var isLoading = false.obs;
  var publicIp = ''.obs;
  var registrationSuccess = false.obs;
  var mnemonicSeed = [].obs;

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();

  // Firestore reference
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateSubServerStatus() async {
    final result = await fetchSubServerStatus();
    subServersStatus.value = result;
    await _updateServerStateInFirestore();
  }

  dynamic loginAndStartEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await startEcsTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");

    // If started successfully, set isActive to true and update Firestore
    if (statusresult == 200) {
      // publicIp should already be set from earlier or after ECS start
      // If you have a publicIp from ECS response, set it here again or ensure it's already set.
      await _updateServerStateInFirestore(isActive: true);
    }
  }

  //when logging out there is no need to wait ==> we can stop the ecs task instantly
  dynamic logoutAndStopEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await stopUserTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");

    // If stopped successfully, set isActive to false and update Firestore
    if (statusresult == 200) {
      await _updateServerStateInFirestore(isActive: false);
    }
  }

  dynamic registerAndSetupUser(String taskTag, String mnemonicString) async {
    try {
      final logger = Get.find<LoggerService>();
      logger.i("AWS ECS Register and setup user called");

      isLoading.value = true;
      int resultStatus = await registerUserWithEcsTask(taskTag);

      if (resultStatus == 200) {
        logger.i("User registered successfully");
        EcsTaskStartResponse ecsResponse = await startEcsTask(taskTag);
        publicIp.value = ecsResponse.details!.publicIp;
        logger.i("Public IP: ${publicIp.value}");

        litd_baseurl.value = "${ecsResponse.details!.publicIp}:8443";
        List<String> mnemonicSeedList = mnemonicString.split(' ');

        String seed = bip39.mnemonicToSeedHex(mnemonicString);
        logger.i('Seed derived from mnemonic:\n$seed\n');
        dynamic macaroon_root_key = seed;

        // Wait a bit for LND services to be ready
        await Future.delayed(Duration(seconds: 10));

        dynamic initWalletResponse = await initWallet(mnemonicSeedList, macaroon_root_key);
        logger.i("Wallet initialization response: $initWalletResponse");

        // Indicate success
        registrationSuccess.value = true;

        // After successful registration and initialization, we consider the server active
        // Update Firestore with the newly registered server info
        await _updateServerStateInFirestore(
          isActive: true,
          mnemonicSeed: mnemonicString,
          macaroonRootKey: seed,
        );
      } else {
        logger.e("Registration failed");
        registrationSuccess.value = false;
      }
    } catch (error) {
      print("Error occurred: $error");
      registrationSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Private method to update the server state in Firestore
  Future<void> _updateServerStateInFirestore({
    bool? isActive,
    String? mnemonicSeed,
    String? macaroonRootKey,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Use existing values if not provided in the method call
    bool activeStatus = isActive ?? _determineActiveStatus();
    String currentPublicIp = publicIp.value;

    // Build the subServers map if we have the status
    Map<String, dynamic>? subServersMap;
    if (subServersStatus.value != null) {
      subServersMap = {};
      subServersStatus.value!.subServers.forEach((key, value) {
        subServersMap![key] = {
          'disabled': value.disabled,
          'running': value.running,
          'error': value.error,
        };
      });
    }

    ServerStateModel model = ServerStateModel(
      publicIp: currentPublicIp,
      isActive: activeStatus,
      lastUpdated: DateTime.now(),
      subServers: subServersMap,
      mnemonicSeed: mnemonicSeed,
      macaroonRootKey: macaroonRootKey,
    );

    // Save to Firestore: users/<uid>/serverstate/current
    await usersCollection
        .doc(user.uid)
        .collection('serverstate')
        .doc('current')
        .set(model.toMap(), SetOptions(merge: true));
  }

  bool _determineActiveStatus() {
    // If you have logic to determine if the server is active, implement it here.
    // For now, we assume that if we have a publicIp set, it's active.
    return publicIp.value.isNotEmpty;
  }

  //this will be automatically be called on each app start ==> if user is logges in ==> and check the firebase on serverinformation
  @override
  void onInit() {
    super.onInit();
    loadServerStateFromFirestore();
  }

  Future<void> loadServerStateFromFirestore() async {
    final logger = Get.find<LoggerService>();
    final user = Auth().currentUser;
    if (user == null) {
      // No logged-in user, nothing to load
      return;
    }

    try {
      final docRef = usersCollection
          .doc(user.uid)
          .collection('serverstate')
          .doc('current');
      final docSnap = await docRef.get();

      if (docSnap.exists && docSnap.data() != null) {
        final data = docSnap.data()!;
        final stateModel = ServerStateModel.fromMap(data);

        // Update the controller state with the stored data
        publicIp.value = stateModel.publicIp;

        // If subServers exist, convert them back to SubServersStatus
        if (stateModel.subServers != null) {
          final subServersData = {'sub_servers': stateModel.subServers!};
          final fetchedStatus = SubServersStatus.fromJson(subServersData);
          subServersStatus.value = fetchedStatus;
        }

        // If mnemonicSeed was stored, split it back into a list
        if (stateModel.mnemonicSeed != null && stateModel.mnemonicSeed!.isNotEmpty) {
          mnemonicSeed.value = stateModel.mnemonicSeed!.split(' ');
        }

        // You can also use other fields like isActive, macaroonRootKey, etc. if needed
        // For example, if you want to reflect isActive in your UI or logic:
        // bool currentlyActive = stateModel.isActive;
        // ... handle that if needed
      } else {
        // No previous serverstate document found. Possibly a new user or no server deployed yet.
      }
    } catch (e) {
      // Handle any errors loading from Firestore
      logger.e("Error loading server state: $e");
    }
  }

  @override
  void dispose() {

  }
}