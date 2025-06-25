import 'dart:io';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> urlToXFile(String url) async {
  try {
    final DioClient dioClient = Get.find<DioClient>();

    // Downloading the file from the URL
    final response = await dioClient.get(url: url);
    if (response.statusCode != 200) {
      throw Exception('Error downloading file');
    }

    // Getting a directory to store the file
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${DateTime.now().toIso8601String()}';

    // Writing the file to the local storage
    final file = File(filePath);
    await file.writeAsBytes(response.data);

    // Creating an XFile instance from the local file path
    return XFile(file.path);
  } catch (e) {
    print('Error converting URL to XFile: $e');
    return null;
  }
}
