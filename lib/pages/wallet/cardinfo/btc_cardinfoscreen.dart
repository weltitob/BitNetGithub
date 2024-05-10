import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BitcoinCardInformationScreen extends StatelessWidget {
  const BitcoinCardInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: "Bitcoin Card Information",
        ),
      context: context,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
                height: 200,
                child: BalanceCardBtc()),
            BitNetListTile(
              text: 'Address',
              trailing: Text('bc1qkmlp...' + '30fltzunefdjln'),
            ),
            BitNetListTile(
              text: 'QRCode',
              trailing: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(
                      AppTheme.cardPadding / 1.25),
                  //margin: const EdgeInsets.all(AppTheme.cardPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusBigger),
                  child: PrettyQrView.data(
                      data:
                      "bc1qkmlpuea96ekcjlk2wpjhsrr030fltzunefdjln",
                      decoration: const PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          roundFactor: 1,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
