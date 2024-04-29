import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/background_push.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/client_manager.dart';

import 'package:bitnet/backbone/security/biometrics/biometric_helper.dart';
import 'package:bitnet/backbone/security/security.dart';
import 'package:matrix/matrix.dart';
import 'package:universal_html/html.dart' as html;

class WidgetTreeController extends GetxController {
  RxBool hasBiometrics = true.obs;
  RxBool isSecurityChecked = false.obs;
  RxBool isBioAuthenticated = false.obs;
  AppLinks? appLinks;
  RxString? initialUrl = ''.obs;

  RxBool? columnMode = false.obs;
  List<Client> clients = [];
  RxBool isLoadingClients = true.obs;

  @override
  void onInit() {
    super.onInit();
    getclientsfunc();
    isBiometricsAvailable();
    appLinks = AppLinks(
      onAppLink: (Uri uri, String string) {
        // Handle the deep link here. You can push to a new page, or perform
        // some action based on the data in the URI.
        print('Got deep link: $uri');
      },
    );
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked.value = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if (isSecurityChecked.value == true) {
      hasBiometrics.value = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        isBioAuthenticated.value = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated.value == false;
      }
    } else {
      hasBiometrics.value = false;
    }
  }

  getclientsfunc() async { 
  Stopwatch stopwatch = Stopwatch()..start();

  try {
    print('getting clients///////');
    clients = await ClientManager.getClients();
    print('gotted the clients////////////');
    isLoadingClients.value = false;
    print("Fetched clients: ${clients.toString()}");

    if (clients.isNotEmpty) {
      // Preload first client if we have clients
      final firstClient = clients.first;
      await firstClient.roomsLoading;
      await firstClient.accountDataLoading;
 
      print("clients after loading: $clients");

      if (PlatformInfos.isMobile) {
        BackgroundPush.clientOnly(clients.first);
      }
    }

    // Load query parameters if it's a web platform
    if (kIsWeb) {
      final queryParameters = Uri.parse(html.window.location.href).queryParameters;
      print("Loaded query parameters: $queryParameters");
    }

    print("Loading should be finished");
  } catch (e) {
    throw Exception("error loading matrix: $e");
  }

  // Set initial URL based on platform and client status
  if (kIsWeb) {
    initialUrl!.value = '/website';
  } else {
    if (clients.isNotEmpty && clients.any((client) => client.isLogged())) {
      initialUrl!.value = '/feed';
    } else {
      initialUrl!.value = '/authhome';
    }
  }

  stopwatch.stop();
  print("Execution Time: ${stopwatch.elapsedMilliseconds} milliseconds");


  }
}
