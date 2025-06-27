import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListNFTScreen extends StatefulWidget {
  final NFTAsset asset;

  const ListNFTScreen({Key? key, required this.asset}) : super(key: key);

  @override
  State<ListNFTScreen> createState() => _ListNFTScreenState();
}

class _ListNFTScreenState extends State<ListNFTScreen> {
  final btcController = TextEditingController();
  final currController = TextEditingController();
  final satController = TextEditingController();
  final focusNode = FocusNode();
  final platformFee = 1.0; // $1 platform fee

  @override
  void dispose() {
    btcController.dispose();
    currController.dispose();
    satController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _showListingConfirmation(BuildContext context, double listingPrice) {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.6,
      extendBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          bitnetAppBar(
            context: context,
            text: "Confirm Listing",
            hasBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NFT preview
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusMid),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppTheme.borderRadiusMid),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey.shade100
                                    : Colors.grey.shade800.withOpacity(0.3),
                          ),
                          child: widget.asset.imageUrl.isNotEmpty
                              ? Image.network(
                                  widget.asset.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppTheme.black60
                                                    : AppTheme.white60,
                                            size: 28,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "No image",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppTheme.black60
                                                      : AppTheme.white60,
                                                ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_not_supported,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppTheme.black60
                                            : AppTheme.white60,
                                        size: 28,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "No image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? AppTheme.black60
                                                  : AppTheme.white60,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding),

                    // Asset details
                    Center(
                      child: Text(
                        widget.asset.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.asset.collection,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white60,
                            ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding * 1.5),

                    // Pricing details
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade100
                            : Colors.grey.shade800.withOpacity(0.3),
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      padding: EdgeInsets.all(AppTheme.cardPadding),
                      child: Column(
                        children: [
                          _buildPriceRow(
                            context,
                            "Listing Price",
                            "\$${listingPrice.toStringAsFixed(2)}",
                          ),
                          const SizedBox(height: AppTheme.elementSpacing),
                          _buildPriceRow(
                            context,
                            "Platform Fee",
                            "\$${platformFee.toStringAsFixed(2)}",
                          ),
                          const SizedBox(height: AppTheme.elementSpacing),
                          const Divider(),
                          const SizedBox(height: AppTheme.elementSpacing),
                          _buildPriceRow(
                            context,
                            "You'll Receive",
                            "\$${(listingPrice - platformFee).toStringAsFixed(2)}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.cardPadding * 2),

                    // Listing terms
                    Text(
                      "Listing Terms",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.elementSpacing),
                    Text(
                      "By confirming this listing, you agree to the marketplace terms and conditions. Your NFT will be visible to all users and can be purchased at the listed price.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black60
                                    : AppTheme.white60,
                          ),
                    ),

                    const SizedBox(height: AppTheme.cardPadding * 2),

                    // Row with Cancel and Confirm buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Cancel button (left)
                        LongButtonWidget(
                          title: "Cancel",
                          buttonType: ButtonType.transparent,
                          customWidth: AppTheme.cardPadding * 6.75,
                          customHeight: AppTheme.cardPadding * 2.5,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),

                        // Confirm button (right)
                        LongButtonWidget(
                          title: "Confirm Listing",
                          buttonType: ButtonType.solid,
                          customWidth: AppTheme.cardPadding * 6.75,
                          customHeight: AppTheme.cardPadding * 2.5,
                          onTap: () {
                            // Handle listing confirmation
                            _handleListingConfirmation(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.elementSpacing),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value,
      {bool isBold = false}) {
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
          style: isBold
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _handleListingConfirmation(BuildContext context) {
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
                  "Listing...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate network request with a slight delay
    Future.delayed(Duration(seconds: 1), () {
      // Close loading dialog
      Navigator.of(context).pop();

      try {
        // In a real implementation, this would submit the listing to a backend
        // and handle potential errors

        // Get the current price from the amount widget
        final listingPrice = double.tryParse(currController.text) ?? 0;

        // For demo purposes, we'll just simulate a successful listing
        // In a real app, you would send the data to your backend here

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "NFT listed successfully for \$${listingPrice.toStringAsFixed(2)}!"),
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

        // Navigate back to the previous screens safely
        // Check if the context is still mounted before popping
        if (mounted) {
          // First pop the confirmation sheet
          Navigator.of(context).pop();

          // Then go back to the previous screen
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      } catch (e) {
        // Handle any errors during listing
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // We'll handle pop manually
      onPopInvoked: (bool didPop) async {
        if (didPop) return; // Already popped, do nothing

        // Check if we have unsaved data before letting the user leave
        if (currController.text.isNotEmpty &&
            double.tryParse(currController.text.trim()) != null) {
          // Ask user to confirm leaving if they entered a price
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Discard listing?'),
              content: Text(
                  'You have entered pricing information. Are you sure you want to exit without listing this NFT?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Discard'),
                ),
              ],
            ),
          );

          if (shouldPop ?? false) {
            Navigator.of(context).pop();
          }
        } else {
          // No unsaved data, allow pop
          Navigator.of(context).pop();
        }
      },
      child: bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 0,
              toolbarHeight: kToolbarHeight,
              title: Text(
                "List Your NFT",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NFT preview
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusMid),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppTheme.borderRadiusMid),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey.shade100
                                    : Colors.grey.shade800.withOpacity(0.3),
                          ),
                          child: widget.asset.imageUrl.isNotEmpty
                              ? Image.network(
                                  widget.asset.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppTheme.black60
                                                    : AppTheme.white60,
                                            size: 48,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Image not available",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppTheme.black60
                                                      : AppTheme.white60,
                                                ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_not_supported,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppTheme.black60
                                            : AppTheme.white60,
                                        size: 48,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "No image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? AppTheme.black60
                                                  : AppTheme.white60,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding),

                    // Asset details
                    Center(
                      child: Text(
                        widget.asset.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.asset.collection,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white60,
                            ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding * 2),

                    // Price input section
                    Text(
                      "Set Your Price",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.elementSpacing),

                    Text(
                      "Enter the price at which you want to list your NFT. A platform fee of \$1 will be deducted from your sale.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black60
                                    : AppTheme.white60,
                          ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding),

                    // Amount widget for price input
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
                    const SizedBox(height: AppTheme.cardPadding * 2),

                    // Row with Back and Preview buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Back button (left)
                        LongButtonWidget(
                          title: "Back",
                          buttonType: ButtonType.transparent,
                          customWidth: AppTheme.cardPadding * 6.75,
                          customHeight: AppTheme.cardPadding * 2.5,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),

                        // Preview button (right)
                        LongButtonWidget(
                          title: "Preview Listing",
                          buttonType: ButtonType.solid,
                          customWidth: AppTheme.cardPadding * 6.75,
                          customHeight: AppTheme.cardPadding * 2.5,
                          onTap: () {
                            // Get the current price from the controller
                            final listingPriceText = currController.text.trim();

                            // Validate price input
                            if (listingPriceText.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please enter a listing price"),
                                  backgroundColor: AppTheme.errorColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            final listingPrice =
                                double.tryParse(listingPriceText) ?? 0;

                            if (listingPrice <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please enter a valid price greater than 0"),
                                  backgroundColor: AppTheme.errorColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            // Check if price is reasonable (less than $1,000,000)
                            if (listingPrice > 1000000) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Listing price cannot exceed \$1,000,000"),
                                  backgroundColor: AppTheme.errorColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            // Show the confirmation bottom sheet
                            _showListingConfirmation(context, listingPrice);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
