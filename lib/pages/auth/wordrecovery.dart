import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/textfield/biptextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class RestoreWalletView extends StatefulWidget {
  @override
  _RestoreWalletScreenState createState() => _RestoreWalletScreenState();
}

class _RestoreWalletScreenState extends State<RestoreWalletView> {

  PageController _pageController = PageController();
  //keep track of last page
  bool onLastPage = false;

  String bipwords = '';
  List<String> splittedbipwords = [];

  late String lottiefile;
  bool _visible = false;

  TextEditingController _textController1 = TextEditingController();
  TextEditingController _textController2 = TextEditingController();
  TextEditingController _textController3 = TextEditingController();
  TextEditingController _textController4 = TextEditingController();
  TextEditingController _textController5= TextEditingController();
  TextEditingController _textController6 = TextEditingController();
  TextEditingController _textController7 = TextEditingController();
  TextEditingController _textController8 = TextEditingController();
  TextEditingController _textController9 = TextEditingController();
  TextEditingController _textController10 = TextEditingController();
  TextEditingController _textController11 = TextEditingController();
  TextEditingController _textController12 = TextEditingController();

  @override
  void initState() {
    super.initState();
    getBIPWords();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getBIPWords() async {
    bipwords = await rootBundle.loadString('assets/textfiles/bip_words.txt');
    splittedbipwords = bipwords.split(" ");
  }

  //erst wenn alle 12 felder grün ausgefüllt sind (validator kann man sign in pressen)


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BitNetScaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100,),
                child: Text('Enter your mneonic words',
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white.withOpacity(0.9))
                ),
              ),
              Container(
                height: size.height / 2.75,
                child: PageView(
                  onPageChanged: (val) {
                    setState((){
                      onLastPage = (val == 3);
                    });
                  },
                  controller: _pageController,
                  children: [
                    buildInputFields("1.", _textController1, "2.", _textController2, "3.", _textController3, splittedbipwords),
                    buildInputFields("4.", _textController4, "5.", _textController5, "6.", _textController6, splittedbipwords),
                    buildInputFields("7.", _textController7, "8.", _textController8, "9.", _textController9, splittedbipwords),
                    buildInputFields("10.", _textController10, "11.", _textController11, "12.", _textController12, splittedbipwords),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect:  SlideEffect(
                    dotWidth:  8.0,
                    dotHeight:  8.0,
                    dotColor:  Colors.grey,
                    activeDotColor:  Colors.orange
                ),
              ),
              SizedBox(height: 40,),
              onLastPage ? LongButtonWidget(title: "Sign In", onTap: () {
                final String mnemonic = '${_textController1.text} ${_textController2.text}'
                    '${_textController3.text} ${_textController4.text} ${_textController5.text}'
                    '${_textController6.text} ${_textController7.text} ${_textController8.text}'
                    '${_textController9.text} ${_textController10.text}'
                    '${_textController11.text} ${_textController12.text}';
                print(mnemonic);
              }) :
              LongButtonWidget(title: "Next", onTap: () {
                _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn
                );
              }),
            ],
          ),
        ],
      ), context: context,
    );
  }
}

Widget buildInputFields(
    String text1, _textController1,
    String text2, _textConroller2,
    String text3, _textController3,
    List<String> splittedbipwords,
    ) {
  return Padding(
    padding: EdgeInsets.only(left: 55, right: 55,),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FormTextFieldBIP(title: text1, controller: _textController1, bipwords: splittedbipwords,),
        FormTextFieldBIP(title: text2, controller: _textConroller2, bipwords: splittedbipwords,),
        FormTextFieldBIP(title: text3, controller: _textController3, bipwords: splittedbipwords,),
      ],
    ),
  );
}