import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';

class HorizontalProduct extends StatelessWidget {
  final GridListModal item;
  final Function()? onDelete;
  
  const HorizontalProduct({
    Key? key, 
    required this.item, 
    this.onDelete
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: NftProductHorizontal(
        cryptoImage: item.cryptoImage,
        nftImage: item.nftImage,
        nftMainName: item.nftMainName,
        nftName: item.nftName,
        cryptoText: item.cryptoText,
        rank: item.rank,
        columnMargin: item.columnMargin,
        onDelete: onDelete
      ),
    );
  }
}