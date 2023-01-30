import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_wallet/theme.dart';

class FormTextField extends StatelessWidget {
  final String title;
  final bool isObscure;
  final TextEditingController? controller;
  final dynamic? validator;
  final dynamic? onChanged;
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
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: validator,
        controller: controller,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: title,
          fillColor: AppTheme.white60,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
