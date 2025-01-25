import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class AddressListTile extends StatefulWidget {
  const AddressListTile({super.key});

  @override
  State<AddressListTile> createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {

  final controller = Get.find<ReceiveController>();
  final overlayController = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {

    return BitNetListTile(
      onTap: () async {
        await Clipboard.setData(ClipboardData(
            text: controller.qrCodeDataStringLightning.value));
        // Display a snackbar to indicate that the wallet address has been copied
        overlayController.showOverlay("L10n.of(context)!.walletAddressCopied");
      },
      text: "L10n.of(context)!.invoice",
      trailing: Obx(() {
        final qrCodeData =
            controller.qrCodeDataStringLightning.value;
        if (qrCodeData.isEmpty ||
            qrCodeData == '' ||
            qrCodeData == 'null') {
          return Text('${"L10n.of(context)!.loading"}...');
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
                color: Theme.of(context).colorScheme.brightness ==
                    Brightness.dark
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
  }
}
