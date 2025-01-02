import 'dart:async';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BitcoinPriceStream {
  late final StreamController<ChartLine> _priceController;
  String localCurrency = 'usd'; // Default currency

  Stream<ChartLine> get priceStream => _priceController.stream;

  // Subscription to Firestore snapshots
  StreamSubscription<DocumentSnapshot>? _subscription;

  // Constructor without initial currency
  BitcoinPriceStream() {
    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
  }

  // Constructor with initial currency
  BitcoinPriceStream.withCurrency(String currency) {

    String? currency =
        Provider.of<CurrencyChangeProvider>(Get.context!).selectedCurrency;
    currency = currency ?? "USD";

    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
  }

  // Update currency and restart listener if needed
  void updateCurrency(String currency) {
    if (localCurrency != currency.toLowerCase()) {
      localCurrency = currency.toLowerCase();
      _restartStream();
    }
  }

  // Start listening to Firestore
  void _startStream() {
    _setupFirestoreListener();
  }

  // Stop listening to Firestore
  void _stopStream() {
    _subscription?.cancel();
    _subscription = null;
  }

  // Restart the Firestore listener
  void _restartStream() {
    _stopStream();
    _startStream();
  }

  // Setup Firestore listener
  Future<void> _setupFirestoreListener() async {
    final LoggerService logger = Get.find<LoggerService>();
    logger.d("Setting up Firestore listener for Bitcoin price in $localCurrency...");

    try {
      String? currency =
          Provider.of<CurrencyChangeProvider>(Get.context!).selectedCurrency;
      currency = currency ?? "USD";

      // Assume currency is already set via constructor or updateCurrency
      String currencyUpper = localCurrency.toUpperCase();
      DocumentReference dataRef = FirebaseFirestore.instance
          .collection('chart_data')
          .doc(currencyUpper)
          .collection('live')
          .doc('data');

      // Ensure any existing subscription is canceled before setting up a new one
      await _subscription?.cancel();

      // Set up the listener
      _subscription = dataRef.snapshots().listen((docSnapshot) {
        if (docSnapshot.exists) {
          Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

          // Extract the price
          double? price = data['price']?.toDouble();

          // Extract the last updated timestamp
          Timestamp? timestamp = data['last_updated'] as Timestamp?;
          double time = timestamp != null
              ? timestamp.toDate().millisecondsSinceEpoch.toDouble()
              : DateTime.now().millisecondsSinceEpoch.toDouble();

          if (price != null) {
            logger.d("Received Bitcoin price in $localCurrency: $price at $time");
            final ChartLine latestChartLine = ChartLine(time: time, price: price);

            // Add to the stream if there are listeners
            if (!_priceController.isClosed && _priceController.hasListener) {
              _priceController.add(latestChartLine);
            } else {
              logger.i("No listeners available to receive Bitcoin price updates.");
            }
          } else {
            logger.e("Price data is missing in Firestore for $currencyUpper > live.");
          }
        } else {
          logger.e("No document found in Firestore for $localCurrency > live.");
        }
      }, onError: (error) {
        logger.e("Error listening to Firestore for Bitcoin price: $error");
      });

      logger.d("Firestore listener successfully set up.");
    } catch (e) {
      logger.e("Exception while setting up Firestore listener: $e");
    }
  }

  // Dispose method to clean up resources
  void dispose() {
    // Once dispose() is called, we’ll assume the stream should be closed.
    _stopStream();
    _priceController.close();
  }
}
