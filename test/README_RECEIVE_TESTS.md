# Receive Payment Flow Tests

This directory contains implementation tests for the Lightning and Onchain receive payment flows in BitNET.

## Test Structure

The receive tests are split into two separate integration tests in the `integration/receive/` folder:

### 1. `integration/receive/lightning_receive_test.dart`
Tests for Lightning invoice creation and management:
- Lightning invoice creation with amount and memo
- Invoice clipboard copy functionality
- Amount validation (empty, zero, invalid)
- Invoice format validation
- Success message display and timeout
- QR code button functionality
- Invoice creation without memo

### 2. `integration/receive/onchain_receive_test.dart`
Tests for Bitcoin onchain address generation:
- Automatic address generation on screen load
- Address clipboard copy functionality
- New address generation with refresh button
- Address format validation (Bech32, P2PKH, P2SH)
- Address type identification (SegWit, Taproot, Legacy)
- Warning message display
- Multiple address generation

## Running the Tests

### Run all receive tests:
```bash
flutter test test/widget/receive_flow_widget_test.dart
```

### Run specific test group:
```bash
flutter test test/widget/receive_flow_widget_test.dart --name "Lightning Receive Flow Tests"
```

### Run with coverage:
```bash
flutter test --coverage test/widget/receive_flow_widget_test.dart
```

## Test Scenarios Covered

### Lightning Receive Flow:
1. ✅ Create Lightning invoice with amount and memo
2. ✅ Copy invoice to clipboard
3. ✅ Validate invoice format (lnbc, lntb, lnbcrt prefixes)
4. ✅ Show error when amount is empty
5. ✅ Display success message after copying

### Onchain Receive Flow:
1. ✅ Auto-generate Bitcoin address on screen load
2. ✅ Copy address to clipboard
3. ✅ Generate new address with refresh button
4. ✅ Validate Bitcoin address formats (P2PKH, P2SH, Bech32)
5. ✅ Display success message after copying

### Wallet Screen Navigation:
1. ✅ Navigate to Lightning receive by default
2. ✅ Show receive type selection dialog
3. ✅ Navigate to correct receive screen based on selection

## Key Test Patterns

### 1. Clipboard Testing
```dart
// Set clipboard before test
await Clipboard.setData(ClipboardData(text: ''));

// Verify clipboard after action
final clipboardData = await Clipboard.getData('text/plain');
expect(clipboardData?.text, equals(expectedValue));
```

### 2. Widget Interaction
```dart
// Enter text
await tester.enterText(find.byType(TextField).first, '1000');

// Tap button
await tester.tap(find.text('Create Invoice'));
await tester.pumpAndSettle();

// Verify result
expect(find.textContaining('lnbc'), findsOneWidget);
```

### 3. Navigation Testing
```dart
// Navigate to new screen
await tester.tap(find.text('Receive'));
await tester.pumpAndSettle();

// Verify navigation
expect(find.text('Lightning'), findsOneWidget);
```

## Adding New Tests

To add new receive flow tests:

1. Add test cases to the appropriate group in `receive_flow_widget_test.dart`
2. Follow the existing patterns for widget testing
3. Use the mock screens for isolated testing
4. Add validation functions as needed

## Common Issues and Solutions

### Issue: Clipboard tests failing
**Solution**: Ensure `TestWidgetsFlutterBinding.ensureInitialized()` is called in `main()`

### Issue: Navigation tests not working
**Solution**: Use `pumpAndSettle()` instead of just `pump()` after navigation

### Issue: Async operations not completing
**Solution**: Use appropriate delays with `await tester.pump(Duration(seconds: 1))`