# BitNET Testing Strategy

## Overview

This document outlines the comprehensive testing strategy for BitNET application. Our goal is to achieve robust test coverage with 70% unit tests and 30% integration/end-to-end tests, fully integrated into our CI/CD pipeline.

## Testing Philosophy

- **70% Unit Tests**: Fast, isolated tests for business logic, controllers, and utilities
- **30% Integration Tests**: End-to-end tests for critical user flows and payment operations
- **Continuous Integration**: All tests run automatically on every commit
- **Test-Driven Development**: Write tests before implementation for critical features

## Core Testing Areas

### 1. Payment Operations (Priority 1)

#### Lightning Network Operations
- **Receive Lightning Payments**
  - Invoice generation
  - QR code creation
  - Payment status tracking
  - Balance updates
  - Transaction history updates

- **Send Lightning Payments**
  - Invoice decoding
  - Payment request validation
  - Fee estimation
  - Payment execution
  - Error handling (insufficient balance, routing failures)
  - Payment proof generation

#### Onchain Operations
- **Receive Onchain Payments**
  - Address generation (SegWit, Taproot)
  - Address validation
  - UTXO detection
  - Confirmation tracking
  - Balance updates after confirmations

- **Send Onchain Payments**
  - Address validation
  - Fee estimation
  - Transaction building
  - Broadcasting
  - Confirmation tracking
  - Change address handling

### 2. Transaction Tracking (Priority 1)

#### Lightning Tracking
- Real-time payment status updates
- Payment history synchronization
- Failed payment handling
- Pending payment timeouts
- Fee tracking

#### Onchain Tracking
- Mempool monitoring
- Confirmation counting
- Transaction history updates
- Fee tracking
- UTXO management

### 3. User Authentication (Priority 2)
- Mnemonic generation
- Recovery flows
- Biometric authentication
- Session management
- Node assignment

### 4. State Management (Priority 2)
- Wallet balance calculations
- Exchange rate updates
- Transaction list management
- User preferences
- Network status

## Test Implementation Plan

### Phase 1: Core Payment Tests (Weeks 1-2)
1. Unit tests for payment controllers
2. Integration tests for Lightning receive/send
3. Integration tests for onchain receive/send
4. Mock LND responses for isolated testing

### Phase 2: Tracking & Monitoring (Weeks 3-4)
1. Unit tests for transaction parsers
2. Integration tests for real-time updates
3. WebSocket/streaming response tests
4. Error recovery scenarios

### Phase 3: Full E2E Flows (Weeks 5-6)
1. Complete user journey tests
2. Multi-node payment scenarios
3. Edge case handling
4. Performance benchmarks

## Testing Infrastructure

### Test Environment Setup
```yaml
test_environment:
  nodes:
    - testnet_node1: Authentication & user management
    - testnet_node2: Payment operations
  networks:
    - bitcoin: testnet3
    - lightning: testnet
  services:
    - caddy_proxy: Route to test nodes
    - mock_server: Simulate LND responses
```

### Required Test Data
- Pre-funded testnet wallets
- Known-good Lightning invoices
- Various address formats for testing
- Error response scenarios

### Test Categories

#### Unit Tests (70%)
```dart
// Example structure
test/
├── unit/
│   ├── controllers/
│   │   ├── wallet_controller_test.dart
│   │   ├── send_controller_test.dart
│   │   └── receive_controller_test.dart
│   ├── services/
│   │   ├── bitcoin_service_test.dart
│   │   ├── lightning_service_test.dart
│   │   └── node_mapping_service_test.dart
│   ├── models/
│   │   ├── transaction_model_test.dart
│   │   └── user_model_test.dart
│   └── utils/
│       ├── currency_converter_test.dart
│       └── bitcoin_validator_test.dart
```

#### Integration Tests (30%)
```dart
test/
├── integration/
│   ├── payment_flows/
│   │   ├── lightning_payment_e2e_test.dart
│   │   ├── onchain_payment_e2e_test.dart
│   │   └── mixed_payment_e2e_test.dart
│   ├── tracking/
│   │   ├── lightning_tracking_test.dart
│   │   └── onchain_tracking_test.dart
│   └── auth/
│       └── recovery_flow_test.dart
```

## CI/CD Integration

### GitHub Actions Workflow
```yaml
name: BitNET Tests
on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test test/unit/

  integration-tests:
    runs-on: ubuntu-latest
    needs: unit-tests
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test test/integration/
```

### Test Execution Strategy
1. **Pre-commit**: Run unit tests locally
2. **Pull Request**: Run all tests in CI
3. **Main Branch**: Run full test suite + performance tests
4. **Release**: Run extended E2E tests on staging

## Mocking Strategy

### LND API Mocks
- Use mock responses for unit tests
- Record real responses for replay testing
- Simulate error conditions
- Test timeout scenarios

### Example Mock Structure
```dart
class MockLightningService {
  Future<Invoice> createInvoice({
    required int amountSat,
    required String memo,
  }) async {
    return Invoice(
      paymentRequest: 'lnbc1234...',
      paymentHash: 'abc123...',
      amountSat: amountSat,
      memo: memo,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(Duration(hours: 1)),
    );
  }
}
```

## Key Testing Scenarios

### Happy Path Tests
1. User receives Lightning payment
2. User sends Lightning payment
3. User receives onchain payment
4. User sends onchain payment
5. User tracks all transactions

### Error Scenarios
1. Insufficient balance
2. Invalid addresses/invoices
3. Network timeouts
4. Node offline
5. Payment routing failures

### Edge Cases
1. Zero-amount invoices
2. Expired invoices
3. Double-spend attempts
4. Maximum amount transfers
5. Minimum dust amounts

## Testing Best Practices

1. **Isolation**: Each test should be independent
2. **Repeatability**: Tests must produce consistent results
3. **Speed**: Unit tests should complete in milliseconds
4. **Coverage**: Aim for 80%+ code coverage
5. **Documentation**: Each test should clearly state what it tests

## Metrics & Reporting

### Coverage Goals
- Overall: 75% minimum
- Critical paths: 90% minimum
- UI components: 60% minimum

### Performance Benchmarks
- Unit test suite: < 30 seconds
- Integration test suite: < 5 minutes
- Full E2E suite: < 15 minutes

## Future Enhancements

1. **Automated Performance Testing**: Track app performance over time
2. **Security Testing**: Penetration testing for payment flows
3. **Load Testing**: Simulate high-volume transactions
4. **Chaos Testing**: Random failure injection
5. **Visual Regression Testing**: UI screenshot comparisons

## Getting Started

To implement this testing strategy:

1. Set up test environment with testnet nodes
2. Create mock services for LND APIs
3. Write unit tests for existing controllers
4. Add integration tests for payment flows
5. Configure CI/CD pipeline
6. Monitor test coverage and performance

## Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Lightning Network Testnet](https://github.com/lightningnetwork/lnd/blob/master/docs/INSTALL.md)
- [Bitcoin Testnet Faucets](https://testnet-faucet.mempool.co/)
- [Mock Service Guidelines](https://github.com/dart-lang/mockito)

---

*This document should be updated as the testing infrastructure evolves and new requirements emerge.*