import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  // Mock data for demonstration
  static List<UserData> getMockUsers(String category) {
    // Base list of mock users
    final List<Map<String, String>> mockData = [
      {
        'username': 'satoshi',
        'did': 'did:key:z6MknKdJ',
        'profileImageUrl':
            'https://img.freepik.com/premium-vector/bitcoin-technology-logo-template_79169-137.jpg'
      },
      {
        'username': 'vitalik',
        'did': 'did:key:z6MknLmK',
        'profileImageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/1/1c/Vitalik_Buterin_TechCrunch_London_2015_%28cropped%29.jpg'
      },
      {
        'username': 'nakamoto',
        'did': 'did:key:z6MknOpQ',
        'profileImageUrl':
            'https://miro.medium.com/v2/resize:fit:1400/1*LFOnoZXCIEDAifD_7KyGkQ.jpeg'
      },
      {
        'username': 'andreas',
        'did': 'did:key:z6MknRsT',
        'profileImageUrl':
            'https://bitcoinmagazine.com/.image/t_share/MTc5Mjk3ODEyMDcyNzU3Mjgy/interview-andreas-m-antonopoulos-how-bitcoin-can-help-financially-excluded-communities.jpg'
      },
      {
        'username': 'hal_finney',
        'did': 'did:key:z6MknXyZ',
        'profileImageUrl':
            'https://static01.nyt.com/images/2022/02/25/business/00roose-finney-print1/merlin_202999180_46ec97d9-25ff-43db-b1e9-f1f8dd3028b0-superJumbo.jpg'
      },
      {
        'username': 'adamback',
        'did': 'did:key:z6MknAaB',
        'profileImageUrl':
            'https://pbs.twimg.com/profile_images/1654127645837729792/ggwwwcIb_400x400.jpg'
      },
      {
        'username': 'elon_btc',
        'did': 'did:key:z6MknCcD',
        'profileImageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/9/99/Elon_Musk_Colorado_2022_%28cropped%29.jpg'
      },
      {
        'username': 'gavin_wood',
        'did': 'did:key:z6MknEeF',
        'profileImageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/8/83/Gavin_Wood.jpg'
      },
      {
        'username': 'btc_trader',
        'did': 'did:key:z6MknGgH',
        'profileImageUrl':
            'https://png.pngtree.com/png-vector/20191027/ourmid/pngtree-crypto-trader-icon-simple-style-png-image_1886630.jpg'
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

  Widget _buildUserCarouselItem(UserData userData, int? rank, BuildContext context) {
    Widget? rankBadge;
    
    if (rank != null) {
      Color badgeColor;
      Color textColor = Colors.white;
      
      // Determine badge color based on rank
      if (rank == 1) {
        badgeColor = Color(0xFFFFD700); // Gold
      } else if (rank == 2) {
        badgeColor = Color(0xFFC0C0C0); // Silver
      } else if (rank == 3) {
        badgeColor = Color(0xFFCD7F32); // Bronze
      } else {
        badgeColor = Colors.grey.shade700;
        textColor = Colors.white70;
      }
      
      rankBadge = Container(
        width: AppTheme.cardPadding * 0.9,
        height: AppTheme.cardPadding * 0.9,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            rank.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return GlassContainer(
      borderRadius: BorderRadius.circular(AppTheme.cardPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: InkWell(
          onTap: () async {},
          borderRadius: BorderRadius.circular(AppTheme.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar in the center
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Center(
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      onTap: () async {},
                      mxContent: userData.profileImageUrl,
                      name: userData.username,
                      profileId: userData.did,
                      isNft: false,
                    ),
                  ),
                  if (rankBadge != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Transform.scale(
                        scale: 1.4,
                        child: rankBadge,
                      ),
                    ),
                ],
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
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
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
    );
  }

  Widget _buildFeaturedPeopleCarousel(List<UserData> users, BuildContext context) {
    if (users.isEmpty) {
      return SizedBox();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carousel without any title/header
        SizedBox(
          height: 320,
          child: Padding(
            // Use padding with negative values to extend beyond the parent container
            padding: EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                height: 320,
                autoPlayInterval: Duration(seconds: 5),
                // Disable padding at the ends of the carousel
                padEnds: false,
              ),
              itemCount: users.length,
              itemBuilder: (context, index, realIndex) {
                return _buildUserCarouselItem(
                  users[index],
                  null,
                  context,
                );
              },
            ),
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
          padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
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
                  users[index], 
                  showRanking ? index + 1 : null);
              }),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing),
      ],
    );
  }
  
  Widget _buildUserItem(UserData userData, [int? rank]) {
    Widget? rankBadge;
    
    if (rank != null) {
      Color badgeColor;
      Color textColor = Colors.white;
      
      // Determine badge color based on rank
      if (rank == 1) {
        badgeColor = Color(0xFFFFD700); // Gold
      } else if (rank == 2) {
        badgeColor = Color(0xFFC0C0C0); // Silver
      } else if (rank == 3) {
        badgeColor = Color(0xFFCD7F32); // Bronze
      } else {
        badgeColor = Colors.grey.shade700;
        textColor = Colors.white70;
      }
      
      rankBadge = Container(
        width: AppTheme.cardPadding * 0.9,
        height: AppTheme.cardPadding * 0.9,
        decoration: BoxDecoration(
          color: badgeColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            rank.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.elementSpacing * 0.75,
        horizontal: AppTheme.elementSpacing,
      ),
      child: InkWell(
        onTap: () async {},
        borderRadius: AppTheme.cardRadiusBig,
        child: Row(
          children: [
            Stack(
              children: [
                Avatar(
                  size: AppTheme.cardPadding * 2,
                  onTap: () async {},
                  mxContent: userData.profileImageUrl,
                  name: userData.username,
                  profileId: userData.did,
                  isNft: false,
                  cornerWidget: rankBadge,
                ),
              ],
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

    // Create mock data for each category
    final featuredPeople = getMockUsers('featured');
    final recentContacts = getMockUsers('recent');
    final hypedPeople = getMockUsers('hyped');
    final topBuyers = getMockUsers('buyers');
    final topSellers = getMockUsers('sellers');

    return controller.searchResultsFuture == null
        ? dotProgress(context)
        : GetBuilder<FeedController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(

                  top: AppTheme.elementSpacing),
              child: ListView(
                // Remove the padding from ListView to allow the carousel to extend full width
                padding: EdgeInsets.zero,
                children: [
                  // Featured people carousel at the top
                  _buildFeaturedPeopleCarousel(featuredPeople, context),
                  
                  // Regular sections below
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                    child: Column(
                      children: [
                        _buildContactSection(
                          title: 'Recent Contacts',
                          users: recentContacts,
                          context: context,
                          showViewAll: true,
                        ),
                        _buildContactSection(
                          title: 'Hyped People',
                          users: hypedPeople,
                          context: context,
                          showViewAll: true,
                          showRanking: true,
                        ),
                        _buildContactSection(
                          title: 'Top Buyers',
                          users: topBuyers,
                          context: context,
                          showViewAll: true,
                          showRanking: true,
                        ),
                        _buildContactSection(
                          title: 'Top Sellers',
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
            );
          });
  }
}