import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:get/get.dart';

class LitdController extends GetxController {
  // If runInReleaseMode is not explicitly set, it defaults to kReleaseMode
  // This can be manually overridden at runtime by setting it before the controller initializes.
  static bool runInReleaseMode = false; //kReleaseMode

  // Start with empty by default; will conditionally set in onInit
  RxString litd_baseurl = ''.obs;
  var isLoading = false.obs;
  var publicIp = ''.obs;
  var registrationSuccess = false.obs;
  var mnemonicSeed = [].obs;

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();

  // Access the RemoteConfigController

  @override
  void onInit() {
    super.onInit();
    // If not running in release mode, force the litd_baseurl to the AppTheme debug value and never update it

    final RemoteConfigController remoteConfigController =
        Get.find<RemoteConfigController>();

    litd_baseurl.value =
        remoteConfigController.baseUrlLightningTerminalWithPort.value;
    publicIp.value = remoteConfigController.baseUrlLightningTerminal.value;

    // loadServerStateFromFirestore();
  }
  //
  // Future<void> updateSubServerStatus() async {
  //   final result = await fetchSubServerStatus();
  //   subServersStatus.value = result;
  //   await _updateServerStateInFirestore();
  // }
  //
  // dynamic loginAndStartEcs(String taskTag) async {
  //   final logger = Get.find<LoggerService>();
  //   dynamic statusresult = await startEcsTask(taskTag);
  //   logger.i("Result received now: ${statusresult.toString()}");
  //
  //   if (statusresult == 200) {
  //     await _updateServerStateInFirestore(isActive: true);
  //   }
  // }
  //
  // dynamic logoutAndStopEcs(String taskTag) async {
  //   final logger = Get.find<LoggerService>();
  //   dynamic statusresult = await stopUserTask(taskTag);
  //   logger.i("Result received now: ${statusresult.toString()}");
  //
  //   if (statusresult == 200) {
  //     await _updateServerStateInFirestore(isActive: false);
  //   }
  // }
  //
  // dynamic registerAndSetupUser(String taskTag, String mnemonicString) async {
  //   try {
  //     final logger = Get.find<LoggerService>();
  //     logger.i("AWS ECS Register and setup user called");
  //
  //     isLoading.value = true;
  //     logger.i("Calling registerUserWithEcsTask for taskTag: $taskTag");
  //     int resultStatus = await registerUserWithEcsTask(taskTag);
  //
  //     logger.i("Result status: $resultStatus");
  //
  //     if (resultStatus == 200) {
  //       logger.i("User registered successfully, starting ECS task...");
  //       EcsTaskStartResponse ecsResponse = await startEcsTask(taskTag);
  //
  //       if (runInReleaseMode) {
  //         publicIp.value = ecsResponse.details!.publicIp;
  //         logger.i("Public IP: ${publicIp.value}");
  //         litd_baseurl.value = "${ecsResponse.details!.publicIp}:8443";
  //       } else {
  //         logger.i("Non-release mode detected. Not overwriting litd_baseurl or publicIp.");
  //       }
  //
  //       // Convert mnemonic into seed
  //       logger.i("Splitting mnemonic into list...");
  //       List<String> mnemonicSeedList = mnemonicString.split(' ');
  //
  //       HDWallet hdWallet = hdWalletFromMnemonic(mnemonicString);
  //       final String macaroon_root_key = hdWallet.privKey!;
  //
  //       logger.i("Requesting initial wallet state...");
  //       WalletState initialState = await requestState();
  //       logger.i("Initial Wallet State: ${initialState.description}, ${initialState}");
  //
  //       // logger.i("Waiting for wallet to be ready...");
  //       // await waitForWalletReady();
  //       // logger.i("Wallet initialization complete and ready to use.");
  //
  //       logger.i("Initializing wallet now...");
  //       try {
  //         dynamic initWalletResponse = await initWallet(mnemonicSeedList, macaroon_root_key);
  //         logger.i("Wallet initialization response: $initWalletResponse");
  //       } catch (e, stacktrace) {
  //         logger.e("Error during initWallet: $e");
  //         logger.e("Stacktrace: $stacktrace");
  //       }
  //
  //       // Optionally, you can request the state again
  //       logger.i("Requesting wallet state after readiness...");
  //       WalletState finalState = await requestState();
  //       logger.i("Final Wallet State: ${finalState.description}, ${initialState}");
  //
  //       registrationSuccess.value = true;
  //
  //       logger.i("Updating server state in Firestore...");
  //       await _updateServerStateInFirestore(
  //         isActive: true,
  //       );
  //
  //       logger.i("registerAndSetupUser completed successfully.");
  //     } else {
  //       logger.e("User registration did not return 200 status. Result was $resultStatus.");
  //       // Handle non-200 status result here if needed.
  //     }
  //   } catch (e, stacktrace) {
  //     final logger = Get.find<LoggerService>();
  //     logger.e("An error occurred in registerAndSetupUser: $e");
  //     logger.e("Stacktrace: $stacktrace");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  //
  // Future<void> _updateServerStateInFirestore({
  //   bool? isActive,
  // }) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;
  //
  //   bool activeStatus = isActive ?? _determineActiveStatus();
  //   String currentPublicIp = publicIp.value;
  //
  //   Map<String, dynamic>? subServersMap;
  //   if (subServersStatus.value != null) {
  //     subServersMap = {};
  //     subServersStatus.value!.subServers.forEach((key, value) {
  //       subServersMap![key] = {
  //         'disabled': value.disabled,
  //         'running': value.running,
  //         'error': value.error,
  //       };
  //     });
  //   }
  //
  //   ServerStateModel model = ServerStateModel(
  //     publicIp: currentPublicIp,
  //     isActive: activeStatus,
  //     lastUpdated: DateTime.now(),
  //     subServers: subServersMap,
  //   );
  //
  //   await usersCollection
  //       .doc(user.uid)
  //       .collection('serverstate')
  //       .doc('current')
  //       .set(model.toMap(), SetOptions(merge: true));
  // }
  //
  // bool _determineActiveStatus() {
  //   return publicIp.value.isNotEmpty;
  // }
  //
  // Future<void> loadServerStateFromFirestore() async {
  //   final logger = Get.find<LoggerService>();
  //   final user = Auth().currentUser;
  //   if (user == null) {
  //     return;
  //   }
  //
  //   try {
  //     final docRef = usersCollection.doc(user.uid).collection('serverstate').doc('current');
  //     final docSnap = await docRef.get();
  //
  //     if (docSnap.exists && docSnap.data() != null) {
  //
  //       final data = docSnap.data()!;
  //       final stateModel = ServerStateModel.fromMap(data);
  //
  //       // Only update IP and baseurl in release mode
  //       if (runInReleaseMode) {
  //         publicIp.value = stateModel.publicIp;
  //         litd_baseurl.value = "${stateModel.publicIp}:8443";
  //       }
  //
  //       if (stateModel.subServers != null) {
  //         final subServersData = {'sub_servers': stateModel.subServers!};
  //         final fetchedStatus = SubServersStatus.fromJson(subServersData);
  //         subServersStatus.value = fetchedStatus;
  //       }
  //
  //       if (stateModel.mnemonicSeed != null && stateModel.mnemonicSeed!.isNotEmpty) {
  //         mnemonicSeed.value = stateModel.mnemonicSeed!.split(' ');
  //       }
  //     }
  //   } catch (e) {
  //     logger.e("Error loading server state: $e");
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
