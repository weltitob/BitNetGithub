import 'dart:async';
import 'dart:math';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/recoverkey.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// izak: TO BE DELETED

// Random random = new Random();

// // ignore: must_be_immutable
// class DidAndPrivateKeyScreen extends StatefulWidget {
//   // function to toggle between login and register screens

//   @override
//   _SignupScreenState createState() {
//     return _SignupScreenState();
//   }
// }

// class _SignupScreenState extends State<DidAndPrivateKeyScreen>
//     with TickerProviderStateMixin {
//   // error message if sign in fails
//   String? errorMessage = null;

//   // user's password
//   String? password = '';

//   // key for the form validation
//   final GlobalKey<FormState> _form = GlobalKey<FormState>();

//   // controllers for email and password fields
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   // loading status
//   bool _isLoading = false;
//   late String myusername;

//   // function to sign in with email and password
//   //izak: We will be getting rid of this...
//   Future<void> signIn() async {
//     // LoggerService logger = Get.find();
//     // logger.i("signIn pressed...");
//     // setState(() {
//     //   _isLoading = true;
//     //   errorMessage = null;
//     // });
//     // try {
//     //   final bool isDID = isCompressedPublicKey(_controllerUsername.text);
//     //   late String did;
//     //   if (isDID) {
//     //     did = _controllerUsername.text;
//     //     myusername = await Auth().getUserUsername(_controllerUsername.text);
//     //   } else {
//     //     did = await Auth().getUserDID(_controllerUsername.text);
//     //     myusername = _controllerUsername.text;
//     //   }

//     //   logger.i("didandpkscreen.dart: $did");

//     //   final String privateKeyHex = _controllerPassword.text;
//     //   //
//     //   // HDWallet hdWallet = HDWallet.fromBase58(privateKeyHex);

//     //   PrivateData privateData = PrivateData(did: did, privateKey: privateKeyHex,mnemonic: mnemonic);

//     //   String challengeData = "Privatekey Login Challenge";

//     //   String signatureHex = await signChallengeData(
//     //       privateData.privateKey, privateData.did, challengeData);

//     //   logger.d('Generated signature hex: $signatureHex');

//     //   await Auth().signIn(ChallengeType.privkey_login, privateData, signatureHex, context);

//     // } catch (e) {
//     //   setState(() {
//     //     errorMessage = L10n.of(context)!.errorSomethingWrong;
//     //     print(e);
//     //   });
//     // }
//     // setState(() {
//     //   _isLoading = false;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       final screenWidth = MediaQuery.of(context).size.width;
//       bool isSuperSmallScreen =
//           constraints.maxWidth < AppTheme.isSuperSmallScreen;
//       return bitnetScaffold(
//         margin: const EdgeInsets.symmetric(horizontal: 0),
//         extendBodyBehindAppBar: true,
//         context: context,
//         gradientColor: Colors.black,
//         appBar: bitnetAppBar(
//           text: L10n.of(context)!.privateKeyLogin,
//           context: context,
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           actions: [
//             const PopUpLangPickerWidget(),
//           ],
//         ),
//         body: Form(
//           key: _form,
//           child: ListView(
//             padding: EdgeInsets.only(
//                 left: AppTheme.cardPadding * 2.ws,
//                 right: AppTheme.cardPadding * 2.ws,
//                 top: AppTheme.cardPadding * 6.h),
//             physics: const BouncingScrollPhysics(),
//             children: [
//               SizedBox(
//                 height: AppTheme.cardPadding * 3,
//               ),
//               Container(
//                 height: AppTheme.cardPadding * 4.5.h,
//                 child: Text(
//                   L10n.of(context)!.welcomeBack,
//                   style: Theme.of(context).textTheme.displayLarge,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.start,
//               //   children: [
//               //     Text(
//               //       L10n.of(context)!.poweredByDIDs,
//               //       style: Theme.of(context).textTheme.bodyMedium,
//               //     ),
//               //     Container(
//               //       margin: EdgeInsets.only(left: AppTheme.elementSpacing / 2.ws),
//               //       height: AppTheme.cardPadding * 1.5.h,
//               //       child: Image.asset("assets/images/ion.png"),
//               //     ),
//               //   ],
//               // ),
//               SizedBox(
//                 height: AppTheme.cardPadding.h,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Container(
//                   //   child: FormTextField(
//                   //     hintText: L10n.of(context)!.usernameOrDID,
//                   //     controller: _controllerUsername,
//                   //     isObscure: false,
//                   //     //das muss eh noch geändert werden gibt ja keine email
//                   //     validator: (val) => val!.isEmpty ? "Iwas geht nicht" : null,
//                   //     onChanged: (val) {
//                   //       setState(() {
//                   //         username = val;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: AppTheme.cardPadding.h),
//                     child: Container(
//                       child: FormTextField(
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return L10n.of(context)!.pleaseEnterYourPassword;
//                           } else if (val.length < 6) {
//                             return L10n.of(context)!.passwordShouldBeSixDig;
//                           } else {
//                             return null;
//                           }
//                         },
//                         onChanged: (val) {
//                           setState(() {
//                             password = val;
//                           });
//                         },
//                         hintText: L10n.of(context)!.privateKey,
//                         controller: _controllerPassword,
//                         isObscure: true,
//                       ),
//                     ),
//                   ),
//                   LongButtonWidget(
//                     customWidth: AppTheme.cardPadding * 14.ws,
//                     title: L10n.of(context)!.restoreAccount,
//                     onTap: () {
//                       if (_form.currentState!.validate()) {
//                         signIn();
//                       }
//                     },
//                     state: _isLoading ? ButtonState.loading : ButtonState.idle,
//                   ),
//                   errorMessage == null
//                       ? Container()
//                       : Padding(
//                           padding:
//                               const EdgeInsets.only(top: AppTheme.cardPadding),
//                           child: Text(
//                             errorMessage!,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall!
//                                 .copyWith(color: AppTheme.errorColor),
//                           ),
//                         ),
//                   Container(
//                     margin: EdgeInsets.only(top: AppTheme.cardPadding * 2.h),
//                     child: Text(
//                       L10n.of(context)!.noAccountYet,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: AppTheme.cardPadding.h),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Theme.of(context).brightness == Brightness.dark
//                             ? AppTheme.white60
//                             : AppTheme.black60,
//                         width: 2,
//                       ),
//                       borderRadius: AppTheme.cardRadiusCircular,
//                     ),
//                     child: SizedBox(
//                       height: 0,
//                       width: 65.ws,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(
//                         top: AppTheme.cardPadding,
//                         bottom: AppTheme.cardPadding),
//                     child: GestureDetector(
//                       onTap: () {
//                         context.go("/authhome/pinverification");
//                       },
//                       child: Text(
//                         L10n.of(context)!.register,
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
