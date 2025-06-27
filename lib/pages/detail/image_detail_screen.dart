import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageDetailScreen extends StatelessWidget {
  final String encodedData;
  final String? caption;
  final bool isAsset;

  const ImageDetailScreen({
    Key? key,
    required this.encodedData,
    this.caption,
    this.isAsset = false,
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
    // Determine image type based on path or data format
    final bool isAssetImage = isAsset || _isAssetPath(encodedData);
    final bool isUrlImage = _isUrl(encodedData);

    // Widget to display the image
    Widget imageWidget;

    if (isAssetImage) {
      // Handle asset images
      imageWidget = Image.asset(
        encodedData,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 200,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 50,
          ),
        ),
      );
    } else if (isUrlImage) {
      // Handle network images
      imageWidget = Image.network(
        encodedData,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 200,
          child: Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 50,
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
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 200,
            child: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
              size: 50,
            ),
          ),
        );
      } catch (e) {
        // If Base64 decoding fails, display an error
        imageWidget = Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                color: Theme.of(context).colorScheme.error,
                size: 50,
              ),
              SizedBox(height: 8),
              Text(
                'Invalid image format',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        );
      }
    }

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: caption != null ? "Image" : "",
        onTap: () => Navigator.of(context).pop(),
      ),
      context: context,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(), // Tap anywhere to close
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.9),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: imageWidget,
                ),
                if (caption != null && caption!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      caption!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
