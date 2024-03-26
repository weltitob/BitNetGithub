import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class LightningTransactionDetails extends StatelessWidget {
  final TransactionItemData data;
  LightningTransactionDetails({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = displayTimeAgoFromInt(data.timestamp);
    return bitnetScaffold(
        context: context,

        body: Column(
          children: [
            bitnetAppBar(context: context, onTap: (){Navigator.pop(context);},),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transaction',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(5),
                      color: data.status == TransactionStatus.confirmed
                          ? AppTheme.successColor
                          : data.status == TransactionStatus.pending ? AppTheme.colorBitcoin
                          : AppTheme.errorColor,
                    ),
                    child: Center(
                      child: Text(
                        data.status == TransactionStatus.confirmed ? 'Confirmed'
                            : data.status == TransactionStatus.pending ? 'Pending'
                            : 'Error',
                        style: const TextStyle(
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Flexible(
                    child: Text(data.txHash,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(
                              text: data.txHash,
                            ));
                        Get.snackbar(
                            'Copied', data.txHash);
                      },
                      icon: const Icon(Icons.copy))
                ],
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Payment Network',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Flexible(
                    child: Image.asset(
                      data.type == TransactionType.onChain ? "assets/images/bitcoin.png" : "assets/images/lightning.png",
                      width: AppTheme.cardPadding * 0.75,
                      height: AppTheme.cardPadding * 0.75,
                      fit: BoxFit.contain,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Amount',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Flexible(
                    child: Text(data.amount,
                        style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:  data.direction == TransactionDirection.received
                                ? AppTheme.successColor
                                : AppTheme.errorColor)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Time',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Flexible(
                    child: Text(formattedDate,
                        style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:  Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
