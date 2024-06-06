import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    return controller.searchResultsFuture == null
        ? dotProgress(context)
        : GetBuilder<FeedController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppTheme.cardPadding,
                  right: AppTheme.cardPadding,
                  top: AppTheme.elementSpacing),
              child: ListView(
                shrinkWrap: true,
                children: controller.searchresults,
              ),
            );
          });
  }
}
