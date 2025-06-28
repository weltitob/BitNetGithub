import 'package:bitnet/backbone/helper/theme/theme.dart';

import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/number_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnersTabView extends StatefulWidget {
  const OwnersTabView({Key? key}) : super(key: key);

  @override
  State<OwnersTabView> createState() => _OwnersTabViewState();
}

class _OwnersTabViewState extends State<OwnersTabView> {
  String searchQuery = '';

  final ownersData = [
    {
      "name": "User1",
      "address": "bc1q...3x9f",
      "assets": 42,
      "percentage": "4.2%"
    },
    {
      "name": "User2",
      "address": "bc1q...7t2g",
      "assets": 38,
      "percentage": "3.8%"
    },
    {
      "name": "User3",
      "address": "bc1q...5k1h",
      "assets": 27,
      "percentage": "2.7%"
    },
    {
      "name": "User4",
      "address": "bc1q...9j4d",
      "assets": 19,
      "percentage": "1.9%"
    },
    {
      "name": "User5",
      "address": "bc1q...2m7s",
      "assets": 15,
      "percentage": "1.5%"
    },
    {
      "name": "User6",
      "address": "bc1q...6f3a",
      "assets": 12,
      "percentage": "1.2%"
    },
    {
      "name": "User7",
      "address": "bc1q...8n2v",
      "assets": 10,
      "percentage": "1.0%"
    },
    {
      "name": "User8",
      "address": "bc1q...1p4c",
      "assets": 8,
      "percentage": "0.8%"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter owners based on search query
    final filteredOwners = ownersData.where((owner) {
      if (searchQuery.isEmpty) return true;

      final query = searchQuery.toLowerCase();
      return owner["name"]!.toString().contains(query) ||
          owner["address"]!.toString().contains(query);
    }).toList();

    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding.w, vertical: AppTheme.cardPadding.h),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Top Owners", style: Theme.of(context).textTheme.titleLarge),
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
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16.h),

          // No Results Message
          if (filteredOwners.isEmpty)
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
          GlassContainer(
            child: Column(
              children: filteredOwners.asMap().entries.map((item) {
                int index = item.key;
                int displayNumber = index + 1;
                Map<String, Object> owner = item.value;

                return BitNetListTile(
                  margin: EdgeInsets.zero,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPaddingSmall,
                    vertical: AppTheme.elementSpacing,
                  ),
                  leading: Avatar(
                    profileId: owner["name"].toString().toLowerCase(),
                    name: owner["name"].toString(),
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
                        owner["name"].toString(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        owner["address"].toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                        "${owner["assets"]} assets",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        owner["percentage"].toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Handle owner tap - navigate to owner detail
                  },
                );
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
