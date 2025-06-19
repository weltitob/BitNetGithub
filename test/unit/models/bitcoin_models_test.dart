import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/models/bitcoin/fees.dart';
import 'package:bitnet/models/bitcoin/lnd/invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/mempool_models/validate_address_component.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

/// Unit tests for Bitcoin model classes
/// 
/// These tests verify the serialization/deserialization logic for
/// Bitcoin-related data models including fees, invoices, and address
/// validation components.
/// 
/// Test categories:
/// 1. Fee model serialization
/// 2. Invoice model serialization
/// 3. Received invoice model serialization
/// 4. Address validation model
/// 5. Bitcoin unit conversions
void main() {
  group('Bitcoin Models - Fees', () {
    test('should create Fees object with all properties', () {
      final fees = Fees(
        fees_low: '10',
        fees_medium: '20',
        fees_high: '30',
      );
      
      expect(fees.fees_low, equals('10'));
      expect(fees.fees_medium, equals('20'));
      expect(fees.fees_high, equals('30'));
    });

    test('should handle empty fee values', () {
      final fees = Fees(
        fees_low: '',
        fees_medium: '',
        fees_high: '',
      );
      
      expect(fees.fees_low, equals(''));
      expect(fees.fees_medium, equals(''));
      expect(fees.fees_high, equals(''));
    });

    test('should handle numeric string fee values', () {
      final fees = Fees(
        fees_low: '0',
        fees_medium: '100',
        fees_high: '999999',
      );
      
      expect(fees.fees_low, equals('0'));
      expect(fees.fees_medium, equals('100'));
      expect(fees.fees_high, equals('999999'));
    });
    
    test('should create Fees from JSON', () {
      final json = {
        'fees_low': 10,
        'fees_medium': 20,
        'fees_high': 30,
      };
      
      final fees = Fees.fromJson(json);
      
      expect(fees.fees_low, equals('10'));
      expect(fees.fees_medium, equals('20'));
      expect(fees.fees_high, equals('30'));
    });
  });

  group('Bitcoin Models - Simple Invoice Model', () {
    test('should create InvoiceModel with all properties', () {
      final invoice = InvoiceModel(
        r_hash: 'hash123',
        payment_request: 'lnbc1000...',
        add_index: '1',
        payment_addr: 'payment_addr_123',
        state: 'SETTLED',
      );
      
      expect(invoice.r_hash, equals('hash123'));
      expect(invoice.payment_request, equals('lnbc1000...'));
      expect(invoice.add_index, equals('1'));
      expect(invoice.payment_addr, equals('payment_addr_123'));
      expect(invoice.state, equals('SETTLED'));
    });

    test('should handle different invoice states', () {
      final states = ['OPEN', 'SETTLED', 'CANCELED', 'ACCEPTED'];
      
      for (final state in states) {
        final invoice = InvoiceModel(
          r_hash: 'hash123',
          payment_request: 'lnbc1000...',
          add_index: '1', 
          payment_addr: 'payment_addr_123',
          state: state,
        );
        expect(invoice.state, equals(state));
      }
    });
    
    test('should convert InvoiceModel to/from JSON', () {
      final json = {
        'r_hash': 'hash123',
        'payment_request': 'lnbc1000...',
        'add_index': '1',
        'payment_addr': 'payment_addr_123',
        'state': 'SETTLED',
      };
      
      final invoice = InvoiceModel.fromJson(json);
      
      expect(invoice.r_hash, equals('hash123'));
      expect(invoice.payment_request, equals('lnbc1000...'));
      expect(invoice.add_index, equals('1'));
      expect(invoice.payment_addr, equals('payment_addr_123'));
      expect(invoice.state, equals('SETTLED'));
      
      final map = invoice.toMap();
      expect(map['r_hash'], equals('hash123'));
      expect(map['state'], equals('SETTLED'));
    });
  });

  group('Bitcoin Models - Received Invoice Model', () {
    test('should create ReceivedInvoice with all properties', () {
      final invoice = ReceivedInvoice(
        memo: 'Test payment',
        rPreimage: 'preimage123',
        rHash: 'hash123',
        value: 1000,
        valueMsat: 1000000,
        settled: true,
        creationDate: 1234567890,
        settleDate: 1234567900,
        paymentRequest: 'lnbc1000...',
        state: 'SETTLED',
        amtPaid: 1000,
        amtPaidSat: 1000,
        amtPaidMsat: 1000000,
      );
      
      expect(invoice.memo, equals('Test payment'));
      expect(invoice.value, equals(1000));
      expect(invoice.settled, isTrue);
      expect(invoice.state, equals('SETTLED'));
      expect(invoice.amtPaidSat, equals(1000));
    });

    test('should convert ReceivedInvoice to JSON correctly', () {
      final invoice = ReceivedInvoice(
        memo: 'Coffee payment',
        rPreimage: 'preimage456',
        rHash: 'hash456',
        value: 2000,
        valueMsat: 2000000,
        settled: false,
        creationDate: 1234567890,
        settleDate: 0,
        paymentRequest: 'lnbc2000...',
        state: 'OPEN',
        amtPaid: 0,
        amtPaidSat: 0,
        amtPaidMsat: 0,
      );
      
      final json = invoice.toJson();
      
      expect(json['memo'], equals('Coffee payment'));
      expect(json['value'], equals(2000));
      expect(json['settled'], isFalse);
      expect(json['payment_request'], equals('lnbc2000...'));
      expect(json['state'], equals('OPEN'));
    });

    test('should create ReceivedInvoice from JSON correctly', () {
      final json = {
        'memo': 'Test invoice',
        'r_preimage': 'preimage789',
        'r_hash': 'hash789',
        'value': '5000',
        'value_msat': '5000000',
        'settled': true,
        'creation_date': '1234567890',
        'settle_date': '1234567900',
        'payment_request': 'lnbc5000...',
        'state': 'SETTLED',
        'amt_paid': '5000',
        'amt_paid_sat': '5000',
        'amt_paid_msat': '5000000',
      };
      
      final invoice = ReceivedInvoice.fromJson(json);
      
      expect(invoice.memo, equals('Test invoice'));
      expect(invoice.value, equals(5000));
      expect(invoice.settled, isTrue);
      expect(invoice.paymentRequest, equals('lnbc5000...'));
      expect(invoice.creationDate, equals(1234567890));
    });

    test('should handle ReceivedInvoicesList', () {
      final invoices = [
        ReceivedInvoice(
          memo: 'Invoice 1',
          rPreimage: 'pre1',
          rHash: 'hash1',
          value: 1000,
          valueMsat: 1000000,
          settled: true,
          creationDate: 1234567890,
          settleDate: 1234567900,
          paymentRequest: 'lnbc1000...',
          state: 'SETTLED',
          amtPaid: 1000,
          amtPaidSat: 1000,
          amtPaidMsat: 1000000,
        ),
        ReceivedInvoice(
          memo: 'Invoice 2',
          rPreimage: 'pre2',
          rHash: 'hash2',
          value: 2000,
          valueMsat: 2000000,
          settled: true,
          creationDate: 1234567890,
          settleDate: 1234567900,
          paymentRequest: 'lnbc2000...',
          state: 'SETTLED',
          amtPaid: 2000,
          amtPaidSat: 2000,
          amtPaidMsat: 2000000,
        ),
      ];
      
      final list = ReceivedInvoicesList(invoices: invoices);
      
      expect(list.invoices.length, equals(2));
      expect(list.invoices[0].memo, equals('Invoice 1'));
      expect(list.invoices[1].value, equals(2000));
    });
    
    test('should convert ReceivedInvoicesList from JSON', () {
      final json = {
        'invoices': [
          {
            'memo': 'Test 1',
            'r_preimage': 'pre1',
            'r_hash': 'hash1',
            'value': '100',
            'value_msat': '100000',
            'settled': true,
            'creation_date': '1234567890',
            'settle_date': '1234567900',
            'payment_request': 'lnbc100...',
            'state': 'SETTLED',
            'amt_paid': '100',
            'amt_paid_sat': '100',
            'amt_paid_msat': '100000',
          },
          {
            'memo': 'Test 2',
            'r_preimage': 'pre2',
            'r_hash': 'hash2',
            'value': '200',
            'value_msat': '200000',
            'settled': true,
            'creation_date': '1234567890',
            'settle_date': '1234567900',
            'payment_request': 'lnbc200...',
            'state': 'SETTLED',
            'amt_paid': '200',
            'amt_paid_sat': '200',
            'amt_paid_msat': '200000',
          },
        ],
      };
      
      final list = ReceivedInvoicesList.fromJson(json);
      expect(list.invoices.length, equals(2));
      expect(list.invoices[0].memo, equals('Test 1'));
      expect(list.invoices[1].value, equals(200));
    });
  });

  group('Bitcoin Models - Address Validation', () {
    test('should create ValidateAddressComponentModel correctly', () {
      final model = ValidateAddressComponentModel(
        isvalid: true,
        address: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
        scriptPubKey: '0014...',
        isscript: false,
        iswitness: true,
      );
      
      expect(model.isvalid, isTrue);
      expect(model.address, equals('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'));
      expect(model.iswitness, isTrue);
      expect(model.isscript, isFalse);
    });

    test('should convert ValidateAddressComponentModel to/from JSON', () {
      final json = {
        'isvalid': true,
        'address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
        'scriptPubKey': '0014...',
        'isscript': false,
        'iswitness': true,
      };
      
      final model = ValidateAddressComponentModel.fromJson(json);
      
      expect(model.isvalid, isTrue);
      expect(model.address, equals('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'));
      expect(model.iswitness, isTrue);
      
      final toJson = model.toJson();
      expect(toJson['isvalid'], isTrue);
      expect(toJson['address'], equals('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'));
    });

    test('should handle different address types', () {
      // P2PKH address
      final p2pkh = ValidateAddressComponentModel(
        isvalid: true,
        address: '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
        scriptPubKey: '76a914...',
        isscript: false,
        iswitness: false,
      );
      expect(p2pkh.isscript, isFalse);
      expect(p2pkh.iswitness, isFalse);
      
      // P2SH address
      final p2sh = ValidateAddressComponentModel(
        isvalid: true,
        address: '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy',
        scriptPubKey: 'a914...',
        isscript: true,
        iswitness: false,
      );
      expect(p2sh.isscript, isTrue);
      expect(p2sh.iswitness, isFalse);
      
      // Bech32 address
      final bech32 = ValidateAddressComponentModel(
        isvalid: true,
        address: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
        scriptPubKey: '0014...',
        isscript: false,
        iswitness: true,
      );
      expect(bech32.iswitness, isTrue);
    });
  });

  group('Bitcoin Models - Bitcoin Units', () {
    test('should convert BitcoinUnits enum to string correctly', () {
      // Only BTC and SAT units exist in the actual enum
      expect(BitcoinUnitModel(bitcoinUnit: BitcoinUnits.BTC, amount: 1.0).bitcoinUnitAsString, equals('BTC'));
      expect(BitcoinUnitModel(bitcoinUnit: BitcoinUnits.SAT, amount: 100).bitcoinUnitAsString, equals('SAT'));
    });

    test('should handle unit conversions with amount', () {
      final btcModel = BitcoinUnitModel(
        bitcoinUnit: BitcoinUnits.BTC,
        amount: 1.0,
      );
      expect(btcModel.bitcoinUnit, equals(BitcoinUnits.BTC));
      expect(btcModel.amount, equals(1.0));
      expect(btcModel.bitcoinUnitAsString, equals('BTC'));
      
      final satModel = BitcoinUnitModel(
        bitcoinUnit: BitcoinUnits.SAT,
        amount: 100000000,
      );
      expect(satModel.bitcoinUnit, equals(BitcoinUnits.SAT));
      expect(satModel.amount, equals(100000000));
      expect(satModel.bitcoinUnitAsString, equals('SAT'));
    });

    test('should create consistent models', () {
      final model1 = BitcoinUnitModel(bitcoinUnit: BitcoinUnits.BTC, amount: 1.0);
      final model2 = BitcoinUnitModel(bitcoinUnit: BitcoinUnits.BTC, amount: 1.0);
      
      expect(model1.bitcoinUnit, equals(model2.bitcoinUnit));
      expect(model1.bitcoinUnitAsString, equals(model2.bitcoinUnitAsString));
    });
  });
}