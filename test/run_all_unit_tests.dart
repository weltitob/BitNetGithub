import 'package:flutter_test/flutter_test.dart';

// Import all unit test files
import 'unit/currency/currency_converter_test.dart' as currency_tests;
import 'unit/bitcoin/bitcoin_validation_test.dart' as bitcoin_tests;
import 'unit/utils/date_time_utils_test.dart' as datetime_tests;
import 'unit/utils/string_utils_test.dart' as string_tests;
import 'unit/models/bitcoin_models_test.dart' as model_tests;
import 'unit/receive/receive_controller_simple_test.dart' as receive_controller_tests;
import 'unit/receive/receive_models_test.dart' as receive_model_tests;
import 'unit/receive/receive_cloud_functions_test.dart' as receive_cloud_tests;

/// Main test runner for all unit tests
/// 
/// This file imports and runs all unit tests in the project.
/// Run this file to execute the complete unit test suite.
/// 
/// Usage:
/// ```bash
/// flutter test test/run_all_unit_tests.dart
/// ```
/// 
/// Or run with coverage:
/// ```bash
/// flutter test --coverage test/run_all_unit_tests.dart
/// ```
void main() {
  // Print test suite header
  print('=' * 60);
  print('BitNET Unit Test Suite');
  print('=' * 60);
  
  group('Currency Conversion Tests', () {
    currency_tests.main();
  });
  
  group('Bitcoin Validation Tests', () {
    bitcoin_tests.main();
  });
  
  group('Date/Time Utility Tests', () {
    datetime_tests.main();
  });
  
  group('String Utility Tests', () {
    string_tests.main();
  });
  
  group('Model Serialization Tests', () {
    model_tests.main();
  });
  
  group('Receive Controller Tests', () {
    receive_controller_tests.main();
  });
  
  group('Receive Models Tests', () {
    receive_model_tests.main();
  });
  
  group('Receive Cloud Functions Tests', () {
    receive_cloud_tests.main();
  });
}