import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
          context: context,
          onTap: () => context.pop(),
          text: L10n.of(context)!.hotNewItems),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4 / 5.9,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: gridListData.length,
              itemBuilder: (BuildContext context, int index) {
                return AssetCard(
                    encodedData: gridListData[index].nftImage,
                    scale: 0.5,
                    nftName: gridListData[index].nftName,
                    nftMainName: gridListData[index].nftMainName,
                    cryptoText: gridListData[index].cryptoText,
                    rank: gridListData[index].rank.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
