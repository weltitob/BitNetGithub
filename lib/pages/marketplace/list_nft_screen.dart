import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';

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
      child: Column(
        children: [
          bitnetAppBar(
            context: context,
            text: "Confirm Listing",
            hasBackButton: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NFT preview
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                        image: DecorationImage(
                          image: NetworkImage(widget.asset.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                  
                  // Asset details
                  Text(
                    widget.asset.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.asset.collection,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light 
                          ? AppTheme.black60 
                          : AppTheme.white60,
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 1.5),
                  
                  // Pricing details
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
                  
                  const Spacer(),
                  
                  // Confirm button
                  LongButtonWidget(
                    title: "Confirm Listing",
                    onTap: () {
                      // Handle listing confirmation
                      _handleListingConfirmation(context);
                    },
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  
                  // Cancel button
                  LongButtonWidget(
                    title: "Cancel",
                    buttonType: ButtonType.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value, {bool isBold = false}) {
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
    // In a real implementation, this would submit the listing to a backend
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("NFT listed successfully!"),
        backgroundColor: AppTheme.successColor,
      ),
    );
    
    // Navigate back to the asset screen or marketplace
    Navigator.of(context).pop(); // Close confirmation sheet
    context.pop(); // Return to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
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
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                        image: DecorationImage(
                          image: NetworkImage(widget.asset.imageUrl),
                          fit: BoxFit.cover,
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
                        color: Theme.of(context).brightness == Brightness.light 
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
                      color: Theme.of(context).brightness == Brightness.light 
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
                  
                  // Preview button
                  LongButtonWidget(
                    title: "Preview Listing",
                    onTap: () {
                      // Get the current price from the controller
                      final listingPrice = double.tryParse(currController.text) ?? 0;
                      
                      if (listingPrice <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter a valid price greater than 0"),
                            backgroundColor: AppTheme.errorColor,
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
            ),
          ),
        ],
      ),
    );
  }
}