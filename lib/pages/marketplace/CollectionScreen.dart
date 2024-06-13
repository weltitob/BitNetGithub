import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSliderClickable.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class CollectionScreen extends StatefulWidget {
  final GoRouterState? routerState;
  final BuildContext context;
  const CollectionScreen({Key? key, required this.routerState, required this.context})
      : super(key: key);
  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final inscriptions = [2424242, 3434343];
  var search_filter = 1;
  late var sorting_filter;
  var sortedGridList = gridListData;
  var selected_products = [];
  var showCartBottomSheet = false;
  var item_buy = -1;
  PersistentBottomSheetController? sheetCtrler;
  Widget? bottomSheet;
  late PanelController buyPanelController;
  @override
  initState() {
    sorting_filter = L10n.of(widget.context)!.recentlyListed;
    sortList(search_filter, sorting_filter);
    buyPanelController = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final name = widget.routerState!.pathParameters['collection_id'];
    return bitnetScaffold(
       extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(context: context,
      onTap: ()=>context.pop(),),
      context: context,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              children: [
               
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 38.h),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            nftImage5,
                            width: size.width,
                            height: 185.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: SizedBox(
                          width: size.width,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                user1Image,
                                width: 75.w,
                                height: 75.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, route.kOwnerDetailScreenRoute);
                    },
                    child: Text(
                      name != null ? name : L10n.of(context)!.unknown,
                      textAlign: TextAlign.center,
                      style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Inscriptions #${inscriptions[0]}-${inscriptions[inscriptions.length - 1]}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const OwnerDataText(
                        ownerDataImg: discordIcon,
                        ownerDataTitle: 'Discord',
                        hasImage: true,
                      ),
                      const OwnerDataText(
                        ownerDataImg: twitterIcon,
                        ownerDataTitle: 'Twitter',
                        hasImage: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, route.kActivityScreenRoute);
                        },
                        child:   OwnerDataText(
                          ownerDataImg: activityIcon,
                          ownerDataTitle: L10n.of(context)!.activity,
                          hasImage: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.floorPrice,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Row(children: [
                            Text("0.025"),
                            Image.asset(
                              bitCoinIcon,
                              width: 15,
                              height: 15,
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.sales,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Text("500"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "24H Volume",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Row(children: [
                            Text("0.021"),
                            Image.asset(
                              bitCoinIcon,
                              width: 15,
                              height: 15,
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.totalVolume,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Row(children: [
                            Text("1.0235"),
                            Image.asset(
                              bitCoinIcon,
                              width: 15,
                              height: 15,
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.listed,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Text("52"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.supply,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Text("1000"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: GlassContainer(
                    opacity: 0.05,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            L10n.of(context)!.owners,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.colorBitcoin),
                          ),
                          Text("250"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: Text("Inscriptions",
                        style: Theme.of(context).textTheme.headlineMedium)),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LongButtonWidget(
                        customWidth: 10 * 8,
                        customHeight: 10 * 2.5,
                        title: L10n.of(context)!.forSale,
                        titleStyle: Theme.of(context).textTheme.bodySmall,
                        onTap: () {
                          setState(() {
                            search_filter = 0;
                            sortList(search_filter, sorting_filter);
                          });
                        },
                        buttonType: search_filter == 0
                            ? ButtonType.solid
                            : ButtonType.transparent,
                      ),
                      LongButtonWidget(
                        title: L10n.of(context)!.showAll,
                        customWidth: 10 * 8,
                        customHeight: 10 * 2.5,
                        onTap: () {
                          setState(() {
                            search_filter = 1;
                            sortList(search_filter, sorting_filter);
                          });
                        },
                        buttonType: search_filter == 1
                            ? ButtonType.solid
                            : ButtonType.transparent,
                      ),
                      LongButtonWidget(
                        title: L10n.of(context)!.sold,
                        customWidth: 10 * 8,
                        customHeight: 10 * 2.5,
                        onTap: () {
                          setState(() {
                            search_filter = 2;
                            sortList(search_filter, sorting_filter);
                          });
                        },
                        buttonType: search_filter == 2
                            ? ButtonType.solid
                            : ButtonType.transparent,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SortingCategoryPopup(
                      onChanged: (str) {
                        setState(() {
                          sorting_filter = str;
                          sortList(search_filter, sorting_filter);
                        });
                      },
                      currentSortingCategory: sorting_filter,
                    )
                  ],
                ),
                CommonHeading(
                  headingText: '',
                  hasButton: false,
                  isNormalChild: true,
                  isChild: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 5.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: sortedGridList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NftProductSliderClickable(
                            id: sortedGridList[index].id,
                            nftImage: sortedGridList[index].nftImage,
                            nftName: sortedGridList[index].nftName,
                            nftMainName: sortedGridList[index].nftMainName,
                            cryptoImage: sortedGridList[index].cryptoImage,
                            cryptoText: sortedGridList[index].cryptoText,
                            columnMargin: sortedGridList[index].columnMargin,
                            rank: sortedGridList[index].rank,
                            onTap:(i){
                              handleProductClick(i, context);
                            } ,
                            onLongTap: () {
                              context.goNamed(
                                  '/asset_screen',
                                  pathParameters: {
                                    'nft_id': sortedGridList[index].nftName
                                  }
                                  );
                            },
                            onTapBuy: () {
                              setState(() {
                                this.item_buy = sortedGridList[index].id;
                                _buildBuySlidingPanel(context).whenComplete((){
                                  this.item_buy = -1;
                                  setState((){});
                                });
                              });
                            },
                            selected: selected_products
                                .contains(sortedGridList[index].id));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          //const FilterBtn(),
          //const StatusBarBg(),

          if (showCartBottomSheet && item_buy == -1 && bottomSheet != null)
            bottomSheet!
           
        ],
      ),
    );
  }

  void sortList(search_filter, sort_filter) {
    //First we filter using the search filter
    List<GridListModal> newList = [];
    switch (search_filter) {
      case 0:
        for (int i = 0; i < gridListData.length; i++) {
          if (!gridListData[i].sold) {
            newList.add(gridListData[i]);
          }
        }
      case 1:
        newList = gridListData;
      case 2:
        for (int i = 0; i < gridListData.length; i++) {
          if (gridListData[i].sold) {
            newList.add(gridListData[i]);
          }
        }
    }
    switch (sort_filter) {
      case "Recently Listed":
        newList.sort((a, b) {
          return a.date.compareTo(b.date);
        });
      case "Rank":
        newList.sort(
          (a, b) {
            return a.rank.compareTo(b.rank);
          },
        );
      case "Lowest Price":
        newList.sort(
          (a, b) {
            var priceA = double.parse(a.cryptoText);
            var priceB = double.parse(b.cryptoText);
            return priceA.compareTo(priceB);
          },
        );
      case "Highest Price":
        newList.sort(
          (a, b) {
            var priceA = double.parse(a.cryptoText);
            var priceB = double.parse(b.cryptoText);
            return -priceA.compareTo(priceB);
          },
        );
      case "Lowest Inscription":
        newList.sort(
          (a, b) {
            var inscriptionA = int.parse(a.nftMainName.substring(
                a.nftMainName.indexOf('#') + 1, (a.nftMainName.length)));
            var inscriptionB = int.parse(b.nftMainName.substring(
                b.nftMainName.indexOf('#') + 1, (b.nftMainName.length)));

            return inscriptionA.compareTo(inscriptionB);
          },
        );
      case "Highest Inscription":
        newList.sort(
          (a, b) {
            var inscriptionA = int.parse(a.nftMainName.substring(
                a.nftMainName.indexOf('#') + 1, (a.nftMainName.length)));
            var inscriptionB = int.parse(b.nftMainName.substring(
                b.nftMainName.indexOf('#') + 1, (b.nftMainName.length)));

            return -inscriptionA.compareTo(inscriptionB);
          },
        );
    }
    sortedGridList = newList;
  }

  handleProductClick(int id, BuildContext ctx) {
    setState(() {
      if (selected_products.contains(id)) {
        selected_products.remove(id);
      } else {
        selected_products.add(id);
      }
      if (selected_products.isEmpty) {
        showCartBottomSheet = false;
        if(sheetCtrler != null) {
          sheetCtrler!.close();
        }
        bottomSheet=null;
        setState((){});
      } else {
        showCartBottomSheet = true;

        bottomSheet = 
        SlidingUpPanel(
          color: Colors.transparent,
          boxShadow: [],
          maxHeight: 600,
          minHeight: 100,
          // initialChildSize: 0.2,
          // snapSizes: [0.2, 0.6],
          // shouldCloseOnMinExtent:  false,
          panel:Padding(
            padding:EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - AppTheme.columnWidth * 1.5)/2),
            child: CartSheet(
              selected_products: selected_products,
              sortedGridList: sortedGridList,
              onClear: (){
            
                                        setState(() {
                                          selected_products.clear();
                                          showCartBottomSheet = false;
                                        });
                                   
              },
              onDeleteItem: (i) {
                setState(() {
                Get.find<LoggerService>().i("about to delete item with id: ${sortedGridList[i].id}");
                selected_products.remove(i);
                if (selected_products.isEmpty) {
                  showCartBottomSheet = false;
                }
              });
              }
            ),
          )
        );
        setState((){});
      }
    });
  }

  Widget _buildHorizontalProductWithId(int id) {
    var gridIndex = sortedGridList.indexWhere((element) => element.id == id);
    var product = Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: NftProductHorizontal(
        cryptoImage: sortedGridList[gridIndex].cryptoImage,
        nftImage: sortedGridList[gridIndex].nftImage,
        nftMainName: sortedGridList[gridIndex].nftMainName,
        nftName: sortedGridList[gridIndex].nftName,
        cryptoText: sortedGridList[gridIndex].cryptoText,
        rank: sortedGridList[gridIndex].rank,
        columnMargin: sortedGridList[gridIndex].columnMargin,
      ),
    );
    return product;
  }

  

 Future<T?> _buildBuySlidingPanel<T>(BuildContext ctx) {
        return BitNetBottomSheet(
      context: ctx,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: ctx,
        appBar: bitnetAppBar(
          context: ctx,
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
                   margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppTheme.elementSpacing/2,
                        ),
                        _buildHorizontalProductWithId(item_buy),
                         SizedBox(
                          height: AppTheme.elementSpacing/2,
                        ),
                        BitNetListTile(
                          text: 'Subtotal',
                          trailing: Text('0.5'),
                        ),
                        BitNetListTile(
                          text: 'Network Fee',
                          trailing: Text('0.5'),
                        ),
                        BitNetListTile(
                          text: 'Market Fee',
                          trailing: Text('0.5'),
                        ),
                          BitNetListTile(
                          text: 'Total Price',
                          trailing: Text('0.5'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.cardPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       SizedBox(height: AppTheme.cardPadding,),
                        LongButtonWidget(
                          title: "Purchase",
                          onTap: () {
                        
                          },
              
                        ),
                        SizedBox(height: AppTheme.elementSpacing,),
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
      ),
    );
    // showGeneralDialog(
    //     barrierDismissible: true,
    //     barrierLabel: "buy_dialog",
    //     context: context,
    //     pageBuilder: (context, a1, a2) {
    //       return AlertDialog(
    //         insetPadding: EdgeInsets.zero,
    //         backgroundColor: Colors.transparent,
    //         content: Container(
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               color: AppTheme.colorBackground,
    //               border: Border.all(color: AppTheme.colorBitcoin, width: 2)),
    //           height: 600,
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text("Buy",
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .headlineMedium!
    //                         .copyWith(color: Colors.white)),
    //                 Divider(
    //                   color: AppTheme.colorBitcoin,
    //                   thickness: 2,
    //                 ),
    //                 _buildHorizontalProductWithId(item_buy),
    //                 Spacer(),
    //                 Container(
    //                   width: AppTheme.cardPadding * 10,
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             "Subtotal",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           ),
    //                           Text(
    //                             "0.024",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           )
    //                         ],
    //                       ),
    //                       SizedBox(height: 10),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             "Network Fee",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           ),
    //                           Text(
    //                             "0.024",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           )
    //                         ],
    //                       ),
    //                       SizedBox(height: 10),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             "Market Fee",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           ),
    //                           Text(
    //                             "0.024",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           )
    //                         ],
    //                       ),
    //                       SizedBox(height: 10),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             "Total Price",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           ),
    //                           Text(
    //                             "0.024",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyMedium!
    //                                 .copyWith(color: Colors.white),
    //                           )
    //                         ],
    //                       ),
    //                       SizedBox(height: 10),
    //                     ],
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 16.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       LongButtonWidget(
    //                         title: "Cancel",
    //                         onTap: () {
    //                           Navigator.pop(context);
    //                         },
    //                         buttonType: ButtonType.transparent,
    //                         customWidth: 15 * 10,
    //                         customHeight: 15 * 2.5,
    //                       ),
    //                       LongButtonWidget(
    //                         title: "Buy Now",
    //                         onTap: () {},
    //                         customWidth: 15 * 10,
    //                         customHeight: 15 * 2.5,
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }).whenComplete(() {
    //   setState(() {
    //     item_buy = -1;
    //   });
    // });
  }
}

class SortingCategoryPopup extends StatelessWidget {
  final Function(String str) onChanged;
  final String currentSortingCategory;
  const SortingCategoryPopup(
      {super.key,
      required this.onChanged,
      required this.currentSortingCategory});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        backgroundColor: Colors.transparent,
        context: context,
        direction: PopoverDirection.bottom,
        bodyBuilder: (context) {
          return _buildOptions(context);
        },
      ),
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.colorBitcoin,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Row(
              children: [
                Text(currentSortingCategory,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          )),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onChanged("Recently Listed");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Recently Listed",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Rank");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rank", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Lowest Price");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text("Lowest Price", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Highest Price");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Highest Price",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Lowest Inscription");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Lowest Inscription",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Highest Inscription");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Highest Inscription",
                    style: TextStyle(color: Colors.white)),
              )),
        )
      ],
    );
  }
}

