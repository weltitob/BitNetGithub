import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/cloudfunctions/recoverKeyWithMnemonic.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/indicators/smoothpageindicator.dart';
import 'package:BitNet/components/textfield/formtextfield.dart';
import 'package:BitNet/generated/l10n.dart';
import 'package:BitNet/models/qr_codes/qr_privatekey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordRecoveryScreen extends StatefulWidget {
  @override
  _RestoreWalletScreenState createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<WordRecoveryScreen> {
  PageController _pageController = PageController();
  bool onLastPage = false;
  bool _isLoading = false;
  String? username = '';

  String bipwords = '';
  List<String> splittedbipwords = [];

  late String lottiefile;
  bool _visible = false;

  TextEditingController _usernameController = TextEditingController();

  List<TextEditingController> textControllers =
      List.generate(12, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(12, (index) => FocusNode());

  void moveToNext() async {
    print("MOVETONEXT TRIGGERED");
    int currentFocusIndex = focusNodes.indexWhere((node) => node.hasFocus);

    if (currentFocusIndex == -1 || currentFocusIndex == 11) {
      return;
    }

    // If the current focus index is 3 or 7 (the index starts from 0), move to the next page
    if (currentFocusIndex == 3 || currentFocusIndex == 7) {
      nextPageFunction();
    }

    focusNodes[currentFocusIndex].unfocus();
    FocusScope.of(context).requestFocus(focusNodes[currentFocusIndex + 1]);
    setState(() {});
  }

  void nextPageFunction() async {
    await _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    getBIPWords();
  }

  @override
  void dispose() {
    textControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  getBIPWords() async {
    bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
    splittedbipwords = bipwords.split(" ");
  }

  void onSignInPressesd() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final String mnemonic =
          textControllers.map((controller) => controller.text).join(' ');
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
      print("Privatedata succesfully recovered: $privateData");
      print("DID: ${privateData.did}");
      print("PrivateKey: ${privateData.privateKey}");
      final signedMessage =
          await Auth().signMessageAuth(privateData.did, privateData.privateKey);
      print("Signed message: $signedMessage");
      await Auth().signIn(privateData.did, signedMessage, context);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception("Irgendeine error message lel: $e");
    }

    //use privatekey and did to sign the message and authenticate afterwards
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BitNetScaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: BitNetAppBar(
          text: "Word recovery",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: Text(
                  'Enter your 12 words in the right order',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                height: size.height / 2.5,
                child: PageView(
                  onPageChanged: (val) {
                    setState(() {
                      onLastPage = (val == 3);
                    });
                  },
                  controller: _pageController,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
                        child: FormTextField(
                          title: S.of(context).usernameOrDID,
                          controller: _usernameController,
                          isObscure: false,
                          //das muss eh noch geändert werden gibt ja keine email
                          validator: (val) =>
                              val!.isEmpty ? "Iwas geht nicht" : null,
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                        ),
                      ),
                    ),
                    buildInputFields(
                        "1.",
                        textControllers[0],
                        focusNodes[0],
                        "2.",
                        textControllers[1],
                        focusNodes[1],
                        "3.",
                        textControllers[2],
                        focusNodes[2],
                        "4.",
                        textControllers[3],
                        focusNodes[3],
                        splittedbipwords),
                    buildInputFields(
                        "5.",
                        textControllers[4],
                        focusNodes[4],
                        "6.",
                        textControllers[5],
                        focusNodes[5],
                        "7.",
                        textControllers[6],
                        focusNodes[6],
                        "8.",
                        textControllers[7],
                        focusNodes[7],
                        splittedbipwords),
                    buildInputFields(
                        "9.",
                        textControllers[8],
                        focusNodes[8],
                        "10.",
                        textControllers[9],
                        focusNodes[9],
                        "11.",
                        textControllers[10],
                        focusNodes[10],
                        "12.",
                        textControllers[11],
                        focusNodes[11],
                        splittedbipwords),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              buildIndicator(_pageController, 4),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
                child: LongButtonWidget(
                  title: onLastPage ? "Sign In" : "Next",
                  onTap: onLastPage ? onSignInPressesd : nextPageFunction,
                  state: _isLoading ? ButtonState.loading : ButtonState.idle,
                ),
              ),
            ],
          ),
        ],
      ),
      context: context,
    );
  }

  Widget buildInputFields(
    String text1,
    TextEditingController _textController1,
    FocusNode _focusNode1,
    String text2,
    TextEditingController _textController2,
    FocusNode _focusNode2,
    String text3,
    TextEditingController _textController3,
    FocusNode _focusNode3,
    String text4,
    TextEditingController _textController4,
    FocusNode _focusNode4,
    List<String> splittedbipwords,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppTheme.cardPadding * 2,
        right: AppTheme.cardPadding * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormTextField(
            title: text1,
            controller: _textController1,
            focusNode: _focusNode1,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            title: text2,
            controller: _textController2,
            focusNode: _focusNode2,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            title: text3,
            controller: _textController3,
            focusNode: _focusNode3,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            title: text4,
            controller: _textController4,
            focusNode: _focusNode4,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
        ],
      ),
    );
  }
}
