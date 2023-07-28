import 'dart:convert';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/auth/storePrivateData.dart';
import 'package:BitNet/components/loaders/loaders.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/models/keys/privatedata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class RecoverWithQRPage extends StatefulWidget {
  const RecoverWithQRPage({Key? key}) : super(key: key);

  @override
  State<RecoverWithQRPage> createState() => _RecoverWithQRPageState();
}

class _RecoverWithQRPageState extends State<RecoverWithQRPage> {

  //userprovider und dann für jeweilige userdid also user uid die getIonData Funktion auf dem
  //lokalen device callen

  final myuserdid = Auth().currentUser!.uid;
  late dynamic userdatajson;

  @override void initState() {
    userdatajson = getPrivateKey();
    // TODO: implement initState
    super.initState();
  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getPrivateKey() async {
    print("Trying to read data from secure storage(QR)...");
    print(myuserdid);
    PrivateData privateuserdata = await getPrivateData(myuserdid);


    final userdataJsonString = json.encode(privateuserdata.toMap());
    return userdataJsonString;
  }

  GlobalKey globalKeyQR = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RepaintBoundary(
          key: globalKeyQR,
          child: Column(
            children: [
              SizedBox(height: AppTheme.cardPadding,),
              FutureBuilder(
                future: getPrivateKey(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                        height: AppTheme.cardPadding * 10,
                        child: Center(child: dotProgress(context)));
                  }
                  return Container(
                    margin: EdgeInsets.all(AppTheme.cardPadding),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppTheme.cardRadiusBigger),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.elementSpacing * 1.5),
                      child: PrettyQr(
                        //image: AssetImage('assets/images/key_removed_bck.png'),
                        typeNumber: 14,
                        size: AppTheme.cardPadding * 11,
                        data: snapshot.data,
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        roundEdges: true,
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.solidEyeSlash, size: AppTheme.elementSpacing,),
                  SizedBox(width: AppTheme.elementSpacing / 2,),
                  Text("DON'T SHARE THIS QR CODE TO ANYONE!", style: Theme.of(context).textTheme.button,),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
