import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnersTabView extends StatelessWidget {
  const OwnersTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ownersData = [
      {"name": "User1", "address": "bc1q...3x9f", "assets": 42, "percentage": "4.2%"},
      {"name": "User2", "address": "bc1q...7t2g", "assets": 38, "percentage": "3.8%"},
      {"name": "User3", "address": "bc1q...5k1h", "assets": 27, "percentage": "2.7%"},
      {"name": "User4", "address": "bc1q...9j4d", "assets": 19, "percentage": "1.9%"},
      {"name": "User5", "address": "bc1q...2m7s", "assets": 15, "percentage": "1.5%"},
      {"name": "User6", "address": "bc1q...6f3a", "assets": 12, "percentage": "1.2%"},
      {"name": "User7", "address": "bc1q...8n2v", "assets": 10, "percentage": "1.0%"},
      {"name": "User8", "address": "bc1q...1p4c", "assets": 8, "percentage": "0.8%"},
    ];
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Top Owners",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Owners List
          Column(
            children: ownersData.map((owner) {
              return GlassContainer(
                opacity: 0.1,
                width: double.infinity,
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
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              owner["address"].toString(),
                              style: Theme.of(context).textTheme.bodySmall,
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
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 4),
                          Text(
                            owner["percentage"].toString(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppTheme.colorBitcoin,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}