import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:bitnet/backbone/cloudfunctions/getbalance.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BalanceCardLightning extends StatelessWidget {
  final WalletController controller;
  const BalanceCardLightning({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            const BalanceBackground2(),
            BalanceTextWidget(
              iconData: FontAwesomeIcons.wallet,
              balance: controller.lightningBalance.balance,
              walletAddress: "safdadasdas",
              currencyEquivalent: 'balanceInEuroOrBTC',
            ),
            currencyPicture(context, "assets/images/lightning.png"),
          ],
        ),
      ),
    );
  }
}

class BalanceCardBtc extends StatelessWidget {
  final WalletController controller;
  const BalanceCardBtc({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            const BalanceBackground(),
            BalanceTextWidget(
              iconData: FontAwesomeIcons.piggyBank,
              balance: controller.onchainBalance.confirmedBalance,
              walletAddress: "safdadasdas",
              currencyEquivalent: 'balanceInEuroOrBTC',
            ),
            currencyPicture(context, 'assets/images/bitcoin.png')
          ],
        ),
      ),
    );
  }
}

class BalanceBackground2 extends StatelessWidget {
  const BalanceBackground2({Key? key}) : super(key: key);

  Widget circleTopRight() {
    return Positioned(
      right: 100,
      top: -80,
      child: Container(
        width: 265,
        height: 265,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-0.8, -0.7),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x26FFFFFF),
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
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
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
        borderRadius: BorderRadius.circular(34),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF522F77),
                Color(0xFF7127B7),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleTopRight(),
            ],
          ),
        ),
      ),
    );
  }
}

class BalanceBackground extends StatelessWidget {
  const BalanceBackground({Key? key}) : super(key: key);

  Widget circleTopRight() {
    return Positioned(
      right: -100,
      top: -80,
      child: Container(
        width: 265,
        height: 265,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment(-0.8, -0.7),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x26FFFFFF),
              Color(0x00FFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleBottomLeft() {
    return Positioned(
      left: -20,
      bottom: -140,
      child: Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, -0.2),
            colors: [
              Color(0x00FFFFFF),
              Color(0x4DFFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
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
        borderRadius: BorderRadius.circular(34),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF522F77),
                Color(0xFF7127B7),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleTopRight(),
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundGradientPurple2 extends StatelessWidget {
  const BackgroundGradientPurple2({Key? key}) : super(key: key);

  Widget circleBottomLeft() {
    return Positioned(
      left: -40,
      bottom: 0,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, -0.2),
            colors: [
              Color(0x00FFFFFF),
              Color(0x4DFFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBig,
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
        borderRadius: AppTheme.cardRadiusBig,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF522F77),
                Color(0xFF7127B7),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundGradientOrange extends StatelessWidget {
  const BackgroundGradientOrange({Key? key}) : super(key: key);

  Widget circleBottomLeft() {
    return Positioned(
      left: -40,
      bottom: 0,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, -0.2),
            colors: [
              Color(0x00FFFFFF),
              Color(0x4DFFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBig,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            Color(0x99FFFFFF),
            AppTheme.colorPrimaryGradient,
            AppTheme.colorBitcoin,
            Color(0x99FFFFFF),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBig,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppTheme.colorBitcoin,
                AppTheme.colorPrimaryGradient,
              ],
            ),
          ),
          child: Stack(
            children: [
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundGradientPurple extends StatelessWidget {
  const BackgroundGradientPurple({Key? key}) : super(key: key);

  Widget circleBottomLeft() {
    return Positioned(
      right: -40,
      top: -20,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(0.9, -0.2),
            colors: [
              Color(0x00FFFFFF),
              Color(0x4DFFFFFF),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBig,
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
        borderRadius: AppTheme.cardRadiusBig,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF522F77),
                Color(0xFF7127B7),
              ],
            ),
          ),
          child: Stack(
            children: [
              circleBottomLeft(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget currencyPicture(BuildContext context, String imageUrl) {
  return Positioned(
    right: AppTheme.cardPadding * 1.5,
    top: AppTheme.cardPadding * 1.5,
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
  final String balance;
  final String walletAddress;
  final IconData iconData;
  final String currencyEquivalent;

  const BalanceTextWidget({
    Key? key,
    required this.balance,
    required this.walletAddress,
    required this.iconData,
    required this.currencyEquivalent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding * 1.5),
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
                'Guthaben',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8), // Replace with your AppTheme.elementSpacing if needed
          Text(
            "$balance SAT",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 4, // Replace with your AppTheme.elementSpacing * 0.25 if needed
          ),
          Container(
            width: 160, // Replace with your AppTheme.cardPadding * 10 if needed
            child: Text(
              "= $currencyEquivalent€",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deine Adresse:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: walletAddress));
                  // copied successfully
                  // Replace with your method to display a snackbar
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.copy_rounded,
                      color: Colors.grey, // Replace with your AppTheme.white80 if needed
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      walletAddress,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
