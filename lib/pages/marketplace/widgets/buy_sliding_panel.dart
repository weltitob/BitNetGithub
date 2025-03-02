import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/widgets/horizontal_product.dart';
import 'package:flutter/material.dart';

class BuySlidingPanel extends StatelessWidget {
  final int itemId;
  final List<GridListModal> sortedGridList;
  
  const BuySlidingPanel({
    Key? key,
    required this.itemId,
    required this.sortedGridList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: "Purchase NFT",
        hasBackButton: false,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppTheme.elementSpacing / 2,
                      ),
                      _buildHorizontalProduct(),
                      const SizedBox(
                        height: AppTheme.elementSpacing / 2,
                      ),
                      const BitNetListTile(
                        text: 'Subtotal',
                        trailing: Text('0.5'),
                      ),
                      const BitNetListTile(
                        text: 'Network Fee',
                        trailing: Text('0.5'),
                      ),
                      const BitNetListTile(
                        text: 'Market Fee',
                        trailing: Text('0.5'),
                      ),
                      const BitNetListTile(
                        text: 'Total Price',
                        trailing: Text('0.5'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      LongButtonWidget(
                        title: "Purchase",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      LongButtonWidget(
                        title: "Cancel",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonType: ButtonType.transparent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHorizontalProduct() {
    var gridIndex = sortedGridList.indexWhere((element) => element.id == itemId);
    if (gridIndex == -1) return Container();
    
    return HorizontalProduct(item: sortedGridList[gridIndex]);
  }
  
  static Future<T?> show<T>(BuildContext context, int itemId, List<GridListModal> sortedGridList) {
    return BitNetBottomSheet(
      context: context,
      child: BuySlidingPanel(
        itemId: itemId,
        sortedGridList: sortedGridList,
      ),
    );
  }
}