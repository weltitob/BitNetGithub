import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/list_nft_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shows the NFT listing bottom sheet when a user clicks on "List" button
void showListingBottomSheet(BuildContext context, NFTAsset asset) {
  BitNetBottomSheet(
    context: context,
    height: MediaQuery.of(context).size.height * 0.7, // Control the height to avoid overflow
    backgroundColor: Theme.of(context).colorScheme.surface, // Use the surface color from theme
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App bar with back button
        bitnetAppBar(
          context: context,
          text: "List Your NFT",
          hasBackButton: true,
        ),
        
        Expanded(
          child: SingleChildScrollView( // Make content scrollable to avoid overflow
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  
                  // Display asset image
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        asset.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback for invalid image URLs
                          return Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Asset name
                  Text(
                    asset.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  
                  // Collection name
                  Text(
                    asset.collection,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light 
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Short message about listing
                  Text(
                    "Ready to list this NFT on the marketplace?",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    "Set your price on the next screen and earn when someone buys your NFT.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light 
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Use LongButtonWidget for consistency with app's UI
                  // Continue button
                  LongButtonWidget(
                    title: "Continue",
                    onTap: () {
                      // Close the current bottom sheet
                      Navigator.of(context).pop();
                      
                      // Navigate to the full listing screen
                      context.push('/marketplace/list-nft', extra: asset);
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Cancel button
                  LongButtonWidget(
                    title: "Cancel",
                    buttonType: ButtonType.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  
                  // Bottom padding to avoid buttons being cut off
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Extension method to make it easy to call from any NFT asset card
extension AssetListingExtension on NFTAsset {
  void showListingSheet(BuildContext context) {
    showListingBottomSheet(context, this);
  }
}