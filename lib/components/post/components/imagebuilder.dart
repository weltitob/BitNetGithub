import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//USED FOR UPLOAD SCREEN (USER PICKS FILE LOCALLY)
class ImageBuilderLocal extends StatelessWidget {
  final PostFile postFile;
  const ImageBuilderLocal({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the image in a dialog when tapped
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fullscreen image
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.file(
                    postFile.file!,
                    fit: BoxFit.contain,
                  ),
                ),
                // Close button
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.0, // Force 1:1 aspect ratio
        child: ImageBox(
          radius: AppTheme.cardRadiusMid.r,
          child: Image.file(
            postFile.file!,
            fit: BoxFit.cover, // Cover ensures the image fills the space
            errorBuilder: (context, error, stackTrace) => Container(
              height: AppTheme.cardPadding * 5,
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//USED FOR POSTS IN FEED ETC. IMAGE IS FETCHED FROM DATABASE
class ImageBuilder extends StatelessWidget {
  final String encodedData;
  final BorderRadius? radius;
  final String? caption;
  const ImageBuilder({
    Key? key,
    required this.encodedData,
    this.radius,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string into bytes
    final imageType =
        encodedData.split(',').first.split('/').last.split(';').first;
    final base64String = encodedData.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    return GestureDetector(
      onTap: () {
        // Navigate to detail view when image is tapped
        final uri = Uri(
          path: '/image_detail',
          queryParameters: {
            'data': encodedData,
            if (caption != null) 'caption': caption,
          },
        );
        context.go(uri.toString());
      },
      child: AspectRatio(
        aspectRatio: 1.0, // Force 1:1 aspect ratio
        child: ImageBox(
          radius: radius ?? AppTheme.cardRadiusSuperSmall.r,
          child: Image.memory(
            imageBytes,
            filterQuality: FilterQuality.medium,
            fit: BoxFit.cover, // Cover ensures the image fills the space
            errorBuilder: (context, error, stackTrace) => Container(
              height: 50,
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final Widget child;
  final BorderRadius radius;
  const ImageBox({
    required this.child,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2.5),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: child,
          ),
        ),
      ],
    );
  }
}