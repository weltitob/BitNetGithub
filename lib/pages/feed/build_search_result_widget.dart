import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/items/number_indicator.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  // Mock data for demonstration
  static List<UserData> getMockUsers(String category) {
    // Base list of mock users with working placeholder images
    final List<Map<String, String>> mockData = [
      {
        'username': 'satoshi',
        'did': 'did:key:z6MknKdJ',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'vitalik',
        'did': 'did:key:z6MknLmK',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'nakamoto',
        'did': 'did:key:z6MknOpQ',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'andreas',
        'did': 'did:key:z6MknRsT',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'hal_finney',
        'did': 'did:key:z6MknXyZ',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'adamback',
        'did': 'did:key:z6MknAaB',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'elon_btc',
        'did': 'did:key:z6MknCcD',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'gavin_wood',
        'did': 'did:key:z6MknEeF',
        'profileImageUrl': '' // Will use fallback avatar
      },
      {
        'username': 'btc_trader',
        'did': 'did:key:z6MknGgH',
        'profileImageUrl': '' // Will use fallback avatar
      },
    ];

    // Shuffle the list to get different users for each category
    final shuffled = List.of(mockData)..shuffle();
    return shuffled
        .take(3)
        .map((data) => UserData(
              username: '${data['username']}_$category',
              did: data['did'] ?? '',
              profileImageUrl: data['profileImageUrl'] ?? '',
              backgroundImageUrl: 'https://example.com/background.jpg',
              isPrivate: false,
              showFollowers: true,
              displayName: '${data['username']} Display',
              bio: 'This is the bio of ${data['username']}',
              customToken: 'customToken123',
              setupWordRecovery: true,
              updatedAt: Timestamp.fromMicrosecondsSinceEpoch(233),
              createdAt: Timestamp.fromMicrosecondsSinceEpoch(233),
              setupQrCodeRecovery: true,
              isActive: true,
              dob: 2,
            ))
        .toList();
  }

  Widget _buildUserCarouselItem(
      UserData userData, int? rank, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: getStandardizedCardMargin().w),
      child: GlassContainer(
        width: getStandardizedCardWidth().w,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
        opacity: isDarkMode ? 0.15 : 0.05,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: InkWell(
            onTap: () async {},
            borderRadius: BorderRadius.circular(AppTheme.cardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar in the center
                Center(
                  child: Avatar(
                    size: AppTheme.cardPadding * 4,
                    onTap: () async {},
                    mxContent: userData.profileImageUrl,
                    name: userData.username,
                    profileId: userData.did,
                    isNft: false,
                    cornerWidget: rank != null
                        ? NumberIndicator(
                            number: rank,
                            size: 0.8,
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: AppTheme.elementSpacing),

                // Username
                Text(
                  "@${userData.username}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: AppTheme.elementSpacing / 2),

                // Display name
                Text(
                  userData.displayName,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: AppTheme.elementSpacing),

                // Bio
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing),
                  child: Text(
                    userData.bio,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedPeopleCarousel(
      List<UserData> users, BuildContext context) {
    if (users.isEmpty) {
      return SizedBox();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Consistent spacing at the top
        SizedBox(height: AppTheme.cardPadding * 1.5.h),
        // Carousel without any title/header
        Container(
          width: screenWidth,
          height: 300.h, // Use ScreenUtil for consistent sizing
          child: CarouselSlider.builder(
            options: getStandardizedCarouselOptions(autoPlayIntervalSeconds: 5),
            itemCount: users.length,
            itemBuilder: (context, index, realIndex) {
              return _buildUserCarouselItem(
                users[index],
                index + 1, // Add ranks to the featured profiles
                context,
              );
            },
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing),
      ],
    );
  }

  Widget _buildContactSection({
    required String title,
    required List<UserData> users,
    required BuildContext context,
    required bool showViewAll,
    bool showRanking = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              RoundedButtonWidget(
                size: AppTheme.cardPadding * 1.25,
                buttonType: ButtonType.transparent,
                iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
                onTap: () {
                  // Handle view all
                },
                iconData: Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
        ),
        GlassContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.elementSpacing * 0.5,
            ),
            child: Column(
              children: List.generate(users.length, (index) {
                return _buildUserItem(
                    users[index], showRanking ? index + 1 : null);
              }),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing),
      ],
    );
  }

  Widget _buildUserItem(UserData userData, [int? rank]) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.elementSpacing * 0.75,
        horizontal: AppTheme.elementSpacing,
      ),
      child: InkWell(
        onTap: () async {},
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusBig),
        child: Row(
          children: [
            Avatar(
              size: AppTheme.cardPadding * 2,
              onTap: () async {},
              mxContent: userData.profileImageUrl,
              name: userData.username,
              profileId: userData.did,
              isNft: false,
              cornerWidget: rank != null
                  ? NumberIndicator(
                      number: rank,
                      size: 0.8,
                    )
                  : null,
            ),
            const SizedBox(width: AppTheme.elementSpacing),
            Container(
              width: AppTheme.cardPadding * 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "@${userData.username}",
                    style: Theme.of(Get.context!).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.elementSpacing / 4),
                  Text(
                    userData.displayName,
                    style: Theme.of(Get.context!).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    // Check if search is active (if controller.searchresults has filtered results)
    final bool isSearchActive = controller.searchresults.isNotEmpty &&
        controller.searchresults.length != controller.searchresultsMain.length;

    // Create mock data for category display when not searching
    final featuredPeople = getMockUsers('featured');
    final recentContacts = getMockUsers('recent');
    final hypedPeople = getMockUsers('hyped');
    final topBuyers = getMockUsers('buyers');
    final topSellers = getMockUsers('sellers');

    return controller.searchResultsFuture == null
        ? dotProgress(context)
        : GetBuilder<FeedController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
              child: isSearchActive
                  // Show search results when active
                  ? ListView.builder(
                      itemCount: controller.searchresults.length,
                      itemBuilder: (context, index) {
                        return controller.searchresults[index];
                      },
                    )
                  // Show normal UI when not searching
                  : VerticalFadeListView.standardTab(
                      child: ListView(
                        // Remove the padding from ListView to allow the carousel to extend full width
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          // Featured people carousel at the top
                          _buildFeaturedPeopleCarousel(featuredPeople, context),

                          // Regular sections below
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.cardPadding.w),
                            child: Column(
                              children: [
                                _buildContactSection(
                                  title: '🔄 Recent Contacts',
                                  users: recentContacts,
                                  context: context,
                                  showViewAll: true,
                                ),
                                _buildContactSection(
                                  title: '🌟 Hyped People',
                                  users: hypedPeople,
                                  context: context,
                                  showViewAll: true,
                                  showRanking: true,
                                ),
                                _buildContactSection(
                                  title: '💎 Top Buyers',
                                  users: topBuyers,
                                  context: context,
                                  showViewAll: true,
                                  showRanking: true,
                                ),
                                _buildContactSection(
                                  title: '💼 Top Sellers',
                                  users: topSellers,
                                  context: context,
                                  showViewAll: true,
                                  showRanking: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          });
  }
}
