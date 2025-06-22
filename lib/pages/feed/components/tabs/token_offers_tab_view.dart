import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TokenOffersTabView extends StatefulWidget {
  final String tokenSymbol;
  final List<Map<String, dynamic>> sellOffers;

  const TokenOffersTabView({
    Key? key,
    required this.tokenSymbol,
    required this.sellOffers,
  }) : super(key: key);

  @override
  State<TokenOffersTabView> createState() => _TokenOffersTabViewState();
}

class _TokenOffersTabViewState extends State<TokenOffersTabView> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredOffers = [];

  @override
  void initState() {
    super.initState();
    _filteredOffers = widget.sellOffers;
    _searchController.addListener(_filterOffers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOffers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredOffers = widget.sellOffers;
      } else {
        _filteredOffers = widget.sellOffers.where((offer) {
          final seller = offer['seller'].toString().toLowerCase();
          final price = offer['price'].toString().toLowerCase();
          final amount = offer['amount'].toString().toLowerCase();
          
          return seller.contains(query) || 
                 price.contains(query) || 
                 amount.contains(query);
        }).toList();
      }
    });
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search offers by seller, price, or amount...',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing.w,
              vertical: AppTheme.elementSpacing.h,
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildOfferTile(Map<String, dynamic> offer) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding.w,
          vertical: AppTheme.elementSpacing.h * 0.5,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Text(
            offer['seller'][0],
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['seller'],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: AppTheme.colorBitcoin,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${offer['rating']} (${offer['trades']} trades)',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${offer['amount']} ${widget.tokenSymbol}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '\$${offer['price']} each',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: AppTheme.elementSpacing.h * 0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Available: ${offer['amount']} ${widget.tokenSymbol}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.successColor,
                  ),
                ),
              ),
              LongButtonWidget(
                buttonType: ButtonType.solid,
                title: 'Buy',
                customHeight: 32.h,
                customWidth: 80.w,
                onTap: () {
                  _showBuyDialog(offer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuyDialog(Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Buy ${widget.tokenSymbol}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seller: ${offer['seller']}'),
            Text('Amount: ${offer['amount']} ${widget.tokenSymbol}'),
            Text('Price per token: \$${offer['price']}'),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Are you sure you want to buy this amount?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.find<OverlayController>().showOverlay(
                'Buy order initiated with ${offer['seller']}',
                color: AppTheme.successColor,
              );
            },
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing.h),
            child: _buildSearchBar(),
          ),
        ),
        
        // Results count
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: Text(
              '${_filteredOffers.length} offers found',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ),
        
        SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.elementSpacing.h),
        ),
        
        // Offers list
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: GlassContainer(
              child: _filteredOffers.isEmpty
                  ? Container(
                      padding: EdgeInsets.all(AppTheme.cardPadding.w),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48.sp,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                            ),
                            SizedBox(height: AppTheme.elementSpacing.h),
                            Text(
                              'No offers found',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              'Try adjusting your search terms',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: _filteredOffers
                          .map<Widget>((offer) => _buildOfferTile(offer))
                          .toList(),
                    ),
            ),
          ),
        ),
        
        // Bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.cardPadding.h * 2),
        ),
      ],
    );
  }
}