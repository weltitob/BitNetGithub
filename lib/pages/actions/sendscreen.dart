import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:http/http.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/send.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/backbone/security/biometrics/biometric_helper.dart';
import 'package:nexus_wallet/backbone/security/security.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/components/camera/qrscanneroverlay.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/components/swipebutton/swipeable_button_view.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/qrscreen.dart';
import 'package:nexus_wallet/backbone/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SendBTCScreen extends StatefulWidget {
  final String? bitcoinReceiverAdress;
  const SendBTCScreen({Key? key, this.bitcoinReceiverAdress}) : super(key: key);

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
  String _bitcoinReceiverAdress = '';
  dynamic _moneyineur = '';
  bool _isLoadingExchangeRt = true;
  //biometric authentication before sending
  bool hasBiometrics = true;
  bool isBioAuthenticated = false;
  late bool isSecurityChecked;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    moneyController.text = "0.00001";
    myFocusNode = FocusNode();
    getBitcoinPrice();
    if (widget.bitcoinReceiverAdress != null) {
      setState(() {
        _bitcoinReceiverAdress = widget.bitcoinReceiverAdress!;
        _hasReceiver = true;
        bitcoinReceiverAdressController.text = widget.bitcoinReceiverAdress!;
      });
    } else {
      print("Bisher wurde noch keine Empfängeradresse angegeben");
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    moneyController.dispose();
    super.dispose();
  }

  awaitSecurityBool() async {
    bool securitybool = await SharedPrefSecurityCheck();
    return securitybool;
  }

  isBiometricsAvailable() async {
    isSecurityChecked = await awaitSecurityBool();
    //user needs to have enrolled Biometrics and also high security checked in settings to get fingerpint auth request
    if (isSecurityChecked == true) {
      hasBiometrics = await BiometricHelper().hasEnrolledBiometrics();
      if (hasBiometrics == true) {
        print('trying to check biometrics...');
        isBioAuthenticated = await BiometricHelper().authenticate();
      } else {
        isBioAuthenticated == false;
      }
      setState(() {});
    } else {
      hasBiometrics = false;
    }
  }

  Future<void> getBitcoinPrice() async {
    _isLoadingExchangeRt = true;
    final String url = 'https://api.coingecko.com/api/v3/simple/price';

    final Map<String, String> params = {
      'ids': 'bitcoin',
      'vs_currencies': 'eur',
      'include_last_updated_at': 'true'
    };

    final response =
        await get(Uri.parse(url).replace(queryParameters: params), headers: {});
    if (response.statusCode == 200) {
      final bitcoinPrice = jsonDecode(response.body)['bitcoin']['eur'];
      print('The current price of Bitcoin in Euro is $bitcoinPrice');
      setState(() {
        if (moneyController.text.isNotEmpty) {
          _moneyineur = bitcoinPrice * double.parse(moneyController.text);
          _isLoadingExchangeRt = false;
        } else {
          _moneyineur = 0.0;
        }
      });
    } else {
      print(
          'Error beim Laden des Bitcoin Preises: ${response.statusCode}: ${response.reasonPhrase}');
      setState(() {
        _moneyineur = "Ein Fehler ist aufgetreten";
      });
    }
  }

  String feesSelected = "Niedrig";

  @override
  Widget build(BuildContext context) {
    final userWallet = Provider.of<UserWallet>(context);

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bitcoin versenden",
                style: Theme.of(context).textTheme.titleLarge),
            Text("${userWallet.walletBalance}BTC verfügbar",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        backgroundColor: AppTheme.colorBackground,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                const SizedBox(
                  height: AppTheme.cardPadding * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: Text(
                        "Empfänger",
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
                                          horizontal:
                                              AppTheme.elementSpacing * 1.5),
                                      height: AppTheme.cardPadding * 2,
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        maxLength: 40,
                                        controller: bitcoinReceiverAdressController,
                                        onFieldSubmitted: (value) {
                                          if (value == null || value.isEmpty) {
                                            displaySnackbar(context, "Hmm. Diese Walletadresse scheint nicht zu existieren");
                                          }
                                          final isValid = isBitcoinWalletValid(value);
                                          if (isValid) {
                                            setState(() {
                                              _bitcoinReceiverAdress = value;
                                              _hasReceiver = true;
                                            });
                                          }
                                          displaySnackbar(context, "Hmm. Diese Walletadresse scheint nicht zu existieren"); //to indicate the input is valid
                                        },
                                        autofocus: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          hintText:
                                              "Bitcoin-Adresse hier eingeben",
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
                                            builder: (context) => const QRScreen(
                                              isBottomButtonVisible: true,
                                            ),
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
                  height: AppTheme.cardPadding * 1,
                ),
                Center(child: bitcoinWidget()),
                Center(child: bitcoinToMoneyWidget()),
                const SizedBox(
                  height: AppTheme.cardPadding * 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Gebühren",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            width: AppTheme.elementSpacing / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              displaySnackbar(
                                  context,
                                  "Die Gebührenhöhe bestimmt über "
                                  "die Transaktionsgeschwindigkeit. "
                                  "Wenn du hohe Gebühren zahlst wird deine "
                                  "Transaktion schneller bei dem Empfänger ankommen");
                            },
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: AppTheme.white90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      buildFeesChooser()
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: AppTheme.cardPadding * 1.5),
                  child: button()),
            ),
          ],
        ),
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
            "= ${_moneyineur.toStringAsFixed(2)}€",
            style: Theme.of(context).textTheme.titleMedium,
          );
  }

  Widget userTile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://bitfalls.com/wp-content/uploads/2017/09/header-5.png"),
            ),
            title: Text(
              "Unbekannte Walletadresse",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            subtitle: cardWithNumber(),
            trailing: IconButton(
                icon: const Icon(Icons.edit_rounded,
                    color: Colors.grey, size: 18),
                onPressed: () {
                  setState(() {
                    _hasReceiver = false;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget cardWithNumber() {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: _bitcoinReceiverAdress));
        // copied successfully
        displaySnackbar(context, "Wallet-Adresse in Zwischenablage kopiert");
      },
      child: Row(
        children: [
          const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
          SizedBox(
            width: AppTheme.cardPadding * 8,
            child: Text(
              _bitcoinReceiverAdress,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget bitcoinWidget() {
    final userWallet = Provider.of<UserWallet>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wert eingeben",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
              child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                textAlign: TextAlign.center,
                onChanged: (text) {
                  getBitcoinPrice();
                  setState(() {});
                },
                maxLength: 10,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                  NumericalRangeFormatter(
                      min: 0, max: double.parse("2.000"), context: context),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "0.0",
                  hintStyle: TextStyle(color: AppTheme.white60),
                ),
                focusNode: myFocusNode,
                controller: moneyController,
                autofocus: false,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Icon(
                Icons.currency_bitcoin_rounded,
                size: AppTheme.cardPadding * 1.5,
              )
            ],
          )),
        ],
      ),
    );
  }

  //test
  Widget buildFeesChooser() {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          glassButtonFees(
            "Niedrig",
          ),
          glassButtonFees(
            "Mittel",
          ),
          glassButtonFees(
            "Hoch",
          ),
        ],
      ),
    );
  }

  Widget glassButtonFees(
    String fees,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
      child: fees == feesSelected
          ? Glassmorphism(
              blur: 20,
              opacity: 0.1,
              radius: 50.0,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5,
                    horizontal: AppTheme.elementSpacing,
                  ),
                  child: Text(fees,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppTheme.white90)),
                ),
              ),
            )
          : TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: () {
                setState(() {
                  feesSelected = fees;
                  switch (feesSelected) {
                    case "Niedrig":
                      break;
                    case "Mittel":
                      break;
                    case "Hoch":
                      break;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.5,
                  horizontal: AppTheme.elementSpacing,
                ),
                child: Text(
                  fees,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppTheme.white60),
                ),
              ),
            ),
    );
  }

  Widget button() {
    final userWallet = Provider.of<UserWallet>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SwipeableButtonView(
          isActive: _hasReceiver,
          buttontextstyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppTheme.white80, shadows: [AppTheme.boxShadowSmall]),
          buttonText: "JETZT SENDEN!",
          buttonWidget: Container(
            child: Icon(
              _hasReceiver
                  ? Icons.double_arrow_rounded
                  : Icons.lock_outline_rounded,
              color: AppTheme.white90,
              size: 33,
              shadows: [AppTheme.boxShadowProfile],
            ),
          ),
          activeColor: Colors.purple.shade800,
          disableColor: Colors.purple.shade800,
          isFinished: isFinished,
          onWaitingProcess: () {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isFinished = true;
              });
            });
          },
          onFinish: () async {
            await isBiometricsAvailable();
            if (isBioAuthenticated == true || hasBiometrics == false) {
              try {
                BitcoinTransaction mytransaction = await sendBitcoin(
                  receiver_address: "${_bitcoinReceiverAdress}",
                  amount_to_send: "${moneyController.text}",
                  fee_size: '$feesSelected',
                  userWallet: userWallet,
                );
                displaySnackbar(
                    context,
                    "Deine Bitcoin wurden versendet!"
                        " Es wird eine Weile dauern bis der Empfänger sie auch erhält.");
                await Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const BottomNav()));
              } catch (e) {
                print(e);
                displaySnackbar(context, "Ein Fehler ist aufgetreten");
                setState(() {
                  isFinished = false;
                });
              }
            } else {
              print('Biometric authentication failed');
            }
          }),
    );
  }
}
