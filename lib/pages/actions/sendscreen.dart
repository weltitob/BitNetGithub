import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/components/cameraqr.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
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
  TextEditingController bitcoinReceiverAdressController =
      TextEditingController();
  TextEditingController moneyController = TextEditingController();
  bool isFinished = false;
  bool _hasReceiver = false;
  String _bitcoinAdresse = '';
  dynamic _moneyineur = '';
  bool _isLoadingExchangeRt = true;
  double bitcoinBalanceWallet = 1.24;

  @override
  void initState() {
    super.initState();
    moneyController.text = "";
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send Bitcoin", style: Theme.of(context).textTheme.titleLarge),
            Text("${bitcoinBalanceWallet}BTC available",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        backgroundColor: AppTheme.colorBackground,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: Text(
                  "Receiver",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              _hasReceiver
                  ? userTile()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding,
                          vertical: AppTheme.elementSpacing / 2),
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
                                child: TextField(
                                  maxLength: 40,
                                  controller: bitcoinReceiverAdressController,
                                  autofocus: false,
                                  onSubmitted: (text) {
                                    setState(() {
                                      _bitcoinAdresse = text;
                                      _hasReceiver = true;
                                    });
                                    ;
                                  },
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    hintText: "Bitcoin-Adresse hier eingeben",
                                    hintStyle:
                                        TextStyle(color: AppTheme.white60),
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
            ],
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
                setState(() {
                  _hasReceiver = false;
                });
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
          _bitcoinAdresse,
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
      child: Container(
        child: TextField(
          textAlign: TextAlign.center,
          onChanged: (text) {
            print('Bitcoin amount entered: $text');
            getBitcoinPrice();
            setState(() {});
          },
          maxLength: 10,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
            DotFormatter(),
            NumericalRangeFormatter(
                min: 0, max: bitcoinBalanceWallet, context: context),
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
            hintText: "Bitcoin-Adresse hier eingeben",
            hintStyle: TextStyle(color: AppTheme.white60),
          ),
          focusNode: myFocusNode,
          controller: moneyController,
          autofocus: false,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),

      /*RichText(
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
          )),*/
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
