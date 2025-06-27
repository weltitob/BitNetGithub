import 'dart:typed_data';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
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
import 'package:bitnet/intl/generated/l10n.dart';
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
    final logger = Get.find<LoggerService>();

    return Obx(() {
      print(
          "ReceiveType detected in receive_qr.dart: ${controller.receiveType.value}");

      switch (controller.receiveType.value) {
        case ReceiveType.Lightning_b11:
          return _buildLightningQr(context, controller, overlayController);

        case ReceiveType.OnChain_taproot:
          return _buildTaprootQr(context, controller, overlayController);

        case ReceiveType.Combined_b11_taproot:
          return _buildCombinedQr(context, controller, overlayController);

        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildLightningQr(
    BuildContext context,
    ReceiveController controller,
    OverlayController overlayController,
  ) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(
          ClipboardData(text: controller.qrCodeDataStringLightning.value),
        );
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: SizedBox(
        child: Center(
          child: RepaintBoundary(
            key: controller.globalKeyQR,
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
                      padding: EdgeInsets.all(AppTheme.cardPadding / 1.25),
                      child: Obx(
                        () => PrettyQrView.data(
                          data:
                              "lightning:${controller.qrCodeDataStringLightning}",
                          decoration: PrettyQrDecoration(
                            shape: const PrettyQrSmoothSymbol(roundFactor: 1),
                            image: PrettyQrDecorationImage(
                              image: isImageLoaded
                                  ? MemoryImage(avatarImage) as ImageProvider
                                  : const AssetImage(
                                          'assets/images/lightning.png')
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

  Widget _buildLNURLQr(
    BuildContext context,
    ReceiveController controller,
    OverlayController overlayController,
  ) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(
          ClipboardData(text: "LNURL"),
        );
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: SizedBox(
        child: Center(
          child: RepaintBoundary(
            key: controller.globalKeyQR,
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
                      padding: EdgeInsets.all(AppTheme.cardPadding / 1.25),
                      child: Obx(
                        () => PrettyQrView.data(
                          data: "lightning:${"LNURL"}",
                          decoration: PrettyQrDecoration(
                            shape: const PrettyQrSmoothSymbol(roundFactor: 1),
                            image: PrettyQrDecorationImage(
                              image: isImageLoaded
                                  ? MemoryImage(avatarImage) as ImageProvider
                                  : const AssetImage(
                                          'assets/images/lightning.png')
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
                      '',
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

  Widget _buildTaprootQr(
    BuildContext context,
    ReceiveController controller,
    OverlayController overlayController,
  ) {
    final globalKeyQR = GlobalKey();

    return Obx(
      () {
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
            overlayController
                .showOverlay(L10n.of(context)!.walletAddressCopied);
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
                                                  .btcControllerOnChain.text) !=
                                              null &&
                                          double.tryParse(controller
                                                  .btcControllerOnChain.text)! >
                                              0)
                                      ? '?amount=${double.parse(controller.btcControllerOnChain.text)}'
                                      : ''),
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(roundFactor: 1),
                                image: PrettyQrDecorationImage(
                                  image:
                                      AssetImage('assets/images/bitcoin.png'),
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
                          double? invoiceAmount = double.tryParse(
                              controller.btcControllerOnChain.text);
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

  Widget _buildCombinedQr(
    BuildContext context,
    ReceiveController controller,
    OverlayController overlayController,
  ) {
    final globalKeyQR = GlobalKey();

    final onChainAddress = controller.qrCodeDataStringOnchain.value;
    final lightningInvoice = controller.qrCodeDataStringLightningCombined.value;

    String combinedBip21Uri =
        "bitcoin:$onChainAddress?lightning=$lightningInvoice";
    double? btcAmount = double.tryParse(controller.btcControllerCombined.text);
    if (btcAmount != null && btcAmount > 0) {
      combinedBip21Uri =
          "bitcoin:$onChainAddress?amount=$btcAmount&lightning=$lightningInvoice";
    }
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: combinedBip21Uri));
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: SizedBox(
        child: Center(
          child: RepaintBoundary(
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
                      padding:
                          const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                      child: PrettyQrView.data(
                        data: combinedBip21Uri,
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(roundFactor: 1),
                          image: PrettyQrDecorationImage(
                            image: AssetImage('assets/images/bip21.png'),
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
                    double? btcAmount =
                        double.tryParse(controller.btcControllerCombined.text);
                    String combinedQr =
                        "bitcoin:$onChainAddress?lightning=$lightningInvoice";
                    if (btcAmount != null && btcAmount > 0) {
                      combinedQr =
                          "bitcoin:$onChainAddress?amount=$btcAmount&lightning=$lightningInvoice";
                    }
                    Share.share(
                      'https://${AppTheme.currentWebDomain}/#/wallet/send/$combinedQr',
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
}
