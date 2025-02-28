import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
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

  Widget _buildContactSection({
    required String title,
    required List<UserData> users,
    required BuildContext context,
    required bool showViewAll,
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (showViewAll)
                TextButton(
                  onPressed: () {
                    // Handle view all
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: AppTheme.colorBitcoin,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        GlassContainer(
          child: Column(
            children: users
                .map((user) => _buildUserItem(user))
                .toList(),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing),
      ],
    );
  }
  
  Widget _buildUserItem(UserData userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.elementSpacing / 2,
        horizontal: AppTheme.elementSpacing * 0.75,
      ),
      child: InkWell(
        onTap: () async {},
        borderRadius: AppTheme.cardRadiusBig,
        child: Row(
          children: [
            Avatar(
              size: AppTheme.cardPadding * 2,
              onTap: () async {},
              mxContent: userData.profileImageUrl,
              name: userData.username,
              profileId: userData.did,
              isNft: false,
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
    final recentContacts = getMockUsers('recent');
    final hypedPeople = getMockUsers('hyped');
    final topBuyers = getMockUsers('buyers');
    final topSellers = getMockUsers('sellers');

    return controller.searchResultsFuture == null
        ? dotProgress(context)
        : GetBuilder<FeedController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppTheme.cardPadding,
                  right: AppTheme.cardPadding,
                  top: AppTheme.elementSpacing),
              child: ListView(
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
                  ),
                  _buildContactSection(
                    title: 'Top Buyers',
                    users: topBuyers,
                    context: context,
                    showViewAll: true,
                  ),
                  _buildContactSection(
                    title: 'Top Sellers',
                    users: topSellers,
                    context: context,
                    showViewAll: true,
                  ),
                ],
              ),
            );
          });
  }
}