# BitNET Unit Test TODO List

This document lists simple, pure functions that are perfect candidates for unit testing. These functions have minimal risk and are easy to test correctly.

## Priority 1: Currency & Bitcoin Core Functions (Critical for App Functionality)

### Currency Conversion Functions
**File**: `lib/backbone/helper/currency/currency_converter.dart`

- [ ] `convertBitcoinToSats(double amount)`
  - Test cases: 0, 1, 0.00000001, 21000000, negative values
  - Expected: Multiplies by 100,000,000

- [ ] `convertSatoshiToBTC(double amount)`
  - Test cases: 0, 1, 100000000, 2100000000000000, negative values
  - Expected: Divides by 100,000,000

- [ ] `convertCurrency(String inputCurrency, double amount, String outputCurrency, double? bitcoinPrice)`
  - Test cases: BTC->USD, USD->BTC, EUR->USD, edge cases with null price
  - Expected: Correct conversion based on exchange rates

- [ ] `convertToBitcoinUnit(double amount, BitcoinUnits unit)`
  - Test cases: Various amounts with BTC, mBTC, μBTC, SAT units
  - Expected: Smart unit selection based on amount size

### Bitcoin Address Validation
**File**: `lib/backbone/helper/helpers.dart`

- [ ] `isCompressedPublicKey(String input)`
  - Test cases: Valid compressed keys (02..., 03...), invalid formats, wrong lengths
  - Expected: True for valid 66-char hex strings starting with 02/03

- [ ] `isValidBitcoinTransactionID(String input)`
  - Test cases: Valid txids, wrong lengths, non-hex characters
  - Expected: True for 64-character hexadecimal strings

- [ ] `isValidBitcoinAddressHash(String input)`
  - Test cases: Valid hashes, wrong lengths, invalid characters
  - Expected: True for valid Bitcoin address hashes

- [ ] `isStringALNInvoice(String input)`
  - Test cases: Valid Lightning invoices (lnbc...), invalid prefixes, malformed
  - Expected: True for valid BOLT11 invoice format

- [ ] `isLightningAdressAsMail(String input)`
  - Test cases: user@domain.com, invalid emails, missing @ or domain
  - Expected: True for valid Lightning address format

- [ ] `isBip21WithBolt11(String input)`
  - Test cases: bitcoin:address?lightning=lnbc..., missing parts, invalid format
  - Expected: True for valid BIP21 with Lightning parameter

## Priority 2: Date/Time & String Utilities (User-Facing Features)

### Date/Time Formatting
**File**: `lib/backbone/helper/helpers.dart`

- [ ] `displayTimeAgoFromTimestamp(String publishedAt, {bool numericDates = true})`
  - Test cases: Now, 1 min ago, 1 hour ago, yesterday, last week, last month
  - Expected: Correct relative time strings

- [ ] `displayTimeAgoFromInt(int time, {bool numericDates = true, String language = 'de'})`
  - Test cases: Various timestamps, different languages (de, en)
  - Expected: Localized relative time strings

- [ ] `convertIntoDateFormat(int time)`
  - Test cases: Various timestamps, edge cases (year 1970, future dates)
  - Expected: Formatted date strings

- [ ] `timeNow()`
  - Test cases: Verify returns current timestamp
  - Expected: Milliseconds since epoch

### String Utilities
**File**: `lib/backbone/helper/helpers.dart`

- [ ] `getRandomString(int length)`
  - Test cases: length 0, 1, 10, 100
  - Expected: Alphanumeric string of specified length

- [ ] `containsSixIntegers(String input)`
  - Test cases: "123456", "12345", "1234567", "abc123456", "123 456"
  - Expected: True only for strings with exactly 6 consecutive digits

- [ ] `toPercent(double value)`
  - Test cases: 0.0, 0.5, 1.0, 10.5, -0.5
  - Expected: Formatted percentage string

## Priority 3: Model Serialization (Data Integrity)

### Fee Model
**File**: `lib/models/bitcoin/fees.dart`

- [ ] `Fees.toMap()`
  - Test cases: Various fee configurations
  - Expected: Correct Map representation

- [ ] `Fees.fromJson(String source)`
  - Test cases: Valid JSON, invalid JSON, missing fields
  - Expected: Correct Fees object or error

- [ ] `Fees.copyWith()`
  - Test cases: Partial updates, null values
  - Expected: New object with updated fields

### Invoice Model
**File**: `lib/models/bitcoin/invoice.dart`

- [ ] `InvoiceModel.toMap()`
  - Test cases: Complete invoice, partial data
  - Expected: Correct Map representation

- [ ] `InvoiceModel.fromJson(Map<String, dynamic> json)`
  - Test cases: Valid data, missing required fields
  - Expected: Correct InvoiceModel or error

### Currency Models
**File**: `lib/models/currency/`

- [ ] `BitcoinUnitModel.bitcoinUnitAsString` getter
  - Test cases: All enum values (BTC, mBTC, μBTC, SAT)
  - Expected: Correct string representation

- [ ] `allCurrenciesFromJson(String str)`
  - Test cases: Valid JSON, empty JSON, malformed JSON
  - Expected: Map<String, String> or error

## Priority 4: Utility Functions (App Features)

### Feature Detection
**File**: `lib/backbone/mempool_utils.dart`

- [ ] `AppUtils.isFeatureActive(String network, int height, String feature)`
  - Test cases: mainnet/testnet, various heights, SegWit/Taproot features
  - Expected: Correct activation status

### Color Utilities
**File**: `lib/pages/secondpages/mempool/colorhelper.dart`

- [ ] `getGradientColors(double medianFee, bool isAccepted)`
  - Test cases: Various fee levels (0, 10, 100, 1000), accepted/rejected
  - Expected: Appropriate color arrays

### Exchange Rate Conversion
**File**: `lib/backbone/helper/utils.dart`

- [ ] `Utils.convert(Map exchangeRates, String amount, String currencyBase, String currencyFinal)`
  - Test cases: Various currency pairs, edge cases (same currency, missing rates)
  - Expected: Correct converted amounts

## Testing Guidelines

### For Each Function Test:

1. **Happy Path**: Normal, expected inputs
2. **Edge Cases**: Boundary values (0, max values, empty strings)
3. **Error Cases**: Invalid inputs, null values where applicable
4. **Type Safety**: Wrong types if dynamically typed

### Example Test Structure:

```dart
import 'package:test/test.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';

void main() {
  group('CurrencyConverter', () {
    test('convertBitcoinToSats converts correctly', () {
      expect(convertBitcoinToSats(1.0), equals(100000000));
      expect(convertBitcoinToSats(0.00000001), equals(1));
      expect(convertBitcoinToSats(0), equals(0));
    });
    
    test('convertBitcoinToSats handles edge cases', () {
      expect(convertBitcoinToSats(21000000), equals(2100000000000000));
      // Add more edge cases
    });
  });
}
```

## Benefits of Testing These Functions

1. **Zero Risk**: Pure functions with no side effects
2. **High Value**: Core functionality used throughout the app
3. **Easy to Test**: Clear inputs and outputs
4. **Fast Execution**: No async operations or external dependencies
5. **Regression Prevention**: Catch breaking changes early
6. **Documentation**: Tests serve as usage examples

## Recommended Testing Order

1. Start with currency conversion (most critical)
2. Move to Bitcoin validation (security-critical)
3. Add date/time formatting (user-visible)
4. Complete with models and utilities

Total functions to test: ~40
Estimated time per function with tests: 15-30 minutes
Total estimated time: 10-20 hours for comprehensive coverage