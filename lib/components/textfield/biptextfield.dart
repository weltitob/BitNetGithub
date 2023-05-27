import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class FormTextFieldBIP extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final List<String> bipwords;

  const FormTextFieldBIP({
    Key? key,
    required this.title,
    required this.controller,
    required this.bipwords,
  }) : super(key: key);

  @override
  State<FormTextFieldBIP> createState() => _FormTextFieldBIPState();
}

class _FormTextFieldBIPState extends State<FormTextFieldBIP> {
  bool isInsideList = false;

  void initState(){
    super.initState();
    widget.controller.addListener(_isinsideList);
  }


  void _isinsideList() {
    isInsideList = widget.bipwords.any((bipword) => (bipword == widget.controller.text));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          color: (isInsideList) ? AppTheme.successColor : AppTheme.errorColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: widget.title,
          fillColor: AppTheme.white60,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}