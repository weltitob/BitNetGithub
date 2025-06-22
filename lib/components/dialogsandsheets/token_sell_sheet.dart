import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/floor_price_widget.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/backbone/services/token_data_service.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:get/get.dart';

// Share the same mock data with buy sheet
final Map<String, Map<String, dynamic>> tokenMarketData = {
  'GENST': {
    'floorPrice': 45000.0,
    'currentPrice': 48350.0,
    'sellOffers': [
      {'seller': 'GenesisKeeper', 'amount': '3', 'price': '46,500', 'rating': 4.9, 'trades': 342},
      {'seller': 'StoneCollector', 'amount': '5', 'price': '47,200', 'rating': 4.8, 'trades': 267},
      {'seller': 'CryptoVault', 'amount': '2', 'price': '47,800', 'rating': 5.0, 'trades': 523},
    ],
    'buyOffers': [
      {'buyer': 'TokenWhale', 'amount': '10', 'price': '45,000', 'rating': 4.8, 'trades': 156},
      {'buyer': 'GenesisHunter', 'amount': '4', 'price': '44,500', 'rating': 4.7, 'trades': 234},
    ]
  },
  'HTDG': {
    'floorPrice': 14.50,
    'currentPrice': 15.75,
    'sellOffers': [
      {'seller': 'HotdogKing', 'amount': '500', 'price': '15.00', 'rating': 4.9, 'trades': 876},
      {'seller': 'FoodToken', 'amount': '750', 'price': '15.50', 'rating': 4.7, 'trades': 432},
    ],
    'buyOffers': [
      {'buyer': 'HotdogFan', 'amount': '300', 'price': '14.00', 'rating': 4.8, 'trades': 234},
    ]
  },
  'CAT': {
    'floorPrice': 825.0,
    'currentPrice': 892.50,
    'sellOffers': [
      {'seller': 'CatLover', 'amount': '25', 'price': '850', 'rating': 5.0, 'trades': 567},
      {'seller': 'FelineTrader', 'amount': '40', 'price': '875', 'rating': 4.8, 'trades': 345},
    ],
    'buyOffers': [
      {'buyer': 'CatCollector', 'amount': '50', 'price': '820', 'rating': 4.9, 'trades': 423},
    ]
  },
  'EMRLD': {
    'floorPrice': 11500.0,
    'currentPrice': 12450.0,
    'sellOffers': [
      {'seller': 'EmeraldVault', 'amount': '8', 'price': '12,000', 'rating': 4.9, 'trades': 234},
      {'seller': 'GemTrader', 'amount': '12', 'price': '12,300', 'rating': 4.8, 'trades': 456},
    ],
    'buyOffers': [
      {'buyer': 'EmeraldSeeker', 'amount': '15', 'price': '11,500', 'rating': 4.7, 'trades': 189},
    ]
  },
  'LILA': {
    'floorPrice': 215.0,
    'currentPrice': 234.80,
    'sellOffers': [
      {'seller': 'LilaHolder', 'amount': '100', 'price': '225', 'rating': 4.8, 'trades': 678},
      {'seller': 'PurpleToken', 'amount': '150', 'price': '230', 'rating': 4.9, 'trades': 543},
    ],
    'buyOffers': [
      {'buyer': 'LilaInvestor', 'amount': '200', 'price': '215', 'rating': 4.9, 'trades': 345},
    ]
  },
  'MINRL': {
    'floorPrice': 3200.0,
    'currentPrice': 3567.25,
    'sellOffers': [
      {'seller': 'MineralMaster', 'amount': '20', 'price': '3,400', 'rating': 5.0, 'trades': 892},
      {'seller': 'RockCollector', 'amount': '35', 'price': '3,500', 'rating': 4.9, 'trades': 654},
    ],
    'buyOffers': [
      {'buyer': 'MineralWhale', 'amount': '50', 'price': '3,200', 'rating': 4.8, 'trades': 432},
    ]
  },
  'TBLUE': {
    'floorPrice': 62.0,
    'currentPrice': 67.90,
    'sellOffers': [
      {'seller': 'BlueTrader', 'amount': '400', 'price': '65.00', 'rating': 4.7, 'trades': 321},
      {'seller': 'TokenBlue', 'amount': '600', 'price': '67.00', 'rating': 4.8, 'trades': 456},
    ],
    'buyOffers': [
      {'buyer': 'BlueBuyer', 'amount': '800', 'price': '62.00', 'rating': 4.6, 'trades': 234},
    ]
  },
};

class TokenSellSheet extends StatefulWidget {
  final String tokenSymbol;
  final Map<String, dynamic>? tokenData;
  
  const TokenSellSheet({
    Key? key,
    required this.tokenSymbol,
    this.tokenData,
  }) : super(key: key);

  static void show(BuildContext context, {
    required String tokenSymbol,
    Map<String, dynamic>? tokenData,
  }) {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.7,
      child: TokenSellSheet(
        tokenSymbol: tokenSymbol,
        tokenData: tokenData,
      ),
    );
  }

  @override
  State<TokenSellSheet> createState() => _TokenSellSheetState();
}

class _TokenSellSheetState extends State<TokenSellSheet> {
  // Controllers
  final btcController = TextEditingController();
  final currController = TextEditingController();
  final satController = TextEditingController();
  final focusNode = FocusNode();
  
