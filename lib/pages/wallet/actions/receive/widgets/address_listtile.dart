import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class AddressListTile extends StatefulWidget {
  const AddressListTile({Key? key}) : super(key: key);

  @override
  State<AddressListTile> createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {
  final controller = Get.find<ReceiveController>();
  final overlayController = Get.find<OverlayController>();
  final logger = Get.find<LoggerService>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final receiveType = controller.receiveType.value;

      logger.i("Change detected in address_listtile.dart: receiveType: $receiveType");
      return BitNetListTile(
        onTap: () async {
          final logger = Get.find<LoggerService>();

          if (receiveType == ReceiveType.Lightning_b11) {
            // Logic for Lightning
            final qrCodeData = controller.qrCodeDataStringLightning.value;
            logger.i('Lightning QR Data: $qrCodeData');
            await Clipboard.setData(ClipboardData(text: qrCodeData));
          } else if (receiveType == ReceiveType.OnChain_taproot ||
              receiveType == ReceiveType.OnChain_segwit) {
            // Logic for Onchain
            logger.i('BTC Amount: ${controller.btcControllerOnChain.text}');
            double? btcAmount =
            double.tryParse(controller.btcControllerOnChain.text);
            logger.i('Parsed BTC Amount: $btcAmount');

            final addressData = btcAmount != null && btcAmount > 0
                ? 'bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${btcAmount}'
                : controller.qrCodeDataStringOnchain.value;

            await Clipboard.setData(ClipboardData(text: addressData));
          } else if (receiveType == ReceiveType.Combined_b11_taproot) {
            // Logic for Combined
            final lightningInvoice = controller.qrCodeDataStringLightning.value;
            final onChainAddress = controller.qrCodeDataStringOnchain.value;
            final bip21Data =
                "bitcoin:$onChainAddress?lightning=$lightningInvoice";
            logger.i('Combined QR Data: $bip21Data');
            await Clipboard.setData(ClipboardData(text: bip21Data));
          }

          // Display a snackbar to indicate the wallet address has been copied
          overlayController
              .showOverlay(L10n.of(context)!.walletAddressCopied);
        },
        text: receiveType == ReceiveType.Lightning_b11
            ? L10n.of(context)!.invoice
            : receiveType == ReceiveType.Combined_b11_taproot
            ? L10n.of(context)!.address
            : L10n.of(context)!.address ,
        trailing: Obx(() {
          final qrCodeData = receiveType == ReceiveType.Lightning_b11
              ? controller.qrCodeDataStringLightning.value
              : receiveType == ReceiveType.Combined_b11_taproot
              ? "bitcoin:${controller.qrCodeDataStringOnchain.value}?lightning=${controller.qrCodeDataStringLightning.value}"
              : controller.qrCodeDataStringOnchain.value;

          if (qrCodeData.isEmpty || qrCodeData == '' || qrCodeData == 'null') {
            return Text('${L10n.of(context)!.loading}...');
          } else {
            final start = qrCodeData.length >= 8
                ? qrCodeData.substring(0, 8)
                : qrCodeData;
            final end = qrCodeData.length > 8
                ? qrCodeData.substring(qrCodeData.length - 5)
                : '';
            return Row(
              children: [
                Icon(
                  Icons.copy_rounded,
                  color: Theme.of(context).colorScheme.brightness == Brightness.dark
                      ? AppTheme.white60
                      : AppTheme.black80,
                ),
                const SizedBox(width: AppTheme.elementSpacing / 2),
                Text(start),
                if (qrCodeData.length > 8) const Text('....'),
                Text(end),
              ],
            );
          }
        }),
      );
    });
  }
}