import 'dart:ui';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatefulWidget {
  final dynamic onTapOutside;
  final int? maxLength;
  final bool autofocus;
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
  final bool isMultiline;
  final bool readOnly; // Add read-only property
  final double? width; // Customizable width
  final double? height; // Customizable height
  final EdgeInsets insidePadding;
  const FormTextField({
    Key? key,
    required this.hintText,
    this.isObscure = false,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onTapOutside,
    this.maxLength,
    this.autofocus = false,
    this.changefocustonext,
    this.isBIPField = false,
    this.bipwords,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.labelText,
    this.prefixText,
    this.suffixIcon,
    this.isMultiline = false,
    this.readOnly = false,
    this.width, // Add width to constructor
    this.height,
    this.insidePadding = EdgeInsets.zero, // Add height to constructor
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool isInsideList = false;
  bool movedToNext = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_isinsideList);
  }

  void _isinsideList() {
    if (widget.isBIPField && widget.controller != null) {
      isInsideList = widget.bipwords
              ?.any((bipword) => (bipword == widget.controller?.text)) ??
          false;
      List<String> matches = widget.bipwords
              ?.where((s) => s.startsWith(widget.controller!.text))
              .toList() ??
          [];
      List<String> longestMatches = findLongestWords(matches);
      setState(() {
        if (isInsideList &&
            !movedToNext &&
            (longestMatches.contains(widget.controller!.text))) {
          print("should changefocustonext");
          widget.changefocustonext?.call();
          movedToNext = true;
        } else {
          movedToNext = false;
        }
      });
    }
  }

  List<String> findLongestWords(List<String> words) {
    int maxLength = 0;
    List<String> longestWords = [];

    for (String word in words) {
      if (word.length > maxLength) {
        maxLength = word.length;
        longestWords = [word];
      } else if (word.length == maxLength) {
        longestWords.add(word);
      }
    }

    return longestWords;
  }

  @override
  Widget build(BuildContext context) {
    // Use a fallback value if widget.height is null.
    final double customHeight = widget.height ?? 100.0;
    final double borderRadiusNum = customHeight / 5.5;
    final BorderRadius borderRadius = BorderRadius.circular(borderRadiusNum);

    return Container(
      width: widget.width, // Use the custom or default width
      height: widget.height, // Use the custom or default height
      margin: const EdgeInsets.only(top: AppTheme.elementSpacing),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: widget.insidePadding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: Colors.transparent,
                width: 0.0,
              ),
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? AppTheme.white60
                      : AppTheme.colorGlassContainer,
            ),
            child: TextFormField(
              readOnly: widget.readOnly,
              onTapOutside: widget.onTapOutside,
              maxLength: widget.maxLength,
              autofocus: widget.autofocus,
              maxLines: widget.isMultiline ? null : 1,
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
                counterText: '', // Hides the counter text
                focusedBorder: GradientOutlineInputBorder(
                  isFocused: true,
                  borderRadius: borderRadius,
                  borderWidth: 3,
                ),
                enabledBorder: GradientOutlineInputBorder(
                  isFocused: false,
                  borderRadius: borderRadius,
                  borderWidth: 1.5,
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
