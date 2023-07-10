import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextField extends StatefulWidget {
  final Function()? changefocustonext;
  final String title;
  final bool isObscure;
  final bool isBIPField;
  final List<String>? bipwords;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final dynamic validator;
  final dynamic onChanged;

  const FormTextField({
    Key? key,
    required this.title,
    required this.isObscure,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.changefocustonext,
    this.isBIPField = false,
    this.bipwords,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField>  {
  bool isInsideList = false;
  bool movedToNext = false;

  void initState() {
    super.initState();
    widget.controller?.addListener(_isinsideList);
  }

  void _isinsideList() {
    if (widget.isBIPField) {
      isInsideList = widget.bipwords?.any((bipword) =>
      (bipword == widget.controller?.text)) ?? false;
      setState(() {
        if(isInsideList && !movedToNext){
          print("should changefocustonext");
          widget.changefocustonext?.call();
          movedToNext = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        style: (widget.isBIPField)
            ? Theme.of(context).textTheme.titleSmall!.copyWith(
          color: (isInsideList) ? AppTheme.successColor : AppTheme.errorColor,
        )
            : Theme.of(context).textTheme.titleSmall,
        obscureText: widget.isObscure,
        decoration: InputDecoration(
          hintText: widget.title,
          fillColor: AppTheme.white60,
          border: OutlineInputBorder(
              borderRadius: AppTheme.cardRadiusMid
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
