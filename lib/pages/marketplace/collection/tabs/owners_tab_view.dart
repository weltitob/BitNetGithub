import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
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

          // Owners List
          Column(
            children: filteredOwners.asMap().entries.map((item) {
              int index = item.key + 1;
              Map<String, Object> owner = item.value;
              return Row(
                children: [
                  Text(
                    "$index",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: index == 1 ? AppTheme.colorBitcoin : null,
                          fontWeight:
                              index == 1 ? FontWeight.w800 : FontWeight.w500,
                          fontSize: index == 1
                              ? 30.sp
                              : index == 2
                                  ? 24.sp
                                  : index == 3
                                      ? 20.sp
                                      : 12.sp,
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GlassContainer(
                      opacity: 0.1,
                      width: MediaQuery.of(context).size.width * 0.77,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Owner avatar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                user1Image,
                                width: 50.w,
                                height: 50.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Owner details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    owner["name"].toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    owner["address"].toString(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            // Assets count
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${owner["assets"]} assets",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  owner["percentage"].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}
