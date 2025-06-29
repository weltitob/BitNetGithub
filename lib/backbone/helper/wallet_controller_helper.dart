import 'package:get/get.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';

/// Helper class for safely accessing WalletsController
class WalletControllerHelper {
  /// Safely get WalletsController instance
  /// Returns null if controller is not registered
  static WalletsController? get safeFind {
    if (Get.isRegistered<WalletsController>()) {
      return Get.find<WalletsController>();
    }
    return null;
  }

  /// Check if WalletsController is registered
  static bool get isRegistered => Get.isRegistered<WalletsController>();

  /// Safely execute a function with WalletsController
  /// Only executes if controller is registered
  static void safeExecute(void Function(WalletsController controller) action) {
    final controller = safeFind;
    if (controller != null) {
      action(controller);
    }
  }

  /// Ensure WalletsController is initialized
  /// Creates a new instance if not already registered
  static WalletsController ensureInitialized() {
    if (!isRegistered) {
      Get.put(WalletsController());
    }
    return Get.find<WalletsController>();
  }
}
