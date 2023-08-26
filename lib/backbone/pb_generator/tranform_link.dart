import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> urlToXFile(String url) async {
  try {
    // Downloading the file from the URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Error downloading file');
    }

    // Getting a directory to store the file
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${DateTime.now().toIso8601String()}';

    // Writing the file to the local storage
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    // Creating an XFile instance from the local file path
    return XFile(file.path);

  } catch (e) {
    print('Error converting URL to XFile: $e');
    return null;
  }
}
