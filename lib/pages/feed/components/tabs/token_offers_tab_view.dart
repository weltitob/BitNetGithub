import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  String _sortBy = 'default';

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
      List<Map<String, dynamic>> filtered;
      
      if (query.isEmpty) {
        filtered = List.from(widget.sellOffers);
      } else {
        filtered = widget.sellOffers.where((offer) {
          final seller = offer['seller'].toString().toLowerCase();
          final price = offer['price'].toString().toLowerCase();
          final amount = offer['amount'].toString().toLowerCase();
          
          return seller.contains(query) || 
                 price.contains(query) || 
                 amount.contains(query);
        }).toList();
      }
      
      // Apply sorting
      _sortOffers(filtered);
      _filteredOffers = filtered;
    });
  }
  
  void _sortOffers(List<Map<String, dynamic>> offers) {
    switch (_sortBy) {
      case 'price_low':
        offers.sort((a, b) {
          final priceA = double.tryParse(a['price'].toString().replaceAll(',', '')) ?? 0;
          final priceB = double.tryParse(b['price'].toString().replaceAll(',', '')) ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'price_high':
        offers.sort((a, b) {
          final priceA = double.tryParse(a['price'].toString().replaceAll(',', '')) ?? 0;
          final priceB = double.tryParse(b['price'].toString().replaceAll(',', '')) ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'amount_low':
        offers.sort((a, b) {
          final amountA = double.tryParse(a['amount'].toString()) ?? 0;
          final amountB = double.tryParse(b['amount'].toString()) ?? 0;
          return amountA.compareTo(amountB);
        });
        break;
      case 'amount_high':
        offers.sort((a, b) {
          final amountA = double.tryParse(a['amount'].toString()) ?? 0;
          final amountB = double.tryParse(b['amount'].toString()) ?? 0;
          return amountB.compareTo(amountA);
        });
        break;
      case 'rating_high':
        offers.sort((a, b) {
          final ratingA = a['rating'] ?? 0;
          final ratingB = b['rating'] ?? 0;
          return ratingB.compareTo(ratingA);
        });
        break;
    }
  }

  Widget _buildSearchBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      child: SearchFieldWidget(
        hintText: 'Search offers by seller, price, or amount...',
        isSearchEnabled: true,
        handleSearch: (value) {
          _filterOffers();
        },
        onChanged: (value) {
          _searchController.text = value;
          _filterOffers();
        },
        suffixIcon: IconButton(
          icon: Icon(
            FontAwesomeIcons.filter,
            color: isDark ? AppTheme.white60 : AppTheme.black60,
            size: AppTheme.cardPadding * 0.75,
          ),
          onPressed: () {
            _showFilterBottomSheet();
          },
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.borderRadiusBig.r),
          topRight: Radius.circular(AppTheme.borderRadiusBig.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(AppTheme.cardPadding.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: AppTheme.cardPadding.h),
              Text(
                'Filter Offers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppTheme.cardPadding.h),
              
              // Filter options
              Text(
                'Sort by',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppTheme.elementSpacing.h),
              
              ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Price: Low to High'),
                trailing: _sortBy == 'price_low' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _sortBy = 'price_low';
                    _filterOffers();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Price: High to Low'),
                trailing: _sortBy == 'price_high' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _sortBy = 'price_high';
                    _filterOffers();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory_2),
                title: Text('Amount: Low to High'),
                trailing: _sortBy == 'amount_low' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _sortBy = 'amount_low';
                    _filterOffers();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory_2),
                title: Text('Amount: High to Low'),
                trailing: _sortBy == 'amount_high' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _sortBy = 'amount_high';
                    _filterOffers();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Rating: High to Low'),
                trailing: _sortBy == 'rating_high' ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                onTap: () {
                  setState(() {
                    _sortBy = 'rating_high';
                    _filterOffers();
                  });
                  Navigator.pop(context);
                },
              ),
              
              SizedBox(height: AppTheme.cardPadding.h),
            ],
          ),
        );
      },
    );
  }
}