import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount.dart';
import 'package:flutter/material.dart';

void onPinVerificationSuccess({
  required VerificationCode code,
  required BuildContext context,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateAccount(
        code: code,
      ),
    ),
  );
}
