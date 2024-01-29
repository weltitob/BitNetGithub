import 'package:flutter/material.dart';

showSheet(BuildContext context,Widget myClass){
  return showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.black87.withOpacity(0.70),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    ),
    context: context,
    builder: (context) {
      return myClass;
    },
  );
}