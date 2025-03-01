import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LikeViewTab extends StatefulWidget {
  const LikeViewTab({Key? key, this.other = false}) : super(key: key);
  final bool other;
  
  @override
  State<LikeViewTab> createState() => _LikeViewTabState();
}

class _LikeViewTabState extends State<LikeViewTab> {
  late final controller;
  late final HomeController homeController;
  
  // Map to track like state for each NFT
  final Map<String, bool> likeStates = {};
  
  // Collection data for the liked NFTs (flattened into a single collection)
  final List<Map<String, dynamic>> allNfts = [
    {
      'id': 'nft-001',
      'name': 'Rainbow Cube',
      'mainName': 'Digital Cubes #231',
      'price': '0.023',
    },
    {
      'id': 'nft-002',
      'name': 'Abstract Art',
      'mainName': 'Modern Art #42',
      'price': '0.087',
    },
    {
      'id': 'nft-003',
      'name': 'Pixel Landscape',
      'mainName': 'Pixelverse #108',
      'price': '0.013',
    },
    {
      'id': 'nft-004',
      'name': 'Space Cat',
      'mainName': 'Crypto Cats #76',
      'price': '0.059',
    },
    {
      'id': 'nft-005',
      'name': 'Alien Planet',
      'mainName': 'Cosmic Realms #14',
      'price': '0.071',
    },
    {
      'id': 'nft-006',
      'name': 'Crypto Ape',
      'mainName': 'Digital Apes #187',
      'price': '0.195',
    },
    {
      'id': 'nft-007',
      'name': 'Abstract Waves',
      'mainName': 'Wave Collection #53',
      'price': '0.031',
    },
    {
      'id': 'nft-008',
      'name': 'Nature Blocks',
      'mainName': 'Elemental #129',
      'price': '0.028',
    }
  ];
  
  // We'll use this single collection for the view
  final List<Map<String, dynamic>> collections = [];
  
  @override
  void initState() {
    super.initState();
    controller = widget.other
        ? Get.find<OtherProfileController>()
        : Get.put(ProfileController());
    
    // Initialize HomeController for like functionality
    homeController = Get.find<HomeController>();
    
    // Initialize all NFTs as liked (true) since this is the likes tab
    for (var nft in allNfts) {
      likeStates[nft['id']] = true;
    }
    
    // Create a single collection with all NFTs
    collections.add({
      'nfts': allNfts,
    });
  }

  // Toggle like state for a specific NFT
  void toggleLike(String nftId) {
    setState(() {
      likeStates[nftId] = !(likeStates[nftId] ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return SliverList(
      delegate: SliverChildListDelegate(
        collections.map((collection) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w / 2),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    mainAxisSpacing: AppTheme.elementSpacing.h,
                    crossAxisSpacing: AppTheme.elementSpacing.w / 6, // Match rowviewtab
                    childAspectRatio: (size.width / 2) / 240.w, // Match exactly with rowviewtab
                  ),
                  itemCount: collection['nfts'].length,
                  itemBuilder: (context, index) {
                    final nft = collection['nfts'][index];
                    final String nftId = nft['id'];
                    
                    // Create mock media objects for the NFT (using direct image path, not base64)
                    // The asset card will display this using Image.asset instead of trying to decode base64
                    final List<Media> mockMedias = [
                      Media(
                        type: 'asset_image', // Custom type to handle asset paths directly
                        data: 'assets/marketplace/NftImage${(index % 8) + 1}.png',
                      )
                    ];
                    
                    // Use the AssetCard component
                    return AssetCard(
                      scale: 0.75,
                      medias: mockMedias,
                      nftName: nft['name'],
                      nftMainName: nft['mainName'],
                      cryptoText: nft['price'],
                      hasLikeButton: true,
                      hasLiked: likeStates[nftId] ?? true,
                      hasPrice: true,
                      postId: nftId,
                    );
                  },
                ),
              ),
              SizedBox(height: AppTheme.elementSpacing),
            ],
          );
        }).toList(),
      ),
    );
  }
}