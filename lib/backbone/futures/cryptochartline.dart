import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart'; // Adjust the import based on your project structure
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';

class CryptoChartLine {
  final String crypto;
  final String days;
  final String currency;

  CryptoChartLine({
    required this.crypto,
    required this.days,
    required this.currency,
  });

  // List to store the chart data
  List<ChartLine> chartLine = [];

  // Function to fetch chart data from Firestore
  Future<void> getChartData() async {
    // Retrieve the logger instance
    LoggerService logger = Get.find<LoggerService>();
    logger.d("Fetching chart data for $crypto... $days days, $currency currency");

    try {
      // Initialize Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Map 'days' to the corresponding timeframe label used in Firestore
      String timeframe = _mapDaysToTimeframe(days);

      // Reference to the specific document in Firestore
      DocumentReference dataRef = firestore
          .collection('chart_data')
          .doc(currency.toUpperCase())
          .collection(timeframe)
          .doc('data');

      // Fetch the document
      DocumentSnapshot docSnapshot = await dataRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        if (timeframe.toLowerCase() == 'live') {
          // Handle live data which contains a single price point
          double? price = data['price']?.toDouble();
          if (price != null) {
            // Use the current timestamp as the time value
            double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
            chartLine.add(ChartLine(time: currentTime, price: price));
          } else {
            logger.e("Price data is missing in Firestore for $currency > $timeframe");
          }
        } else {
          // Handle historical chart data
          List<dynamic>? chartDataList = data['chart_line'];
          if (chartDataList != null) {
            for (var element in chartDataList) {
              double? time = element['time']?.toDouble();
              double? price = element['price']?.toDouble();
              if (time != null && price != null) {
                chartLine.add(ChartLine(time: time, price: price));
              } else {
                logger.i("Incomplete chart data point: $element");
              }
            }
          } else {
            logger.e("Chart line data is missing in Firestore for $currency > $timeframe");
          }
        }
      } else {
        logger.e("No chart data found in Firestore for $currency > $timeframe");
      }
    } catch (e) {
      logger.e("Error fetching chart data from Firestore: $e");
    }
  }

  // Helper function to map 'days' parameter to Firestore timeframe labels
  String _mapDaysToTimeframe(String days) {
    switch (days) {
      case '1':
        return '1T'; // 1 day
      case '7':
        return '1W'; // 7 days
      case '30':
        return '1M'; // 30 days
      case '365':
        return '1J'; // 365 days
      case 'max':
        return 'Max'; // Maximum available data
      case 'live':
        return 'live'; // Live data
      default:
        return '1T'; // Default to 1 day if unrecognized
    }
  }
}
