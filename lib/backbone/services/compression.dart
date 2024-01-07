import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

compressImage(file, postId) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    return compressedImageFile;
  }
  catch(e)
  {
    return file;
  }
}