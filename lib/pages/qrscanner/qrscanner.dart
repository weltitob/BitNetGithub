import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/profile/actions/sendscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => QRScannerController();
}

class QRScannerController extends State<QrScanner> {

  MobileScannerController cameraController = MobileScannerController();
  bool isQRScanner = true;
  bool isLoading = false;


  void onScannedForSignIn(dynamic encodedString) async {
    try{
      //Auth().signOut();

      final privateData = PrivateData.fromJson(encodedString);

      final signedMessage = await Auth().signMessageAuth(
          privateData.did,
          privateData.privateKey
      );
      //login

      // Call the function to store Private data in secure storage
      await storePrivateData(privateData);

      await Auth().signIn(
          privateData.did,
          signedMessage,
          context
      );

      setState(() {});
    } catch(e){
      print("onScannedForSignIn: $e");
    }
  }

  void onScannedForSendingBitcoin(dynamic encodedString) async {

    final userData = Provider.of<UserData>(context);

    final currentqr = QR_BitcoinAddress.fromJson(encodedString);

    /// a simple check if its a BTC wallet or not, regardless of its type
    final bool isValid = isBitcoinWalletValid(currentqr.bitcoinAddress);
    print(isValid);

    /// a bit more complicated check which can return the type of
    /// BTC wallet and return SegWit (Bech32), Regular, or None if
    /// the string is not a BTC address
    final walletType = getBitcoinWalletType(currentqr.bitcoinAddress);
    print(walletType);

    /// Detailed check, for those who need to get more details
    /// of the wallet. Returns the address type, the network, and
    /// the wallet type along with its address.
    /// It always returns BitcoinWalletDetails object. To check if it's
    /// valid or not use bitcoinWalletDetails.isValid getter
    /// IMPORTANT The BitcoinWalletDetails class overrides an
    /// equality operators so two BitcoinWalletDetails objects can be
    /// compared simply like this bwd1 == bwd2
    final walletdetails = getBitcoinWalletDetails(currentqr.bitcoinAddress);
    print(walletdetails);

    if(isValid){
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SendBTCScreen(
              bitcoinReceiverAdress: currentqr.bitcoinAddress,
              bitcoinSenderAdress: userData.mainWallet.walletAddress,),
      ));
    } else {
      print("Error beim einscannen des QR Codes");
      displaySnackbar(context, "Der eingescannte QR-Code hat kein zugelassenes Format");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
