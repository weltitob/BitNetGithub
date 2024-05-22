import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Future<dynamic> fetchMintBatch(String batchKey) async {
  HttpOverrides.global = MyHttpOverrides();
  Logger logger = Logger();

  String restHost = 'mybitnet.com:8443';
  String macaroonPath = './pythonfunctions/keys/tapd_admin.macaroon';


  String url = 'https://$restHost/v1/taproot-assets/assets/mint/batches/$batchKey';

  // Load Macaroon file and encode to hex
  List<int> macaroonBytes = await File(macaroonPath).readAsBytes();
  String macaroon = hex.encode(macaroonBytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  try {
    Dio dio = Dio();
    var response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode == 200) {
      logger.i("RESPONSE SUCCESSFUL!");
      Map<String, dynamic> responseData = response.data;

      // Iteration through all batches
      for (var batch in responseData['batches'] ?? []) {
        logger.i("Processing batch: ${batch['batch_key'] ?? 'N/A'}");

        // Iteration through all assets in the current batch
        for (var asset in batch['assets'] ?? []) {
          var assetMeta = asset['asset_meta'] ?? {};
          var data = assetMeta['data'] ?? '';

          if (data.isEmpty) {
            logger.w("No data field for asset ${asset['name'] ?? ''}");
            continue;
          }

          logger.i("Decoding data for asset: ${asset['name'] ?? ''}");
          try {
            // Base64 decode the data
            var decodedData = base64.decode(data);
            try {
              // Attempt to interpret the decoded binary data as a UTF-8 string
              var decodedString = utf8.decode(decodedData);
              try {
                // Attempt to interpret the string as JSON
                var jsonData = jsonDecode(decodedString);
                logger.i("Decoded JSON data for asset ${asset['name'] ?? ''}: $decodedString");

              } catch (e) {
                // The decoded string is not valid JSON
                logger.w("Decoded data for asset ${asset['name'] ?? ''} is not valid JSON. Raw data: $decodedString");
              }
            } catch (e) {
              // The decoded data cannot be interpreted as UTF-8
              logger.w("Decoded data for asset ${asset['name'] ?? ''} cannot be decoded as UTF-8. It might not be text data.");
            }
          } catch (e) {
            // Error during Base64 decoding
            logger.e("Error decoding Base64 data for asset ${asset['name'] ?? ''}: $e");
          }
        }
      }

      // Return the response data
      return responseData;
    } else {
      logger.e("Failed to fetch data. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    logger.e("Error requesting mint batch: $e");
    return null;
  }
}
