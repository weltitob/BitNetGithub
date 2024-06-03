import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    return Obx(
      ()=> FutureBuilder(
        future: controller.searchResultsFuture?.value,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return dotProgress(context);
          }
          List<UserSearchResult> searchresults = [];
          snapshot.data!.docs.forEach((doc) {
            UserData user = UserData.fromDocument(doc); 
            UserSearchResult searchResult = UserSearchResult(
              onTap: () async {},
              userData: user,
            );
            searchresults.add(searchResult);
          });
          if (searchresults.isEmpty) {
            return Center(
              child: Text(L10n.of(context)!.noUsersFound),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppTheme.cardPadding,
                  right: AppTheme.cardPadding,
                  top: AppTheme.elementSpacing),
              child: ListView(
                children: searchresults,
              ),
            );
          }
        },
      ),
    );
  }
}
