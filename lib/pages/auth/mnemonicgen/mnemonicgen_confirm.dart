import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrix/matrix.dart';

class MnemonicGenConfirm extends StatefulWidget {
  final MnemonicController mnemonicController;

  const MnemonicGenConfirm({super.key, required this.mnemonicController});
  @override
  _MnemonicGenConfirm createState() => _MnemonicGenConfirm();
}

class _MnemonicGenConfirm extends State<MnemonicGenConfirm> {
  PageController _pageController = PageController();
  bool onLastPage = false;

  String bipwords = '';
  List<String> splittedbipwords = [];
  late String lottiefile;
  TextEditingController _usernameController = TextEditingController();

  List<TextEditingController> textControllers =
  List.generate(24, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(24, (index) => FocusNode());

  void moveToNext() async {
    int currentFocusIndex = focusNodes.indexWhere((node) => node.hasFocus);
    if (currentFocusIndex == -1 || currentFocusIndex == 23) {
      return;
    }
    // If the current focus index is 3 or 7 (the index starts from 0), move to the next page
    if (currentFocusIndex == 3 || currentFocusIndex == 7 || currentFocusIndex == 11 || currentFocusIndex == 15 || currentFocusIndex == 19) {
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

  getBIPWords() async {
    bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
    splittedbipwords = bipwords.split(" ");
  }

  @override
  void dispose() {
    textControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void triggerMnemonicCheck(){
    final String mnemonic = textControllers.map((controller) => controller.text).join(' ');
    widget.mnemonicController.confirmMnemonic(mnemonic);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          bool isSuperSmallScreen =
              constraints.maxWidth < AppTheme.isSuperSmallScreen;
          return bitnetScaffold(
            margin: isSuperSmallScreen
                ? EdgeInsets.symmetric(horizontal: 0)
                : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250),
            extendBodyBehindAppBar: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: bitnetAppBar(
                text: "Confirm your mnemonic",
                context: context,
                onTap: () {
                  widget.mnemonicController.changeWrittenDown();
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
                        top: AppTheme.cardPadding * 3,
                      ),
                      child: Text(
                        'Enter your 24 words in the right order',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Container(
                      height: size.height / 2.5,
                      child: PageView(
                        onPageChanged: (val) {
                          setState(() {
                            onLastPage = (val == 5); // Update this to check if the last page is reached
                          });
                        },
                        controller: _pageController,
                        children: [
                          buildInputFields(
                              "1.", textControllers[0], focusNodes[0],
                              "2.", textControllers[1], focusNodes[1],
                              "3.", textControllers[2], focusNodes[2],
                              "4.", textControllers[3], focusNodes[3],
                              splittedbipwords),
                          buildInputFields(
                              "5.", textControllers[4], focusNodes[4],
                              "6.", textControllers[5], focusNodes[5],
                              "7.", textControllers[6], focusNodes[6],
                              "8.", textControllers[7], focusNodes[7],
                              splittedbipwords),
                          buildInputFields(
                              "9.", textControllers[8], focusNodes[8],
                              "10.", textControllers[9], focusNodes[9],
                              "11.", textControllers[10], focusNodes[10],
                              "12.", textControllers[11], focusNodes[11],
                              splittedbipwords),
                          // New set of input fields for 13-16
                          buildInputFields(
                              "13.", textControllers[12], focusNodes[12],
                              "14.", textControllers[13], focusNodes[13],
                              "15.", textControllers[14], focusNodes[14],
                              "16.", textControllers[15], focusNodes[15],
                              splittedbipwords),
                          // New set of input fields for 17-20
                          buildInputFields(
                              "17.", textControllers[16], focusNodes[16],
                              "18.", textControllers[17], focusNodes[17],
                              "19.", textControllers[18], focusNodes[18],
                              "20.", textControllers[19], focusNodes[19],
                              splittedbipwords),
                          // New set of input fields for 21-24
                          buildInputFields(
                              "21.", textControllers[20], focusNodes[20],
                              "22.", textControllers[21], focusNodes[21],
                              "23.", textControllers[22], focusNodes[22],
                              "24.", textControllers[23], focusNodes[23],
                              splittedbipwords),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding,
                    ),
                    buildIndicator(pageController: _pageController, count: 6),
                    SizedBox(
                      height: AppTheme.cardPadding * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding * 2),
                      child: LongButtonWidget(
                        title: onLastPage ? "Confirm Key" : "Next",
                        onTap: onLastPage ? triggerMnemonicCheck : nextPageFunction,
                        state: widget.mnemonicController.isLoadingSignUp ? ButtonState.loading : ButtonState.idle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: AppTheme.cardPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.white60,
                          width: 2,
                        ),
                        borderRadius: AppTheme.cardRadiusCircular,
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: AppTheme.cardPadding,
                          bottom: AppTheme.cardPadding),
                      child: GestureDetector(
                        onTap: () {
                          Logs().w("Skip at own risk pressed");
                          //context.go("/pinverification");
                          widget.mnemonicController.signUp();
                        },
                        child: Text(
                          "Skip at own risk",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            context: context,
          );
        });
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
            hintText: text1,
            controller: _textController1,
            focusNode: _focusNode1,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            hintText: text2,
            controller: _textController2,
            focusNode: _focusNode2,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            hintText: text3,
            controller: _textController3,
            focusNode: _focusNode3,
            bipwords: splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: moveToNext,
          ),
          FormTextField(
            hintText: text4,
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
