import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TokenOrdersTabView extends StatefulWidget {
  final String tokenSymbol;
  final List<Map<String, dynamic>> buyOffers;

  const TokenOrdersTabView({
    Key? key,
    required this.tokenSymbol,
    required this.buyOffers,
  }) : super(key: key);

  @override
  State<TokenOrdersTabView> createState() => _TokenOrdersTabViewState();
}

class _TokenOrdersTabViewState extends State<TokenOrdersTabView> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _filteredOrders = widget.buyOffers;
    _searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredOrders = widget.buyOffers;
      } else {
        _filteredOrders = widget.buyOffers.where((order) {
          final buyer = order['buyer'].toString().toLowerCase();
          final price = order['price'].toString().toLowerCase();
          final amount = order['amount'].toString().toLowerCase();
          
          return buyer.contains(query) || 
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
            hintText: 'Search orders by buyer, price, or amount...',
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

  Widget _buildOrderTile(Map<String, dynamic> order) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding.w,
          vertical: AppTheme.elementSpacing.h * 0.5,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          child: Text(
            order['buyer'][0],
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
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
                    order['buyer'],
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
                        '${order['rating']} (${order['trades']} trades)',
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
                  '${order['amount']} ${widget.tokenSymbol}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '\$${order['price']} each',
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
                  'Buying: ${order['amount']} ${widget.tokenSymbol}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              LongButtonWidget(
                buttonType: ButtonType.transparent,
                title: 'Sell',
                customHeight: 32.h,
                customWidth: 80.w,
                onTap: () {
                  _showSellDialog(order);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSellDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sell ${widget.tokenSymbol}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buyer: ${order['buyer']}'),
            Text('Amount: ${order['amount']} ${widget.tokenSymbol}'),
            Text('Price per token: \$${order['price']}'),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Are you sure you want to sell this amount?',
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
                'Sell order initiated with ${order['buyer']}',
                color: AppTheme.successColor,
              );
            },
            child: const Text('Sell'),
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
              '${_filteredOrders.length} orders found',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ),
        
        SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.elementSpacing.h),
        ),
        
        // Orders list
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: GlassContainer(
              child: _filteredOrders.isEmpty
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
                              'No orders found',
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
                      children: _filteredOrders
                          .map<Widget>((order) => _buildOrderTile(order))
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