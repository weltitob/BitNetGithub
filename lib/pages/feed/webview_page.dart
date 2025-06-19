import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.routerState});
  final GoRouterState routerState;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late String url;
  late String name;
  late WebViewController controller;
  late bool isApp;
  Timer? timer;
  bool jsQRLoaded = false;
  bool handlingData = false;
  Set<String> handledQRCodes = {};

  @override
  void initState() {
    super.initState();
    name = widget.routerState.pathParameters['name']!;
    url = widget.routerState.pathParameters['url']!;
    isApp = widget.routerState.extra is Map
        ? (widget.routerState.extra as Map)['is_app']
        : false;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print("page started");
          },
          onPageFinished: (String url) async {
            print("page finished");
            if (isApp) {
              // Inject jsQR library when page loads
              await injectJsQRLibrary();
              // Start scanning timer after injecting the library
              if (timer == null || !timer!.isActive) {
                timer = Timer.periodic(
                    Duration(seconds: 5), (timer) => scanQRCode());
              }
              await setupClipboardMonitoring();
            }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..addJavaScriptChannel('Android', onMessageReceived: (msg) async {
        if (!isApp) return;
        try {
          Map<String, dynamic> data = jsonDecode(msg.message);

          // Handle clipboard events
          if (data['type'] == 'clipboard_copy') {
            handleCopiedText(data['content']);
            return;
          }

          // Handle existing data format
          if (data.containsKey('api_version')) {
            PaymentPayload payload = PaymentPayload.fromJson(data);
            handlingData = true;
            await BitNetBottomSheet(
              height: 300,
              context: context,
              child: ConfirmPaymentSheetWidget(
                  context: context, url: url, payload: payload),
            );
            handlingData = false;
          }
        } catch (e) {
          print(e);
        }
      })
      ..loadRequest(Uri.parse(url));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /// Injects the jsQR library into the web page
  Future<void> injectJsQRLibrary() async {
    LoggerService logger = Get.find<LoggerService>();
    try {
      await controller.runJavaScript('''
        if (!window.jsQR) {
          var script = document.createElement('script');
          script.src = 'https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.min.js';
          script.onload = function() { 
            console.log('jsQR library loaded successfully');
            window.Android.postMessage(JSON.stringify({type: 'jsqr_loaded', success: true}));
          };
          script.onerror = function() {
            console.error('Failed to load jsQR library');
            window.Android.postMessage(JSON.stringify({type: 'jsqr_loaded', success: false}));
          };
          document.head.appendChild(script);
        } else {
          console.log('jsQR already loaded');
          window.Android.postMessage(JSON.stringify({type: 'jsqr_loaded', success: true}));
        }
      ''');
      jsQRLoaded = true;
      logger.i("Injected jsQR library");
    } catch (e) {
      logger.i("Error injecting jsQR library: $e");
      jsQRLoaded = false;
    }
  }

  Future<void> scanQRCode() async {
    if (handlingData) return;
    LoggerService logger = Get.find<LoggerService>();

    logger.i("Scanning for QR codes...");

    if (!jsQRLoaded) {
      logger.i("jsQR library not loaded yet, trying to load it now");
      await injectJsQRLibrary();
      if (!jsQRLoaded) {
        logger.i("Failed to load jsQR library, cannot scan QR codes");
        return;
      }
    }

    try {
      final result = await controller.runJavaScriptReturningResult('''
        (function() {
          // Check if jsQR is available
          if (typeof jsQR === 'undefined') {
            console.error('jsQR library not found');
            return 'jsQR_not_found';
          }
          
          // Find all image elements
          const images = Array.from(document.querySelectorAll('img'));
          //console.log('Scanning ' + images.length + ' images for QR codes');
          
          // Create canvas for processing
          const canvas = document.createElement('canvas');
          const ctx = canvas.getContext('2d');
          
          // Try each image
          for (const img of images) {
            try {
              // Skip images without proper dimensions
              if (!img.complete || !img.naturalWidth) {
               // console.log('Skipping incomplete image');
                continue;
              }
              
              // Get image dimensions
              const width = img.naturalWidth || img.width;
              const height = img.naturalHeight || img.height;
              
              if (width < 50 || height < 50) {
               // console.log('Skipping small image: ' + width + 'x' + height);
                continue; // Skip tiny images
              }
              
              //console.log('Processing image: ' + width + 'x' + height);
              
              // Resize canvas
              canvas.width = width;
              canvas.height = height;
              
              // Draw image to canvas
              ctx.drawImage(img, 0, 0, width, height);
              
              // Scan for QR code
              try {
                const imageData = ctx.getImageData(0, 0, width, height);
                const code = jsQR(imageData.data, width, height);
                
                if (code) {
                 // console.log('QR code found in image: ' + code.data);
                  return code.data;
                }
              } catch (e) {
                //console.log('Error scanning image: ' + e.message);
              }
            } catch (e) {
              //console.log('Error processing image: ' + e.message);
            }
          }
          
          // If canvas operations are restricted, try scanning visible content 
          try {
            // Try to create a screenshot of the visible page (may fail due to security)
            const fullCanvas = document.createElement('canvas');
            fullCanvas.width = window.innerWidth;
            fullCanvas.height = window.innerHeight;
            const fullCtx = fullCanvas.getContext('2d');
            
            // This will likely fail due to security restrictions
            fullCtx.drawImage(document.documentElement, 0, 0, fullCanvas.width, fullCanvas.height);
            
            const fullImageData = fullCtx.getImageData(0, 0, fullCanvas.width, fullCanvas.height);
            const fullCode = jsQR(fullImageData.data, fullCanvas.width, fullCanvas.height);
            
            if (fullCode) {
              //console.log('QR code found in page: ' + fullCode.data);
              return fullCode.data;
            }
          } catch (e) {
            //console.log('Error scanning page: ' + e.message);
          }
          
          // Also try any canvas elements that might contain QR codes
          const canvases = Array.from(document.querySelectorAll('canvas'));
          for (const canvas of canvases) {
            try {
              const ctx = canvas.getContext('2d');
              const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
              const code = jsQR(imageData.data, canvas.width, canvas.height);
              
              if (code) {
                //console.log('QR code found in canvas: ' + code.data);
                return code.data;
              }
            } catch (e) {
              //console.log('Error scanning canvas: ' + e.message);
            }
          }
          
          // No QR code found
          return null;
        })();
      ''');

      if (result == "jsQR_not_found") {
        logger.i("jsQR library not found, trying to inject it again");
        jsQRLoaded = false;
        await injectJsQRLibrary();
      } else if (result != "null") {
        logger.i("QR Code found");
        // Process the QR code here
        processQRCode(result.toString());
      } else {
        logger.i("No QR Code found");
      }
    } catch (e) {
      logger.i("Error scanning QR code: $e");
    }
  }

  void processQRCode(String qrData) async {
    // Check if we've already handled this QR code
    if (handledQRCodes.contains(qrData) || handlingData) {
      return;
    }

    try {
      dynamic json = jsonDecode(qrData);
      print(json);
      // Check if the result is still a string (double encoded)
      if (json is String) {
        try {
          // Try to decode again for double-encoded JSON
          json = jsonDecode(json);
        } catch (e) {
          // If second decode fails, use the first decode result
          // This handles cases where it's not actually double-encoded
        }
      }

      PaymentPayload payload = PaymentPayload.fromJson(json);
      handlingData = true;

      final result = await BitNetBottomSheet(
        height: 300,
        context: context,
        child: ConfirmPaymentSheetWidget(
            context: context, url: url, payload: payload),
      );

      handlingData = false;

      // If result is true (either cancel or confirm was pressed), mark this QR as handled
      if (result == true) {
        handledQRCodes.add(qrData);
      }
    } catch (e) {
      print(e);
      //wrong qr code, fail silently.
    }
  }

  /// Sets up JavaScript to monitor clipboard copy events
  Future<void> setupClipboardMonitoring() async {
    LoggerService logger = Get.find<LoggerService>();
    try {
      await controller.runJavaScript('''
        // Monitor standard copy events (when user manually copies text)
        document.addEventListener('copy', function(e) {
          const selection = document.getSelection().toString();
          if (selection && selection.trim().length > 0) {
            console.log('User copied text: ' + selection);
            window.Android.postMessage(JSON.stringify({
              type: 'clipboard_copy',
              content: selection
            }));
          }
        });
        
        // Intercept the Clipboard API writeText method
        try {
          // Only proceed if Clipboard API is available
          if (navigator.clipboard) {
            // Store the original clipboard writeText method
            const originalWriteText = navigator.clipboard.writeText;
            
            // Override the clipboard writeText method
            navigator.clipboard.writeText = function(text) {
              console.log('Clipboard API writeText called with: ' + text);
              
              // Send the copied text to Flutter
              window.Android.postMessage(JSON.stringify({
                type: 'clipboard_copy',
                content: text
              }));
              
              // Call the original method and return its promise
              return originalWriteText.call(this, text);
            };
            console.log('Clipboard API successfully intercepted');
          } else {
            console.log('Clipboard API not available');
          }
        } catch (e) {
          console.error('Error intercepting Clipboard API: ' + e.message);
        }
        
        // Intercept document.execCommand('copy')
        try {
          const originalExecCommand = document.execCommand;
          document.execCommand = function(command, showUI, value) {
            // Call the original method first
            const result = originalExecCommand.call(this, command, showUI, value);
            
            // If it's a copy command, capture the selection
            if (command.toLowerCase() === 'copy') {
              const selection = document.getSelection().toString();
              if (selection && selection.trim().length > 0) {
                console.log('execCommand copy captured: ' + selection);
                window.Android.postMessage(JSON.stringify({
                  type: 'clipboard_copy',
                  content: selection
                }));
              }
            }
            
            return result;apiVersion
          };
          console.log('document.execCommand successfully intercepted');
        } catch (e) {
          console.error('Error intercepting execCommand: ' + e.message);
        }
        
        console.log('Clipboard monitoring initialized');
      ''');
      logger.i("Clipboard monitoring initialized");
    } catch (e) {
      logger.i("Error setting up clipboard monitoring: $e");
    }
  }

  /// Handles text that was copied by the user in the WebView
  void handleCopiedText(String text) async {
    LoggerService logger = Get.find<LoggerService>();
    if (text.isEmpty || handlingData) return;

    logger.i("Handling copied text: $text");

    // Get or create the sends controller
    if (!Get.isRegistered<SendsController>()) {
      Get.put(SendsController(context: context, getClipOnInit: false));
    }
    SendsController sendsController = Get.find<SendsController>();

    // Run onQRCodeScanned to determine the type and set up the controller
    await sendsController.onQRCodeScanned(text, context);

    // Check the determined QR type to decide the flow
    QRTyped qrType = sendsController.determineQRType(text);

    // Check if this address type has embedded amount (truly fixed amounts only)
    bool hasEmbeddedAmount = false;
    switch (qrType) {
      case QRTyped.Invoice:
        // Only invoices have truly embedded/fixed amounts
        hasEmbeddedAmount = true;
        break;
      case QRTyped.LightningUrl:
      case QRTyped.LightningMail:
        // Lightning URL/Mail have bounds but user can still choose amount within bounds
        hasEmbeddedAmount = false;
        break;
      case QRTyped.BIP21WithBolt11:
        // Check if BIP21 has amount parameter
        Uri? uri = Uri.tryParse(text);
        hasEmbeddedAmount =
            uri != null && uri.queryParameters.containsKey('amount');
        break;
      case QRTyped.OnChain:
        // Check if OnChain has amount parameter (bitcoin: URI)
        if (text.startsWith('bitcoin:')) {
          Uri? uri = Uri.tryParse(text);
          hasEmbeddedAmount =
              uri != null && uri.queryParameters.containsKey('amount');
        } else {
          hasEmbeddedAmount = false;
        }
        break;
      default:
        hasEmbeddedAmount = false;
        break;
    }

    if (hasEmbeddedAmount) {
      // Show bottom sheet for addresses with embedded amounts
      try {
        // Determine appropriate currency based on the QR type and amount
        String currency = 'BTC';
        String targetCurrency = 'BTC';
        double amount = 0.0;

        // For invoices, use SAT as they work in satoshis
        if (qrType == QRTyped.Invoice) {
          currency = 'SAT';
          targetCurrency = 'SAT';
          amount = double.parse(sendsController.satController.text);
        } else {
          // For BIP21 and OnChain with amounts, use BTC
          currency = 'BTC';
          targetCurrency = 'BTC';
          amount = double.parse(sendsController.btcController.text);
        }

        PaymentPayload payload = PaymentPayload(
          apiVersion: MINI_APP_API_VERSION,
          appId: url,
          amount: amount,
          currency: currency,
          targetCurrency: targetCurrency,
          depositAddress: sendsController.bitcoinReceiverAdress,
          note: sendsController.description.value,
        );

        handlingData = true;

        await BitNetBottomSheet(
          height: 300,
          context: context,
          child: ConfirmPaymentSheetWidget(
            context: context,
            url: url,
            payload: payload,
          ),
        );

        handlingData = false;
      } catch (e) {
        logger.e("Error creating payment payload for clipboard text: $e");
        handlingData = false;
        // If payload creation fails, navigate to send screen
        handlingData = true;
        await context.push('/wallet/send_popper');
        handlingData = false;
      }
    } else {
      // Navigate to send screen for addresses without embedded amounts
      handlingData = true;
      await context.push('/wallet/send_popper');
      handlingData = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: name,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

class ConfirmPaymentSheetWidget extends StatefulWidget {
  const ConfirmPaymentSheetWidget({
    required this.context,
    required this.url,
    required this.payload,
  });

  final BuildContext context;
  final String url;
  final PaymentPayload payload;

  @override
  State<ConfirmPaymentSheetWidget> createState() =>
      _ConfirmPaymentSheetWidgetState();
}

class _ConfirmPaymentSheetWidgetState extends State<ConfirmPaymentSheetWidget> {
  AppData? app;
  bool loadingAmount = true;
  bool unSupportedCurrency = false;
  double price = 0.0;
  bool confirmLoading = false;
  @override
  void initState() {
    super.initState();
    app = Get.find<ProfileController>()
        .availableApps
        .where((app) => app.url == widget.url)
        .firstOrNull;

    if (app == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pop();
      });
    } else {
      // Check if we need currency conversion or if both currencies are Bitcoin units
      if ((widget.payload.currency == 'BTC' ||
              widget.payload.currency == 'SAT') &&
          (widget.payload.targetCurrency == 'BTC' ||
              widget.payload.targetCurrency == 'SAT')) {
        // No external price lookup needed for Bitcoin to Bitcoin conversions
        price = 1.0; // Will be handled by CurrencyConverter internally
        WidgetsBinding.instance.addPostFrameCallback((_) {
          loadingAmount = false;
          setState(() {});
        });
      } else {
        // Currency is a real currency (like USD), need to fetch price data
        FirebaseFirestore.instance
            .collection('chart_data')
            .doc(widget.payload.currency.toUpperCase())
            .collection('live')
            .doc('data')
            .get()
            .then((val) {
          DocumentSnapshot<Map<String, dynamic>> dataRef = val;
          if (!dataRef.exists) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              unSupportedCurrency = true;
              loadingAmount = false;
              setState(() {});
            });
          } else {
            price = dataRef.data()?['price'] is int
                ? (dataRef.data()?['price'] as int).toDouble()
                : dataRef.data()?['price'];
            WidgetsBinding.instance.addPostFrameCallback((_) {
              loadingAmount = false;
              setState(() {});
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: 'Confirm Payment',
        hasBackButton: false,
      ),
      context: context,
      body: app == null
          ? Container()
          : unSupportedCurrency
              ? Center(
                  child: Text(
                      "This currency is not supported, payment cannot be continued."),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: AppTheme.cardPadding,
                      left: AppTheme.cardPaddingBig,
                      right: AppTheme.cardPaddingBig),
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      GlassContainer(
                        child: Column(
                          children: [
                            BitNetListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.elementSpacing * 0.75,
                                  vertical: AppTheme.elementSpacing),
                              leading: AppImageBuilder(
                                  app: app!, width: 40, height: 40),
                              text: "Payment for ${app!.name}",
                            ),
                            BitNetListTile(
                              text: "Amount:",
                              trailing: loadingAmount
                                  ? dotProgress(context)
                                  : AmountPreviewer(
                                      unitModel: BitcoinUnitModel(
                                          amount: double.parse(
                                              CurrencyConverter.convertCurrency(
                                                  widget.payload.currency,
                                                  widget.payload.amount,
                                                  widget.payload.targetCurrency
                                                      .toUpperCase(),
                                                  price)),
                                          bitcoinUnit:
                                              widget.payload.targetCurrency ==
                                                      "SAT"
                                                  ? BitcoinUnits.SAT
                                                  : BitcoinUnits.BTC),
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!,
                                      textColor: null,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: LongButtonWidget(
                              title: "Cancel",
                              onTap: () {
                                context.pop(true);
                              },
                              buttonType: ButtonType.transparent,
                              customWidth: double.infinity,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: LongButtonWidget(
                              title: "Confirm",
                              state: confirmLoading
                                  ? ButtonState.loading
                                  : ButtonState.idle,
                              onTap: () async {
                                confirmLoading = true;
                                setState(() {});
                                if (!Get.isRegistered<SendsController>()) {
                                  Get.put(SendsController(
                                      context: context, getClipOnInit: false));
                                }
                                SendsController sends =
                                    Get.find<SendsController>();
                                await Get.find<SendsController>()
                                    .onQRCodeScanned(
                                        widget.payload.depositAddress, context);

                                BitcoinUnitModel unitModel = BitcoinUnitModel(
                                    amount: double.parse(
                                        CurrencyConverter.convertCurrency(
                                            widget.payload.currency,
                                            widget.payload.amount,
                                            widget.payload.targetCurrency
                                                .toUpperCase(),
                                            price)),
                                    bitcoinUnit:
                                        widget.payload.targetCurrency == "SAT"
                                            ? BitcoinUnits.SAT
                                            : BitcoinUnits.BTC);
                                sends.hasReceiver.value = true;

                                sends.bitcoinReceiverAdress =
                                    widget.payload.depositAddress;

                                sends.btcController.text =
                                    unitModel.bitcoinUnit == BitcoinUnits.SAT
                                        ? CurrencyConverter.convertSatoshiToBTC(
                                                unitModel.amount)
                                            .toString()
                                        : unitModel.amount.toString();

                                sends.satController.text = unitModel
                                            .bitcoinUnit ==
                                        BitcoinUnits.SAT
                                    ? (unitModel.amount as num)
                                        .toInt()
                                        .toString()
                                    : CurrencyConverter.convertBitcoinToSats(
                                            unitModel.amount)
                                        .toString();

                                sends.bip21InvoiceSatController.text = "0";

                                sends.bip21InvoiceBtcController.text = "0.0";

                                sends.moneyTextFieldIsEnabled.value = true;

                                sends.description.value = widget.payload.note;
                                await sends.sendBTC(context,
                                    canNavigate: false);
                                confirmLoading = false;
                                context.pop(true);
                                //Get.delete<SendsController>();
                              },
                              customWidth: double.infinity,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
    );
  }
}

class PaymentPayload {
  final String apiVersion;
  final String appId;
  final double amount;
  final String currency;
  final String targetCurrency;
  final String depositAddress;
  final String note;

  PaymentPayload(
      {required this.apiVersion,
      required this.appId,
      required this.amount,
      required this.currency,
      required this.targetCurrency,
      required this.depositAddress,
      required this.note});

  factory PaymentPayload.fromJson(Map<String, dynamic> data) {
    return PaymentPayload(
        apiVersion: data['api_version'],
        appId: data['app_id'],
        amount: data['data']['amount'] is int
            ? (data['data']['amount'] as int).toDouble()
            : data['data']['amount'],
        currency: data['data']['currency'],
        targetCurrency: data['data']['target_currency'],
        depositAddress: data['data']['deposit_address'],
        note: data['data']['note']);
  }
}
