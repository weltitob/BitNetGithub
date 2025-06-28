import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

// Token marketplace mock data
final Map<String, Map<String, dynamic>> tokenMarketData = {
  'GENST': {
    'floorPrice': 45000.0,
    'currentPrice': 48350.0,
    'sellOffers': [
      {
        'seller': 'GenesisKeeper',
        'amount': '3',
        'price': '46,500',
        'rating': 4.9,
        'trades': 342
      },
      {
        'seller': 'StoneCollector',
        'amount': '5',
        'price': '47,200',
        'rating': 4.8,
        'trades': 267
      },
      {
        'seller': 'CryptoVault',
        'amount': '2',
        'price': '47,800',
        'rating': 5.0,
        'trades': 523
      },
    ],
    'buyOffers': [
      {
        'buyer': 'TokenWhale',
        'amount': '10',
        'price': '45,000',
        'rating': 4.8,
        'trades': 156
      },
      {
        'buyer': 'GenesisHunter',
        'amount': '4',
        'price': '44,500',
        'rating': 4.7,
        'trades': 234
      },
    ]
  },
  'HTDG': {
    'floorPrice': 14.50,
    'currentPrice': 15.75,
    'sellOffers': [
      {
        'seller': 'HotdogKing',
        'amount': '500',
        'price': '15.00',
        'rating': 4.9,
        'trades': 876
      },
      {
        'seller': 'FoodToken',
        'amount': '750',
        'price': '15.50',
        'rating': 4.7,
        'trades': 432
      },
    ],
    'buyOffers': [
      {
        'buyer': 'HotdogFan',
        'amount': '300',
        'price': '14.00',
        'rating': 4.8,
        'trades': 234
      },
    ]
  },
  'CAT': {
    'floorPrice': 825.0,
    'currentPrice': 892.50,
    'sellOffers': [
      {
        'seller': 'CatLover',
        'amount': '25',
        'price': '850',
        'rating': 5.0,
        'trades': 567
      },
      {
        'seller': 'FelineTrader',
        'amount': '40',
        'price': '875',
        'rating': 4.8,
        'trades': 345
      },
    ],
    'buyOffers': [
      {
        'buyer': 'CatCollector',
        'amount': '50',
        'price': '820',
        'rating': 4.9,
        'trades': 423
      },
    ]
  },
  'EMRLD': {
    'floorPrice': 11500.0,
    'currentPrice': 12450.0,
    'sellOffers': [
      {
        'seller': 'EmeraldVault',
        'amount': '8',
        'price': '12,000',
        'rating': 4.9,
        'trades': 234
      },
      {
        'seller': 'GemTrader',
        'amount': '12',
        'price': '12,300',
        'rating': 4.8,
        'trades': 456
      },
    ],
    'buyOffers': [
      {
        'buyer': 'EmeraldSeeker',
        'amount': '15',
        'price': '11,500',
        'rating': 4.7,
        'trades': 189
      },
    ]
  },
  'LILA': {
    'floorPrice': 215.0,
    'currentPrice': 234.80,
    'sellOffers': [
      {
        'seller': 'LilaHolder',
        'amount': '100',
        'price': '225',
        'rating': 4.8,
        'trades': 678
      },
      {
        'seller': 'PurpleToken',
        'amount': '150',
        'price': '230',
        'rating': 4.9,
        'trades': 543
      },
    ],
    'buyOffers': [
      {
        'buyer': 'LilaInvestor',
        'amount': '200',
        'price': '215',
        'rating': 4.9,
        'trades': 345
      },
    ]
  },
  'MINRL': {
    'floorPrice': 3200.0,
    'currentPrice': 3567.25,
    'sellOffers': [
      {
        'seller': 'MineralMaster',
        'amount': '20',
        'price': '3,400',
        'rating': 5.0,
        'trades': 892
      },
      {
        'seller': 'RockCollector',
        'amount': '35',
        'price': '3,500',
        'rating': 4.9,
        'trades': 654
      },
    ],
    'buyOffers': [
      {
        'buyer': 'MineralWhale',
        'amount': '50',
        'price': '3,200',
        'rating': 4.8,
        'trades': 432
      },
    ]
  },
  'TBLUE': {
    'floorPrice': 62.0,
    'currentPrice': 67.90,
    'sellOffers': [
      {
        'seller': 'BlueTrader',
        'amount': '400',
        'price': '65.00',
        'rating': 4.7,
        'trades': 321
      },
      {
        'seller': 'TokenBlue',
        'amount': '600',
        'price': '67.00',
        'rating': 4.8,
        'trades': 456
      },
    ],
    'buyOffers': [
      {
        'buyer': 'BlueBuyer',
        'amount': '800',
        'price': '62.00',
        'rating': 4.6,
        'trades': 234
      },
    ]
  },
};

