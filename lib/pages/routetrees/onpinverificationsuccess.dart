import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/pages/auth/createaccountscreen.dart';
import 'package:flutter/material.dart';
void onPinVerificationSuccess({
  required VerificationCode code,
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateAccountScreen(
        code: code,
      ),
    ),
  );
}
