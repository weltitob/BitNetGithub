import 'dart:async';

import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationSpace extends StatefulWidget {
  final TextEditingController textEditingController;
  final StreamController<ErrorAnimationType>? errorController;
  final GlobalKey<FormState> formKey;
  final Function(String) onCompleted;
  final bool loading;
  final bool hasError;
  final String errorText;

  const VerificationSpace({
    Key? key,
    required this.textEditingController,
    this.errorController,
    required this.formKey,
    required this.onCompleted,
    this.loading = false,
    this.hasError = false,
    this.errorText = "",
  }) : super(key: key);

  @override
  _VerificationSpaceState createState() => _VerificationSpaceState();
}

class _VerificationSpaceState extends State<VerificationSpace> {
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding * 2.ws,
              vertical: AppTheme.elementSpacing.h,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding.h,
                ),
                Text(
                  L10n.of(context).invitationCode,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: AppTheme.cardPadding.h,
                ),
                Form(
                  key: widget.formKey,
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: AppTheme.white90,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedColor: Colors.orange,
                      inactiveColor: AppTheme.white60,
                      activeColor: Colors.orange,
                      shape: PinCodeFieldShape.box,
                      borderRadius: AppTheme.cardRadiusSmall,
                      fieldHeight: AppTheme.cardPaddingBig * 2,
                      fieldWidth: AppTheme.cardPadding * 2,
                      borderWidth: 2,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    backgroundColor: Colors.transparent,
                    enableActiveFill: false,
                    errorAnimationController: widget.errorController,
                    controller: widget.textEditingController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    onCompleted: widget.onCompleted,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                const SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Center(
                  child: widget.loading
                      ? Container(
                          child: dotProgress(context),
                        )
                      : Text(
                          widget.hasError ? widget.errorText : "",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppTheme.errorColor,
                                  ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
