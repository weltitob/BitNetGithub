# BitNET Unit Tests

This directory contains unit tests for the BitNET application, organized by functionality and focusing on pure, easily testable functions.

## Structure

```
test/
├── unit/                    # Unit tests for pure functions
│   ├── currency/           # Currency conversion tests
│   ├── bitcoin/            # Bitcoin validation tests
│   ├── utils/              # Utility function tests
│   └── models/             # Model serialization tests
├── run_all_unit_tests.dart # Main test runner
├── TESTING_STRATEGY.md     # Overall testing strategy
└── UNITTEST_TODO.md        # List of functions to test
```

## Running Tests

# Run all tests
flutter test test/run_all_unit_tests.dart

# Run specific category
flutter test test/unit/currency/

# Run with coverage
flutter test --coverage
4. Safe Functions Only:
   - Only pure functions (no side effects)
   - No external dependencies
   - Deterministic results
   - Clear inputs and outputs

### Run all unit tests:
```bash
flutter test test/run_all_unit_tests.dart
```

### Run specific test categories:
```bash
# Currency conversion tests only
flutter test test/unit/currency/

# Bitcoin validation tests only
flutter test test/unit/bitcoin/

# Utility tests only
flutter test test/unit/utils/

# Model tests only
flutter test test/unit/models/
```

### Run with coverage:
```bash
flutter test --coverage test/run_all_unit_tests.dart
```

### Generate coverage report:
```bash
# Generate coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```

## Test Categories

### 1. Currency Conversion Tests (`unit/currency/`)
- Bitcoin to Satoshi conversion
- Satoshi to Bitcoin conversion
- Fiat currency exchange
- Smart unit selection

### 2. Bitcoin Validation Tests (`unit/bitcoin/`)
- Compressed public key validation
- Transaction ID validation
- Lightning invoice validation
- Lightning address validation
- BIP21 URI validation

### 3. Utility Tests (`unit/utils/`)
- Date/time formatting
- Random string generation
- Percentage formatting
- Color generation
- Numeric validation

### 4. Model Tests (`unit/models/`)
- Fee model serialization
- Invoice model serialization
- Address validation model
- Bitcoin unit conversions

## Test Guidelines

### Writing New Tests

1. **Keep tests pure**: Test only the function logic, not external dependencies
2. **Test edge cases**: Include tests for boundaries, nulls, and invalid inputs
3. **Use descriptive names**: Test names should clearly indicate what is being tested
4. **Group related tests**: Use `group()` to organize related test cases
5. **Add comments**: Explain complex test scenarios or expected behaviors

### Test Structure Example

```dart
group('Function Category', () {
  test('should handle normal case', () {
    // Arrange
    final input = 'test';
    
    // Act
    final result = functionUnderTest(input);
    
    // Assert
    expect(result, equals('expected'));
  });
  
  test('should handle edge case', () {
    expect(() => functionUnderTest(null), throwsException);
  });
});
```

## Coverage Goals

- **Minimum coverage**: 80% for all tested functions
- **Critical functions**: 95% coverage (currency conversion, Bitcoin validation)
- **Focus on**: Business logic, not UI or external service calls

## Adding New Tests

1. Identify pure functions in the codebase
2. Create appropriate test file in the correct subdirectory
3. Write comprehensive tests covering:
   - Happy path
   - Edge cases
   - Error conditions
   - Boundary values
4. Add import to `run_all_unit_tests.dart`
5. Run tests to ensure they pass
6. Check coverage meets requirements

## Continuous Integration

These tests are designed to run quickly (< 30 seconds total) and should be integrated into the CI/CD pipeline to run on every commit.

## Next Steps

See `UNITTEST_TODO.md` for a list of additional functions that should be tested.