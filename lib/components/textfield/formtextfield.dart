import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme.dart';

class FormTextField extends StatelessWidget {
  final String title;
  final bool isObscure;
  final TextEditingController? controller;
  final dynamic validator;
  final dynamic onChanged;
  const FormTextField({
    Key? key,
    required this.title,
    required this.isObscure,
    this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing),
      child: TextFormField(
        validator: validator,
        controller: controller,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: title,
          fillColor: AppTheme.white60,
          border: OutlineInputBorder(
            borderRadius: AppTheme.cardRadiusMid
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
