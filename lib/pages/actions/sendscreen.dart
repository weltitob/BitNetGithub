import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/components/cameraqr.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/sendappbar.dart';
import 'package:nexus_wallet/components/swipebutton/swipeable_button_view.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/pages/qrscreen.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:page_transition/page_transition.dart';

class SendBTCScreen extends StatefulWidget {
  const SendBTCScreen({Key? key}) : super(key: key);

  @override
  State<SendBTCScreen> createState() => _SendBTCScreenState();
}

class _SendBTCScreenState extends State<SendBTCScreen> {
  late FocusNode myFocusNode;
  TextEditingController listController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  List numberAsList = [];
  bool isFinished = false;
  bool _hasReceiver = false;
  String _bitcoinAdresse = '';
  dynamic _moneyineur = '';
  bool _isLoadingExchangeRt = true;

  double bitcoinBalanceWallet = 1.24;

  @override
  void initState() {
    super.initState();
    moneyController.text = "0.0001";
    myFocusNode = FocusNode();
    getBitcoinPrice();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  Future<void> getBitcoinPrice() async {
    _isLoadingExchangeRt = true;
    final String url = 'https://api.coingecko.com/api/v3/simple/price';
    final Map<String, String> params = {
      'ids': 'bitcoin',
      'vs_currencies': 'eur'
    };

    final response =
        await get(Uri.parse(url).replace(queryParameters: params), headers: {});
    if (response.statusCode == 200) {
      final bitcoinPrice = jsonDecode(response.body)['bitcoin']['eur'];
      print('The current price of Bitcoin in Euro is $bitcoinPrice');
      ;
      setState(() {
        _moneyineur = bitcoinPrice * double.parse(moneyController.text);
        _isLoadingExchangeRt = false;
      });
    } else {
      print('Error ${response.statusCode}: ${response.reasonPhrase}');
      setState(() {
        _moneyineur = "An Error occured";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: appBarSend(context),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          _hasReceiver
              ? userTile()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: AppTheme.cardPadding * 11.5,
                        child: Glassmorphism(
                          blur: 20,
                          opacity: 0.1,
                          radius: 50.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing * 1.5),
                            height: AppTheme.cardPadding * 2,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: listController,
                              autofocus: false,
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Bitcoin-Adresse hier eingeben",
                                hintStyle: TextStyle(color: AppTheme.white60),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const QRScreen(),
                                ),
                              ),
                          child: avatarGlow(
                            context,
                            Icons.circle,
                          )),
                    ],
                  ),
                ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Center(child: bitcoinWidget()),
          Center(child: bitcoinToMoneyWidget()),
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Visibility(
            visible: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 5),
              color: Colors.red,
              child: TextFormField(
                onChanged: (text) {
                  print('Bitcoin amount entered: $text');
                  getBitcoinPrice();
                  setState(() {});
                },
                maxLength: 10,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                focusNode: myFocusNode,
                controller: moneyController,
                autofocus: false,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Center(child: button()),
        ],
      ),
    );
  }

  Widget avatarGlow(BuildContext context, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarGlow(
            glowColor: darken(Colors.orange, 14),
            endRadius: AppTheme.cardPadding * 1.25,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            showTwoGlows: true,
            child: CustomPaint(
              foregroundPainter: BorderPainterSmall(),
              child: Container(
                margin: const EdgeInsets.all(AppTheme.elementSpacing),
                child: Icon(
                  icon,
                  size: AppTheme.cardPadding * 0.75,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bitcoinToMoneyWidget() {
    return _isLoadingExchangeRt
        ? dotProgress(context)
        : Text(
            "${_moneyineur.toStringAsFixed(2)}€",
            style: Theme.of(context).textTheme.titleMedium,
          );
  }

  Widget userTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Text(
            "Receiver",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://bitfalls.com/wp-content/uploads/2017/09/header-5.png"),
          ),
          title: Text(
            "Unknown Wallet",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          subtitle: cardWithNumber(),
          trailing: IconButton(
              icon:
                  const Icon(Icons.edit_rounded, color: Colors.grey, size: 18),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }

  Widget cardWithNumber() {
    return Row(
      children: [
        const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
        Text(
          "3FZbgi29cpjq2GjdwV8eyHuJJnkLtktZc5",
          style: Theme.of(context).textTheme.caption,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget bitcoinWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppTheme.cardPadding,
          bottom: AppTheme.elementSpacing,
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding),
      child: GestureDetector(
        onTap: () {
          myFocusNode.requestFocus();
        },
        child: RichText(
            maxLines: 3,
            text: TextSpan(
              text: moneyController.text,
              style: Theme.of(context).textTheme.displayLarge,
              children: [
                if (moneyController.text != '')
                  TextSpan(
                      text: ' BTC',
                      style: Theme.of(context).textTheme.displaySmall),
              ],
            )),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: SwipeableButtonView(
          buttontextstyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppTheme.white80, shadows: [AppTheme.boxShadowSmall]),
          buttonText: "ZIEHE SENDSCH KOHL!",
          buttonWidget: Container(
            child: Icon(
              Icons.double_arrow_rounded,
              color: AppTheme.colorBackground,
              size: 33,
              shadows: [AppTheme.boxShadowProfile],
            ),
          ),
          activeColor: Colors.purple.shade800,
          isFinished: isFinished,
          onWaitingProcess: () {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isFinished = true;
              });
            });
          },
          onFinish: () async {
            await Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const BottomNav()));
            setState(() {
              isFinished = false;
            });
          }),
    );
  }
}
