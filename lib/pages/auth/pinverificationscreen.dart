import 'dart:async';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/fields/verification/verificationspace.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
// import 'package:bitnet/models/firebase/verificationcode.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  _PinVerificationScreenState createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool _loading = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String _error = "";
  String? _textValueClipboard = '';
  bool wanttocopy = true;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    _getClipboard();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  void _getClipboard() async {
    final logger = Get.find<LoggerService>();

    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text?.length == 5) {
      setState(() {
        textEditingController.text = data.text!;
      });
    } else {
      logger.i('No code in users clipboard could be found');
    }
  }

  void checkIfCodeIsValid(String currentCode) async {
    setState(() {
      _loading = true;
    });
    try {
      formKey.currentState?.validate();

      QuerySnapshot snapshot =
          await codesCollection.where("code", isEqualTo: currentCode).get();
      VerificationCode code =
          VerificationCode.fromDocument(snapshot.docs.first);

      if (code.used == false) {
        _loading = false;
        // //passing code to SignUp that it can be flagged as used later on
        // context.go(Uri(
        //     path: '/authhome/pinverification/createaccount',
        //     queryParameters: {
        //       'code': code.code,
        //       'issuer': code.issuer,
        //     }).toString());

        context.go(Uri(
                path: '/authhome/pinverification/createaccount',
                queryParameters: {'code': code.code, 'issuer': code.issuer})
            .toString());
      } else {
        errorController
            .add(ErrorAnimationType.shake); // Triggering error shake animation
        _error = L10n.of(context).codeAlreadyUsed;
        setState(() {
          _loading = false;
          hasError = true;
        });
      }
    } catch (error) {
      _error = L10n.of(context).codeNotValid;
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        _loading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
          onTap: () {
            context.go('/authhome');
          },
          text: L10n.of(context).pinCodeVerification,
          // text:
          context: context,
          actions: [
            // const PopUpLangPickerWidget()
          ]),
      // body: Container(),
      // key: scaffoldKey,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 5.5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logoclean.png',
                    width: AppTheme.cardPadding.h,
                    height: AppTheme.cardPadding.h,
                  ),
                  SizedBox(
                    width: AppTheme.elementSpacing.w / 2,
                  ),
                  Text(
                    "BitNet",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: AppTheme.cardPadding.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding * 2.w),
                child: Text(
                  L10n.of(context).platformDemandText,
                  style: Theme.of(context).textTheme.titleMedium!,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: VerificationSpace(
                textEditingController: textEditingController,
                errorController: errorController,
                formKey: formKey,
                onCompleted: (v) {
                  checkIfCodeIsValid(v);
                },
                loading: _loading,
                hasError: hasError,
                errorText: _error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
