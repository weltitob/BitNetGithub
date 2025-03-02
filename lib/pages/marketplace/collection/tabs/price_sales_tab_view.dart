import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceSalesTabView extends StatelessWidget {
  const PriceSalesTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Statistics
          Text(
            "Price Statistics",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Statistics Cards
          _buildStatisticsCard(context),
          SizedBox(height: 24.h),
          
          // Recent Sales
          Text(
            "Recent Sales",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Sales List
          _buildRecentSalesList(context),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context) {
    return GlassContainer(
      opacity: 0.1,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow(context, "Floor Price", "0.025 BTC"),
            Divider(height: 24),
            _buildStatRow(context, "24h Volume", "0.021 BTC"),
            Divider(height: 24),
            _buildStatRow(context, "Total Volume", "1.0235 BTC"),
            Divider(height: 24),
            _buildStatRow(context, "Listed", "52"),
            Divider(height: 24),
            _buildStatRow(context, "Supply", "1000"),
            Divider(height: 24),
            _buildStatRow(context, "Owners", "250"),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppTheme.colorBitcoin,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
  
  Widget _buildRecentSalesList(BuildContext context) {
    final salesData = [
      {"id": "#2390", "price": "0.024 BTC", "date": "2 hours ago", "from": "User1", "to": "User2"},
      {"id": "#1872", "price": "0.031 BTC", "date": "5 hours ago", "from": "User3", "to": "User4"},
      {"id": "#2103", "price": "0.018 BTC", "date": "1 day ago", "from": "User5", "to": "User6"},
      {"id": "#1945", "price": "0.027 BTC", "date": "2 days ago", "from": "User7", "to": "User8"},
      {"id": "#2287", "price": "0.022 BTC", "date": "3 days ago", "from": "User9", "to": "User10"},
    ];
    
    return Column(
      children: salesData.map((sale) {
        return GlassContainer(
          opacity: 0.1,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // Asset image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    nftImage1,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                // Sale details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Inscription ${sale["id"]}",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${sale["from"]} → ${sale["to"]}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                // Price and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      sale["price"].toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppTheme.colorBitcoin,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      sale["date"].toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}