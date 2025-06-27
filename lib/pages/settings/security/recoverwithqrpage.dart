import 'dart:convert';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:bitnet/intl/generated/l10n.dart';

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

  @override
  void initState() {
    userdatajson = getPrivateKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().setQrCodeRecoverySeen();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getPrivateKey() async {
    PrivateData privateuserdata = await getPrivateData(myuserdid);
    print("privateuserdata: ${privateuserdata.mnemonic}");
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
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              FutureBuilder(
                future: getPrivateKey(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                        height: AppTheme.cardPadding * 8,
                        child: Center(child: dotProgress(context)));
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding,
                        vertical: AppTheme.cardPadding * 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppTheme.cardRadiusBigger),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(AppTheme.elementSpacing * 1.5),
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
                  const Icon(
                    FontAwesomeIcons.solidEyeSlash,
                    size: AppTheme.elementSpacing,
                  ),
                  const SizedBox(
                    width: AppTheme.elementSpacing / 2,
                  ),
                  Text(
                    L10n.of(context)!.dontShareAnyone,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
