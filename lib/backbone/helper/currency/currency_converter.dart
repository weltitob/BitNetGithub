import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

class CurrencyConverter {
  static String convertCurrency(String inputCurrency, double amount,
      String outputCurrency, double? bitcoinPrice,
      {bool fixed = true}) {
    try {
      if (inputCurrency == outputCurrency) {
        return amount.toStringAsFixed(2);
      } else if (inputCurrency == "BTC") {
        return (amount * bitcoinPrice!).toStringAsFixed(8);
      } else if (inputCurrency == "BTC" && outputCurrency == "SATS") {
        return convertBitcoinToSats(amount).toStringAsFixed(8);
      } else if (inputCurrency == "SATS" && outputCurrency == "BTC") {
        return convertSatoshiToBTC(amount).toStringAsFixed(0);
      } else if (outputCurrency == "SAT") {
        return (amount / bitcoinPrice! * 100000000).toStringAsFixed(2);
      } else if (outputCurrency == "BTC") {
        return (amount / bitcoinPrice!).toStringAsFixed(8);
      } else {
        if (fixed)
          return (amount * bitcoinPrice! / 100000000).toStringAsFixed(2);
        return (amount * bitcoinPrice! / 100000000).toString();
      }
    } catch (e) {
      throw Exception("Error converting currency: $e");
    }
  }

  static BitcoinUnitModel convertToBitcoinUnit(
      double amount, BitcoinUnits unit) {
    double absAmount = amount.abs();
    //100k sats is the conversion to BTC
    if (unit == BitcoinUnits.SAT && absAmount > 100000) {
      return BitcoinUnitModel(
          amount: convertSatoshiToBTC(amount), bitcoinUnit: BitcoinUnits.BTC);
      //under 100k sats convert to sats
    } else if (unit == BitcoinUnits.BTC && absAmount < 0.001) {
      return BitcoinUnitModel(
          amount: convertBitcoinToSats(amount).toInt(),
          bitcoinUnit: BitcoinUnits.SAT);
    } else {
      if (unit == BitcoinUnits.SAT) {
        return BitcoinUnitModel(bitcoinUnit: unit, amount: amount.toInt());
      }
      return BitcoinUnitModel(
        amount: amount,
        bitcoinUnit: unit,
      );
    }
  }

  static double convertBitcoinToSats(double amount) {
    // Multiply and round to avoid floating point precision issues
    // Round to nearest integer since satoshis are indivisible
    return (amount * 100000000).roundToDouble();
  }

  static double convertSatoshiToBTC(double amount) {
    return (amount / 100000000);
  }
}
