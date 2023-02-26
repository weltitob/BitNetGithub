import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;
  final BuildContext context;

  NumericalRangeFormatter({
    required this.min,
    required this.max,
    required this.context,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toString());
    } else if (double.parse(newValue.text) > max){
      displaySnackbar(context, "You dont have enough Bitcoin");
      return oldValue;
    } else return newValue;
  }
}

class DotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    int numDots = RegExp(r"\.").allMatches(oldValue.toString()).length;
    print("The string '$oldValue' contains $numDots dots.");

    int newDots = RegExp(r"\.").allMatches(newValue.toString()).length;
    print("The string '$newValue' contains $newDots dots.");

    //flutter thinks there are two more dots then there really are
    if (numDots >= 3) {
      return oldValue;
    } else if (newDots == 2) {
      return newValue;
    } else if (newDots == 3) {
      return newValue;
    }
    else if (newDots > 3) {
      return oldValue;
    }
    else return newValue;
  }
}

