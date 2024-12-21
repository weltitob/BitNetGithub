import 'dart:async';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:get/get.dart';

class BitcoinPriceStream {
  late final StreamController<ChartLine> _priceController;
  Timer? _timer;
  final Duration _updateInterval = const Duration(seconds: 45);
  String localCurrency = 'eur'; // Default currency

  BitcoinPriceStream() {
    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
  }

  BitcoinPriceStream.withCurrency(String currency) {
    if (localCurrency != currency) {
      localCurrency = currency.toLowerCase();
    }
    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
    _startStream();
  }

  Stream<ChartLine> get priceStream => _priceController.stream;

  void updateCurrency(String currency) {
    if (localCurrency != currency) {
      localCurrency = currency.toLowerCase();
      _restartStream();
    }
  }

  void _startStream() {
    _fetchAndUpdate();
    _timer = Timer.periodic(_updateInterval, (_) => _fetchAndUpdate());
  }

  void _stopStream() {
    _timer?.cancel();
  }

  void _restartStream() {
    _stopStream();
    _startStream();
  }

  Future<void> _fetchAndUpdate() async {
    final logger = Get.find<LoggerService>();
    logger.d("Fetching bitcoin price in $localCurrency...");

    try {
      final Map<String, String> params = {
        'ids': 'bitcoin',
        'vs_currencies': localCurrency,
        'include_last_updated_at': 'true',
        'x_cg_pro_api_key': AppTheme.coinGeckoApiKey,
      };

      final DioClient dioClient = Get.find<DioClient>();
      final String _url =
          "${AppTheme.baseUrlCoinGeckoApiPro}/simple/price?ids=bitcoin"
          "&vs_currencies=$localCurrency"
          "&include_last_updated_at='true'"
          "&x_cg_pro_api_key=${AppTheme.coinGeckoApiKey}";

      final response = await dioClient.get(url: _url);

      if (response.statusCode == 200) {
        final data = response.data;
        final double price =
        double.parse(data['bitcoin'][localCurrency].toString());

        // The API might not return `last_updated_at` as a double, so parse safely:
        final double time =
            double.tryParse(data['bitcoin']['last_updated_at'].toString()) ?? 0;

        logger.d("Price of bitcoin in $localCurrency: $price");

        final ChartLine latestChartLine = ChartLine(time: time, price: price);

        // --- IMPORTANT CHECK HERE: do not add events if closed or no one is listening.
        if (!_priceController.isClosed && _priceController.hasListener) {
          _priceController.add(latestChartLine);
        }

      } else {
        logger.e(
          "Error fetching Bitcoin price stream data: ${response.statusCode} ${response.data}",
        );
      }
    } catch (e) {
      logger.e("Error fetching Bitcoin price: $e");
    }
  }

  void dispose() {
    // Once dispose() is called, we’ll assume the stream should be closed.
    _stopStream();
    _priceController.close();
  }
}
