import 'dart:typed_data';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


class ReceiveQRCode extends StatefulWidget {
  const ReceiveQRCode({super.key});

  @override
  State<ReceiveQRCode> createState() => _ReceiveQRCodeState();
}

class _ReceiveQRCodeState extends State<ReceiveQRCode> {
  final ScreenshotController screenshotController = ScreenshotController();
  late Uint8List avatarImage;
  bool isImageLoaded = false;

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    captureAvatar();
  }

  Future<void> captureAvatar() async {
    // Wrap your avatar widget in a Material so that it can be screenshot properly
    final Widget avatarWidget = Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Avatar(
          size: 50,
          mxContent: Uri.parse(
            profileController.userData.value.profileImageUrl,
          ),
          type: profilePictureType.lightning,
          isNft: profileController.userData.value.nft_profile_id.isNotEmpty,
        ),
      ),
    );

    final avatarBytes = await screenshotController.captureFromWidget(
      avatarWidget,
      delay: const Duration(milliseconds: 100),
      pixelRatio: 3.0,
    );

    setState(() {
      avatarImage = avatarBytes;
      isImageLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final overlayController = Get.find<OverlayController>();
    final controller = Get.find<ReceiveController>();

    return Obx(() {
      switch (controller.receiveType.value) {
        case ReceiveType.Lightning_b11:
          return _buildLightningQr(context, controller, overlayController);

        case ReceiveType.OnChain_taproot:
          return _buildTaprootQr(context, controller, overlayController);

        default:
        // Fallback UI if needed
          return const SizedBox();
      }
    });
  }

  /// Existing Lightning QR snippet
  Widget _buildLightningQr(
      BuildContext context,
      ReceiveController controller,
      OverlayController overlayController,
      ) {
    return GestureDetector(
      onTap: () async {
        // Copy LN invoice data
        await Clipboard.setData(
          ClipboardData(text: controller.qrCodeDataStringLightning.value),
        );
        // Show a small overlay notification
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: SizedBox(
        child: Center(
          child: RepaintBoundary(
            key: controller.globalKeyQR,
            child: Column(
              children: [
                CustomPaint(
                  foregroundPainter: Theme.of(context).brightness == Brightness.light
                      ? BorderPainterBlack()
                      : BorderPainter(),
                  child: Container(
                    margin: const EdgeInsets.all(AppTheme.cardPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusBigger,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.cardPadding / 1.25),
                      child: Obx(
                            () => PrettyQrView.data(
                          data: "lightning:${controller.qrCodeDataStringLightning}",
                          decoration: PrettyQrDecoration(
                            shape: const PrettyQrSmoothSymbol(roundFactor: 1),
                            image: PrettyQrDecorationImage(
                              image: isImageLoaded
                                  ? MemoryImage(avatarImage) as ImageProvider
                                  : const AssetImage('assets/images/lightning.png')
                              as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                LongButtonWidget(
                  customHeight: AppTheme.cardPadding * 2,
                  customWidth: AppTheme.cardPadding * 5,
                  title: L10n.of(context)!.share,
                  leadingIcon: const Icon(Icons.share_rounded),
                  onTap: () {
                    Share.share(
                      'https://${AppTheme.currentWebDomain}/#/wallet/send/${controller.qrCodeDataStringLightning}',
                    );
                  },
                  buttonType: ButtonType.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBip21Qr(
      BuildContext context,
      ReceiveController controller,
      OverlayController overlayController,
      ) {
    // Suppose you store the final BIP21 with lightning param in these variables:
    // e.g. "bc1q0lkecru62vc4v7uwrz5n46twx4rdt6q3nleccj"
    final onChainAddress = controller.qrCodeDataStringOnchain.value;
    // e.g. "LNBC1PNEFJ5GDQQN..."
    final lightningInvoice = controller.qrCodeDataStringLightning.value;

    // Build the BIP21 string.
    // Minimal example: bitcoin:<address>?lightning=<invoice>
    final bip21String = "bitcoin:$onChainAddress?lightning=$lightningInvoice";

    // If you want to include an amount param, do something like:
    // final amount = double.tryParse(controller.btcControllerOnChain.text);
    // final bip21String = (amount != null && amount > 0)
    //   ? "bitcoin:$onChainAddress?amount=$amount&lightning=$lightningInvoice"
    //   : "bitcoin:$onChainAddress?lightning=$lightningInvoice";

    return GestureDetector(
      onTap: () async {
        // Copy the BIP21 URI to the clipboard
        await Clipboard.setData(ClipboardData(text: bip21String));
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: SizedBox(
        child: Center(
          child: RepaintBoundary(
            // You can capture or share this QR if needed by hooking up to a GlobalKey
            // key: someGlobalKey,
            child: Column(
              children: [
                CustomPaint(
                  foregroundPainter: Theme.of(context).brightness == Brightness.light
                      ? BorderPainterBlack()
                      : BorderPainter(),
                  child: Container(
                    margin: const EdgeInsets.all(AppTheme.cardPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusBigger,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                      // Use `PrettyQrView.data` just like in your other sections
                      child: Container(
                        child: PrettyQrView.data(
                          data: bip21String,
                          decoration: const PrettyQrDecoration(
                            shape: PrettyQrSmoothSymbol(roundFactor: 1),
                            image: PrettyQrDecorationImage(
                              image: AssetImage('assets/images/bip21.png'),
                            ),
                          ),
                          errorCorrectLevel: QrErrorCorrectLevel.H,
                      )),
                    ),
                  ),
                ),
                // Optional: share button
                LongButtonWidget(
                  customHeight: AppTheme.cardPadding * 2,
                  customWidth: AppTheme.cardPadding * 5,
                  title: L10n.of(context)!.share,
                  leadingIcon: const Icon(Icons.share_rounded),
                  onTap: () {
                    // You can share this as well
                    Share.share(
                      'https://${AppTheme.currentWebDomain}/#/wallet/send/$bip21String',
                    );
                  },
                  buttonType: ButtonType.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Your new Taproot (On-Chain) QR snippet
  Widget _buildTaprootQr(
      BuildContext context,
      ReceiveController controller,
      OverlayController overlayController,
      ) {
    // If you also want to use a RepaintBoundary or a GlobalKey, define them as you do for lightning.
    // You can also re-use the same key if you prefer. Adjust to your needs.
    final globalKeyQR = GlobalKey();

    return Obx(
          () {
        // Just reading controller.qrCodeDataStringOnchain.value here
        // triggers reactivity, but it's good practice to store it to a local
        // variable if you’re using it multiple times.
        final onChainAddress = controller.qrCodeDataStringOnchain.value;

        return GestureDetector(
          onTap: () async {
            double? btcAmount =
            double.tryParse(controller.btcControllerOnChain.text);
            if (btcAmount != null && btcAmount > 0) {
              await Clipboard.setData(
                ClipboardData(
                  text: 'bitcoin:$onChainAddress?amount=$btcAmount',
                ),
              );
            } else {
              await Clipboard.setData(
                ClipboardData(text: onChainAddress),
              );
            }
            overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
          },
          child: SizedBox(
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: controller.btcControllerNotifier,
                builder: (ctx, notifier, _) => RepaintBoundary(
                  key: globalKeyQR,
                  child: Column(
                    children: [
                      CustomPaint(
                        foregroundPainter:
                        Theme.of(context).brightness == Brightness.light
                            ? BorderPainterBlack()
                            : BorderPainter(),
                        child: Container(
                          margin: const EdgeInsets.all(AppTheme.cardPadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppTheme.cardRadiusBigger,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              AppTheme.cardPadding / 1.25,
                            ),
                            child: PrettyQrView.data(
                              data: "bitcoin:$onChainAddress" +
                                  ((double.tryParse(controller
                                      .btcControllerOnChain
                                      .text) !=
                                      null &&
                                      double.tryParse(controller
                                          .btcControllerOnChain
                                          .text)! >
                                          0)
                                      ? '?amount=${double.parse(controller.btcControllerOnChain.text)}'
                                      : ''),
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(roundFactor: 1),
                                image: PrettyQrDecorationImage(
                                  image: AssetImage('assets/images/bitcoin.png'),
                                ),
                              ),
                              errorCorrectLevel: QrErrorCorrectLevel.H,
                            ),
                          ),
                        ),
                      ),
                      LongButtonWidget(
                        customHeight: AppTheme.cardPadding * 2,
                        customWidth: AppTheme.cardPadding * 5,
                        title: L10n.of(context)!.share,
                        leadingIcon: const Icon(Icons.share_rounded),
                        onTap: () {
                          double? invoiceAmount =
                          double.tryParse(controller.btcControllerOnChain.text);
                          if (invoiceAmount != null && invoiceAmount > 0) {
                            Share.share(
                                'https://${AppTheme.currentWebDomain}/#/wallet/send/bitcoin:$onChainAddress?amount=$invoiceAmount');
                          } else {
                            Share.share(
                                'https://${AppTheme.currentWebDomain}/#/wallet/send/$onChainAddress');
                          }
                        },
                        buttonType: ButtonType.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
