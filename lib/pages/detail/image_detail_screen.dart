import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageDetailScreen extends StatelessWidget {
  final String encodedData;
  final String? caption;

  const ImageDetailScreen({
    Key? key, 
    required this.encodedData,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string into bytes
    final imageType = encodedData.split(',').first.split('/').last.split(';').first;
    final base64String = encodedData.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

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
                  child: Image.memory(
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
                  ),
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