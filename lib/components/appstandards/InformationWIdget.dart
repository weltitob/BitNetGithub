import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class InformationWidget extends StatelessWidget {
  final String title;
  final String description;

  const InformationWidget({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: AppTheme.elementSpacing * 1,
          ),
          Text(description),
        ],
      ),
    );
  }
}