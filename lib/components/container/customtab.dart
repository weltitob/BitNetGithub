import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomTabContent extends StatelessWidget {
  final String imageUrl;
  final String text;
  final Function()? onTap;

  const CustomTabContent({
    Key? key,
    required this.imageUrl,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppTheme.elementSpacing / 2),
        Avatar(
          mxContent: Uri.parse(imageUrl),
          size: 25,
        ),
        SizedBox(width: AppTheme.elementSpacing / 2),  // Give some spacing between the image and the text
        Text(
          text,
          style: AppTheme.textTheme.titleMedium!.copyWith(
              color: AppTheme.white80,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: AppTheme.elementSpacing),
      ],
    );
  }
}
