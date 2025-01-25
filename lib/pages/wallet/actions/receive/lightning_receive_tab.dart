import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

class LightningReceiveTab extends StatefulWidget {
  const LightningReceiveTab({
    super.key,
  });

  @override
  State<LightningReceiveTab> createState() => _LightningReceiveTabState();
}

class _LightningReceiveTabState extends State<LightningReceiveTab>
    with AutomaticKeepAliveClientMixin {
  final ScreenshotController screenshotController = ScreenshotController();
  late Uint8List avatarImage;
  bool isImageLoaded = false;

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    captureAvatar();
  }

  Future<void> captureAvatar() async {
    // Wrap your widget in a Material widget
    final Widget avatarWidget = Material(
      type: MaterialType.transparency, // or MaterialType.canvas if you like
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

    // Capture the widget
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
    super.build(context);
    final controller = Get.find<ReceiveController>();
    final overlayController = Get.find<OverlayController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SingleChildScrollView(
        child: controller.isUnlocked.value
            ? Column(
                mainAxisSize: MainAxisSize.min,
                //mainAxisSize: MainAxisSize.min,
                // The contents of the screen are centered vertically
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                          text: controller.qrCodeDataStringLightning.value));
                      // Display a snackbar to indicate that the wallet address has been copied
                      overlayController
                          .showOverlay(L10n.of(context)!.walletAddressCopied);
                    },
                    child: SizedBox(
                      child: Center(
                        child: RepaintBoundary(
                          // The Qr code is generated from this widget's global key
                          key: controller.globalKeyQR,
                          child: Column(
                            children: [
                              // Custom border painted around the Qr code
                              CustomPaint(
                                foregroundPainter:
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? BorderPainterBlack()
                                        : BorderPainter(),
                                child: Container(
                                  margin: const EdgeInsets.all(
                                      AppTheme.cardPadding),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: AppTheme.cardRadiusBigger),
                                  child: Padding(
                                      padding: EdgeInsets.all(
                                          AppTheme.cardPadding / 1.25),
                                      child: Obx(() => PrettyQrView.data(
                                            data:
                                                "lightning: ${controller.qrCodeDataStringLightning}",
                                            decoration: PrettyQrDecoration(
                                              shape: const PrettyQrSmoothSymbol(
                                                roundFactor: 1,
                                              ),
                                              image: PrettyQrDecorationImage(
                                                image: isImageLoaded
                                                    ? MemoryImage(avatarImage)
                                                        as ImageProvider
                                                    : const AssetImage(
                                                            'assets/images/lightning.png')
                                                        as ImageProvider,
                                              ),
                                            ),

                                            // image: PrettyQrDecorationImage(
                                            //   image: AssetImage('assets/images/lightning.png'),
                                            // ),
                                          ))),
                                ),
                              ),
                              LongButtonWidget(
                                customHeight: AppTheme.cardPadding * 2,
                                customWidth: AppTheme.cardPadding * 5,
                                title: L10n.of(context)!.share,
                                leadingIcon: const Icon(Icons.share_rounded),
                                onTap: () {
                                  Share.share(
                                      'https://${AppTheme.currentWebDomain}/#/wallet/send/${controller.qrCodeDataStringLightning}');
                                },
                                buttonType: ButtonType.transparent,
                              ),
                              // SizedBox to add some spacing
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  BitNetListTile(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                          text: controller.qrCodeDataStringLightning.value));
                      // Display a snackbar to indicate that the wallet address has been copied
                      overlayController
                          .showOverlay(L10n.of(context)!.walletAddressCopied);
                    },
                    text: L10n.of(context)!.invoice,
                    trailing: Obx(() {
                      final qrCodeData =
                          controller.qrCodeDataStringLightning.value;
                      if (qrCodeData.isEmpty ||
                          qrCodeData == '' ||
                          qrCodeData == 'null') {
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
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return BitNetListTile(
                      onTap: () async {
                        await BitNetBottomSheet(
                          context: context,
                          //also add a help button as an action at the right once bitnetbottomsheet is fixed
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: bitnetScaffold(
                            extendBodyBehindAppBar: true,
                            appBar: bitnetAppBar(
                              hasBackButton: false,
                              buttonType: ButtonType.transparent,
                              text: "${L10n.of(context)!.changeAmount}",
                              context: context,
                            ),
                            body: SingleChildScrollView(child: CreateInvoice()),
                            context: context,
                          ),
                        );

                        setState(() {});
                      },
                      text: L10n.of(context)!.amount,
                      trailing: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.brightness ==
                                    Brightness.dark
                                ? AppTheme.white60
                                : AppTheme.black80,
                          ),
                          const SizedBox(width: AppTheme.elementSpacing / 2),
                          Text(
                            controller.satController.text == "0" ||
                                    controller.satController.text.isEmpty
                                ? L10n.of(context)!.changeAmount
                                : controller.satController.text,
                          ),
                          controller.satController.text == "0" ||
                                  controller.satController.text.isEmpty
                              ? const SizedBox()
                              : Icon(
                                  getCurrencyIcon(
                                    BitcoinUnits.SAT.name,
                                  ),
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.black70
                                      : AppTheme.white90,
                                )
                        ],
                      ),
                    );
                  }),
                  StatefulBuilder(builder: (context, setState) {
                    return BitNetListTile(
                      onTap: () async {
                        await BitNetBottomSheet(
                          context: context,
                          //also add a help button as an action at the right once bitnetbottomsheet is fixed
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: bitnetScaffold(
                            extendBodyBehindAppBar: true,
                            appBar: bitnetAppBar(
                              hasBackButton: false,
                              buttonType: ButtonType.transparent,
                              text: "Data",
                              context: context,
                            ),
                            body: SingleChildScrollView(child: CreateInvoice()),
                            context: context,
                          ),
                        );

                        setState(() {});
                      },
                      text: L10n.of(context)!.amount,
                      trailing: LongButtonWidget(
                        buttonType: ButtonType.transparent,
                        title: 'Lightning B11',
                        leadingIcon: const Icon(
                          FontAwesomeIcons.bolt,
                          size: AppTheme.cardPadding * 0.75,
                        ),
                        onTap: () {
                          BitNetBottomSheet(
                              context: context,
                              child: bitnetScaffold(
                                  body: Container(
                                    child: Column(

                                    ),
                                  ), context: context));
                        },
                        customWidth: AppTheme.cardPadding * 6.5,
                        customHeight: AppTheme.cardPadding * 1.5,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 2),
                  CustomPaint(
                    foregroundPainter:
                        Theme.of(context).brightness == Brightness.light
                            ? BorderPainterBlack()
                            : BorderPainter(),
                    child: Container(
                      margin: const EdgeInsets.all(AppTheme.cardPadding),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppTheme.cardRadiusBigger),
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.cardPadding / 1.25),
                        child: PrettyQrView.data(
                            data: "ERROR",
                            decoration: const PrettyQrDecoration(
                              shape: PrettyQrSmoothSymbol(
                                roundFactor: 1,
                              ),
                              image: PrettyQrDecorationImage(
                                image: AssetImage('assets/images/key.png'),
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.cardPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.black60
                          : AppTheme.black60,
                      borderRadius: AppTheme.cardRadiusBig,
                    ),
                    width: double.infinity,
                    child: Text(
                      "You need to unlock your lightning card before you can receive funds here...",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black80
                                    : AppTheme.white90,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
//
// import 'package:bitnet/backbone/auth/auth.dart';
// import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
// import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
// import 'package:bitnet/components/appstandards/BitNetListTile.dart';
// import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
// import 'package:bitnet/components/buttons/longbutton.dart';
// import 'package:bitnet/components/camera/qrscanneroverlay.dart';
// import 'package:bitnet/components/container/avatar.dart';
// import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
// import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
// import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
// import 'package:bitnet/pages/profile/profile_controller.dart';
// import 'package:bitnet/pages/qrscanner/qrscanner.dart';
// import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
// import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gen/gen_l10n/l10n.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:screenshot/screenshot.dart';
//
// class LightningReceiveTab extends StatefulWidget {
//   const LightningReceiveTab({
//     super.key,
//   });
//
//   @override
//   State<LightningReceiveTab> createState() => _LightningReceiveTabState();
// }
//
// class _LightningReceiveTabState extends State<LightningReceiveTab>
//     with AutomaticKeepAliveClientMixin {
//   final ScreenshotController screenshotController = ScreenshotController();
//   late Uint8List avatarImage;
//   bool isImageLoaded = false;
//   ReceiveType receiveType = ReceiveType.Lightning;
//
//   final GlobalKey globalKeyQR = GlobalKey();
//   ValueNotifier<String> btcControllerNotifier = ValueNotifier('');
//   final controller = Get.find<ReceiveController>();
//
//   ProfileController profileController = Get.find<ProfileController>();
//
//   @override
//   void initState() {
//     btcControllerNotifier = ValueNotifier(controller.btcControllerOnChain.text);
//     super.initState();
//     captureAvatar();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     btcControllerNotifier = ValueNotifier(controller.btcControllerOnChain.text);
//   }
//
//   @override
//   void dispose() {
//     btcControllerNotifier.dispose();
//     super.dispose();
//   }
//
//   Future<void> captureAvatar() async {
//     // Wrap your widget in a Material widget
//     final Widget avatarWidget = Material(
//       type: MaterialType.transparency, // or MaterialType.canvas if you like
//       child: SizedBox(
//         width: 50,
//         height: 50,
//         child: Avatar(
//           size: 50,
//           mxContent: Uri.parse(
//             profileController.userData.value.profileImageUrl,
//           ),
//           type: profilePictureType.lightning,
//           isNft: profileController.userData.value.nft_profile_id.isNotEmpty,
//         ),
//       ),
//     );
//
//     // Capture the widget
//     final avatarBytes = await screenshotController.captureFromWidget(
//       avatarWidget,
//       delay: const Duration(milliseconds: 100),
//       pixelRatio: 3.0,
//     );
//
//     setState(() {
//       avatarImage = avatarBytes;
//       isImageLoaded = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final controller = Get.find<ReceiveController>();
//     final overlayController = Get.find<OverlayController>();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
//       child: SingleChildScrollView(
//         child: controller.isUnlocked.value
//             ? controller.receiveType == ReceiveType.OnChain
//             ? Column(
//           children: [
//             Obx(() {
//               controller.qrCodeDataStringOnchain.value;
//               return GestureDetector(
//                 onTap: () async {
//                   double? btcAmount = double.tryParse(
//                       controller.btcControllerOnChain.text);
//                   if (btcAmount != null && btcAmount > 0) {
//                     await Clipboard.setData(ClipboardData(
//                         text:
//                         'bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${btcAmount}'));
//                   } else {
//                     await Clipboard.setData(ClipboardData(
//                         text: controller
//                             .qrCodeDataStringOnchain.value));
//                   }
//                   // Display a snackbar to indicate that the wallet address has been copied
//                   overlayController.showOverlay(
//                       L10n.of(context)!.walletAddressCopied);
//                 },
//                 child: SizedBox(
//                   child: Center(
//                     child: ValueListenableBuilder(
//                       valueListenable: btcControllerNotifier,
//                       builder: (ctx, notifier, _) => RepaintBoundary(
//                         // The Qr code is generated from this widget's global key
//                         key: globalKeyQR,
//                         child: Column(
//                           children: [
//                             // Custom border painted around the Qr code
//                             CustomPaint(
//                               foregroundPainter:
//                               Theme.of(context).brightness ==
//                                   Brightness.light
//                                   ? BorderPainterBlack()
//                                   : BorderPainter(),
//                               child: Container(
//                                 margin: const EdgeInsets.all(
//                                     AppTheme.cardPadding),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                     AppTheme.cardRadiusBigger),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(
//                                       AppTheme.cardPadding / 1.25),
//                                   // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
//                                   child: PrettyQrView.data(
//                                       data: "bitcoin:${controller.qrCodeDataStringOnchain}" +
//                                           ((double.tryParse(controller
//                                               .btcControllerOnChain
//                                               .text) !=
//                                               null &&
//                                               double.tryParse(
//                                                   controller
//                                                       .btcControllerOnChain
//                                                       .text) !=
//                                                   0)
//                                               ? '?amount=${double.parse(controller.btcControllerOnChain.text)}'
//                                               : ''),
//                                       decoration:
//                                       const PrettyQrDecoration(
//                                         shape: PrettyQrSmoothSymbol(
//                                           roundFactor: 1,
//                                         ),
//                                         image:
//                                         PrettyQrDecorationImage(
//                                           image: const AssetImage(
//                                               'assets/images/bitcoin.png'),
//                                         ),
//                                       ),
//                                       errorCorrectLevel:
//                                       QrErrorCorrectLevel.H),
//                                 ),
//                               ),
//                             ),
//                             LongButtonWidget(
//                               customHeight: AppTheme.cardPadding * 2,
//                               customWidth: AppTheme.cardPadding * 5,
//                               title: L10n.of(context)!.share,
//                               leadingIcon:
//                               const Icon(Icons.share_rounded),
//                               onTap: () {
//                                 // Share the wallet address
//                                 double? invoiceAmount =
//                                 double.tryParse(controller
//                                     .btcControllerOnChain.text);
//                                 if (invoiceAmount != null &&
//                                     invoiceAmount > 0) {
//                                   Share.share(
//                                       'https://${AppTheme.currentWebDomain}/#/wallet/send/bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${invoiceAmount}');
//                                 } else {
//                                   Share.share(
//                                       'https://${AppTheme.currentWebDomain}/#/wallet/send/${controller.qrCodeDataStringOnchain.value}');
//                                 }
//                               },
//                               buttonType: ButtonType.transparent,
//                             ),
//                             // SizedBox to add some spacing
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }),
//             Column(
//               children: [
//                 BitNetListTile(
//                   onTap: () async {
//                     final logger = Get.find<LoggerService>();
//                     logger.i(
//                         'BTC Amount: ${controller.btcControllerOnChain.text}');
//                     double? btcAmount = double.tryParse(
//                         controller.btcControllerOnChain.text);
//                     logger.i('BTC Amount: $btcAmount');
//                     if (btcAmount != null && btcAmount > 0) {
//                       await Clipboard.setData(ClipboardData(
//                           text:
//                           'bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${btcAmount}'));
//                     } else {
//                       await Clipboard.setData(ClipboardData(
//                           text: controller
//                               .qrCodeDataStringOnchain.value));
//                     }
//
//                     // Display a snackbar to indicate that the wallet address has been copied
//                     overlayController.showOverlay(
//                         L10n.of(context)!.walletAddressCopied);
//                   },
//                   text: L10n.of(context)!.invoice,
//                   trailing: Obx(() {
//                     final qrCodeData =
//                         controller.qrCodeDataStringOnchain.value;
//                     if (qrCodeData.isEmpty ||
//                         qrCodeData == '' ||
//                         qrCodeData == 'null') {
//                       return Text('${L10n.of(context)!.loading}...');
//                     } else {
//                       final start = qrCodeData.length >= 8
//                           ? qrCodeData.substring(0, 8)
//                           : qrCodeData;
//                       final end = qrCodeData.length > 8
//                           ? qrCodeData
//                           .substring(qrCodeData.length - 5)
//                           : '';
//                       return Row(
//                         children: [
//                           Icon(
//                             Icons.copy_rounded,
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .brightness ==
//                                 Brightness.dark
//                                 ? AppTheme.white60
//                                 : AppTheme.black80,
//                           ),
//                           const SizedBox(
//                               width: AppTheme.elementSpacing / 2),
//                           Text(start),
//                           if (qrCodeData.length > 8)
//                             const Text('....'),
//                           Text(end),
//                         ],
//                       );
//                     }
//                   }),
//                 ),
//                 StatefulBuilder(builder: (context, setState) {
//                   return BitNetListTile(
//                     onTap: () async {
//                       await BitNetBottomSheet(
//                         context: context,
//                         //also add a help button as an action at the right once bitnetbottomsheet is fixed
//                         height:
//                         MediaQuery.of(context).size.height * 0.7,
//                         child: bitnetScaffold(
//                           extendBodyBehindAppBar: true,
//                           appBar: bitnetAppBar(
//                             hasBackButton: false,
//                             buttonType: ButtonType.transparent,
//                             text: "Change Amount",
//                             context: context,
//                           ),
//                           body: SingleChildScrollView(
//                               child: CreateInvoice(
//                                 onChain: true,
//                               )),
//                           context: context,
//                         ),
//                       );
//
//                       setState(() {});
//                       btcControllerNotifier.value =
//                           controller.btcControllerOnChain.text;
//                     },
//                     text: L10n.of(context)!.amount,
//                     trailing: Row(
//                       children: [
//                         Icon(
//                           Icons.edit,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .brightness ==
//                               Brightness.dark
//                               ? AppTheme.white60
//                               : AppTheme.black80,
//                         ),
//                         const SizedBox(
//                             width: AppTheme.elementSpacing / 2),
//                         Text(
//                           controller.satControllerOnChain.text ==
//                               "0" ||
//                               controller.satControllerOnChain.text
//                                   .isEmpty
//                               ? "Change Amount"
//                               : controller.satControllerOnChain.text,
//                         ),
//                         controller.satControllerOnChain.text == "0" ||
//                             controller
//                                 .satControllerOnChain.text.isEmpty
//                             ? const SizedBox()
//                             : Icon(
//                           getCurrencyIcon(
//                             BitcoinUnits.SAT.name,
//                           ),
//                           color: Theme.of(context).brightness ==
//                               Brightness.light
//                               ? AppTheme.black70
//                               : AppTheme.white90,
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ],
//         )
//             : Column(
//           mainAxisSize: MainAxisSize.min,
//           //mainAxisSize: MainAxisSize.min,
//           // The contents of the screen are centered vertically
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: AppTheme.cardPadding * 2,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 await Clipboard.setData(ClipboardData(
//                     text:
//                     controller.qrCodeDataStringLightning.value));
//                 // Display a snackbar to indicate that the wallet address has been copied
//                 overlayController.showOverlay(
//                     L10n.of(context)!.walletAddressCopied);
//               },
//               child: SizedBox(
//                 child: Center(
//                   child: RepaintBoundary(
//                     // The Qr code is generated from this widget's global key
//                       key: controller.globalKeyQR,
//                       child: Column(
//                         children: [
//                           // Custom border painted around the Qr code
//                           CustomPaint(
//                             foregroundPainter:
//                             Theme.of(context).brightness ==
//                                 Brightness.light
//                                 ? BorderPainterBlack()
//                                 : BorderPainter(),
//                             child: Container(
//                               margin: const EdgeInsets.all(
//                                   AppTheme.cardPadding),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                   AppTheme.cardRadiusBigger),
//                               child: Padding(
//                                   padding: EdgeInsets.all(
//                                       AppTheme.cardPadding / 1.25),
//                                   child: Obx(() => PrettyQrView.data(
//                                     data:
//                                     "lightning: ${controller.qrCodeDataStringLightning}",
//                                     decoration:
//                                     PrettyQrDecoration(
//                                       shape:
//                                       const PrettyQrSmoothSymbol(
//                                         roundFactor: 1,
//                                       ),
//                                       image:
//                                       PrettyQrDecorationImage(
//                                         image: isImageLoaded
//                                             ? MemoryImage(
//                                             avatarImage)
//                                         as ImageProvider
//                                             : const AssetImage(
//                                             'assets/images/lightning.png')
//                                         as ImageProvider,
//                                       ),
//                                     ),
//
//                                     // image: PrettyQrDecorationImage(
//                                     //   image: AssetImage('assets/images/lightning.png'),
//                                     // ),
//                                   ))),
//                             ),
//                           ),
//                           LongButtonWidget(
//                             customHeight: AppTheme.cardPadding * 2,
//                             customWidth: AppTheme.cardPadding * 5,
//                             title: L10n.of(context)!.share,
//                             leadingIcon:
//                             const Icon(Icons.share_rounded),
//                             onTap: () {
//                               Share.share(
//                                   'https://${AppTheme.currentWebDomain}/#/wallet/send/${controller.qrCodeDataStringLightning}');
//                             },
//                             buttonType: ButtonType.transparent,
//                           ),
//                           // SizedBox to add some spacing
//                         ],
//                       )),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 const SizedBox(
//                   height: AppTheme.cardPadding,
//                 ),
//                 BitNetListTile(
//                   onTap: () async {
//                     await Clipboard.setData(ClipboardData(
//                         text: controller
//                             .qrCodeDataStringLightning.value));
//                     // Display a snackbar to indicate that the wallet address has been copied
//                     overlayController.showOverlay(
//                         L10n.of(context)!.walletAddressCopied);
//                   },
//                   text: L10n.of(context)!.invoice,
//                   trailing: Obx(() {
//                     final qrCodeData =
//                         controller.qrCodeDataStringLightning.value;
//                     if (qrCodeData.isEmpty ||
//                         qrCodeData == '' ||
//                         qrCodeData == 'null') {
//                       return Text('${L10n.of(context)!.loading}...');
//                     } else {
//                       final start = qrCodeData.length >= 8
//                           ? qrCodeData.substring(0, 8)
//                           : qrCodeData;
//                       final end = qrCodeData.length > 8
//                           ? qrCodeData
//                           .substring(qrCodeData.length - 5)
//                           : '';
//                       return Row(
//                         children: [
//                           Icon(
//                             Icons.copy_rounded,
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .brightness ==
//                                 Brightness.dark
//                                 ? AppTheme.white60
//                                 : AppTheme.black80,
//                           ),
//                           const SizedBox(
//                               width: AppTheme.elementSpacing / 2),
//                           Text(start),
//                           if (qrCodeData.length > 8)
//                             const Text('....'),
//                           Text(end),
//                         ],
//                       );
//                     }
//                   }),
//                 ),
//                 StatefulBuilder(builder: (context, setState) {
//                   return BitNetListTile(
//                     onTap: () async {
//                       await BitNetBottomSheet(
//                         context: context,
//                         //also add a help button as an action at the right once bitnetbottomsheet is fixed
//                         height:
//                         MediaQuery.of(context).size.height * 0.7,
//                         child: bitnetScaffold(
//                           extendBodyBehindAppBar: true,
//                           appBar: bitnetAppBar(
//                             hasBackButton: false,
//                             buttonType: ButtonType.transparent,
//                             text: "${L10n.of(context)!.changeAmount}",
//                             context: context,
//                           ),
//                           body: SingleChildScrollView(
//                               child: CreateInvoice()),
//                           context: context,
//                         ),
//                       );
//
//                       setState(() {});
//                     },
//                     text: L10n.of(context)!.amount,
//                     trailing: Row(
//                       children: [
//                         Icon(
//                           Icons.edit,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .brightness ==
//                               Brightness.dark
//                               ? AppTheme.white60
//                               : AppTheme.black80,
//                         ),
//                         const SizedBox(
//                             width: AppTheme.elementSpacing / 2),
//                         Text(
//                           controller.satController.text == "0" ||
//                               controller
//                                   .satController.text.isEmpty
//                               ? L10n.of(context)!.changeAmount
//                               : controller.satController.text,
//                         ),
//                         controller.satController.text == "0" ||
//                             controller.satController.text.isEmpty
//                             ? const SizedBox()
//                             : Icon(
//                           getCurrencyIcon(
//                             BitcoinUnits.SAT.name,
//                           ),
//                           color: Theme.of(context).brightness ==
//                               Brightness.light
//                               ? AppTheme.black70
//                               : AppTheme.white90,
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//                 StatefulBuilder(builder: (context, setState) {
//                   return BitNetListTile(
//                     onTap: () async {
//                       await BitNetBottomSheet(
//                         context: context,
//                         //also add a help button as an action at the right once bitnetbottomsheet is fixed
//                         height:
//                         MediaQuery.of(context).size.height * 0.7,
//                         child: bitnetScaffold(
//                           extendBodyBehindAppBar: true,
//                           appBar: bitnetAppBar(
//                             hasBackButton: false,
//                             buttonType: ButtonType.transparent,
//                             text: "Data",
//                             context: context,
//                           ),
//                           body: SingleChildScrollView(
//                               child: CreateInvoice()),
//                           context: context,
//                         ),
//                       );
//
//                       setState(() {});
//                     },
//                     text: L10n.of(context)!.amount,
//                     trailing: LongButtonWidget(
//                       buttonType: ButtonType.transparent,
//                       title: 'Lightning B11',
//                       leadingIcon: const Icon(
//                         FontAwesomeIcons.bolt,
//                         size: AppTheme.cardPadding * 0.65,
//                       ),
//                       onTap: () {
//                         BitNetBottomSheet(
//                             context: context,
//                             child: bitnetScaffold(
//                                 body: Container(
//                                   child: Column(),
//                                 ),
//                                 context: context));
//                       },
//                       customWidth: AppTheme.cardPadding * 6.25,
//                       customHeight: AppTheme.cardPadding * 1.5,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//             SizedBox(
//               height: AppTheme.cardPadding.h * 1,
//             ),
//           ],
//         )
//             : Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: AppTheme.cardPadding * 2),
//             CustomPaint(
//               foregroundPainter:
//               Theme.of(context).brightness == Brightness.light
//                   ? BorderPainterBlack()
//                   : BorderPainter(),
//               child: Container(
//                 margin: const EdgeInsets.all(AppTheme.cardPadding),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: AppTheme.cardRadiusBigger),
//                 child: Padding(
//                   padding: EdgeInsets.all(AppTheme.cardPadding / 1.25),
//                   child: PrettyQrView.data(
//                       data: "ERROR",
//                       decoration: const PrettyQrDecoration(
//                         shape: PrettyQrSmoothSymbol(
//                           roundFactor: 1,
//                         ),
//                         image: PrettyQrDecorationImage(
//                           image: AssetImage('assets/images/key.png'),
//                         ),
//                       )),
//                 ),
//               ),
//             ),
//             const SizedBox(height: AppTheme.cardPadding * 2),
//             Container(
//               padding: const EdgeInsets.all(AppTheme.cardPadding),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).brightness == Brightness.light
//                     ? AppTheme.black60
//                     : AppTheme.black60,
//                 borderRadius: AppTheme.cardRadiusBig,
//               ),
//               width: double.infinity,
//               child: Text(
//                 "You need to unlock your lightning card before you can receive funds here...",
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color:
//                   Theme.of(context).brightness == Brightness.light
//                       ? AppTheme.black80
//                       : AppTheme.white90,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: AppTheme.cardPadding * 2),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
