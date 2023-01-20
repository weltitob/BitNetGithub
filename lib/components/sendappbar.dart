import 'package:flutter/material.dart';
import 'package:nexus_wallet/theme.dart';

AppBar appBarSend(context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();},
        icon: const Icon(Icons.arrow_back)),
    elevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Send Bitcoin",
            style: Theme.of(context).textTheme.headline6
        ),
        Text("1.23BTC available",
            style: Theme.of(context).textTheme.bodyText2),
      ],
    ),
    backgroundColor: AppTheme.colorBackground,
  );
}
