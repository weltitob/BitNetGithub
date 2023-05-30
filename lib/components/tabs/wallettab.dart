import 'dart:async';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/pages/settings/settingsscreen.dart';
import 'package:flutter/material.dart';

class WalletTab extends StatefulWidget {
  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;

  late bool fixedScroll;
  String watchlist = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: buildWallet(),
    );
  }

  Widget buildWallet() {
    final String total = '=39876.589 SAT';
    final String totalCrypto = '1.251332 BTC';

    //wenn eigenes Profil ist
    //dann statdessen Deposit, send und open channel

    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: [
                  AppTheme.boxShadowSmall
                ],
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                        ),
                        SizedBox(
                          width: AppTheme.elementSpacing,
                        ),
                        Text(
                          'Total Wallet Balance',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.qr_code_rounded,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$totalCrypto',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            '$total',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                MyDivider(),
                buildLightningText(Icons.lock_rounded, 'Main Wallet', 28292),
                buildLightningText(
                    Icons.flash_on_rounded, 'Lightning Wallet', 28282392),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container()
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Icon(Icons.keyboard_arrow_down_rounded,),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLightningText(IconData iconData, String text, double balance) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.orange,
                  child: InkWell(
                    splashColor: Colors.orangeAccent, // inkwell color
                    child: SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: Icon(
                          iconData,
                          color: Colors.white,
                          size: 20.0,
                        )),
                    onTap: () {},
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              Text(
                text,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$balance SATS',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}