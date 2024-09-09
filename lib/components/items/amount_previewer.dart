import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

//this class will be used to hide away the logic
// of what happens when you tap on a btc value to turn it into a use or when you hide your balance
class AmountPreviewer extends StatelessWidget {
  const AmountPreviewer(
      {super.key, required this.unitModel, required this.textStyle, required this.textColor, this.shouldHideBalance = true});
  final BitcoinUnitModel unitModel;
  final TextStyle textStyle;
  final Color? textColor;
  final bool shouldHideBalance;
  @override
  Widget build(BuildContext context) {
    WalletsController controller = Get.find<WalletsController>();
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    String? currency = Provider.of<CurrencyChangeProvider>(context, listen: true).selectedCurrency;
    currency = currency ?? "USD";
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price ?? 0;

    String currBalance =
        CurrencyConverter.convertCurrency(unitModel.bitcoinUnitAsString, (unitModel.amount as num).toDouble(), currency, bitcoinPrice);
    String currUnit = getCurrency(currency);
    if (coin.coin ?? true) {
      return controller.hideBalance.value && shouldHideBalance
          ? Text(
              '*****',
              style: textStyle,
            )
          : GestureDetector(
              onTap: () => coin.setCurrencyType(coin.coin != null ? !coin.coin! : false),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      unitModel.amount.toString(),
                      style: textStyle.copyWith(color: textColor),
                    ),
                    // const SizedBox(
                    //   width: AppTheme.elementSpacing / 2, // Replace with your AppTheme.elementSpacing if needed
                    // ),
                    Icon(
                      getCurrencyIcon(unitModel.bitcoinUnitAsString),
                      color: textColor,
                    ),
                  ],
                ),
              ),
            );
    } else {
      return controller.hideBalance.value && shouldHideBalance
          ? Text(
              '*****',
              style: textStyle,
            )
          : GestureDetector(
              onTap: () => coin.setCurrencyType(coin.coin != null ? !coin.coin! : false),
              child: Container(
                child: Text(
                  "$currBalance${getCurrency(currUnit)}",
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.copyWith(color: textColor),
                ),
              ),
            );
    }
  }
}
