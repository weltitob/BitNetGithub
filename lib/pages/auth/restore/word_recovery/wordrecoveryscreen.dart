import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/recoverKeyWithMnemonic.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WordRecoveryScreen extends StatefulWidget {
  @override
  _RestoreWalletScreenState createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<WordRecoveryScreen> {
  // PageController _pageController = PageController();

  // bool onLastPage = false;
  bool _isLoading = false;
  String? username = '';

  // String bipwords = '';
  // List<String> splittedbipwords = [];

  // late String lottiefile;
  //bool _visible = false;

  TextEditingController _usernameController = TextEditingController();

  // List<TextEditingController> textControllers =
  //     List.generate(24, (index) => TextEditingController());
  // List<FocusNode> focusNodes = List.generate(24, (index) => FocusNode());

  // void moveToNext() async {
  //   print("MOVETONEXT TRIGGERED");
  //   int currentFocusIndex = focusNodes.indexWhere((node) => node.hasFocus);

  //   if (currentFocusIndex == -1 || currentFocusIndex == 11) {
  //     return;
  //   }

  //   // If the current focus index is 3 or 7 (the index starts from 0), move to the next page
  //   if (currentFocusIndex == 3 || currentFocusIndex == 7) {
  //     nextPageFunction();
  //   }

  //   focusNodes[currentFocusIndex].unfocus();
  //   FocusScope.of(context).requestFocus(focusNodes[currentFocusIndex + 1]);
  //   setState(() {});
  // }

  // void nextPageFunction() async {
  //   await _pageController.nextPage(
  //       duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  // }

  @override
  void initState() {
    super.initState();
    // getBIPWords();
  }

  @override
  void dispose() {
    // textControllers.forEach((controller) => controller.dispose());
    // focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  // getBIPWords() async {
  //   bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
  //   splittedbipwords = bipwords.split(" ");
  // }

  void onSignInPressesd(mCtrl, tCtrls) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final String mnemonic =
          tCtrls.map((controller) => controller.text).join(' ');
      print(mnemonic);
      //call the cloudfunction that recovers privatekey and did
      print("reover Key should be triggered!!!");

      //getthedid from Username or DID
      final bool isDID = isStringaDID(_usernameController.text);
      late String did;
      if (isDID) {
        did = _usernameController.text;
      } else {
        did = await Auth().getUserDID(_usernameController.text);
      }
      final PrivateData privateData =
          await recoverKeyWithMnemonic(mnemonic, did); 
      final signedMessage =
          await Auth().signMessageAuth(privateData.did, privateData.privateKey);
      print("Signed message: $signedMessage");
      await Auth().signIn(privateData.did, signedMessage, context);
                  showOverlay(context, "Successfully Signed In.", color: AppTheme.successColor);

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
            showOverlay(context, "No User was found with the provided Mnemonic.", color: AppTheme.errorColor);

      throw Exception("Irgendeine error message lel: $e");
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          bool isSuperSmallScreen =
              constraints.maxWidth < AppTheme.isSuperSmallScreen;
          return bitnetScaffold(
            context: context,
            margin: isSuperSmallScreen
                ? EdgeInsets.symmetric(horizontal: 0)
                : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250.w),
            extendBodyBehindAppBar: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: bitnetAppBar(
                text: "Confirm your mnemonic",
                context: context,
                onTap: () {
                  context.go('/authhome/login');
                },
                actions: [
         PopUpLangPickerWidget()
        ]),

     body: MnemonicFieldWidget(mnemonicController: null, triggerMnemonicCheck: onSignInPressesd,),
          );});
  }



}