class TokenBuySheet extends StatefulWidget {
  final String tokenSymbol;
  final Map<String, dynamic>? tokenData;
  final Map<String, dynamic>? selectedOffer;

  const TokenBuySheet({
    Key? key,
    required this.tokenSymbol,
    this.tokenData,
    this.selectedOffer,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required String tokenSymbol,
    String? tokenName,
    double? currentPrice,
    Map<String, dynamic>? selectedOffer,
    Map<String, dynamic>? tokenData,
  }) {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.75,
      child: TokenBuySheet(
        tokenSymbol: tokenSymbol,
        tokenData: tokenData,
        selectedOffer: selectedOffer,
      ),
    );
  }

  @override
  State<TokenBuySheet> createState() => _TokenBuySheetState();
}

class _TokenBuySheetState extends State<TokenBuySheet> {
  // Controllers
  final btcController = TextEditingController();
  final currController = TextEditingController();
  final satController = TextEditingController();
  final focusNode = FocusNode();

  // State
  int buyStep = 1;
  String buyAmount = '';
  Map<String, dynamic>? selectedOffer;

  @override
  void initState() {
    super.initState();
    selectedOffer = widget.selectedOffer;
  }

  @override
  void dispose() {
    btcController.dispose();
    currController.dispose();
    satController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BitNet AppBar
        bitnetAppBar(
          context: context,
          text: buyStep == 1 
              ? 'Buy ${widget.tokenSymbol}' 
              : selectedOffer != null 
                  ? 'Confirm Purchase' 
                  : 'Best Matches',
          hasBackButton: buyStep == 1 ? false : true,
          onTap: () {
            if (buyStep == 2) {
              // Go back to amount step
              setState(() {
                buyStep = 1;
              });
            } else {
              // Close bottom sheet
              Navigator.of(context).pop();
            }
          },
        ),
        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child:
                buyStep == 1 ? _buildBuyAmountStep() : _buildBestMatchesStep(),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyAmountStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppTheme.elementSpacing.h),

