import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//USED FOR UPLOAD SCREEN (USER PICKS FILE LOCALLY)
class ImageBuilderLocal extends StatelessWidget {
  final PostFile postFile;
  const ImageBuilderLocal({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBox(
      child: Image.file(
        postFile.file!,
        // height: size.height * 0.4,
        // width: double.infinity,
        // fit: BoxFit.cover,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: AppTheme.cardPadding * 5,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}

//USED FOR POSTS IN FEED ETC. IMAGE IS FETCHED FROM DATABASE
class ImageBuilder extends StatelessWidget {
  final String encodedData;

  const ImageBuilder({
    Key? key,
    required this.encodedData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string into bytes
    final imageType = encodedData.split(',').first.split('/').last.split(';').first;
    print("Image Builder detected imagetype: $imageType");
    final base64String = encodedData.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    return ImageBox(
      child: Image.memory(
        imageBytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: AppTheme.cardPadding * 4,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final Widget child;

  const ImageBox({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: AppTheme.cardRadiusMid.r,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: AppTheme.cardRadiusMid.r,
                child: child)),
      ],
    );
  }
}

