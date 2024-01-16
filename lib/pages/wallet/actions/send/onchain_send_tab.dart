import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/models/firebase/cloudfunction_callback.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:bitnet/backbone/cloudfunctions/sendbitcoin.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/components/swipebutton/swipeable_button_view.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:page_transition/page_transition.dart';

class OnChainSendTab extends StatefulWidget {
  final String?
      bitcoinReceiverAdress; // the Bitcoin receiver address, can be null
  final String bitcoinSenderAdress; // the Bitcoin receiver address, can be null
  const OnChainSendTab(
      {super.key,
      this.bitcoinReceiverAdress,
      required this.bitcoinSenderAdress});

  @override
  State<OnChainSendTab> createState() => _OnChainSendTabState();
}

class _OnChainSendTabState extends State<OnChainSendTab> {
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;
  late double feesInEur_medium;
  late double feesInEur_high;
  late double feesInEur_low;
  String feesSelected = "Niedrig";
  late double feesInEur;
  TextEditingController bitcoinReceiverAdressController =
      TextEditingController(); // the controller for the Bitcoin receiver address text field
  TextEditingController moneyController =
      TextEditingController(); // the controller for the amount text field
  bool isFinished =
      false; // a flag indicating whether the send process is finished
  bool _hasReceiver =
      false; // a flag indicating whether a receiver address is present
  String _bitcoinReceiverAdress = ''; // the Bitcoin receiver address
  dynamic _moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;

  bool _isLoadingFees =
      true; // a flag indicating whether the exchange rate is loading
  // Biometric authentication before sending// a flag indicating whether the security has been checked
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // a key for the form widget

  @override
  void initState() {
    super.initState();
    moneyController.text = "0.00001"; // set the initial amount to 0.00001
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
    getFeesLocal(widget.bitcoinSenderAdress);
    if (widget.bitcoinReceiverAdress != null) {
      setState(() {
        _bitcoinReceiverAdress = widget.bitcoinReceiverAdress!;
        _hasReceiver = true;
        bitcoinReceiverAdressController.text = widget.bitcoinReceiverAdress!;
      });
    } else {
      print(
          "Bisher wurde noch keine Empfängeradresse angegeben"); // print a message if no receiver address is provided
    }
  }