        // Show selected offer info if available - matching marketplace style
        if (selectedOffer != null) ...[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              onTap: () {}, // Already selected, no action needed
              child: Padding(
                padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
                child: Row(
                  children: [
                    // Seller avatar
                    Avatar(
                      size: 44.w,
                      isNft: false,
                      name: selectedOffer!['seller'],
                    ),
                    SizedBox(width: AppTheme.elementSpacing),
                    // Title & subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedOffer!['seller'],
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Offering ${selectedOffer!['amount']} ${widget.tokenSymbol}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                    // Price display
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${selectedOffer!['price']}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          'per token',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppTheme.cardPadding.h),
        ],

        // Amount input
        Text(
          'Amount to buy',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        SizedBox(height: AppTheme.elementSpacing.h),

        // AmountWidget for token amount
        AmountWidget(
          enabled: () => true,
          btcController: btcController,
          satController: satController,
          currController: currController,
          focusNode: focusNode,
          context: context,
          autoConvert: true,
          bitcoinUnit: BitcoinUnits.BTC,
          onAmountChange: (currencyType, text) {
            setState(() {});
          },
        ),

        const Spacer(),

        // Bottom button with consistent styling
        BottomCenterButton(
          buttonTitle: selectedOffer != null ? 'Continue' : 'Find Best Matches',
          buttonState: (btcController.text.isEmpty || btcController.text == '0')
              ? ButtonState.disabled
              : ButtonState.idle,
          onButtonTap: () {
            buyAmount = btcController.text;
            setState(() {
              buyStep = 2;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBestMatchesStep() {
    // If there's a selected offer, show only that offer
    if (selectedOffer != null) {
      return _buildSelectedOfferView();
    }
    
    // Get token-specific data
    final tokenData =
        tokenMarketData[widget.tokenSymbol] ?? tokenMarketData['GENST']!;
    final sellOffers = List<Map<String, dynamic>>.from(tokenData['sellOffers']);

    // Filter and sort sellers based on the requested amount
    final requestedAmount = double.tryParse(buyAmount) ?? 0;

    // Advanced matching algorithm
    final availableSellers = sellOffers.where((seller) {
      final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
      return sellerAmount >=
          requestedAmount; // Only show sellers who have enough tokens
    }).toList();

    // Multi-factor sorting for best match
    availableSellers.sort((a, b) {
      final priceA =
          double.tryParse(a['price'].toString().replaceAll(',', '')) ?? 0;
      final priceB =
          double.tryParse(b['price'].toString().replaceAll(',', '')) ?? 0;
      final ratingA = double.tryParse(a['rating'].toString()) ?? 0;
      final ratingB = double.tryParse(b['rating'].toString()) ?? 0;
      final tradesA = int.tryParse(a['trades'].toString()) ?? 0;
      final tradesB = int.tryParse(b['trades'].toString()) ?? 0;

      // Calculate composite score
      // Lower price is better, higher rating is better, more trades is better
      final scoreA = (priceA / 100) - (ratingA * 2) - (tradesA / 100);
      final scoreB = (priceB / 100) - (ratingB * 2) - (tradesB / 100);

      return scoreA.compareTo(scoreB);
    });

    // If no exact matches, find sellers who can partially fulfill
    List<Map<String, dynamic>> partialSellers = [];
    if (availableSellers.isEmpty && requestedAmount > 0) {
      partialSellers = sellOffers.where((seller) {
        final sellerAmount = double.tryParse(seller['amount'].toString()) ?? 0;
        return sellerAmount > 0 && sellerAmount < requestedAmount;
      }).toList();

      partialSellers.sort((a, b) {
        final amountA = double.tryParse(a['amount'].toString()) ?? 0;
        final amountB = double.tryParse(b['amount'].toString()) ?? 0;
        return amountB
            .compareTo(amountA); // Sort by largest available amount first
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Amount summary
          Container(
            padding: EdgeInsets.all(AppTheme.elementSpacing.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                Text(
                  'Looking to buy: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '$buyAmount ${widget.tokenSymbol}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h),

          if (availableSellers.isNotEmpty) ...[
            Text(
              'Best Matches',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Sellers with enough tokens to fulfill your order',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
            ),
          ] else if (partialSellers.isNotEmpty) ...[
            Text(
              'Partial Matches',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Container(
              padding: EdgeInsets.all(AppTheme.elementSpacing.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                  Expanded(
                    child: Text(
                      'No sellers have enough tokens. Showing partial matches.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              'No Matches Found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Container(
              padding: EdgeInsets.all(AppTheme.elementSpacing.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                border: Border.all(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 20,
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                  Expanded(
                    child: Text(
                      'No sellers available for the requested amount.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: AppTheme.elementSpacing.h),

          // List of sellers - not expanded, part of the scrollable column
          ...List.generate(
            availableSellers.isNotEmpty
                ? availableSellers.length
                : partialSellers.length,
            (index) {
              final sellers = availableSellers.isNotEmpty
                  ? availableSellers
                  : partialSellers;
              
              // Only show first 5 offers
              if (index >= 5) return SizedBox.shrink();
              
              final seller = sellers[index];
              final isPartial =
                  availableSellers.isEmpty && partialSellers.isNotEmpty;

              return Container(
                margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                  onTap: () {
                    // Select this offer and proceed to confirmation
                    setState(() {
                      selectedOffer = seller;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
                    child: Row(
                      children: [
                        // Seller avatar
                        Avatar(
                          size: 44.w,
                          isNft: false,
                          name: seller['seller'],
                        ),
                        SizedBox(width: AppTheme.elementSpacing),
                        // Title & subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seller['seller'],
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Offering ${seller['amount']} ${widget.tokenSymbol}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.6),
                                        ),
                                  ),
                                  if (isPartial) ...[
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        'Partial',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Price display
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${seller['price']}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'per token',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Show more button if there are more than 5 offers
          if ((availableSellers.length > 5) || (availableSellers.isEmpty && partialSellers.length > 5)) ...[
            Center(
              child: LongButtonWidget(
                title: 'Show More',
                buttonType: ButtonType.transparent,
                customWidth: 150.w,
                customHeight: 40.h,
                onTap: () {
                  // Close the bottom sheet and navigate to marketplace
                  Navigator.of(context).pop();
                  // The user is already on the marketplace screen, so just closing the sheet
                  // will return them to see all offers
                },
              ),
            ),
          ],
          
          // Add bottom padding to ensure last item is visible
          SizedBox(height: AppTheme.cardPadding.h * 2),
        ],
      ),
    );
  }

  Widget _buildSelectedOfferView() {
    final offer = selectedOffer!;
    final requestedAmount = double.tryParse(buyAmount) ?? 0;
    final availableAmount = double.tryParse(offer['amount'].toString()) ?? 0;
    final price = double.tryParse(offer['price'].toString().replaceAll(',', '')) ?? 0;
    final subtotal = requestedAmount * price;
    final marketplaceFee = 1.0;
    final totalCost = subtotal + marketplaceFee;
    
    return Stack(
      children: [
        // Main content
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seller info card - matching marketplace offer style
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                  onTap: () {}, // Already selected, no action needed
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Seller avatar
                            Avatar(
                              size: 44.w,
                              isNft: false,
                              name: offer['seller'],
                            ),
                            SizedBox(width: AppTheme.elementSpacing),
                            // Title & subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer['seller'],
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Offering ${offer['amount']} ${widget.tokenSymbol}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            // Price display
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${offer['price']}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  'per token',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: AppTheme.cardPadding.h * 2),
                        
                        // Transaction details - amount with conversion
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount to buy:',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '$requestedAmount ${widget.tokenSymbol}',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '\$${subtotal.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        if (requestedAmount > availableAmount) ...[
                          SizedBox(height: AppTheme.elementSpacing.h),
                          Container(
                            padding: EdgeInsets.all(AppTheme.elementSpacing.w),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                SizedBox(width: AppTheme.elementSpacing.w * 0.5),
                                Expanded(
                                  child: Text(
                                    'Seller only has ${offer['amount']} tokens available',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        
                        SizedBox(height: AppTheme.cardPadding.h * 2),
                        
                        // Marketplace fee
                        _buildDetailRow('Marketplace fee:', '\$${marketplaceFee.toStringAsFixed(2)}'),
                        
                        SizedBox(height: AppTheme.cardPadding.h),
                        
                        // Total cost
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Cost:',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '\$${totalCost.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Buy button positioned at bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BottomCenterButton(
            buttonTitle: 'Buy Now',
            buttonState: requestedAmount > availableAmount
                ? ButtonState.disabled
                : ButtonState.idle,
            onButtonTap: () {
              // Handle buy action
              Navigator.of(context).pop();
              // TODO: Implement actual buy logic
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
