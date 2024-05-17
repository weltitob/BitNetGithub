import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final LoggerService logger = Get.find<LoggerService>();

  final DioClient dioClient = Get.find<DioClient>();

  // Controller Lifecycle Methods
  @override
  void onInit() async {
    super.onInit();
    logger.i('onInit: $runtimeType');
  }

  @override
  void onReady() {
    super.onReady();
    logger.i('onReady: $runtimeType');
  }

  @override
  void onClose() {
    super.onClose();
    logger.i('onClose: $runtimeType');
  }

  // Routing Methods

  void goBack() {
    Get.back();
  }
}