  // This method is called when the widget is being disposed.
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    moneyController.dispose();
    super.dispose();
  }

  // This function is used to validate a Bitcoin wallet address. If the input value is null or empty,
  // it displays a Snackbar with an error message. If the input value is a valid Bitcoin wallet address,
  // it sets the state variables _bitcoinReceiverAdress and _hasReceiver to the input value and true, respectively.
  // If the input value is not a valid Bitcoin wallet address, it displays a Snackbar with an error message.
  void validateAdress(String value) {
    if (value.isEmpty) {
      displaySnackbar(
          context, "Hmm. Diese Walletadresse scheint nicht zu existieren");
    }
    final isValid = isBitcoinWalletValid(value);
    if (isValid) {
      setState(() {
        _bitcoinReceiverAdress = value;
        _hasReceiver = true;
      });
    } else {
      displaySnackbar(
          context, "Hmm. Diese Walletadresse scheint nicht zu existieren");
    } //to indicate the input is valid
  }

  void getFeesLocal(String bitcoinaddress) async {
    //IMPLEMENT THE FEES FROM THE MEMPOOL HERE

    // await getBitcoinPriceLocal();
    // _isLoadingFees = true;
    // try {
    //   // Calls the getFees function to retrieve fee information
    //   dynamic feesInBtc = await getFees(
    //     sender_address: widget.bitcoinSenderAdress,
    //   );
    //   if (feesInBtc == null) {
    //     //try it again in 5 seconds
    //     Future.delayed(Duration(seconds: 10), () {
    //       getFeesLocal(bitcoinaddress);
    //     });
    //     return;
    //   }
    //   setState(() {
    //     feesInEur_medium = bitcoinprice * double.parse(feesInBtc.fees_medium);
    //     feesInEur_low = bitcoinprice * double.parse(feesInBtc.fees_low);
    //     feesInEur_high = bitcoinprice * double.parse(feesInBtc.fees_high);
    //     feesInEur = feesInEur_low;
    //     _isLoadingFees = false;
    //   });
    // } catch (e) {
    //   _isLoadingFees = true;
    //   print("error local getfees $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            height:
                MediaQuery.of(context).size.height - AppTheme.cardPadding * 4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding),
                          child: Text(
                            "Empfänger",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        _hasReceiver
                            ? userTile()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding,
                                    vertical: AppTheme.elementSpacing / 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Adds a text input for the Bitcoin receiver address
                                    Container(
                                      width: AppTheme.cardPadding * 8.5,
                                      child: FormTextField(
                                        hintText: "Bitcoin-Adresse",
                                        // Unfocuses the input field when tapped outside of it
                                        onTapOutside: (value) {
                                          if (myFocusNodeAdress.hasFocus) {
                                            myFocusNodeAdress.unfocus();
                                            validateAdress(
                                                bitcoinReceiverAdressController
                                                    .text);
                                          }
                                        },
                                        // Limits the length of the input to 40 characters
                                        maxLength: 40,
                                        // Adds a focus node for the input field
                                        focusNode: myFocusNodeAdress,
                                        // Binds the controller to the text input
                                        controller:
                                            bitcoinReceiverAdressController,
                                        // Validates the address when the text input is submitted
                                        onFieldSubmitted: (value) {
                                          validateAdress(value);
                                        },
                                        autofocus: false,
                                      ),
                                    ),

                                    // A GestureDetector widget that navigates to a new page when tapped
                                    GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const QrScanner(
                                                        //isBottomButtonVisible: true,
                                                        ),
                                              ),
                                            ),
                                        child: avatarGlow(
                                          context,
                                          Icons.circle,
                                        )),
                                    RoundedButtonWidget(iconData: Icons.search, onTap: (){}),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    // A SizedBox widget with a height of AppTheme.cardPadding * 2
                    const SizedBox(
                      height: AppTheme.cardPadding * 2,
                    ),

                    // A Center widget with a child of bitcoinWidget()
                    Center(child: bitcoinWidget()),

                    // A SizedBox widget with a height of AppTheme.cardPadding * 3
                    const SizedBox(
                      height: AppTheme.cardPadding * 3,
                    ),

                    // A Padding widget that contains a Column widget with a few children

                  ],
                ),
                // A Padding widget that contains a button widget
                Padding(
                    padding: EdgeInsets.only(bottom: AppTheme.cardPadding * 4),
                    child: button()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget onChainFees(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // A Row widget with a Text widget, a SizedBox widget, and a GestureDetector widget
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
                  // Displays a snackbar message when tapped
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
          // A function that returns a widget for choosing fees
          buildFeesChooser(),
          SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
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
                  size: AppTheme.cardPadding,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // This widget represents a user tile with an avatar, title, subtitle, and edit button.
  Widget userTile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The ListTile widget is used to display the user tile.
          ListTile(
            // The leading widget is a circle avatar that displays an image.
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://bitfalls.com/wp-content/uploads/2017/09/header-5.png"),
            ),
            // The title displays the user's name.
            title: Text(
              "Unbekannte Walletadresse",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            // The subtitle displays a card number.
            subtitle: cardWithNumber(),
            // The trailing widget is an icon button that is used to edit the user's information.
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

// A widget to display the bitcoin receiver address in a row with an icon for copying it to the clipboard
  Widget cardWithNumber() {
    return GestureDetector(
      // On tap, copies the receiver address to the clipboard and displays a snackbar
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: _bitcoinReceiverAdress));
        displaySnackbar(context, "Wallet-Adresse in Zwischenablage kopiert");
      },
      child: Row(
        children: [
          // Icon for copying the receiver address to clipboard
          const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
          SizedBox(
            width: AppTheme.cardPadding * 8,
            child: Text(
              // The receiver address to be displayed
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
    // Accessing the user wallet object from Provider
    //final userWallet = Provider.of<UserWallet>(context);
    final userWallet = UserWallet(
        walletAddress: "fakewallet",
        walletType: "walletType",
        walletBalance: "0",
        privateKey: "privateKey",
        userdid: "userdid");

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
          AmountWidget(),
        ],
      ),
    );
  }

  Widget buildFeesChooser() {
    // create a container with top and bottom padding
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15.0, bottom: 10),
          // create a row with evenly distributed children buttons
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // create a button for "Niedrig" fees
              glassButtonFees(
                "Niedrig",
              ),
              // create a button for "Mittel" fees
              glassButtonFees(
                "Mittel",
              ),
              // create a button for "Hoch" fees
              glassButtonFees(
                "Hoch",
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        _isLoadingFees // if exchange rate is still loading
            ? dotProgress(context) // show a loading indicator
            : Text(
                "≈ ${feesInEur.toStringAsFixed(2)}€", // show the converted value of Bitcoin to Euro with 2 decimal places
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // use the bodyLarge text theme style from the current theme
              )
      ],
    );
  }

  Widget glassButtonFees(String fees) {
    // defines a function that takes a string parameter called "fees"
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
      child:
          fees == feesSelected // if the fees parameter equals the selected fees
              ? GlassContainer(
                  // render a button with glassmorphism effect
                  borderThickness: 1.5, // remove border if not active
                  blur: 50,
                  opacity: 0.1,
                  borderRadius: AppTheme.cardRadiusCircular,
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
                  // if the fees parameter is not selected
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    setState(() {
                      // update the state with the new selected fees
                      feesSelected = fees;
                      switch (fees) {
                        case "Niedrig":
                          feesInEur = feesInEur_low;
                          break;
                        case "Mittel":
                          feesInEur = feesInEur_medium;
                          break;
                        case "Hoch":
                          feesInEur = feesInEur_high;
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
    // Get the user wallet from the context using Provider
    //final userWallet = Provider.of<UserWallet>(context);
    final userWallet = UserWallet(
        walletAddress: "fakewallet",
        walletType: "walletType",
        walletBalance: "0",
        privateKey: "privateKey",
        userdid: "userdid");

    // Return a Padding widget containing a SwipeableButtonView
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SwipeableButtonView(
          // Determine if the button should be active based on whether a receiver has been selected
          isActive: _hasReceiver,
          // Set the text style for the button text
          buttontextstyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppTheme.white80, shadows: [AppTheme.boxShadowSmall]),
          // Set the text to display on the button
          buttonText: "JETZT SENDEN!",
          // Set the widget to display inside the button
          buttonWidget: Container(
            child: Icon(
              // Set the icon to display based on whether a receiver has been selected
              _hasReceiver
                  ? Icons.double_arrow_rounded
                  : Icons.lock_outline_rounded,
              color: AppTheme.white90,
              size: 33,
              shadows: [AppTheme.boxShadowProfile],
            ),
          ),
          // Set the active and disabled colors for the button
          activeColor: Colors.purple.shade800,
          disableColor: Colors.purple.shade800,
          // Determine whether the button has finished its operation
          isFinished: isFinished,
          // Define the function to execute while the button is in a waiting state
          onWaitingProcess: () {
            // Wait for 2 seconds, then set isFinished to true
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                isFinished = true;
              });
            });
          },
          // Define the function to execute when the button is finished
          onFinish: () async {
            // Check if biometric authentication is available
            await isBiometricsAvailable();
            setState(() {});
            if (isBioAuthenticated == true || hasBiometrics == false) {
              try {
                // Send bitcoin to the selected receiver using the user's wallet
                CloudfunctionCallback callback = await sendBitcoin(
                  receiver_address: "${_bitcoinReceiverAdress}",
                  amount_to_send: "${moneyController.text}",
                  fee_size: '$feesSelected',
                  userWallet: userWallet,
                );
                if (callback.statusCode == "success") {
                  // Display a success message and navigate to the bottom navigation bar
                  displaySnackbar(
                      context,
                      "Deine Bitcoin wurden versendet!"
                      " Es wird eine Weile dauern bis der Empfänger sie auch erhält.");
                  await Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const Scaffold(
                            body: Center(
                              child: Text("ADD SCREEN!"),
                            ),
                          )));
                } else {
                  // Display an error message if the cloud function failed and set isFinished to false
                  print(
                      "Fehler in der Cloudfunktion augetreten: ${callback.message}");
                  displaySnackbar(context, "${callback.message}");
                  setState(() {
                    isFinished = false;
                  });
                }
              } catch (e) {
                // Display an error message if an error occurred and set isFinished to false
                print(e);
                displaySnackbar(context, "Ein Fehler ist aufgetreten: $e");
                setState(() {
                  isFinished = false;
                });
              }
            } else {
              // Display an error message if biometric authentication failed
              print('Biometric authentication failed');
            }
          }),
    );
  }
}
