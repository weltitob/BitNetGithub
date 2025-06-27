import 'package:local_auth/local_auth.dart';

// Define a class to handle biometric authentication
class BiometricHelper {
  final LocalAuthentication _auth =
      LocalAuthentication(); // Create a LocalAuthentication object

  // Check if the device has any biometric authentication types available
  Future<bool> hasEnrolledBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Authenticate the user using biometric authentication
  Future<bool> authenticate() async {
    final bool didAuthenticate = await _auth.authenticate(
        localizedReason:
            'Please authenticate to proceed', // Provide a localized reason for authentication
        options: const AuthenticationOptions(
            biometricOnly: true)); // Only allow biometric authentication
    return didAuthenticate;
  }
}
