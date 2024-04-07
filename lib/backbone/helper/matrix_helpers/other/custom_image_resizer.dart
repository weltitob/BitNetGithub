import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fc_native_image_resize/fc_native_image_resize.dart' as native;
import 'package:blurhash_ffi/blurhash_ffi.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:image/image.dart' as img;


Future<MatrixImageFileResizedResponse?> customImageResizer(
  MatrixImageFileResizeArguments arguments,
) async {
  
  // await native.init();
  // late native.Image nativeImg;

  // try {
  //   nativeImg = await native.Image.loadEncoded(arguments.bytes); // load on web
  // } on UnsupportedError {
  //   try {
  //     // for the other platforms
      // final dartCodec = await instantiateImageCodec(arguments.bytes);
      // final dartFrame = await dartCodec.getNextFrame();
      // final rgbaData = await dartFrame.image.toByteData();
  //     if (rgbaData == null) {
  //       return null;
  //     }
  //     final rgba = Uint8List.view(
  //       rgbaData.buffer,
  //       rgbaData.offsetInBytes,
  //       rgbaData.lengthInBytes,
  //     );

  //     final width = dartFrame.image.width;
  //     final height = dartFrame.image.height;

  //     dartFrame.image.dispose();
  //     dartCodec.dispose();

  //     nativeImg = native.Image.fromRGBA(width, height, rgba);
  //   } catch (e, s) {
  //     Logs().e("Could not generate preview", e, s);
  //     rethrow;
  //   }
  // }

  // final width = nativeImg.width;
  // final height = nativeImg.height;


  //   final scaledImg = nativeImg.resample(w, h, native.Transform.lanczos);
  //   nativeImg.free();
  //   nativeImg = scaledImg;
  // }
  // final jpegBytes = await nativeImg.toJpeg(75);
    MemoryImage oldImage = MemoryImage(arguments.bytes);
      ui.Image uiImage = await decodeImageFromList(arguments.bytes);
  final max = arguments.maxDimension;
  if (uiImage.width > max || uiImage.height > max) {
    var w = max, h = max;
    if (uiImage.width > uiImage.height) {
      h = max * uiImage.height ~/ uiImage.width;
    } else {
      w = max * uiImage.width ~/ uiImage.height;
    }
  img.Image newImg = img.copyResize(img.Image.fromBytes(width: uiImage.width, height: uiImage.height, bytes: arguments.bytes.buffer),width: w, height: h );
    Uint8List bytes = newImg.getBytes();
  MemoryImage memoryImage = MemoryImage(bytes);
  String blurHash = await BlurhashFFI.encode(memoryImage,componentX: 3, componentY: 3);
  return MatrixImageFileResizedResponse(
    bytes: bytes,
    width: newImg.width,
    height: newImg.height,
    blurhash: arguments.calcBlurhash ? blurHash : null,
  );
  }
}
