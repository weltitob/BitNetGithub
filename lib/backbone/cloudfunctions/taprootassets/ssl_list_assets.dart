import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:get/get.dart';
//
// //might be a stream need to check
// Future<void> listAssetsWithSSL() async {
//   String restHost = AppTheme.baseUrlLightningTerminal;
//   const String macaroonPath =
//       './assets/keys/tap_admin.macaroon'; // Update the path to the macaroon file
//
//   // Read the macaroon file
//   String macaroon = await File(macaroonPath)
//       .readAsBytes()
//       .then((bytes) => base64.encode(bytes));
//
//   // Prepare the headers
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//     // 'User-Agent': 'Your custom user agent' // Uncomment if needed
//   };
//
//   // Make the GET request
//   String url = 'https://$restHost/v1/taproot-assets/assets';
//   try {
//       final DioClient dioClient = Get.find<DioClient>();
//
//     var response = await dioClient.get(url: url, headers: headers);
//
//     if (response.statusCode == 200) {
//       // If server returns an OK response, parse the JSON
//       print(json.decode(response.data));
//     } else {
//       // If the server did not return a 200 OK response, throw an exception.
//       print('Failed to load data: ${response.statusCode}, ${response.data}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
