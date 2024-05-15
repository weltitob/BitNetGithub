import 'package:bitnet/backbone/services/base_controller/base_service.dart';
import 'package:logger/logger.dart';

class LoggerService extends BaseService {
  late final Logger logger;

  @override
  void onInit() {
    super.onInit();

    logger = Logger(
        printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 5,
            lineLength: 75,
            colors: true,
            printEmojis: true,
            printTime: false));
  }

  void d(Object message) {
    logger.d(message);
  }

  void i(Object message) {
    logger.i(message);
  }

  void e(Object message) {
    logger.e(message);
  }
}
