import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/container/avatar.dart';
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
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: AppTheme.cardPadding * 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Avatar(
                  size: AppTheme.cardPadding * 4.75,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing,
                ),
                Icon(
                  Icons.double_arrow_rounded,
                  size: AppTheme.cardPadding * 3,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.white80
                      : AppTheme.black60,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing,
                ),
                Avatar(
                  size: AppTheme.cardPadding * 4.75,
                ),
              ],
            ),

            SizedBox(height: AppTheme.cardPadding),
            Text(data.amount,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color:
                    data.direction == TransactionDirection.received
                        ? AppTheme.successColor
                        : AppTheme.errorColor)),
            SizedBox(height: AppTheme.elementSpacing),
            Text(formattedDate,
                style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
              child: Row(
                children: [
                  Flexible(
                    child: Text(data.txHash,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                          text: data.txHash,
                        ));
                        Get.snackbar('Copied', data.txHash);
                      },
                      icon: const Icon(Icons.copy))
                ],
              ),
            ),
            SizedBox(height: AppTheme.cardPadding * 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
              child: MyDivider(),
            ),
            BitNetListTile(
              text: 'Status',
              trailing: Container(
                height: AppTheme.cardPadding * 1.5,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusCircular,
                  color: data.status == TransactionStatus.confirmed
                      ? AppTheme.successColor
                      : data.status == TransactionStatus.pending
                      ? AppTheme.colorBitcoin
                      : AppTheme.errorColor,
                ),
                child: Center(
                  child: Text(
                    data.status == TransactionStatus.confirmed
                        ? 'Received'
                        : data.status == TransactionStatus.pending
                        ? 'Pending'
                        : 'Error',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            BitNetListTile(
              text: "Payment Network",
              trailing: data.type == TransactionType.onChain
                  ? Image.asset(
                      "assets/images/bitcoin.png",
                      width: AppTheme.cardPadding * 1.5,
                      height: AppTheme.cardPadding * 1.5,
                    )
                  : Image.asset(
                      "assets/images/lightning.png",
                      width: AppTheme.cardPadding * 1.5,
                      height: AppTheme.cardPadding * 1.5,
                    ),
            ),
            BitNetListTile(
              text: 'Time',
              trailing: Text(
                "${data.timestamp}",
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ),
          ],
        ));
  }
}