  // Sell price controllers
  final sellPriceBtcController = TextEditingController();
  final sellPriceSatController = TextEditingController();
  final sellPriceCurrController = TextEditingController();
  final sellPriceFocusNode = FocusNode();
  
  // State
  int sellStep = 1;
  String selectedPrice = '';
  String selectedAmount = '';
  
  @override
  void dispose() {
    btcController.dispose();
    currController.dispose();
    satController.dispose();
    focusNode.dispose();
    sellPriceBtcController.dispose();
    sellPriceSatController.dispose();
    sellPriceCurrController.dispose();
    sellPriceFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BitNet AppBar
        bitnetAppBar(
          context: context,
          text: sellStep == 1 ? 'Set Price' : sellStep == 2 ? 'Set Amount' : 'Order Overview',
          hasBackButton: sellStep == 1 ? false : true,
          onTap: () {
            if (sellStep == 3) {
              // Go back to amount step
              setState(() {
                sellStep = 2;
              });
            } else if (sellStep == 2) {
              // Go back to price step
              setState(() {
                sellStep = 1;
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
            child: sellStep == 1 
              ? _buildPriceStep() 
              : sellStep == 2 
                ? _buildAmountStep()
                : _buildOrderOverviewStep(),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPriceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price input section
        Text(
          'Your price per token',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // AmountWidget for price input (USD/currency mode)
        AmountWidget(
          enabled: () => true,
          btcController: sellPriceBtcController,
          satController: sellPriceSatController,
          currController: sellPriceCurrController,
          focusNode: sellPriceFocusNode,
          context: context,
          autoConvert: false,
          bitcoinUnit: BitcoinUnits.BTC,
          swapped: true, // Start in currency mode for price
          onAmountChange: (currencyType, text) {
            setState(() {});
          },
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Floor price info
        FloorPriceWidget(
          price: '\$${tokenMarketData[widget.tokenSymbol]?['floorPrice'] ?? '0'}',
          tokenSymbol: widget.tokenSymbol,
        ),
        
        SizedBox(height: AppTheme.elementSpacing.h),
        
        // Price comparison
        if (sellPriceCurrController.text.isNotEmpty && sellPriceCurrController.text != '0.00') ...[
          Container(
            padding: EdgeInsets.all(AppTheme.elementSpacing.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Price',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${sellPriceCurrController.text} per token',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Continue',
          buttonState: (sellPriceCurrController.text.isEmpty || sellPriceCurrController.text == '0.00') 
            ? ButtonState.disabled 
            : ButtonState.idle,
          onButtonTap: () {
            selectedPrice = sellPriceCurrController.text;
            setState(() {
              sellStep = 2;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildAmountStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price summary
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            border: Border.all(
              color: AppTheme.successColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: AppTheme.successColor,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Your price: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '\$$selectedPrice per token',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Amount input
        Text(
          'How many ${widget.tokenSymbol} to sell?',
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
        
        SizedBox(height: AppTheme.cardPadding.h),
        
        // Available tokens info
        Container(
          padding: EdgeInsets.all(AppTheme.elementSpacing.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: AppTheme.elementSpacing.w * 0.5),
              Text(
                'Available: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '2.5 ${widget.tokenSymbol}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Review Order',
          buttonState: (btcController.text.isEmpty || btcController.text == '0') 
            ? ButtonState.disabled 
            : ButtonState.idle,
          onButtonTap: () {
            selectedAmount = btcController.text;
            setState(() {
              sellStep = 3;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildOrderOverviewStep() {
    final double totalValue = (double.tryParse(selectedAmount) ?? 0) * (double.tryParse(selectedPrice) ?? 0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order summary card
        Container(
          padding: EdgeInsets.all(AppTheme.cardPadding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Token info
              Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _getTokenImagePath(widget.tokenSymbol),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selling ${widget.tokenData?['tokenName'] ?? widget.tokenSymbol}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          widget.tokenSymbol,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.cardPadding.h),
              
              // Order details
              _buildOrderDetailRow('Amount', '$selectedAmount ${widget.tokenSymbol}'),
              SizedBox(height: AppTheme.elementSpacing.h),
              _buildOrderDetailRow('Price per token', '\$$selectedPrice'),
              SizedBox(height: AppTheme.elementSpacing.h),
              Divider(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
              SizedBox(height: AppTheme.elementSpacing.h),
              _buildOrderDetailRow(
                'Total Value', 
                '\$${totalValue.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
        
        const Spacer(),
        
        // Bottom button with proper styling
        BottomCenterButton(
          buttonTitle: 'Put on Market',
          buttonState: ButtonState.idle,
          onButtonTap: () {
            Navigator.of(context).pop();
            Get.find<OverlayController>().showOverlay(
              'Successfully listed $selectedAmount ${widget.tokenSymbol} at \$$selectedPrice per token',
              color: AppTheme.successColor,
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildOrderDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal 
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: isTotal 
            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              )
            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
  
  // Helper to get token image path using centralized service
  String _getTokenImagePath(String tokenSymbol) {
    final metadata = TokenDataService.instance.getTokenMetadata(tokenSymbol);
    return metadata?['image'] ?? 'assets/images/bitcoin.png';
  }
}