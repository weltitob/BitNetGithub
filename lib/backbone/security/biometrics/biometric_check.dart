
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';
import 'package:BitNet/backbone/security/security.dart';

bool hasBiometrics =
true; // a flag indicating whether biometrics is supported on the device
bool isBioAuthenticated =
false; // a flag indicating whether the user has successfully authenticated via biometrics
late bool
isSecurityChecked;

// This method is used to get the security check value from the shared preferences.
awaitSecurityBool() async {
  bool securitybool = await SharedPrefSecurityCheck();
  return securitybool;
}

// This method is used to check if the biometrics feature is available on the device.
isBiometricsAvailable() async {
  isSecurityChecked = await awaitSecurityBool();
  //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
  if (isSecurityChecked == true) {
    hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
    if (hasBiometrics == true) {
      print('trying to check biometrics...');
      isBioAuthenticated = await BiometricHelper().authenticate();
    } else {
      isBioAuthenticated == false;
    }
  } else {
    hasBiometrics = false;
  }
}
