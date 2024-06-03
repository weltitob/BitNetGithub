import 'package:app_links/app_links.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_helper.dart';
import 'package:bitnet/backbone/security/security.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:get/get.dart';

class WidgetTreeController extends BaseController {
  RxBool hasBiometrics = true.obs;
  RxBool isSecurityChecked = false.obs;
  RxBool isBioAuthenticated = false.obs;
  AppLinks? appLinks;
  RxString? initialUrl = ''.obs;

  RxBool? columnMode = false.obs;
  RxBool isLoadingClients = true.obs;

  @override
  void onInit() {
    super.onInit(); 
    isBiometricsAvailable();
    appLinks = AppLinks(
      onAppLink: (Uri uri, String string) { 
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
}
