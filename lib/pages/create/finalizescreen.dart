import 'dart:convert';

import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/estimatefee.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/cancelpendingbatch.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/finalize.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/listbatches.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/batch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class BatchScreen extends StatefulWidget {
  final GoRouterState? routerState;
  const BatchScreen({super.key, this.routerState});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  String batchKey = '';
  double sat_per_vbyte = 0.0;
  List<AssetInBatchList> assets = [];

  @override
  void initState() {
    super.initState();
    fetchFee();
    _decodeBatchKey();
  }

  void _decodeBatchKey() {
    final batchKeyUrl64Encoded =
        widget.routerState?.pathParameters['batch_key'];
    print('Current route: ${widget.routerState?.path}');
    print('batchKeyUrl64Encoded: $batchKeyUrl64Encoded');

    if (batchKeyUrl64Encoded != null) {
      try {
        // Decode the Base64 URL-safe string back to bytes
        final decodedBytes = base64Url.decode(batchKeyUrl64Encoded);

        // Decode the bytes to the original batch key string
        batchKey = utf8.decode(decodedBytes);

        print("Decoded bListatch key: $batchKey");

        callListBatch(batchKey);
      } catch (e) {
        print("Error decoding batch key: $e");
      }
    } else {
      print('Batch key is null');
    }
  }

  fetchFee() async {
    dynamic fundedPsbtResponse = await estimateFee(AppTheme.targetConf.toString());
    final sat_per_kw = fundedPsbtResponse.data["sat_per_kw"];
    if(mounted)
      setState(() {
        sat_per_vbyte = double.parse(sat_per_kw);
      });
  }

  void callListBatch(String batchKey) async {
    print("Calling Listing batch with this key: $batchKey");
    try {
      Batch? responseBatch = await fetchMintBatch(batchKey);
      print("Response Batch: $responseBatch");
      
      // Check if response is not null before accessing properties
      if (responseBatch != null && responseBatch.assets != null) {
        setState(() {
          assets = responseBatch.assets.reversed.toList();
          hasError = false;
          print("Assets: $assets");
          for (var asset in assets) {
            print("Assetname ${asset.name}");
          }
        });
      } else {
        // Handle null response
        setState(() {
          hasError = true;
          errorMessage = L10n.of(context)!.errorFinalizingBatch;
        });
        
        final overlayController = Get.find<OverlayController>();
        overlayController.showOverlay(
          L10n.of(context)!.errorFinalizingBatch, 
          color: AppTheme.errorColor
        );
        
        // Stay on the page and let user handle navigation
        // They can see the error and choose to go back manually
      }
    } catch (e) {
      print("Error fetching batch data: $e");
      
      setState(() {
        hasError = true;
        errorMessage = "Error loading batch data. Please try again.";
      });
      
      // Show error message
      final overlayController = Get.find<OverlayController>();
      overlayController.showOverlay(
        "Error loading batch: $e", 
        color: AppTheme.errorColor
      );
      
      // Stay on the page and let user handle navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return PopScope(
      onPopInvoked: (bool shouldPop) {
        // Let the system handle the back navigation
        // No need to call Navigator.pop manually here
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: true,
          onTap: () {
            // Use GoRouter for consistent navigation
            context.pop();
          },
          context: context,
          text: L10n.of(context)!.fianlizePosts,
        ),
        body: SingleChildScrollView(
          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 4.h,
                  ),
                  Container(
                    width: size.width,
                    height: 245.w,
                    margin: EdgeInsets.only(bottom: AppTheme.cardPadding.h),
                    child: hasError
                      ? _buildInlineErrorState(context)
                      : assets.isEmpty
                        ? _buildLoadingState(context)
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(
                                top: 0.0,
                                bottom: 0.0,
                                right: AppTheme.elementSpacing.w,
                                left: AppTheme.elementSpacing.w),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: assets.length,
                            itemBuilder: (context, index) {
                              return AssetCard(
                                  //assets[index].assetMeta!.data ?? 'metahash',
                                  medias: assets[index].assetMeta?.toMedias(),
                                  nftName: assets[index].assetMeta?.data ?? 'metahash',
                                  nftMainName: assets[index].name ?? 'assetID',
                                  cryptoText: assets[index].groupKey ?? 'price',
                                 );
                            },
                          ),
                  ),
                  Center(
                    child: LongButtonWidget(
                        customWidth: AppTheme.cardPadding * 6.5,
                        customHeight: AppTheme.cardPadding * 1.75,
                        buttonType: ButtonType.transparent,
                        leadingIcon: Icon(
                          hasError ? Icons.arrow_back : Icons.add_rounded,
                        ),
                        title: hasError 
                            ? "Go back"
                            : L10n.of(context)!.addMore,
                        onTap: () {
                          if (mounted) {
                            context.pop();
                          }
                        }),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 2.5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                    child: Text(
                      L10n.of(context)!.costEstimation,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.elementSpacing,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing),
                    child: Column(
                      children: [
                        BitNetListTile(
                          text: L10n.of(context)!.transactionFees,
                          trailing: AmountPreviewer(unitModel: CurrencyConverter.convertToBitcoinUnit(sat_per_vbyte, BitcoinUnits.SAT),textStyle: Theme.of(context).textTheme.titleMedium!,textColor: null, shouldHideBalance: false,)
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.bitnetUsageFee,
                          trailing: AmountPreviewer(unitModel: CurrencyConverter.convertToBitcoinUnit((sat_per_vbyte * 0.5), BitcoinUnits.SAT),textStyle: Theme.of(context).textTheme.titleMedium!,textColor: null, shouldHideBalance: false,)
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                  Center(
                    child: LongButtonWidget(
                      state: isLoading ? ButtonState.loading : ButtonState.idle,
                      title: L10n.of(context)!.uploadToBlockchain,
                      onTap: hasError || assets.isEmpty
                          ? null  // Disable tap when there's an error or no assets
                          : () {
                              finalizeBatch();
                            },
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      cancelBatch();
                    },
                    child: Center(
                      child: Text(L10n.of(context)!.cancelDelete),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInlineErrorState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Center(
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardPadding / 2),
            side: BorderSide(
              color: AppTheme.errorColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 40,
                  color: AppTheme.errorColor,
                ),
                const SizedBox(height: AppTheme.elementSpacing),
                Text(
                  "Unable to load your asset",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  errorMessage.isNotEmpty 
                      ? errorMessage 
                      : "There was an error loading your post.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.elementSpacing),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        if (batchKey.isNotEmpty) {
                          callListBatch(batchKey);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Try Again",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: AppTheme.elementSpacing),
          Text(
            "Loading your assets...",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  void cancelBatch() async {
    print("Calling Cancel batch which will kill all pending batches.");
    await cancelMintAsset();
    //navigate to profile
    context.go("/profile");
  }

  void finalizeBatch() async {
    setState(() {
      isLoading = true;
    });
    final overlayController = Get.find<OverlayController>();
    try {
      await finalizeMint();
      setState(() {
        isLoading = false;
      });
      context.go("/profile");
    } catch (e) {
      print("Error finalizing batch: $e");
      setState(() {
        isLoading = false;
      });
      overlayController.showOverlay(L10n.of(context)!.errorFinalizingBatch,
          color: AppTheme.errorColor);
    }
  }
}
