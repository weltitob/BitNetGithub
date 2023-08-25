import 'package:BitNet/pages/auth/createaccount/createaccount.dart';
import 'package:BitNet/pages/auth/ionloadingscreen.dart';
import 'package:BitNet/pages/routetrees/widgettree.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/models/verificationcode.dart';


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
