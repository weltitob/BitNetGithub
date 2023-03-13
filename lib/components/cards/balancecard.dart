import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/backbone/theme.dart';

class BalanceCardBtc extends StatelessWidget {
  const BalanceCardBtc({Key? key}) : super(key: key);

  final String _walletAddress = "1Lbcfr7sAHTD9CgdQo3HTMTkV8LK4ZnX71";

  Widget balanceText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Guthaben',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 2),
          Text(
            "2.150 BTC",
            // NumberFormat.simpleCurrency().format(MockBalance.data.last),
            style: Theme.of(context).textTheme.displaySmall),
          const Spacer(),
          Text(
            'Deine Wallet-Adresse:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: _walletAddress));
              // copied successfully
              displaySnackbar(context, "Wallet-Adresse in Zwischenablage kopiert");
            },
            child: Row(
              children: [
                Icon(Icons.copy_rounded, color: AppTheme.white80, size: 18,),
                const SizedBox(width: 4,),
                Container(
                  width: AppTheme.cardPadding * 10,
                  child: Text(
                    _walletAddress,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget currencyPicture(BuildContext context) {
    return Positioned(
      right: AppTheme.cardPadding * 1.5,
      top: AppTheme.cardPadding * 1.5,
      child: Container(
        height: AppTheme.cardPadding * 2,
        width: AppTheme.cardPadding * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2),
          color: Theme.of(context).backgroundColor.withOpacity(0.25),
        ),
        child: CachedNetworkImage(
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png',
        ),
      ),
    );
  }

  Widget profitPercent(BuildContext context) {
    return Positioned(
      right: 28,
      bottom: 28,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 8, 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).backgroundColor.withOpacity(0.25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              FontAwesomeIcons.caretUp,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text('+5.2%', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            const BalanceBackground(),
            balanceText(context),
            currencyPicture(context)
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