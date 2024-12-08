import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/stop_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'dart:async';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;

class LitdController extends GetxController   { //BaseController
  //the app either needs to store the information about the resepctive container or smth

  RxString litd_baseurl= '${AppTheme.baseUrlLightningTerminal}'.obs;
  // Define observable states
  var isLoading = false.obs;
  var publicIp = ''.obs;
  var registrationSuccess = false.obs;
  var mnemonicSeed = [].obs;

  //login
  dynamic loginAndStartEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await startEcsTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");
  }

  //logout
  dynamic logoutAndStopEcs(String taskTag) async {
    final logger = Get.find<LoggerService>();
    dynamic statusresult = await stopUserTask(taskTag);
    logger.i("Result received now: ${statusresult.toString()}");
  }

  // Method to handle full registration and setup
  dynamic registerAndSetupUser(String taskTag, String mnemonicString) async {
    try {

      final logger = Get.find<LoggerService>();
      logger.i("AWS ECS Register and setup user called");

      isLoading.value = true;
      // Step 1: Register the user
      int resultStatus = await registerUserWithEcsTask(taskTag);

      if (resultStatus == 200) {
        final logger = Get.find<LoggerService>();
        print("User registered successfully");

        // Step 2: Start ECS Task
        EcsTaskStartResponse ecsResponse = await startEcsTask(taskTag);
        publicIp.value = ecsResponse.details!.publicIp;
        print("Public IP: ${publicIp.value}");

        litd_baseurl.value = "${ecsResponse.details!.publicIp}:8443";
        String mnemonic = mnemonicString;

        // make a list of strings from the mnemonic
        List<String> mnemonicSeed = mnemonic.split(' ');

        String seed = bip39.mnemonicToSeedHex(mnemonic);
        print('Seed derived from mnemonic:\n$seed\n');
        dynamic macaroon_root_key = seed;

        dynamic time2 = await Timer(Duration(seconds: 10), () => logger.i('10 seconds passed'));

        dynamic initWalletResponse = await initWallet(mnemonicSeed, macaroon_root_key);
        logger.i("Wallet initialization response: $initWalletResponse");

        // Step 5: Unlock Wallet
        //braucht man gar nicht mehr nach init wallet vllt weil es das automatisch macht da sbrauchen wir aber für den login maybe wenn wir nen bestehenden container neu hochfahren
        // dynamic unlockWalletResponse = await unlockWallet();
        // print("Wallet unlock response: $unlockWalletResponse");

        //check if the litd service is available

        // Indicate success
        registrationSuccess.value = true;
      } else {
        print("Registration failed");
        registrationSuccess.value = false;
      }
    } catch (error) {
      print("Error occurred: $error");
      registrationSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onInit() {

  }

  @override
  void dispose() {

  }
}


