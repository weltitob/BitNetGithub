import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> listAssetsWithSSL() async {
  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
  const String macaroonPath = './assets/keys/tap_admin.macaroon'; // Update the path to the macaroon file

  // Read the macaroon file
  String macaroon = await File(macaroonPath).readAsBytes().then((bytes) => base64.encode(bytes));

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    // 'User-Agent': 'Your custom user agent' // Uncomment if needed
  };

  // Make the GET request
  String url = 'https://$restHost/v1/taproot-assets/assets';
  try {
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      print('Failed to load data: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
String bytesToHex(List<int> bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
  const String macaroonPath = './assets/keys/tap_admin.macaroon'; // Update the path to the macaroon file

  // Read the macaroon file and convert it to a hexadecimal string
  String macaroon = bytesToHex(await File(macaroonPath).readAsBytes());

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    // 'User-Agent': 'Your custom user agent' // Uncomment if needed
  };

  // Make the GET request
  String url = 'https://$restHost/v1/taproot-assets/assets';
  try {
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      print('Failed to load data: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}