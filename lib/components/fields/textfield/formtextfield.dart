import 'dart:ui';

import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatefulWidget {
  final Function()? changefocustonext;
  final String hintText;
  final bool isObscure;
  final bool isBIPField;
  final List<String>? bipwords;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final dynamic validator;
  final dynamic onChanged;
  final TextInputAction? textInputAction;
  final dynamic onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? prefixText;
  final Widget? suffixIcon;

  const FormTextField({
    Key? key,
    required this.hintText,
    required this.isObscure,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.changefocustonext,
    this.isBIPField = false,
    this.bipwords,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.labelText,
    this.prefixText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool isInsideList = false;
  bool movedToNext = false;

  void initState() {
    super.initState();
    widget.controller?.addListener(_isinsideList);
  }

  void _isinsideList() {
    if (widget.isBIPField) {
      isInsideList = widget.bipwords
              ?.any((bipword) => (bipword == widget.controller?.text)) ??
          false;
      setState(() {
        if (isInsideList && !movedToNext) {
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
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusMid,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusMid,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  color: AppTheme.colorGlassContainer,
                ),
                child: TextFormField(
                  validator: widget.validator,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  inputFormatters: widget.inputFormatters,
                  textAlign: TextAlign.center,
                  style: (widget.isBIPField)
                      ? Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: (isInsideList)
                                ? AppTheme.successColor
                                : AppTheme.errorColor,
                          )
                      : Theme.of(context).textTheme.titleSmall,
                  obscureText: widget.isObscure,
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    prefixText: widget.prefixText,
                    suffixIcon: widget.suffixIcon,
                    fillColor: AppTheme.white60,
                    focusedBorder: GradientOutlineInputBorder(
                      isFocused: true,
                      borderRadius: AppTheme.cardRadiusMid,
                      borderWidth: 2,
                    ),
                    enabledBorder: GradientOutlineInputBorder(
                      isFocused: false,
                      borderRadius: AppTheme.cardRadiusMid,
                      borderWidth: 1.5,
                    ),
                  ),
                  onChanged: widget.onChanged,
                ))),
      ),
    );
  }
}

