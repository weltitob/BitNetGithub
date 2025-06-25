class LoopTerms {
  final String minSwapAmount;
  final String maxSwapAmount;
  final int cltvDelta;
  final String? maxSwapFee;
  final String? maxMinerFee;
  final String? maxPrepayAmt;

  LoopTerms({
    required this.minSwapAmount,
    required this.maxSwapAmount,
    required this.cltvDelta,
    this.maxSwapFee,
    this.maxMinerFee,
    this.maxPrepayAmt,
  });

  factory LoopTerms.fromJson(Map<String, dynamic> json) {
    return LoopTerms(
      minSwapAmount: json['min_swap_amount'] ?? '0',
      maxSwapAmount: json['max_swap_amount'] ?? '0',
      cltvDelta: json['cltv_delta'] ?? 0,
      maxSwapFee: json['max_swap_fee'],
      maxMinerFee: json['max_miner_fee'],
      maxPrepayAmt: json['max_prepay_amt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min_swap_amount': minSwapAmount,
      'max_swap_amount': maxSwapAmount,
      'cltv_delta': cltvDelta,
      'max_swap_fee': maxSwapFee,
      'max_miner_fee': maxMinerFee,
      'max_prepay_amt': maxPrepayAmt,
    };
  }

  // Convert string amounts to integers for comparison
  int get minSwapAmountInt => int.tryParse(minSwapAmount) ?? 0;
  int get maxSwapAmountInt => int.tryParse(maxSwapAmount) ?? 0;

  // Helper method to check if an amount is within valid range
  bool isAmountValid(int amount) {
    return amount >= minSwapAmountInt && amount <= maxSwapAmountInt;
  }

  // Helper method to get formatted minimum amount for display
  String getFormattedMinAmount() {
    final minSats = minSwapAmountInt;
    if (minSats >= 100000000) {
      return '${(minSats / 100000000).toStringAsFixed(2)} BTC';
    } else if (minSats >= 1000) {
      return '${(minSats / 1000).toStringAsFixed(0)}k sats';
    } else {
      return '$minSats sats';
    }
  }

  // Helper method to get formatted maximum amount for display
  String getFormattedMaxAmount() {
    final maxSats = maxSwapAmountInt;
    if (maxSats >= 100000000) {
      return '${(maxSats / 100000000).toStringAsFixed(2)} BTC';
    } else if (maxSats >= 1000000) {
      return '${(maxSats / 1000000).toStringAsFixed(1)}M sats';
    } else if (maxSats >= 1000) {
      return '${(maxSats / 1000).toStringAsFixed(0)}k sats';
    } else {
      return '$maxSats sats';
    }
  }
}
