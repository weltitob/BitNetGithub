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

  // Checks if the string is likely an asset path or a Base64 image
  bool _isAssetPath(String data) {
    return data.startsWith('assets/') || 
           data.endsWith('.png') || 
           data.endsWith('.jpg') || 
           data.endsWith('.jpeg') || 
           data.endsWith('.webp') || 
           data.endsWith('.gif');
  }

  // Checks if the string is a URL
  bool _isUrl(String data) {
    return data.startsWith('http://') || data.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    // Check if it's an asset path or Base64
    final bool isAsset = _isAssetPath(encodedData);
    final bool isUrl = _isUrl(encodedData);
    
    // Widget to display the image
    Widget imageWidget;
    
    if (isAsset) {
      // Handle asset images (local paths)
      imageWidget = Image.asset(
        encodedData,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 50,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    } else if (isUrl) {
      // Handle network images
      imageWidget = Image.network(
        encodedData,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 50,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    } else {
      // Try to handle as Base64
      try {
        // Handle Base64 images
        String base64String = encodedData;
        if (encodedData.contains(',')) {
          base64String = encodedData.split(',').last;
        }
        
        Uint8List imageBytes = base64Decode(base64String);
        imageWidget = Image.memory(
          imageBytes,
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 50,
            child: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        );
      } catch (e) {
        // If Base64 decoding fails, display an error
        imageWidget = Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: 4),
              Text(
                'Invalid image format',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigate to detail view when image is tapped
        final uri = Uri(
          path: '/image_detail',
          queryParameters: {
            'data': encodedData,
            if (caption != null) 'caption': caption,
            'isAsset': isAsset.toString(),
          },
        );
        // Use push instead of go to maintain navigation stack
        context.push(uri.toString());
      },
      child: AspectRatio(
        aspectRatio: 1.0, // Force 1:1 aspect ratio
        child: ImageBox(
          radius: radius ?? AppTheme.cardRadiusSuperSmall.r,
          child: imageWidget,
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