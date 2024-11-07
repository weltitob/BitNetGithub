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
        print("User registered successfully");

        // Step 2: Start ECS Task
        EcsTaskStartResponse ecsResponse = await startEcsTask(taskTag);
        publicIp.value = ecsResponse.details!.publicIp;
        print("Public IP: ${publicIp.value}");

        // Step 3: Generate Seed
        dynamic genseedResponse = await generateSeed(publicIp.value);
        print("Seed generation response: $genseedResponse");

        // Step 4: Initialize Wallet
        dynamic initWalletResponse = await initWallet(publicIp.value);
        print("Wallet initialization response: $initWalletResponse");

        // Step 5: Unlock Wallet
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
