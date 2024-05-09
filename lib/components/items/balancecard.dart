import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BalanceCardLightning extends GetWidget<WalletsController> {
  const BalanceCardLightning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
        double.parse(controller.lightningBalance.balance), BitcoinUnits.SAT);
    final balanceStr = unitModel.amount.toString();

    return SizedBox(
      child: Stack(
        children: [
          const CardBackgroundLightning(),
          BalanceTextWidget(
            balanceStr: balanceStr,
            iconData: FontAwesomeIcons.wallet,
            balanceSAT: controller.lightningBalance.balance,
            walletAddress: "safdadasdas",
            cardname: 'Lightning Balance',
            iconDataUnit: getCurrencyIcon(unitModel.bitcoinUnitAsString),
          ),
          paymentNetworkPicture(context, "assets/images/lightning.png"),
        ],
      ),
    );
  }
}

class BalanceCardBtc extends GetWidget<WalletsController> {
  // final WalletController controller;
  const BalanceCardBtc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
        double.parse(controller.onchainBalance.confirmedBalance),
        BitcoinUnits.SAT);
    final balanceStr = unitModel.amount.toString();

    return SizedBox(
      child: Stack(
        children: [
          const CardBackgroundOnchain(),
          BalanceTextWidget(
            balanceStr: balanceStr,
            iconDataUnit: getCurrencyIcon(unitModel.bitcoinUnitAsString),
            iconData: FontAwesomeIcons.piggyBank,
            balanceSAT: controller.onchainBalance.confirmedBalance,
            walletAddress: "safdadasdas",
            cardname: 'On-Chain Balance',
          ),
          paymentNetworkPicture(context, 'assets/images/bitcoin.png')
        ],
      ),
    );
  }
}

class CardBackgroundLightning extends StatelessWidget {
  const CardBackgroundLightning({Key? key}) : super(key: key);

