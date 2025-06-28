import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/number_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // Mock data from original owners tab
    _owners = [
      OwnerModel(
        name: "User1",
        address: "bc1q...3x9f",
        assets: 42,
        percentage: "4.2%",
      ),
      OwnerModel(
        name: "User2",
        address: "bc1q...7t2g",
        assets: 38,
        percentage: "3.8%",
      ),
      OwnerModel(
        name: "User3",
        address: "bc1q...5k1h",
        assets: 27,
        percentage: "2.7%",
      ),
      OwnerModel(
        name: "User4",
        address: "bc1q...9j4d",
        assets: 19,
        percentage: "1.9%",
      ),
      OwnerModel(
        name: "User5",
        address: "bc1q...2m7s",
        assets: 15,
        percentage: "1.5%",
      ),
      OwnerModel(
        name: "User6",
        address: "bc1q...6f3a",
        assets: 12,
        percentage: "1.2%",
      ),
      OwnerModel(
        name: "User7",
        address: "bc1q...8n2v",
        assets: 10,
        percentage: "1.0%",
      ),
      OwnerModel(
        name: "User8",
        address: "bc1q...1p4c",
        assets: 8,
        percentage: "0.8%",
      ),
    ];
  }

  void _filterOwners(String query) {
    _searchQuery = query;
    setState(() {
      if (query.isEmpty) {
        _filteredOwners = _owners;
      } else {
        final queryLower = query.toLowerCase();
        _filteredOwners = _owners.where((owner) {
          return owner.name.toLowerCase().contains(queryLower) ||
              owner.address.toLowerCase().contains(queryLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: '${widget.collectionName ?? "Collection"} Holders',
        onTap: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding.w,
            vertical: AppTheme.cardPadding.h),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Top Owners",
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            SizedBox(height: 12.h),

            // Search Bar
            SearchFieldWidget(
              hintText: "Search owners...",
              isSearchEnabled: true,
              handleSearch: (value) {
                // Handle search submission
              },
              onChanged: (value) => _filterOwners(value),
            ),
            SizedBox(height: 16.h),

            // No Results Message
            if (_filteredOwners.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Text(
                    "No owners found matching your search",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),

            // Owners List with GlassContainer wrapper for consistency
            if (_filteredOwners.isNotEmpty)
              Expanded(
                child: GlassContainer(
                  child: ListView.builder(
                    itemCount: _filteredOwners.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final owner = _filteredOwners[index];
                      final displayNumber = index + 1;

                      return BitNetListTile(
                        margin: EdgeInsets.zero,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPaddingSmall,
                          vertical: AppTheme.elementSpacing,
                        ),
                        leading: Avatar(
                          profileId: owner.name.toLowerCase(),
                          name: owner.name,
                          size: 48.w,
                          type: profilePictureType.onchain,
                          cornerWidget: displayNumber <= 3
                              ? NumberIndicator(
                                  number: displayNumber,
                                  size: 0.8,
                                )
                              : null,
                          onTap: () {
                            // Handle owner profile tap
                          },
                        ),
                        customTitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              owner.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              owner.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppTheme.white60
                                        : AppTheme.black60,
                                  ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${owner.assets} assets",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              owner.percentage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // Handle owner tap - navigate to owner detail
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OwnerModel {
  final String name;
  final String address;
  final int assets;
  final String percentage;

  OwnerModel({
    required this.name,
    required this.address,
    required this.assets,
    required this.percentage,
  });
}
