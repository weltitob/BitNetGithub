import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class RecoverWithQRPage extends StatefulWidget {
  const RecoverWithQRPage({Key? key}) : super(key: key);

  @override
  State<RecoverWithQRPage> createState() => _RecoverWithQRPageState();
}

class _RecoverWithQRPageState extends State<RecoverWithQRPage> {

  GlobalKey globalKeyQR = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RepaintBoundary(
          key: globalKeyQR,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(AppTheme.cardPadding),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppTheme.cardRadiusBigger),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.elementSpacing * 1.5),
                  child: PrettyQr(
                    image: AssetImage('assets/images/bitcoin.png'),
                    typeNumber: 3,
                    size: AppTheme.cardPadding * 10,
                    data: 'test',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
