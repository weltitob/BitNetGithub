import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LightningTransactionDetails extends GetWidget<WalletsController> {
  final TransactionItemData data;
  final TextEditingController inputCtrl = TextEditingController();
  final TextEditingController outputCtrl = TextEditingController();

  LightningTransactionDetails({required this.data, super.key});

  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    final String formattedDate = displayTimeAgoFromInt(data.timestamp);
    final String time = convertIntoDateFormat(data.timestamp);

    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    print('cooin ${coin.coin}');
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? (double.parse(data.amount) / 100000000 * bitcoinPrice)
        .toStringAsFixed(2)
        : "0.00";
    final currencyEquivalentFee = bitcoinPrice != null
        ? (data.fee.toDouble() / 100000000 * bitcoinPrice).toStringAsFixed(2)
        : "0.00";
    return bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          text: 'Lightning Transaction',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Obx(() {
          Get.find<WalletsController>().chartLines.value;
          return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppTheme.cardPadding * 3,
                    ),
                    GlassContainer(
                      borderRadius: AppTheme.borderRadiusBig,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.elementSpacing,
                          horizontal: AppTheme.elementSpacing,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: AppTheme.cardPadding * 0.75,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Avatar(
                                              size: AppTheme.cardPadding * 4,
                                              isNft: false,
                                              onTap: () {}),
                                          const SizedBox(
                                            height: AppTheme.elementSpacing * 0.5,
                                          ),
                                          const Text("You"),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: AppTheme.cardPadding * 0.75,
                                      ),
                                      Icon(
                                        Icons.double_arrow_rounded,
                                        size: AppTheme.cardPadding * 2.5,
                                        color: Theme.of(context).brightness ==
                                            Brightness.dark
                                            ? AppTheme.white80
                                            : AppTheme.black60,
                                      ),
                                      const SizedBox(
                                        width: AppTheme.cardPadding * 0.75,
                                      ),
                                      Column(
                                        children: [
                                          Avatar(
                                              size: AppTheme.cardPadding * 4,
                                              isNft: false,
                                              onTap: () {}),
                                          const SizedBox(
                                            height: AppTheme.elementSpacing * 0.5,
                                          ),
                                          const Text("Receiver"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppTheme.cardPadding * 0.75),
                                  controller.hideBalance.value
                                      ? Text(
                                    '*****',
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  )
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          coin.setCurrencyType(coin.coin != null
                                              ? !coin.coin!
                                              : false);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              coin.coin ?? true
                                                  ? double.parse(data.amount) > 0
                                                  ? '${data.amount}'
                                                  : data.amount
                                                  : double.parse(data.amount) > 0
                                                  ? "+${currencyEquivalent}"
                                                  : "$currencyEquivalent",
                                              overflow: TextOverflow.ellipsis,
                                              // Removed color styling based on transaction direction
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            ),
                                            if (!(coin.coin ?? true)) ...[
                                              Text(
                                                ' ${getCurrency(currency!)}',
                                                // Removed color styling based on transaction direction
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              )
                                            ]
                                          ],
                                        ),
                                      ),
                                      coin.coin ?? true
                                          ? Icon(
                                        AppTheme.satoshiIcon,
                                        // Using neutral color instead of conditional color
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? AppTheme.white80
                                            : AppTheme.black80,
                                        size: AppTheme.cardPadding * 2,
                                      )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 0.5, vertical: AppTheme.elementSpacing),
                              child: GlassContainer(
                                opacity: 0.05,
                                borderRadius: AppTheme.borderRadiusSmall,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppTheme.elementSpacing,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BitNetListTile(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: AppTheme.elementSpacing * 0.75,
                                          vertical: AppTheme.elementSpacing * 0.25,
                                        ),
                                        text: 'Status',
                                        trailing: Row(
                                          children: [
                                            data.status == TransactionStatus.pending
                                                ? Positioned(
                                              top: 0,
                                              right: 10,
                                              child: Transform.scale(
                                                scale: 1.1,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.showInfo.value =
                                                    !controller.showInfo.value;
                                                    BitNetBottomSheet(
                                                      context: context,
                                                      child: bitnetScaffold(
                                                        extendBodyBehindAppBar: true,
                                                        appBar: bitnetAppBar(
                                                          context: context,
                                                          text: 'Info',
                                                          hasBackButton: false,
                                                        ),
                                                        context: context,
                                                        body: Padding(
                                                          padding: const EdgeInsets.only(
                                                              top: AppTheme.cardPaddingBigger *
                                                                  5,
                                                              left: AppTheme.cardPaddingBig,
                                                              right: AppTheme.cardPaddingBig),
                                                          child: Text(
                                                            'When the lightning invoice wont get trough the payment will be canceled and the user will receive the funds back',
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.center,
                                                            maxLines: 5,
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .titleMedium!,
                                                          ),
                                                        ),
                                                      ),
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
                                                ),
                                              ),
                                            )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            // Blinking dot animation
                                            BlinkingDot(
                                              color: data.status == TransactionStatus.confirmed
                                                  ? AppTheme.successColor
                                                  : data.status == TransactionStatus.pending
                                                  ? AppTheme.colorBitcoin
                                                  : AppTheme.errorColor,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              data.status == TransactionStatus.confirmed
                                                  ? 'Received'
                                                  : data.status == TransactionStatus.pending
                                                  ? 'Pending'
                                                  : 'Error',
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                color: data.status == TransactionStatus.confirmed
                                                    ? AppTheme.successColor
                                                    : data.status == TransactionStatus.pending
                                                    ? AppTheme.colorBitcoin
                                                    : AppTheme.errorColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      BitNetListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: AppTheme.elementSpacing * 0.75,
                                            vertical: AppTheme.elementSpacing * 0.5,
                                          ),
                                          text: 'TransactionID',
                                          trailing: GestureDetector(
                                            onTap: () async {
                                              await Clipboard.setData(ClipboardData(
                                                text: data.txHash,
                                              ));
                                              overlayController.showOverlay(
                                                  L10n.of(context)!.copiedToClipboard);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.copy,
                                                  color: AppTheme.white60,
                                                  size: AppTheme.cardPadding * 0.75,
                                                ),
                                                const SizedBox(
                                                  width: AppTheme.elementSpacing / 2,
                                                ),
                                                Container(
                                                  width: AppTheme.cardPadding * 5.w,
                                                  child: Text(
                                                    data.txHash,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),


                                      BitNetListTile(
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: AppTheme.elementSpacing * 0.75,
                                          vertical: AppTheme.elementSpacing * 0.5,
                                        ),
                                        text: "Payment Network",
                                        trailing: Row(
                                          children: [
                                            Image.asset("assets/images/lightning.png",
                                                width: AppTheme.cardPadding * 1,
                                                height: AppTheme.cardPadding * 1),
                                            const SizedBox(
                                              width: AppTheme.elementSpacing / 2,
                                            ),
                                            Text(
                                              'Lightning',
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      BitNetListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: AppTheme.elementSpacing * 0.75,
                                            vertical: AppTheme.elementSpacing * 0.5,
                                          ),
                                          text: 'Time',
                                          leading: Icon(
                                            Icons.access_time,
                                            size: AppTheme.cardPadding * 0.75,
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? AppTheme.white60
                                                : AppTheme.black60,
                                          ),
                                          trailing: Container(
                                            width: AppTheme.cardPadding * 7.w,
                                            child: Text(
                                              "${time} "
                                                  '(${formattedDate})',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          )),
                                      BitNetListTile(
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: AppTheme.elementSpacing * 0.75,
                                            vertical: AppTheme.elementSpacing * 0.5,
                                          ),
                                          text: 'Fee',
                                          trailing: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  coin.setCurrencyType(
                                                      coin.coin != null ? !coin.coin! : false);
                                                },
                                                child: Text(
                                                  coin.coin ?? true
                                                      ? '${data.fee}'
                                                      : "$currencyEquivalentFee ${getCurrency(currency!)}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                              ),
                                              coin.coin ?? true
                                                  ? Icon(AppTheme.satoshiIcon)
                                                  : const SizedBox.shrink(),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }));
  }
}

// Blinking dot animation widget
class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;

  const BlinkingDot({
    Key? key,
    required this.color,
    this.size = 10.0,
  }) : super(key: key);

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}