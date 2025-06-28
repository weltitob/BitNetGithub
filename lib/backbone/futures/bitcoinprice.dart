import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:provider/provider.dart';

/*
This function retrieves the latest Bitcoin price in Euro from Firestore.
*/
Future<double> getBitcoinPrice() async {
  // Retrieve the logger instance
  LoggerService logger = Get.find<LoggerService>();

  logger.d("Fetching latest Bitcoin price in EUR from Firestore.");

  try {
    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? currency =
        Provider.of<CurrencyChangeProvider>(Get.context!).selectedCurrency;
    currency = currency ?? "USD";

    // Define the Firestore path: chart_data > EUR > live > data
    DocumentReference dataRef = firestore
        .collection('chart_data')
        .doc(currency)
        .collection('live')
        .doc('data');

    // Fetch the document
    DocumentSnapshot docSnapshot = await dataRef.get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // Extract the price
      double? price = data['price']?.toDouble();

      if (price != null) {
        logger.d('The current price of Bitcoin in Euro is $price');
        return price;
      } else {
        logger.e("Price data is missing in Firestore for EUR > live");
        return 0.00;
      }
    } else {
      logger.e("No chart data found in Firestore for EUR > live");
      return 0.00;
    }
  } catch (e) {
    logger.e("Error fetching Bitcoin price from Firestore: $e");
    return 0.00;
  }
}
