import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/transactions/base_transaction_details.dart';
import 'package:bitnet/components/transactions/transaction_amount_widget.dart';
import 'package:bitnet/components/transactions/transaction_detail_tile.dart';
import 'package:bitnet/components/transactions/transaction_details_container.dart';
import 'package:bitnet/components/transactions/transaction_header_widget.dart';
import 'package:bitnet/components/transactions/transaction_status_indicator.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LightningTransactionDetails extends BaseTransactionDetails {
  const LightningTransactionDetails({required TransactionItemData data, Key? key})
      : super(data: data, key: key);

  @override
  LightningTransactionDetailsState createState() => LightningTransactionDetailsState();
}

class LightningTransactionDetailsState extends BaseTransactionDetailsState<LightningTransactionDetails> {
  
  @override
  String getHeaderTitle() => 'Lightning Transaction';

  @override
  Widget buildNetworkSpecificDetails() {
    // Lightning has no specific additional details beyond the standard ones
    return const SizedBox.shrink();
  }

  @override
  Widget buildMainContainer() {
    return TransactionDetailsContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.elementSpacing,
          horizontal: AppTheme.elementSpacing,
        ),
        child: Column(
          children: [
            // Transaction header with sender/receiver
            TransactionHeaderWidget(data: widget.data),
            
            // Amount display
            TransactionAmountWidget(data: widget.data),
            
            // Details container
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.elementSpacing * 0.5, 
                vertical: AppTheme.elementSpacing
              ),
              child: TransactionDetailsContainer(
                nested: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status
                      TransactionDetailTile(
                        text: 'Status',
                        trailing: buildStatusIndicator(),
                      ),
                      
                      // Transaction ID
                      TransactionDetailTile(
                        text: 'TransactionID',
                        trailing: buildCopyableText(widget.data.txHash),
                      ),
                      
                      // Payment Network
                      TransactionDetailTile(
                        text: "Payment Network",
                        trailing: Row(
                          children: [
                            Image.asset(
                              "assets/images/lightning.png",
                              width: AppTheme.cardPadding * 1,
                              height: AppTheme.cardPadding * 1
                            ),
                            const SizedBox(width: AppTheme.elementSpacing / 2),
                            Text(
                              'Lightning',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      
                      // Time
                      TransactionDetailTile(
                        text: 'Time',
                        leading: Icon(
                          Icons.access_time,
                          size: AppTheme.cardPadding * 0.75,
                          color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white60
                            : AppTheme.black60,
                        ),
                        trailing: SizedBox(
                          width: AppTheme.cardPadding * 7.w,
                          child: Text(
                            "${time} (${formattedDate})",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      
                      // Fee
                      TransactionDetailTile(
                        text: 'Fee',
                        trailing: buildFeeDisplay(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildStatusIndicator() {
    final controller = Get.find<WalletsController>();
    
    return Row(
      children: [
        widget.data.status == TransactionStatus.pending
          ? Obx(() => GestureDetector(
              onTap: () {
                controller.showInfo.value = !controller.showInfo.value;
                BitNetBottomSheet(
                  context: context,
                  child: _buildInfoBottomSheet(),
                );
              },
              child: Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.black60,
                ),
                child: Center(
                  child: Icon(
                    controller.showInfo.value
                      ? Icons.info
                      : Icons.info_outline,
                    color: AppTheme.white60,
                  ),
                ),
              ),
            ))
          : const SizedBox.shrink(),
        SizedBox(width: 10.w),
        TransactionStatusIndicator(status: widget.data.status),
      ],
    );
  }
  
  Widget buildFeeDisplay() {
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency ?? "USD";
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            coin.setCurrencyType(coin.coin != null ? !coin.coin! : false);
          },
          child: Text(
            coin.coin ?? true
              ? '${widget.data.fee}'
              : "$currencyEquivalentFee ${getCurrency(currency)}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        coin.coin ?? true
          ? Icon(AppTheme.satoshiIcon)
          : const SizedBox.shrink(),
      ],
    );
  }
  
  Widget _buildInfoBottomSheet() {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: 'Info',
        hasBackButton: false,
      ),
      context: context,
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppTheme.cardPaddingBigger * 5,
          left: AppTheme.cardPaddingBig,
          right: AppTheme.cardPaddingBig
        ),
        child: Text(
          'When the lightning invoice wont get trough the payment will be canceled and the user will receive the funds back',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 5,
          style: Theme.of(context).textTheme.titleMedium!,
        ),
      ),
    );
  }
}