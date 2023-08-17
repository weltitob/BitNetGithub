import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomTabContent extends StatelessWidget {
  final String imageUrl;
  final String text;

  const CustomTabContent({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,  // Adjust the size as needed
          backgroundImage: CachedNetworkImageProvider(imageUrl),
          backgroundColor: Colors.transparent, // or another color if you want a background
        ),
        SizedBox(width: AppTheme.elementSpacing / 3),  // Give some spacing between the image and the text
        Text(
          text,
          style: AppTheme.textTheme.bodyMedium!.copyWith(
              color: AppTheme.white80,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: AppTheme.elementSpacing),
      ],
    );
  }
}
