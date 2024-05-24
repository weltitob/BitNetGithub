import 'dart:convert';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/cancelpendingbatch.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/finalize.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/listbatches.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/batch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BatchScreen extends StatefulWidget {
  final GoRouterState? routerState;
  const BatchScreen({super.key, this.routerState});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  bool isLoading = false;
  String batchKey = '';
  List<AssetInBatchList> assets = [];

  @override
  void initState() {
    super.initState();
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

  void callListBatch(String batchKey) async {
    print("Calling Listing batch with this key: $batchKey");
    Batch? responeBatch = await fetchMintBatch(batchKey);
    print("Response Batch: $responeBatch");
    //now lets get all of the assets to a list
    setState(() {
      assets = responeBatch!.assets.reversed.toList();
      print("Assets: $assets");
      for (var asset in assets) {
        print("Assetname ${asset.name}");
      }
    });
    //now lets put them in the listview
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return PopScope(
      onPopInvoked: (bool shouldPop) {
        if (mounted) {
          Navigator.pop(context);
        }
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: true,
          onTap: () {
            if (mounted) {
              Navigator.pop(context);
            }
          },
          context: context,
          text: 'Finalize Posts',
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
                child: ListView.builder(
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
                    return NftProductSlider(
                        //assets[index].assetMeta!.data ?? 'metahash',
                        medias: assets[index].assetMeta?.toMedias(),
                        nftName: assets[index].assetMeta!.data ?? 'metahash',
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
                    leadingIcon: Icon(Icons.add_rounded),
                    title: "Add more",
                    onTap: () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2.5.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                child: Text(
                  'Cost Estimation',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                ),
              ),
              SizedBox(
                height: AppTheme.elementSpacing,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Column(
                  children: [
                    BitNetListTile(
                      text: 'Transaction fees',
                      trailing: Text('0.25',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    BitNetListTile(
                      text: 'BitNet usage fee',
                      trailing: Text('0.001',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Center(
                child: LongButtonWidget(
                  state: isLoading ? ButtonState.loading : ButtonState.idle,
                  title: 'Upload to Blockchain',
                  onTap: () {
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
                  child: Text("Cancel and delete"),
                ),
              ),
            ],
          ),
        ),
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
      showOverlay(context, "Error finalizing batch",
          color: AppTheme.errorColor);
    }
  }
}
