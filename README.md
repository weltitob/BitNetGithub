# BitNet

BitNet is a cross-platform Bitcoin and Lightning Network wallet with enhanced social features, built using Flutter.

## Overview

BitNet provides a complete solution for Bitcoin and Lightning Network management with an intuitive user interface, social features, and marketplace integration. The application supports multiple platforms including Android, iOS, and Web.

## Features

### Wallet Functionality
- **Bitcoin Integration**: Complete on-chain transaction management
- **Lightning Network**: Fast, low-fee transactions via LND integration
- **Multi-currency Support**: View balances in various fiat currencies
- **Address Management**: Generate and track Bitcoin addresses
- **Transaction Management**: Send, receive, and track payments
- **QR Code Integration**: Generate and scan payment requests

### Security Features
- **HD Wallet Implementation**: BIP32/39/44 standards for key derivation
- **Secure Storage**: Encrypted storage of sensitive data
- **Biometric Authentication**: Fingerprint and Face ID support
- **PIN Protection**: Additional security layer
- **Mnemonic Recovery**: Backup and restore functionality

### Social and UI Features
- **User Profiles**: Customizable profiles with social integration
- **Feed Interface**: Activity and content aggregation
- **Posts & Media**: Content sharing capabilities
- **Marketplace**: NFT and digital asset marketplace
- **Responsive Design**: Adaptive UI for various screen sizes
- **Theming**: Light and dark mode with custom color schemes

### Advanced Features
- **MoonPay Integration**: Fiat on-ramp for purchasing crypto
- **Loop Service**: Lightning Network liquidity management
- **Multi-language Support**: 30+ languages with complete localization
- **AWS Integration**: ECS tasks for Lightning Network nodes

## Technical Stack

### Frontend
- **Flutter**: Cross-platform UI toolkit
- **GetX**: State management, dependency injection, and routing
- **Provider**: Additional state management for specific components
- **Lottie**: Advanced animations
- **WebView**: Web content integration
- **Hive**: Local persistent storage

### Backend & Services
- **Firebase**:
  - Authentication
  - Firestore
  - Cloud Functions
  - Storage
  - Analytics & Crashlytics
- **Bitcoin Libraries**:
  - bip32, bip39, wallet
  - bitcoin_base
  - cryptography
  - bolt11_decoder
- **AWS Integration**:
  - ECS for Lightning Network nodes

### Cryptocurrency Specific
- **Lightning Network**: Integration via `litd_controller`
- **Mempool API**: Transaction monitoring
- **Blockchain Utils**: Crypto utility functions

## Project Structure

```
lib/
├── backbone/            # Core services and business logic
│   ├── auth/            # Authentication functionality
│   ├── cloudfunctions/  # Backend cloud functions
│   ├── futures/         # Future-based operations
│   ├── helper/          # Utility functions
│   ├── security/        # Security services
│   ├── services/        # Core application services
│   └── streams/         # Stream-based data providers
├── components/          # Reusable UI components
│   ├── animations/      # Animation widgets
│   ├── appstandards/    # Standard components (AppBar, etc.)
│   ├── buttons/         # Button components
│   ├── items/           # UI item components
│   └── loaders/         # Loading indicators
├── models/              # Data models
│   ├── bitcoin/         # Bitcoin-related models
│   ├── currency/        # Currency models
│   ├── tapd/            # Taproot asset models
│   └── user/            # User-related models
└── pages/               # Application screens
    ├── auth/            # Authentication screens
    ├── feed/            # Feed screens
    ├── marketplace/     # Marketplace screens
    ├── wallet/          # Wallet screens
    └── routetrees/      # Navigation routes
```

## Development Guidelines

For detailed development guidelines, including design standards, coding conventions, and folder structure, please refer to the [CLAUDE.md](CLAUDE.md) file.

## Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Firebase project setup

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase credentials
4. run the application and look for the "Enter this debug secret into the allow list in the Firebase Console for your project:" message in the console
5. Add it to the firebase console, or ask an administrator to add it for you


### Useful Commands
```bash
# Run the app in debug mode
flutter run

# Build the app for release
flutter build apk --release

# Generate internationalization files
flutter gen-l10n

# Run tests
flutter test

# Clean and rebuild
flutter clean && flutter pub get
```

## Confidentiality Notice

**IMPORTANT**: This project and all of its contents are confidential and intended solely for the use of the individual or entity to whom they are addressed. This repository contains proprietary information belonging to BitNet GmBH.

## Contact Information

- **Project Manager**: Tobias Welti
- **Email**: weltitob@gmail.com
- **Phone**: +49 17636384058

---

© 2024 BitNet, Germany. All rights reserved.
