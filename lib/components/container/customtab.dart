import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';

class CustomTabContent extends StatelessWidget {
  final dynamic mxContent;
  final String text;
  final Function()? onTap;

  const CustomTabContent({
    Key? key,
    required this.mxContent,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppTheme.elementSpacing / 2),
        Avatar(
          mxContent: mxContent,
          size: 30,
          isNft: false,
        ),
        SizedBox(width: AppTheme.elementSpacing / 2),
        Text(
          text,
          style: AppTheme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: AppTheme.elementSpacing),
      ],
    );
  }
}
