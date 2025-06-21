import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CollectionHeader extends StatefulWidget {
  final Size size;
  final String? name;
  final List<int> inscriptions;

  const CollectionHeader({
    Key? key,
    required this.size,
    required this.name,
    required this.inscriptions,
  }) : super(key: key);

  @override
  State<CollectionHeader> createState() => _CollectionHeaderState();
}

class _CollectionHeaderState extends State<CollectionHeader>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(
          top: AppTheme.cardPadding.h * 2, bottom: AppTheme.cardPadding.h),
      child: Column(
        children: [
          // Hero image section
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Banner image
              Container(
                width: widget.size.width,
                height: 200.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.surface.withOpacity(0.3),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: ClipRRect(
                  child: Image.asset(
                    nftImage5,
                    width: widget.size.width,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Profile image using proper Avatar component
              Transform.translate(
                offset: Offset(0, 40),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 4,
                    ),
                  ),
                  child: Avatar(
                    profileId: "bitcoinpunks",
                    name: widget.name ?? "Bitcoin Punks",
                    size: 80.w,
                    isNft: true,
                    type: profilePictureType.none,
                    onTap: () {
                      // Handle profile tap if needed
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 48.h),
          
          // Collection name
          Text(
            widget.name != null ? widget.name! : L10n.of(context)!.unknown,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: AppTheme.elementSpacing.h),
          
          
          SizedBox(height: AppTheme.cardPadding.h),
          
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: Text(
              _getProjectDescription(widget.name),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 24.h,
      width: 1,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
    );
  }

  String _getProjectDescription(String? projectName) {
    if (projectName == null) return 'A unique digital collection on the Bitcoin blockchain.';
    
    switch (projectName.toLowerCase()) {
      case 'mutant ape club':
      case 'mutant apes':
        return 'A collection of unique mutant apes created by exposing Bored Apes to a vial of mutant serum or by minting a Mega Mutant in the public sale.';
      case 'bored ape club':
      case 'bored apes':
        return 'A collection of 10,000 unique Bored Ape NFTs— unique digital collectibles living on the Bitcoin blockchain.';
      case 'crypto punks':
      case 'punk collection':
        return 'CryptoPunks launched as a fixed set of 10,000 items in mid-2017 and became one of the inspirations for the ERC-721 standard.';
      case 'ordinal punks':
      case 'bitcoin punks':
        return 'The first 100 Ordinal Punks inscribed on the Bitcoin blockchain, bringing the iconic CryptoPunks aesthetic to Bitcoin.';
      case 'taproot wizards':
      case 'magic collection':
        return 'Taproot Wizards is the largest NFT collection on Bitcoin, featuring magical wizards and enchanted artwork on the Bitcoin blockchain.';
      case 'bitcoin frens':
      case 'frens club':
        return 'A friendly collection of Bitcoin enthusiasts and frens, celebrating the Bitcoin community through unique digital art.';
      case 'abstract masterpieces':
        return 'A curated collection of abstract digital artworks exploring the intersection of traditional art and blockchain technology.';
      case 'digital artworks':
        return 'Contemporary digital art pieces that push the boundaries of creativity and showcase the potential of blockchain-based art.';
      case 'pixel worlds':
        return 'Retro-inspired pixel art collection featuring detailed landscapes and characters in classic 8-bit style.';
      default:
        return 'A unique digital collection on the Bitcoin blockchain, featuring rare and collectible artwork with provable ownership and scarcity.';
    }
  }

  @override
  bool get wantKeepAlive => true;
}