class CartSheet extends StatefulWidget {
  const CartSheet({super.key, this.onClear, this.onDeleteItem, required this.selected_products, required this.sortedGridList});
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
        SizedBox(height: AppTheme.elementSpacing),
        Container(
          height: AppTheme.elementSpacing / 1.5,
          width: AppTheme.cardPadding * 2.25,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius:
                BorderRadius.circular(AppTheme.borderRadiusCircular),
          ),
        ),
        SizedBox(height: AppTheme.elementSpacing * 0.75),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Container(
              height: 600,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: bitnetScaffoldUnsafe(
                              context: context,
                              extendBodyBehindAppBar: true,
                                appBar: bitnetAppBar(context: context, text: "${L10n.of(context)!.cart}(${widget.selected_products.length})", actions: [
                                  TextButton(
                                              child: Text(L10n.of(context)!.clearAll,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(color: Colors.white)),
                                              onPressed: widget.onClear,
                                              
                                           
                                            ),],
                                            hasBackButton: false,),
                                body: Container(
                                  // decoration: BoxDecoration(
                                  //     color: AppTheme.colorBackground,
                                  //     borderRadius: BorderRadius.only(
                                  //         topLeft: Radius.circular(8),
                                  //         topRight: Radius.circular(8)),
                                  //     border:
                                  //         Border.all(color: AppTheme.colorBitcoin, width: 2)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 200.w,
                                        child: ListView.builder(
                                            itemCount: widget.selected_products.length,
                                            itemBuilder: (ctx, i){
                                              return Padding(

                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: HorizontalProduct(item: widget.sortedGridList.firstWhere((test) => test.id == widget.selected_products[i]),onDelete: (){
                                                  if(widget.onDeleteItem != null) {                                                  
                                                    widget.onDeleteItem!(widget.selected_products[i]);
                                                    setState((){});
                                                  }
                                                                                    
                                                                                    
                                                }),
                                              );
                                            }),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: AppTheme.cardPadding * 10,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Text(L10n.of(context)!.subTotal), Text("0.024")],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Text(L10n.of(context)!.networkFee), Text("0.024")],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Text(L10n.of(context)!.marketFee), Text("0.024")],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [Text(L10n.of(context)!.totalPrice), Text("0.024")],
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: LongButtonWidget(title: L10n.of(context)!.buyNow, onTap: () {}),
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



  class HorizontalProduct extends StatelessWidget {
  const HorizontalProduct({super.key, required this.item, this.onDelete});
  final GridListModal item;
  final Function()? onDelete;
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
        // () {
          
          // setState(() {
          //   selected_products.remove(id);
          //   if (selected_products.isEmpty) {
          //     showCartBottomSheet = false;
          //   }
          // });
        // },
      ),
    );
  }
}