import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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
    logger
        .d("Fetching chart data for $crypto... $days days, $currency currency");

    try {
      // Initialize Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Map 'days' to the corresponding timeframe label used in Firestore
      String timeframe = _mapDaysToTimeframe(days);

      // Reference to the specific document in Firestore

      if (timeframe.toLowerCase() == 'live') {
        DocumentReference dataRef = firestore
            .collection('chart_data')
            .doc(currency.toUpperCase())
            .collection(timeframe)
            .doc('data');

        // Fetch the document
        DocumentSnapshot docSnapshot = await dataRef.get();
        if (docSnapshot.exists) {
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;

          // Handle live data which contains a single price point
          double? price = data['price']?.toDouble();
          if (price != null) {
            // Use the current timestamp as the time value
            double currentTime =
                DateTime.now().millisecondsSinceEpoch.toDouble();
            chartLine.add(ChartLine(time: currentTime, price: price));
          } else {
            logger.e(
                "Price data is missing in Firestore for $currency > $timeframe");
          }
        } else {
          logger
              .e("No chart data found in Firestore for $currency > $timeframe");
        }
      } else {
        // Handle historical chart data
        int? count = (await firestore
                .collection('chart_data')
                .doc(currency.toUpperCase())
                .collection(timeframe)
                .doc('data')
                .collection("data_points")
                .count()
                .get())
            .count;
        late Query<Map<String, dynamic>> dataRef;
        print("docs count for ${days} and ${currency} is ${count}");
        if (count != null && count > 500) {
          dataRef = firestore
              .collection('chart_data')
              .doc(currency.toUpperCase())
              .collection(timeframe)
              .doc('data')
              .collection("data_points")
              .where("index", isEqualTo: 1);
          logger.i(
              "retrieving chart data for ${days} and ${currency} only when index == 1");
        } else {
          dataRef = firestore
              .collection('chart_data')
              .doc(currency.toUpperCase())
              .collection(timeframe)
              .doc('data')
              .collection("data_points");
          logger.i("retrieving all chart data for ${days} and ${currency}");
        }
        // Fetch the document
        late QuerySnapshot<Map<String, dynamic>> docSnapshot;
        await dataRef.get().then((val) {
          docSnapshot = val;
        }, onError: (e) {
          logger.e(e);
        });
        if (docSnapshot.docs.isNotEmpty) {
          List<dynamic>? chartDataList =
              docSnapshot.docs.map((doc) => doc.data()).toList();
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
          logger.e(
              "Chart line data is missing in Firestore for $currency > $timeframe");
        }
      }
    } catch (e) {
      logger.e("Error fetching chart data from Firestore: $e");
    }
  }

  // Helper function to map 'days' parameter to Firestore timeframe labels
  String _mapDaysToTimeframe(String days) {
    switch (days) {
      case '1':
        return '1D'; // 1 day
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
        return '1D'; // Default to 1 day if unrecognized
    }
  }
}
