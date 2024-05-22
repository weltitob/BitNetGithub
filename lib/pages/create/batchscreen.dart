import 'package:bitnet/backbone/cloudfunctions/taprootassets/finalize.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({super.key});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (bool) {
        Navigator.pop(context);
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: true,
          onTap: () {
            Navigator.pop(context);
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
                height: AppTheme.cardPadding * 3.5,
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
                  itemCount: nftHotProductSliderData.length,
                  itemBuilder: (context, index) {
                    return NftProductSlider(
                        nftImage: nftHotProductSliderData[index].nftImage,
                        cryptoImage:
                        nftHotProductSliderData[index].cryptoImage,
                        nftName: nftHotProductSliderData[index].nftName,
                        nftMainName:
                        nftHotProductSliderData[index].nftMainName,
                        cryptoText:
                        nftHotProductSliderData[index].cryptoText,
                        columnMargin:
                        nftHotProductSliderData[index].columnMargin,
                        rank: nftHotProductSliderData[index].rank);
                  },
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 0.5,
              ),

              Center(
                child: LongButtonWidget(
                  customWidth: AppTheme.cardPadding * 6.5,
                  customHeight: AppTheme.cardPadding * 1.75,
                  buttonType: ButtonType.transparent,

                    leadingIcon: Icon(Icons.add_rounded),
                    title: "Add more", onTap: (){}),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                child: Text(
                  'Cost Estimation',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  ),
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
                  title: 'Upload to Blockchain',
                  onTap: () {
                    //finalize the batch
                    finalizeMint();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
