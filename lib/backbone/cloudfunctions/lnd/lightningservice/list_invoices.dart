
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Future<RestResponse> listInvoices({bool pending_only = false}) async {
//   LoggerService logger = Get.find();

//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;

//   // String restHost = AppTheme.baseUrlLightningTerminal;
//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
//   String url = 'https://$restHost/v1/invoices?pending_only=$pending_only';

//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);

//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };

//   HttpOverrides.global = MyHttpOverrides();

//   //data still needs to add the include_incomplete parameter

//   try {
//     final DioClient dioClient = Get.find<DioClient>();
//     var response = await dioClient.get(url: url, headers: headers);
//     // Print raw response for debugging
//     logger.d('Raw Response Invoices: ${response.data}');

//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(
//           statusCode: "${response.statusCode}",
//           message: "Successfully retrieved Lightning Invoices",
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

Future<List<ReceivedInvoice>> listInvoices(String acc,
    {bool pending_only = false}) async {
  QuerySnapshot<Map<String, dynamic>> query =
      await backendRef.doc(acc).collection('invoices').get();
  List<ReceivedInvoice> invoices =
      query.docs.map((map) => ReceivedInvoice.fromJson(map.data())).toList();
  if (pending_only) {
    invoices.removeWhere(
        (invoice) => invoice.state == "SETTLED" || invoice.state == "CANCELED");
  }
  return invoices;
}
