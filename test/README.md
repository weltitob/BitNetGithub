# BitNET Test Suite

This directory contains tests for the BitNET one-user-one-node payment architecture.

## Test Node Configuration

We have **two testnet Lightning nodes** running through Caddy proxy:

### Node 1 - Authentication & Setup Node
- **Node ID**: `node1`
- **Purpose**: Used for authentication tests and initial user setup
- **Usage**: 
  - User registration
  - Lightning identity generation
  - Initial wallet creation
  - Authentication flows

### Node 2 - Payment Operations Node
- **Node ID**: `node2` 
- **Purpose**: Used for all payment functionality tests after user signup
- **Usage**:
  - Lightning payments (sending/receiving)
  - Onchain transactions
  - Address generation
  - Balance operations
  - Invoice creation

## Test Credentials & Configuration

All credentials and configuration needed to access `node2` for payment tests are available in this folder:

### Configuration Files:
- `test_config.json` - Contains node endpoints and test user data
- `node2_macaroon.hex` - Admin macaroon for node2 (if needed)
- `test_wallets.json` - Pre-funded test wallet information

### Example Test Configuration:
```dart
// For authentication tests (node1)
const authTestConfig = {
  'nodeId': 'node1',
  'userId': 'auth-test-user',
  'baseUrl': 'testnet.bitnet.com', // Caddy proxy URL
};

// For payment tests (node2)
const paymentTestConfig = {
  'nodeId': 'node2',
  'userId': 'payment-test-user',
  'baseUrl': 'testnet.bitnet.com', // Same Caddy proxy
  'testInvoice': 'lnbc...', // Pre-generated test invoice
  'testAddress': 'tb1q...', // Testnet address
};
```

## Test Structure

### Unit Tests
- `unit/send_payment_test.dart` - Lightning payment sending tests
- `unit/onchain_test.dart` - Onchain transaction tests
- `unit/auth_test.dart` - Authentication flow tests

### Integration Tests
- `integration/payment_flows_test.dart` - End-to-end payment flows
- `integration/live_node_test.dart` - Real node interaction tests
- `integration/auth_flow_test.dart` - Complete authentication flow

## Running Tests

### Run all tests:
```bash
flutter test
```

### Run authentication tests (node1):
```bash
flutter test test/unit/auth_test.dart
```

### Run payment tests (node2):
```bash
flutter test test/unit/send_payment_test.dart test/unit/onchain_test.dart
```

### Run integration tests:
```bash
flutter test test/integration/ --dart-define=INTEGRATION_TEST=true
```

## Test Data Setup

### Before running payment tests:
1. Ensure node2 has testnet funds
2. Check that test invoices are valid
3. Verify Caddy proxy is running
4. Confirm node2 credentials are up to date

### Test Wallet Funding:
- Node2 is pre-funded with testnet Bitcoin
- Lightning channels are already opened
- Test amounts are kept small (100-10000 sats)

## Important Notes

1. **Never use mainnet nodes** for testing
2. **Node isolation**: Node1 and Node2 are completely separate
3. **Cleanup**: Tests should clean up generated addresses/invoices
4. **Rate limiting**: Add delays between tests to avoid overwhelming nodes
5. **Credentials**: Never commit real macaroons or sensitive data

## Test Coverage

### Authentication (Node1):
- ✅ User registration with Lightning identity
- ✅ Mnemonic-based recovery
- ✅ Challenge/response authentication
- ✅ Node assignment

### Payments (Node2):
- ✅ Lightning invoice creation
- ✅ Lightning payment sending
- ✅ Onchain address generation (SegWit & Taproot)
- ✅ Onchain transaction sending
- ✅ Fee estimation
- ✅ Balance queries
- ✅ Internal rebalancing

## Troubleshooting

### Common Issues:
1. **"Node not accessible"** - Check Caddy proxy is running
2. **"Invalid macaroon"** - Update test credentials
3. **"Insufficient balance"** - Refund test wallets
4. **"Channel not active"** - Check Lightning channels on node2

### Debug Mode:
```bash
flutter test --verbose test/integration/live_node_test.dart
```

## Contributing

When adding new tests:
1. Use node1 for auth-related tests only
2. Use node2 for all payment operations
3. Include proper cleanup in tearDown()
4. Document any new test requirements
5. Update test configuration if needed