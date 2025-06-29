import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Future<RestResponse> getTransactions() async {
//   LoggerService logger = Get.find();
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;
//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
//   String url = 'https://$restHost/v1/transactions';

//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);

//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };

//   HttpOverrides.global = MyHttpOverrides();

//   try {
//       final DioClient dioClient = Get.find<DioClient>();
//     var response = await dioClient.get(
//       url: url,
//       headers: headers,
//     );
//     // Print raw response for debugging
//     logger.d('Raw Response Transactions: ${response.data}');

//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(
//           statusCode: "${response.statusCode}",
//           message: "Successfully retrieved OnChain Transactions",
//           data: response.data);
//     } else {
//       print('Failed to load data: ${response.statusCode}, ${response.data}');
//       return RestResponse(
//           statusCode: "error",
//           message:
//               "Failed to load data: ${response.statusCode}, ${response.data}",
//           data: {});
//     }
//   } catch (e) {
//     print('Error: $e');
//     return RestResponse(
//         statusCode: "error",
//         message:
//             "Failed to load data: Could not get response from Lightning node!",
//         data: {});
//   }
// }

Future<List<BitcoinTransaction>> getTransactions(String acc) async {
  QuerySnapshot<Map<String, dynamic>> query =
      await backendRef.doc(acc).collection('transactions').get();
  List<BitcoinTransaction> transactions =
      query.docs.map((map) => BitcoinTransaction.fromJson(map.data())).toList();
  return transactions;
}
