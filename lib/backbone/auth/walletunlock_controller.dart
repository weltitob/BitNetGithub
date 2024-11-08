import 'dart:async';

import 'package:bitnet/backbone/auth/macaroon_mnemnoic.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/unlock_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';

class RegistrationController extends GetxController {
  // Define observable states
  var isLoading = false.obs;
  var publicIp = ''.obs;
  var registrationSuccess = false.obs;

  // Method to handle full registration and setup
  dynamic registerAndSetupUser(String taskTag) async {
    try {

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

        // Step 3: Generate Seed
        //would like to skip this step and generate locally if possible
        //can be skipped if we use root key in the next step

        dynamic time = await Timer(Duration(seconds: 3), () => logger.i('10 seconds passed'));


        //Relationship Between Mnemonic and Macaroon Root Key: By default, lnd generates the macaroon root key independently of the mnemonic. However, for scenarios requiring deterministic or pre-generated macaroons, you can derive the macaroon root key from the wallet's seed. This approach ensures that the macaroon root key is reproducible from the mnemonic, facilitating consistent authorization tokens across different instances.
        // dynamic genseedResponse = await generateSeed(publicIp.value);
        // print("Seed generation response: $genseedResponse");

        // Step 4: Initialize Wallet
        //macaroon_root_key is an optional 32 byte macaroon root key that can be provided when initializing the wallet rather than letting lnd generate one on its own.#

        //maybe zu schnell oder somehow called der das 3mal
        List<String> mnemonicSeed = [
          'about', 'double', 'estate', 'saddle', 'floor', 'where', 'nut', 'soon',
          'beach', 'address', 'describe', 'maple', 'child', 'razor', 'claim', 'mountain',
          'kitten', 'struggle', 'boost', 'useful', 'prevent', 'baby', 'more', 'rescue'
        ];

        String mnemonic = mnemonicSeed.join(' ');

        //generate a custom admin macaroon root key
        dynamic macaroon_root_key =  deriveMacaroonRootKey(mnemonic);



        dynamic time2 = await Timer(Duration(seconds: 10), () => logger.i('10 seconds passed'));

        dynamic initWalletResponse = await initWallet(publicIp.value, mnemonicSeed, macaroon_root_key);
        print("Wallet initialization response: $initWalletResponse");

        // Step 5: Unlock Wallet
        //braucht man gar nicht mehr nach init wallet vllt weil es das automatisch macht da sbrauchen wir aber für den login maybe wenn wir nen bestehenden container neu hochfahren
        dynamic unlockWalletResponse = await unlockWallet(publicIp.value);
        print("Wallet unlock response: $unlockWalletResponse");

        //4. change the password to the key
        //dynamic passwordchange_response = unlockWallet();

        //5. check the status of the wallet services
        //dynamic status_response = unlockWallet();

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
}
