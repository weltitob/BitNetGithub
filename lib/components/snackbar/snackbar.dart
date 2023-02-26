import 'package:flutter/material.dart';
import 'package:nexus_wallet/theme.dart';

displaySnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text,
    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppTheme.black90),),
    elevation: 0.0,
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppTheme.elementSpacing * 1.5)),
    ),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar).closed
      .then((value) => ScaffoldMessenger.of(context).clearSnackBars());;
}