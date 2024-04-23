import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:flutter/material.dart';

class CurrencyConverter {

  static String convertCurrency(String inputCurrency, double amount,
      String outputCurrency, double? bitcoinPrice) {
    try {
      if (inputCurrency == outputCurrency) {
        return amount.toStringAsFixed(2);
      } else if (inputCurrency == "BTC") {
        return (amount * bitcoinPrice!).toStringAsFixed(8);
      }
      else if (inputCurrency == "BTC" && outputCurrency == "SATS") {
        return convertBitcoinToSats(amount).toStringAsFixed(8);
      }
      else if (inputCurrency == "SATS" && outputCurrency == "BTC") {
        return convertSatoshiToBTC(amount).toStringAsFixed(0);
      }
      else if(inputCurrency == "USD" && outputCurrency == "SAT") {
        return (amount / bitcoinPrice! * 100000000).toStringAsFixed(2);
      }
       else if(inputCurrency == "USD" && outputCurrency == "BTC") {
        return (amount / bitcoinPrice!).toStringAsFixed(8);
      }
      else {
        return (amount * bitcoinPrice! / 100000000).toStringAsFixed(8);
      }
    } catch (e) {
      throw Exception("Error converting currency: $e");
    }
  }

  static BitcoinUnitModel convertToBitcoinUnit(double amount, BitcoinUnits unit) {
    //100k sats is the conversion to BTC
    if(unit == BitcoinUnits.SAT && amount > 10000) {
      return BitcoinUnitModel(
          amount: convertSatoshiToBTC(amount),
          bitcoinUnit: BitcoinUnits.BTC
      );
      //under 100k sats convert to sats
    } else if (unit == BitcoinUnits.BTC && amount < 0.001) {
      return BitcoinUnitModel(
          amount: convertBitcoinToSats(amount),
          bitcoinUnit: BitcoinUnits.SAT
      );
    } else{
      return BitcoinUnitModel(
          amount: amount,
          bitcoinUnit: unit,
      ); 
    }
  }

  static double convertBitcoinToSats(double amount) {
    return (amount * 100000000);
  }

  static double convertSatoshiToBTC(double amount) {
    return (amount / 100000000);
  }
}