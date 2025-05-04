import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

/// Shows the NFT listing bottom sheet with direct price input when a user clicks on "List" button
void showListingBottomSheet(BuildContext context, NFTAsset asset) {
  // Controllers for the AmountWidget
  final btcController = TextEditingController();
  final currController = TextEditingController();
  final satController = TextEditingController();
  final focusNode = FocusNode();
  final platformFee = 1.0; // $1 platform fee
  
  BitNetBottomSheet(
    context: context,
    height: MediaQuery.of(context).size.height * 0.7,
    backgroundColor: Theme.of(context).colorScheme.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // App bar without back button
        bitnetAppBar(
          context: context,
          text: "List NFT",
          hasBackButton: false,
        ),
        
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
              vertical: AppTheme.elementSpacing,
            ),
            child: Column(
              children: [
                // Asset info row
                Row(
                  children: [
                    // Asset image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade100
                          : Colors.grey.shade800,
                        child: asset.imageUrl.isNotEmpty
                          ? Image.network(
                              asset.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.image_not_supported,
                                color: Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white60,
                              ),
                            )
                          : Icon(
                              Icons.image_not_supported,
                              color: Theme.of(context).brightness == Brightness.light
                                ? AppTheme.black60
                                : AppTheme.white60,
                            ),
                      ),
                    ),
                    
                    const SizedBox(width: AppTheme.elementSpacing),
                    
                    // Asset details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            asset.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            asset.collection,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.light 
                                ? AppTheme.black60
                                : AppTheme.white60,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.elementSpacing * 2),
                
                // Set price (small label)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Set price",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "• \$1 platform fee",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).brightness == Brightness.light 
                            ? AppTheme.black60
                            : AppTheme.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppTheme.elementSpacing),
                
                // AmountWidget for price input
                AmountWidget(
                  context: context,
                  enabled: () => true,
                  focusNode: focusNode,
                  btcController: btcController,
                  satController: satController,
                  currController: currController,
                  autoConvert: true,
                  swapped: true, // Start with USD by default
                ),
                
                // Spacer to push buttons to bottom
                const Spacer(),
                
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Cancel button (left)
                    LongButtonWidget(
                      title: "Cancel",
                      buttonType: ButtonType.transparent,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.25,
                      onTap: () {
                        // Clean up controllers
                        btcController.dispose();
                        currController.dispose();
                        satController.dispose();
                        focusNode.dispose();
                        
                        Navigator.of(context).pop();
                      },
                    ),
                    
                    // Preview listing button (right)
                    LongButtonWidget(
                      title: "Continue",
                      buttonType: ButtonType.solid,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.25,
                      onTap: () {
                        // Get the current price
                        final listingPriceText = currController.text.trim();
                        
                        // Simple price validation
                        if (listingPriceText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter a price"),
                              backgroundColor: AppTheme.errorColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        
                        final listingPrice = double.tryParse(listingPriceText) ?? 0;
                        
                        if (listingPrice <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter a valid price"),
                              backgroundColor: AppTheme.errorColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }
                        
                        // Close current sheet and show confirmation
                        Navigator.of(context).pop();
                        
                        // Show confirmation bottom sheet
                        _showListingConfirmation(
                          context, 
                          asset, 
                          listingPrice,
                          btcController.text,
                          satController.text,
                          currController.text
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.elementSpacing),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Shows a confirmation bottom sheet for the final listing step
void _showListingConfirmation(
  BuildContext context, 
  NFTAsset asset, 
  double listingPrice,
  String btcValue,
  String satValue,
  String currValue
) {
  BitNetBottomSheet(
    context: context,
    height: MediaQuery.of(context).size.height * 0.55,
    backgroundColor: Theme.of(context).colorScheme.surface,
    child: Column(
      children: [
        bitnetAppBar(
          context: context,
          text: "Confirm Listing",
          hasBackButton: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
              vertical: AppTheme.elementSpacing,
            ),
            child: Column(
              children: [
                // Asset info row
                Row(
                  children: [
                    // Asset image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade100
                          : Colors.grey.shade800,
                        child: asset.imageUrl.isNotEmpty
                          ? Image.network(
                              asset.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.image_not_supported,
                                color: Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white60,
                              ),
                            )
                          : Icon(
                              Icons.image_not_supported,
                              color: Theme.of(context).brightness == Brightness.light
                                ? AppTheme.black60
                                : AppTheme.white60,
                            ),
                      ),
                    ),
                    
                    const SizedBox(width: AppTheme.elementSpacing),
                    
                    // Asset details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            asset.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            asset.collection,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.light 
                                ? AppTheme.black60
                                : AppTheme.white60,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.cardPadding),
                
                // Pricing details
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade100
                        : Colors.grey.shade800.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                  ),
                  padding: EdgeInsets.all(AppTheme.cardPadding),
                  child: Column(
                    children: [
                      _buildPriceRow(
                        context,
                        "Your price",
                        "\$${listingPrice.toStringAsFixed(2)}",
                      ),
                      const SizedBox(height: AppTheme.elementSpacing),
                      _buildPriceRow(
                        context,
                        "Platform fee",
                        "-\$1.00",
                        valueColor: Theme.of(context).brightness == Brightness.light 
                            ? AppTheme.black60
                            : AppTheme.white60,
                      ),
                      const SizedBox(height: AppTheme.elementSpacing),
                      const Divider(),
                      const SizedBox(height: AppTheme.elementSpacing),
                      _buildPriceRow(
                        context,
                        "You'll receive",
                        "\$${(listingPrice - 1.0).toStringAsFixed(2)}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Back button (left)
                    LongButtonWidget(
                      title: "Back",
                      buttonType: ButtonType.transparent,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.25,
                      onTap: () {
                        Navigator.of(context).pop();
                        // Re-open the previous sheet
                        showListingBottomSheet(context, asset);
                      },
                    ),
                    
                    // List button (right)
                    LongButtonWidget(
                      title: "List NFT",
                      buttonType: ButtonType.solid,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.25,
                      onTap: () {
                        // Handle listing confirmation
                        _handleListingConfirmation(
                          context, 
                          asset, 
                          listingPrice,
                          btcValue,
                          satValue,
                          currValue
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.elementSpacing),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPriceRow(
  BuildContext context, 
  String label, 
  String value, 
  {
    bool isBold = false,
    Color? valueColor,
  }
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: isBold 
            ? Theme.of(context).textTheme.titleMedium 
            : Theme.of(context).textTheme.bodyMedium,
      ),
      Text(
        value,
        style: (isBold 
            ? Theme.of(context).textTheme.titleMedium 
            : Theme.of(context).textTheme.bodyMedium)?.copyWith(
          color: valueColor,
        ),
      ),
    ],
  );
}

void _handleListingConfirmation(
  BuildContext context, 
  NFTAsset asset, 
  double listingPrice,
  String btcValue,
  String satValue,
  String currValue
) {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Listing NFT...",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    },
  );

  // Get current user ID
  final userId = Auth().currentUser?.uid;
  
  // Generate timestamp
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  // Prepare listing data
  final listingData = {
    'asset_id': asset.id,
    'name': asset.name,
    'collection': asset.collection,
    'image_url': asset.imageUrl,
    'price_usd': listingPrice,
    'price_btc': btcValue,
    'price_sat': satValue,
    'owner_id': userId,
    'created_at': timestamp,
    'is_sold': false,
  };

  // Simulate network request with a slight delay
  Future.delayed(Duration(seconds: 1), () {
    // Write to Firestore
    try {
      // Get Firestore instance and create a reference to the 'listed_assets' collection
      final firestore = FirebaseFirestore.instance;
      final listingsCollection = firestore.collection('listed_assets');
      
      // Add the listing data to get a new document with auto-generated ID
      listingsCollection.add(listingData);
      
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("NFT listed successfully for \$${listingPrice.toStringAsFixed(2)}!"),
          backgroundColor: AppTheme.successColor,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: AppTheme.cardPadding * 3,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
        ),
      );
      
      // Close the confirmation sheet
      Navigator.of(context).pop();
      
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error listing NFT: ${e.toString()}"),
          backgroundColor: AppTheme.errorColor,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: AppTheme.cardPadding * 3,
            left: AppTheme.cardPadding,
            right: AppTheme.cardPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
        ),
      );
    }
  });
}

/// Extension method to make it easy to call from any NFT asset card
extension AssetListingExtension on NFTAsset {
  void showListingSheet(BuildContext context) {
    showListingBottomSheet(context, this);
  }
}