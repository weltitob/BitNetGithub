import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:flutter/material.dart';

class TransactionHeaderWidget extends StatelessWidget {
  final TransactionItemData data;
  final VoidCallback? onSenderTap;
  final VoidCallback? onReceiverTap;
  final String? senderLabel;
  final String? receiverLabel;

  const TransactionHeaderWidget({
    required this.data,
    this.onSenderTap,
    this.onReceiverTap,
    this.senderLabel,
    this.receiverLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Sender avatar and label
        Column(
          children: [
            Avatar(
              size: AppTheme.cardPadding * 4,
              isNft: false,
              onTap: onSenderTap,
            ),
            const SizedBox(height: AppTheme.elementSpacing * 0.5),
            Text(senderLabel ??
                (data.type == TransactionType.lightning ? "You" : "Sender")),
          ],
        ),

        // Arrow
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding * 0.75),
          child: Icon(
            Icons.double_arrow_rounded,
            size: AppTheme.cardPadding * 2.5,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white80
                : AppTheme.black60,
          ),
        ),

        // Receiver avatar and label
        Column(
          children: [
            Avatar(
              size: AppTheme.cardPadding * 4,
              isNft: false,
              onTap: onReceiverTap,
            ),
            const SizedBox(height: AppTheme.elementSpacing * 0.5),
            Text(receiverLabel ??
                (data.type == TransactionType.lightning
                    ? "Receiver"
                    : "Receiver")),
          ],
        ),
      ],
    );
  }
}
