import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Centers the column vertically
          children: [
            // Image Widget: Replace the path with your own image asset
            Image.asset(
              'assets/images/monkey.webp', // Update this path
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
              fit: BoxFit.contain, // Adjust how the image should fit
            ),
            const SizedBox(height: AppTheme.cardPadding * 2), // Spacing between image and text
            Text(
              'Coming soon...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