  Widget topLeftGradient() {
    return Positioned(
      left: -AppTheme.cardPadding * 7.5,
      top: -AppTheme.cardPadding * 7.5,
      child: Container(
        width: AppTheme.cardPadding * 15,
        height: AppTheme.cardPadding * 15,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.7],
            colors: [
              Color(0x99FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomRightGradient() {
    return Positioned(
      right: -AppTheme.cardPadding * 7.5,
      bottom: -AppTheme.cardPadding * 7.5,
      child: Container(
        width: AppTheme.cardPadding * 15,
        height: AppTheme.cardPadding * 15,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0, 0.7],
            colors: [
              Color(0x99FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBiggest,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            Color(0x99FFFFFF),
            Color(0x00FFFFFF),
            Color(0x00FFFFFF),
            Color(0x99FFFFFF),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBiggest,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.75],
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.tertiaryContainer,
              ],
            ),
          ),
          child: Stack(
            children: [
              topLeftGradient(),
              bottomRightGradient(),
              CustomPaint(
                size: Size(double.infinity,
                    double.infinity), // nimmt die Größe des Containers an
                painter: WavyGleamPainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WavyGleamPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
          .withOpacity(0.04) // Mehr Opazität für bessere Sichtbarkeit
      ..style = PaintingStyle.fill;

    // Erste Welle breiter machen
    Path path1 = Path()
      ..moveTo(0, 0) // Startpunkt oben links
      ..lineTo(
          0,
          size.height *
              0.0) // Beginn der Welle ein Drittel des Weges nach unten
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.0, // Erster Kontrollpunkt leicht rechts von Start
        size.width * 0.3,
        size.height * 0.0, // Zweiter Kontrollpunkt für den Aufstieg der Welle
        size.width * 0.4,
        size.height * 0.4, // Höhepunkt der Welle in der Mitte der Karte
      )
      ..cubicTo(
        size.width * 0.6,
        size.height * 0.9, // Dritter Kontrollpunkt für den Abstieg
        size.width * 0.8,
        size.height *
            0.7, // Vierter Kontrollpunkt weiter rechts für die Rundung
        size.width,
        size.height *
            0.75, // Endpunkt rechts, auf gleicher Höhe wie der vierte Kontrollpunkt
      )
      ..lineTo(size.width,
          size.height) // Linie nach unten zum unteren rechten Eckpunkt
      ..lineTo(0, size.height) // Linie zurück zum unteren linken Eckpunkt
      ..close(); // Pfad schließen

    // Zweite Welle breiter machen, etwas unterhalb der ersten
    Path path2 = Path()
      ..moveTo(0, 0) // Startpunkt oben links
      ..lineTo(
          0,
          size.height *
              0.0) // Beginn der Welle ein Drittel des Weges nach unten
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.1, // Erster Kontrollpunkt leicht rechts von Start
        size.width * 0.3,
        size.height * 0.1, // Zweiter Kontrollpunkt für den Aufstieg der Welle
        size.width * 0.4,
        size.height * 0.5, // Höhepunkt der Welle in der Mitte der Karte
      )
      ..cubicTo(
        size.width * 0.6,
        size.height * 1, // Dritter Kontrollpunkt für den Abstieg
        size.width * 0.8,
        size.height *
            0.8, // Vierter Kontrollpunkt weiter rechts für die Rundung
        size.width,
        size.height *
            0.85, // Endpunkt rechts, auf gleicher Höhe wie der vierte Kontrollpunkt
      )
      ..lineTo(size.width,
          size.height) // Linie nach unten zum unteren rechten Eckpunkt
      ..lineTo(0, size.height) // Linie zurück zum unteren linken Eckpunkt
      ..close(); // Pfad schließen

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CardBackgroundOnchain extends StatelessWidget {
  const CardBackgroundOnchain({Key? key}) : super(key: key);

  Widget topLeftGradient() {
    return Positioned(
      left: -AppTheme.cardPadding * 7.5,
      top: -AppTheme.cardPadding * 7.5,
      child: Container(
        width: AppTheme.cardPadding * 15,
        height: AppTheme.cardPadding * 15,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.7],
            colors: [
              Color(0x99FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomRightGradient() {
    return Positioned(
      right: -AppTheme.cardPadding * 7.5,
      bottom: -AppTheme.cardPadding * 7.5,
      child: Container(
        width: AppTheme.cardPadding * 15,
        height: AppTheme.cardPadding * 15,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: [0, 0.7],
            colors: [
              Color(0x99FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBiggest,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            Color(0x99FFFFFF),
            Color(0x00FFFFFF),
            Color(0x00FFFFFF),
            Color(0x99FFFFFF),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBiggest,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              //stops: [0.25, 1],
              stops: [0, 0.75],
              colors: [
                Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Stack(
            children: [
              //iconOnchain(),
              topLeftGradient(),
              bottomRightGradient(),
              CustomPaint(
                size: Size(double.infinity,
                    double.infinity), // nimmt die Größe des Containers an
                painter: WavyGleamPainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget paymentNetworkPicture(BuildContext context, String imageUrl) {
  return Positioned(
    right: AppTheme.cardPadding * 1.25,
    top: AppTheme.cardPadding * 1.25,
    child: Container(
      height: AppTheme.cardPadding * 2,
      width: AppTheme.cardPadding * 2,
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusCircular,
        color: Theme.of(context).colorScheme.background.withOpacity(0.25),
      ),
      child: Image.asset(
        imageUrl,
      ),
    ),
  );
}

class BalanceTextWidget extends GetWidget<WalletsController> {
  final String balanceSAT;
  final String balanceStr;
  final String cardname;
  final String walletAddress;
  final IconData iconData;
  final IconData iconDataUnit;

  const BalanceTextWidget({
    Key? key,
    required this.balanceSAT,
    required this.balanceStr,
    required this.walletAddress,
    required this.iconData,
    required this.iconDataUnit,
    required this.cardname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? (double.parse(balanceSAT) / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";

    return Padding(
      padding: const EdgeInsets.all(
        AppTheme.cardPadding * 1.25,
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  cardname,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            SizedBox(
              height: AppTheme.elementSpacing * 0.75,
            ),
            if (coin.coin ?? true) ...[
              controller.hideBalance.value
                  ? Text('*****')
                  : GestureDetector(
                      onTap: () => coin.setCurrencyType(
                          coin.coin != null ? !coin.coin! : false),
                      child: Container(
                        width: 160,
                        child: Row(
                          children: [
                            Text(
                              balanceStr,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            // const SizedBox(
                            //   width: AppTheme.elementSpacing / 2, // Replace with your AppTheme.elementSpacing if needed
                            // ),
                            Icon(
                              iconDataUnit,
                            ),
                          ],
                        ),
                      ),
                    ),
            ] else ...[
              controller.hideBalance.value
                  ? Text('*****')
                  : GestureDetector(
                      onTap: () => coin.setCurrencyType(
                          coin.coin != null ? !coin.coin! : false),
                      child: Container(
                        width:
                            160, // Replace with your AppTheme.cardPadding * 10 if needed
                        child: Text(
                          "$currencyEquivalent${getCurrency(currency!)}",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
            ]
          ],
        ),
      ),
    );
  }
}
