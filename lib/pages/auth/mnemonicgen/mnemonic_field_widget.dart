import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MnemonicFieldWidget extends StatefulWidget {
  final MnemonicController? mnemonicController;
  final Function(MnemonicController?, List<TextEditingController>)
      triggerMnemonicCheck;
  const MnemonicFieldWidget(
      {super.key,
      required this.mnemonicController,
      required this.triggerMnemonicCheck});

  @override
  State<MnemonicFieldWidget> createState() => MnemonicFieldWidgetState();
}

class MnemonicFieldWidgetState extends State<MnemonicFieldWidget> {
  PageController _pageController = PageController();
  bool onLastPage = false;

  String bipwords = '';
  List<String> splittedbipwords = [];
  late String lottiefile;
  TextEditingController _usernameController = TextEditingController();

  List<TextEditingController> textControllers =
      List.generate(24, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(24, (index) => FocusNode());

  void triggerCheck() {
    widget.triggerMnemonicCheck(widget.mnemonicController, textControllers);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        //physics: BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: AppTheme.cardPadding * 3.h,
                ),
                child: Text(
                  L10n.of(context)!.enterWordsRightOrder,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                height: size.height / 2.5.h,
                child: PageView(
                  onPageChanged: (val) {
                    setState(() {
                      onLastPage = (val ==
                          5); // Update this to check if the last page is reached
                    });
                  },
                  controller: _pageController,
                  children: [
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
                    // New set of input fields for 13-16
                    buildInputFields(
                        "13.",
                        textControllers[12],
                        focusNodes[12],
                        "14.",
                        textControllers[13],
                        focusNodes[13],
                        "15.",
                        textControllers[14],
                        focusNodes[14],
                        "16.",
                        textControllers[15],
                        focusNodes[15],
                        splittedbipwords),
                    // New set of input fields for 17-20
                    buildInputFields(
                        "17.",
                        textControllers[16],
                        focusNodes[16],
                        "18.",
                        textControllers[17],
                        focusNodes[17],
                        "19.",
                        textControllers[18],
                        focusNodes[18],
                        "20.",
                        textControllers[19],
                        focusNodes[19],
                        splittedbipwords),
                    // New set of input fields for 21-24
                    buildInputFields(
                        "21.",
                        textControllers[20],
                        focusNodes[20],
                        "22.",
                        textControllers[21],
                        focusNodes[21],
                        "23.",
                        textControllers[22],
                        focusNodes[22],
                        "24.",
                        textControllers[23],
                        focusNodes[23],
                        splittedbipwords),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding.h,
              ),
              CustomIndicator(pageController: _pageController, count: 6),
              SizedBox(
                height: AppTheme.cardPadding * 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding * 2.ws),
                child: LongButtonWidget(
                  title: onLastPage
                      ? L10n.of(context)!.confirmKey
                      : L10n.of(context)!.next,
                  onTap: onLastPage ? triggerCheck : nextPageFunction,
                  state: (widget.mnemonicController != null &&
                          widget.mnemonicController!.isLoadingSignUp)
                      ? ButtonState.loading
                      : ButtonState.idle,
                ),
              ),
            ],
          ),
        ],
      ),
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
    return MnemonicPage(
        text1: text1,
        text2: text2,
        text3: text3,
        text4: text4,
        textController1: _textController1,
        textController2: _textController2,
        textController3: _textController3,
        textController4: _textController4,
        focusNode1: _focusNode1,
        focusNode2: _focusNode2,
        focusNode3: _focusNode3,
        focusNode4: _focusNode4,
        splittedbipwords: splittedbipwords,
        moveToNext: moveToNext);
  }

  void moveToNext() async {
    int currentFocusIndex = focusNodes.indexWhere((node) => node.hasFocus);
    if (currentFocusIndex == -1 || currentFocusIndex == focusNodes.length - 1) {
      return;
    }
    // If the current focus index is 3 or 7 (the index starts from 0), move to the next page
    if ((currentFocusIndex + 1) % 4 == 0) {
      nextPageFunction();
    }
    focusNodes[currentFocusIndex].unfocus();
    FocusScope.of(context).requestFocus(focusNodes[currentFocusIndex + 1]);
    setState(() {});
  }

  void nextPageFunction() async {
    await _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    getBIPWords();
  }

  getBIPWords() async {
    bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
    splittedbipwords = bipwords.split(" ");
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    textControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }
}

class MnemonicPage extends StatefulWidget {
  const MnemonicPage(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.textController1,
      required this.textController2,
      required this.textController3,
      required this.textController4,
      required this.focusNode1,
      required this.focusNode2,
      required this.focusNode3,
      required this.focusNode4,
      required this.splittedbipwords,
      this.moveToNext});
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final TextEditingController textController1;
  final TextEditingController textController2;
  final TextEditingController textController3;
  final TextEditingController textController4;
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final FocusNode focusNode3;
  final FocusNode focusNode4;
  final List<String> splittedbipwords;
  final Function()? moveToNext;

  @override
  State<MnemonicPage> createState() => _MnemonicPageState();
}

class _MnemonicPageState extends State<MnemonicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppTheme.cardPadding * 2.ws,
        right: AppTheme.cardPadding * 2.ws,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormTextField(
            width: AppTheme.cardPadding * 14.ws,
            hintText: widget.text1,
            controller: widget.textController1,
            focusNode: widget.focusNode1,
            bipwords: widget.splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: widget.moveToNext,
          ),
          FormTextField(
            width: AppTheme.cardPadding * 14.ws,
            hintText: widget.text2,
            controller: widget.textController2,
            focusNode: widget.focusNode2,
            bipwords: widget.splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: widget.moveToNext,
          ),
          FormTextField(
            width: AppTheme.cardPadding * 14.ws,
            hintText: widget.text3,
            controller: widget.textController3,
            focusNode: widget.focusNode3,
            bipwords: widget.splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: widget.moveToNext,
          ),
          FormTextField(
            width: AppTheme.cardPadding * 14.ws,
            hintText: widget.text4,
            controller: widget.textController4,
            focusNode: widget.focusNode4,
            bipwords: widget.splittedbipwords,
            isObscure: false,
            isBIPField: true,
            changefocustonext: widget.moveToNext,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
