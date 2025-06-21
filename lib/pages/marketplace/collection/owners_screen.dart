import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OwnersScreen extends StatefulWidget {
  final String? collectionName;

  const OwnersScreen({
    Key? key,
    this.collectionName,
  }) : super(key: key);

  @override
  State<OwnersScreen> createState() => _OwnersScreenState();
}

class _OwnersScreenState extends State<OwnersScreen> {
  String _searchQuery = '';
  List<OwnerModel> _owners = [];
  List<OwnerModel> _filteredOwners = [];

  @override
  void initState() {
    super.initState();
    _loadMockOwners();
    _filteredOwners = _owners;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadMockOwners() {
    // Mock data for demonstration
    _owners = [
      OwnerModel(
        address: '1A1zP1e...aMGHmknpX',
        username: 'satoshi_nakamoto',
        itemsOwned: 1200,
        totalValue: '12.5 BTC',
        isVerified: true,
      ),
      OwnerModel(
        address: '1BvBMS...3J3RQborc',
        username: 'punk_collector',
        itemsOwned: 850,
        totalValue: '8.2 BTC',
        isVerified: true,
      ),
      OwnerModel(
        address: '1HLoD9...iqhzqtX5H',
        username: 'ordinal_maxi',
        itemsOwned: 642,
        totalValue: '6.1 BTC',
        isVerified: false,
      ),
      OwnerModel(
        address: '12c6DS...Qj7VWXl2R',
        username: 'bitcoin_whale',
        itemsOwned: 521,
        totalValue: '5.8 BTC',
        isVerified: true,
      ),
      OwnerModel(
        address: '1F1tAa...8WUvhW9oK',
        username: 'nft_enthusiast',
        itemsOwned: 387,
        totalValue: '4.2 BTC',
        isVerified: false,
      ),
      OwnerModel(
        address: '1Dorian...SSgqyKP5L',
        username: 'crypto_artist',
        itemsOwned: 256,
        totalValue: '3.1 BTC',
        isVerified: true,
      ),
      OwnerModel(
        address: '1JwSS...8BEHhABfY',
        username: 'hodler_supreme',
        itemsOwned: 198,
        totalValue: '2.4 BTC',
        isVerified: false,
      ),
      OwnerModel(
        address: '1Nd4T...k7VKqyRzs',
        username: 'punk_trader',
        itemsOwned: 134,
        totalValue: '1.8 BTC',
        isVerified: false,
      ),
    ];
  }

  void _filterOwners(String query) {
    _searchQuery = query;
    setState(() {
      _filteredOwners = _owners.where((owner) {
        return owner.username.toLowerCase().contains(query.toLowerCase()) ||
               owner.address.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: '${widget.collectionName ?? "Collection"} Holders',
        onTap: () => context.pop(),
      ),
      body: Column(
        children: [
          // Search Section
          Padding(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Holders',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.elementSpacing.h),
                SearchFieldWidget(
                  hintText: 'Search by username or address...',
                  isSearchEnabled: true,
                  handleSearch: (value) => _filterOwners(value),
                  onChanged: (value) => _filterOwners(value),
                ),
              ],
            ),
          ),
          
          // Owners List
          Expanded(
            child: _filteredOwners.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    itemCount: _filteredOwners.length,
                    itemBuilder: (context, index) {
                      final owner = _filteredOwners[index];
                      return _buildOwnerTile(owner, index + 1);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerTile(OwnerModel owner, int rank) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      child: GlassContainer(
        boxShadow: Theme.of(context).brightness == Brightness.dark ? [] : null,
        child: Padding(
          padding: EdgeInsets.all(AppTheme.cardPaddingSmall.w),
          child: Row(
            children: [
              // Rank
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: rank <= 3 
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                ),
                child: Center(
                  child: Text(
                    '#$rank',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: rank <= 3 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: AppTheme.elementSpacing.w),
              
              // Avatar
              Avatar(
                profileId: owner.address,
                name: owner.username,
                size: 44.w,
                type: profilePictureType.none,
              ),
              
              SizedBox(width: AppTheme.elementSpacing.w),
              
              // Owner Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            owner.username,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (owner.isVerified) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.verified,
                            size: 16.w,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      owner.address,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: AppTheme.elementSpacing.w),
              
              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${owner.itemsOwned} items',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    owner.totalValue,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.w,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'No holders found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h / 2),
            Text(
              'Try adjusting your search terms',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerModel {
  final String address;
  final String username;
  final int itemsOwned;
  final String totalValue;
  final bool isVerified;

  OwnerModel({
    required this.address,
    required this.username,
    required this.itemsOwned,
    required this.totalValue,
    required this.isVerified,
  });
}