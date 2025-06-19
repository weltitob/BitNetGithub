import 'package:flutter_test/flutter_test.dart';

// Import all test files to check for compilation errors
import 'test/unit/currency/currency_converter_test.dart';
import 'test/unit/bitcoin/bitcoin_validation_test.dart';
import 'test/unit/utils/date_time_utils_test.dart';
import 'test/unit/utils/string_utils_test.dart';
import 'test/unit/models/bitcoin_models_test.dart';
import 'test/run_all_unit_tests.dart';

void main() {
  test('Compilation check', () {
    // This test simply ensures all imports compile successfully
    expect(true, isTrue);
  });
}