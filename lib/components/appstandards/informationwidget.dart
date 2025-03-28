import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class InformationWidget extends StatelessWidget {
  final String title;
  final String description;

  const InformationWidget({
    Key? key, // Accepting a Key as an optional parameter
    required this.title,
    required this.description,
  }) : super(key: key); // Passing the Key to the superclass

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: AppTheme.elementSpacing * 1,
          ),
          Text(description),
        ],
      ),
    );
  }
}
