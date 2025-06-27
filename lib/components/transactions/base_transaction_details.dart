import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

abstract class BaseTransactionDetails extends StatefulWidget {
  final TransactionItemData data;

  const BaseTransactionDetails({required this.data, Key? key})
      : super(key: key);

  @override
  BaseTransactionDetailsState createState();
}

abstract class BaseTransactionDetailsState<T extends BaseTransactionDetails>
    extends State<T> {
  // Common properties
  late String formattedDate;
  late String time;
  late String currencyEquivalent;
  late String currencyEquivalentFee;
  final overlayController = Get.find<OverlayController>();

  // Methods to be implemented by subclasses
  Widget buildNetworkSpecificDetails();
  String getHeaderTitle();

  @override
  void initState() {
    super.initState();
    updateFormattedValues();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: getHeaderTitle(),
        onTap: () => Navigator.pop(context),
      ),
      body: buildTransactionDetailsBody(),
    );
  }

  Widget buildTransactionDetailsBody() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: Column(
        children: [
          const SizedBox(height: AppTheme.cardPadding * 3),
          buildMainContainer(),
        ],
      ),
    ));
  }

  Widget buildMainContainer();

  // Helper methods
  void updateFormattedValues() {
    formattedDate = displayTimeAgoFromInt(widget.data.timestamp);
    time = convertIntoDateFormat(widget.data.timestamp);

    final controller = Get.find<WalletsController>();
    final chartLine = controller.chartLines.value;
    final bitcoinPrice = chartLine?.price;

    currencyEquivalent = bitcoinPrice != null
        ? (double.parse(widget.data.amount) / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";

    currencyEquivalentFee = bitcoinPrice != null
        ? (widget.data.fee.toDouble() / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
  }

  Widget buildCopyableText(String text) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: text));
        overlayController.showOverlay(L10n.of(context)!.copiedToClipboard);
      },
      child: Row(
        children: [
          Icon(
            Icons.copy,
            color: AppTheme.white60,
            size: AppTheme.cardPadding * 0.75,
          ),
          const SizedBox(width: AppTheme.elementSpacing / 2),
          SizedBox(
            width: AppTheme.cardPadding * 5.w,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
