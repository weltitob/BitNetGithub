import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BalanceCardLightning extends StatelessWidget {
  final WalletController controller;
  const BalanceCardLightning({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(double.parse(controller.lightningBalance.balance), BitcoinUnits.SAT);
    final balanceStr = unitModel.amount.toString();
    return SizedBox(
      child: Stack(
        children: [
          const BalanceBackground2(),
          BalanceTextWidget(
            balanceStr: balanceStr,
            iconData: FontAwesomeIcons.wallet,
            balanceSAT: controller.lightningBalance.balance,
            walletAddress: "safdadasdas",
            cardname: 'Lightning',
            iconDataUnit: getCurrencyIcon(unitModel.bitcoinUnitAsString),
          ),
          paymentNetworkPicture(context, "assets/images/lightning.png"),
        ],
      ),
    );
  }
}

class BalanceCardBtc extends StatelessWidget {
  final WalletController controller;
  const BalanceCardBtc({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(double.parse(controller.onchainBalance.confirmedBalance), BitcoinUnits.SAT);
    final balanceStr = unitModel.amount.toString();

    return SizedBox(
      child: Stack(
        children: [
          const BalanceBackground(),
          BalanceTextWidget(
            balanceStr: balanceStr,
            iconDataUnit: getCurrencyIcon(unitModel.bitcoinUnitAsString),
            iconData: FontAwesomeIcons.piggyBank,
            balanceSAT: controller.onchainBalance.confirmedBalance,
            walletAddress: "safdadasdas",
            cardname: 'On-Chain',
          ),
          paymentNetworkPicture(context, 'assets/images/bitcoin.png')
        ],
      ),
    );
  }
}

class BalanceBackground2 extends StatelessWidget {
  const BalanceBackground2({Key? key}) : super(key: key);

  Widget iconLightning() {
    return Positioned(
        right: 0,
        top: 0,
        child: Icon(
          Icons.bolt,
          size: 150,
          color: Colors.white.withOpacity(0.1),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppTheme.cardRadiusBigger,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.tertiaryContainer,
            ],
          ),
        ),
        child: Stack(
          children: [
            iconLightning(),
          ],
        ),
      ),
    );
  }
}

class BalanceBackground extends StatelessWidget {
  const BalanceBackground({Key? key}) : super(key: key);


  Widget iconOnchain() {
    return Positioned(
        right: 0,
        top: 0,
        child: Icon(
          FontAwesomeIcons.chain,
          size: 150,
          color: Colors.white.withOpacity(0.1),
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppTheme.cardRadiusBigger,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: Stack(
          children: [
            iconOnchain(),
          ],
        ),
      ),
    );
  }
}

Widget paymentNetworkPicture(BuildContext context, String imageUrl) {
  return Positioned(
    right: AppTheme.cardPadding * 1.25,
    bottom: AppTheme.cardPadding * 1.25,
    child: Container(
      height: AppTheme.cardPadding * 2,
      width: AppTheme.cardPadding * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2),
        color: Theme.of(context).colorScheme.background.withOpacity(0.25),
      ),
      child: Image.asset(
        imageUrl,
      ),
    ),
  );
}


class BalanceTextWidget extends StatelessWidget {
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
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null ? (double.parse(balanceSAT) / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";

    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding * 1.25,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 24, // Replace with your AppTheme.elementSpacing * 1.75 if needed
              ),
              const SizedBox(
                width: 8, // Replace with your AppTheme.elementSpacing if needed
              ),
              Text(
                cardname,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const Spacer(), // Replace with AppTheme.elementSpacing if needed
          if(coin.coin ?? true) ...[
GestureDetector(
  onTap:() => coin.setCurrencyType(coin.coin != null ? !coin.coin!: false),
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
              GestureDetector(
                  onTap:() => coin.setCurrencyType(coin.coin != null ? !coin.coin!: false),

                child: Container(
                            width: 160, // Replace with your AppTheme.cardPadding * 10 if needed
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
    );
  }
}
