import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/widgets/horizontal_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

class CartSheet extends StatefulWidget {
  const CartSheet(
      {Key? key,
      this.onClear,
      this.onDeleteItem,
      required this.selected_products,
      required this.sortedGridList})
      : super(key: key);

  final Function()? onClear;
  final Function(int)? onDeleteItem;
  final List<dynamic> selected_products;
  final List<GridListModal> sortedGridList;

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppTheme.elementSpacing),
        Container(
          height: AppTheme.elementSpacing / 1.5,
          width: AppTheme.cardPadding * 2.25,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing * 0.75),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Container(
              height: 600,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: bitnetScaffoldUnsafe(
                  context: context,
                  extendBodyBehindAppBar: true,
                  appBar: bitnetAppBar(
                    context: context,
                    text:
                        "${L10n.of(context)!.cart}(${widget.selected_products.length})",
                    actions: [
                      TextButton(
                        child: Text(L10n.of(context)!.clearAll,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white)),
                        onPressed: widget.onClear,
                      ),
                    ],
                    hasBackButton: false,
                  ),
                  body: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 200.0,
                          child: ListView.builder(
                              itemCount: widget.selected_products.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: HorizontalProduct(
                                      item: widget.sortedGridList.firstWhere(
                                          (test) =>
                                              test.id ==
                                              widget.selected_products[i]),
                                      onDelete: () {
                                        if (widget.onDeleteItem != null) {
                                          widget.onDeleteItem!(
                                              widget.selected_products[i]);
                                          setState(() {});
                                        }
                                      }),
                                );
                              }),
                        ),
                        const Spacer(),
                        Container(
                          width: AppTheme.cardPadding * 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.subTotal),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.networkFee),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.marketFee),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.totalPrice),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: LongButtonWidget(
                              title: L10n.of(context)!.buyNow, onTap: () {}),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
