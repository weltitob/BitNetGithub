import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/sendappbar.dart';
import 'package:nexus_wallet/components/swipebutton/swipeable_button_view.dart';
import 'package:nexus_wallet/pages/homescreen.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:page_transition/page_transition.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  _AmountScreenState createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  List numberAsList = [];
  bool isFinished = false;
  String money = '0001';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: appBarSend(context),
      body: body(),
    );
  }
  Widget body() {
    return Column(
      children: [
        const SizedBox(
          height: AppTheme.cardPadding,
        ),
        userTile(),
        bitcoinWidget(),
        bitcoinToMoneyWidget(),
        const SizedBox(
          height: AppTheme.cardPadding,
        ),
        keypadWidget(),
        const SizedBox(
          height: AppTheme.cardPadding,
        ),
        button(),
      ],
    );
  }

  Widget bitcoinToMoneyWidget() {
    return Text(
      "= 2778901.09 USD",
      style: Theme.of(context).textTheme.bodyText2,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
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
          top: AppTheme.cardPadding, bottom: AppTheme.elementSpacing),
      child: RichText(
//$
          text: TextSpan(
        text: '0.',
        style: TextStyle(
          fontSize: AppTheme.cardPadding * 2.5,
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.w300,
        ),
        children: [
          TextSpan(
            text: money,
            style: const TextStyle(
              fontSize: AppTheme.cardPadding * 2.5,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (money != '')
            TextSpan(
                text: ' BTC', style: Theme.of(context).textTheme.headline6),
        ],
      )),
    );
  }

  Widget keypadWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardNumber(
                n: 1,
                onPressed: () {
                  setState(() => money = '$money' '1');
                }),
            KeyboardNumber(
                n: 2,
                onPressed: () {
                  setState(() => money = '$money' '2');
                }),
            KeyboardNumber(
                n: 3,
                onPressed: () {
                  setState(() => money = '$money' '3');
                }),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardNumber(
                n: 4,
                onPressed: () {
                  setState(() => money = '$money' '4');
                }),
            KeyboardNumber(
                n: 5,
                onPressed: () {
                  setState(() => money = '$money' '5');
                }),
            KeyboardNumber(
                n: 6,
                onPressed: () {
                  setState(() => money = '$money' '6');
                }),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardNumber(
                n: 7,
                onPressed: () {
                  setState(() => money = '$money' '7');
                }),
            KeyboardNumber(
                n: 8,
                onPressed: () {
                  setState(() => money = '$money' '8');
                }),
            KeyboardNumber(
                n: 9,
                onPressed: () {
                  setState(() => money = '$money' '9');
                }),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(
              width: 60.0,
              child: MaterialButton(
                onPressed: null,
                child: SizedBox(),
              ),
            ),
            KeyboardNumber(
                n: 0,
                onPressed: () {
                  setState(() => money = '$money' '0');
                }),
            Glassmorphism(
              blur: 20,
              opacity: 0.1,
              radius: 50.0,
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed: (){
                    try {
                      setState(() => money = money.replaceRange(money.length - 1, money.length, ''));
                    } catch (e) {
                      print("Error removing $e");
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0)),
                  height: 90.0,
                  child: Icon(
                    Icons.cancel,
                    color: AppTheme.white60,
                  )
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: SwipeableButtonView(
          buttontextstyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppTheme.white80, shadows: [AppTheme.boxShadowSmall]),
          buttonText: "SLIDE TO PAY",
          buttonWidget: Container(
            child: Icon(
              Icons.double_arrow_rounded,
              color: AppTheme.colorBackground,
              size: 33,
              shadows: [AppTheme.boxShadowProfile],
            ),
          ),
          activeColor: AppTheme.colorBackground,
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
                    type: PageTransitionType.fade, child: const HomeScreen()));

            setState(() {
              isFinished = false;
            });
          }),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  const KeyboardNumber({Key? key, required this.n, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Glassmorphism(
      blur: 20,
      opacity: 0.1,
      radius: 50.0,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: MaterialButton(
          padding: const EdgeInsets.all(8.0),
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
          height: 90.0,
          child: Text(
            "$n",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 24 * MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
