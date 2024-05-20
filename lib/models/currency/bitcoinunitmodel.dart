
enum BitcoinUnits { BTC, SAT, }

class BitcoinUnitModel {
  // The Bitcoin unit using the BitcoinUnits enum
  BitcoinUnits bitcoinUnit;

  // The amount represented as a double (or any appropriate type)
  var amount;

  // Constructor for the model
  BitcoinUnitModel({required this.bitcoinUnit, required this.amount});

  // A method to get the string representation of the Bitcoin unit
  String get bitcoinUnitAsString {
    switch (bitcoinUnit) {
      case BitcoinUnits.BTC:
        return 'BTC';
      case BitcoinUnits.SAT:
        return 'SAT';
      default:
        return 'Unknown Unit';
    }
  }

  // Example method to print details of the model (optional)
  void printDetails() {
    print('Unit: $bitcoinUnitAsString, Amount: $amount');
  }
}