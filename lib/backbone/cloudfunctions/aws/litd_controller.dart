import 'dart:async';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/stop_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/serverstate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LitdController extends GetxController {
  // Start with empty by default; will conditionally set in onInit
  RxString litd_baseurl = ''.obs;
  var isLoading = false.obs;
  var publicIp = ''.obs;
  var registrationSuccess = false.obs;
  var mnemonicSeed = [].obs;

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();

  @override
  void onInit() {
    super.onInit();
    // In debug mode, force the litd_baseurl to the AppTheme debug value and never update it
    if (!kReleaseMode) {
      litd_baseurl.value = AppTheme.baseUrlLightningTerminalWithPort;
      publicIp.value = AppTheme.baseUrlLightningTerminal;
    }
    loadServerStateFromFirestore();
  }

  Future<void> updateSubServerStatus() async {
    final result = await fetchSubServerStatus();
    subServersStatus.value = result;
    await _updateServerStateInFirestore();
  }

  dynamic loginAndStartEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await startEcsTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");

    if (statusresult == 200) {
      await _updateServerStateInFirestore(isActive: true);
    }
  }

  dynamic logoutAndStopEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await stopUserTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");

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

        // Only update these values if we are in release mode
        if (kReleaseMode) {
          publicIp.value = ecsResponse.details!.publicIp;
          logger.i("Public IP: ${publicIp.value}");
          litd_baseurl.value = "${ecsResponse.details!.publicIp}:8443";
        } else {
          // In debug mode, we do not overwrite publicIp and litd_baseurl
          logger.i("Debug mode detected. Not overwriting litd_baseurl or publicIp.");
        }

        List<String> mnemonicSeedList = mnemonicString.split(' ');
        String seed = bip39.mnemonicToSeedHex(mnemonicString);
        logger.i('Seed derived from mnemonic:\n$seed\n');
        dynamic macaroon_root_key = seed;

        // Wait a bit for LND services to be ready
        await Future.delayed(Duration(seconds: 10));

        dynamic initWalletResponse = await initWallet(mnemonicSeedList, macaroon_root_key);
        logger.i("Wallet initialization response: $initWalletResponse");

        registrationSuccess.value = true;

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

  Future<void> _updateServerStateInFirestore({
    bool? isActive,
    String? mnemonicSeed,
    String? macaroonRootKey,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    bool activeStatus = isActive ?? _determineActiveStatus();
    String currentPublicIp = publicIp.value;

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

    await usersCollection
        .doc(user.uid)
        .collection('serverstate')
        .doc('current')
        .set(model.toMap(), SetOptions(merge: true));
  }

  bool _determineActiveStatus() {
    return publicIp.value.isNotEmpty;
  }

  Future<void> loadServerStateFromFirestore() async {
    final logger = Get.find<LoggerService>();
    final user = Auth().currentUser;
    if (user == null) {
      return;
    }

    try {
      final docRef = usersCollection.doc(user.uid).collection('serverstate').doc('current');
      final docSnap = await docRef.get();

      if (docSnap.exists && docSnap.data() != null) {
        final data = docSnap.data()!;
        final stateModel = ServerStateModel.fromMap(data);

        publicIp.value = stateModel.publicIp;

        if (stateModel.subServers != null) {
          final subServersData = {'sub_servers': stateModel.subServers!};
          final fetchedStatus = SubServersStatus.fromJson(subServersData);
          subServersStatus.value = fetchedStatus;
        }

        if (stateModel.mnemonicSeed != null && stateModel.mnemonicSeed!.isNotEmpty) {
          mnemonicSeed.value = stateModel.mnemonicSeed!.split(' ');
        }
      }
    } catch (e) {
      logger.e("Error loading server state: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
