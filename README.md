<p align="center">
  <img src="assets/images/logotransparent.png" alt="BitNet Logo" width="200"/>
</p>

# BitNet

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/bitnet/releases)
[![Flutter](https://img.shields.io/badge/Flutter-3.0.0+-02569B.svg?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android%20%7C%20Web-lightgrey.svg)](https://bitnet.app)
[![Languages](https://img.shields.io/badge/languages-30+-green.svg)](./lib/generated/intl)
[![License](https://img.shields.io/badge/license-Proprietary-red.svg)](LICENSE)

BitNet is a cross-platform Bitcoin and Lightning Network wallet with enhanced social features, built using Flutter.

<p align="center">
  <img src="assets/screenshot_small.png" alt="BitNet App Screenshot" width="300"/>
</p>

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
- Android Studio or VS Code with Flutter extensions
- Xcode (for iOS development)

### System Requirements

#### Mobile
- **Android**: 6.0 (API level 23) or higher
- **iOS**: 12.0 or higher  
- **Storage**: ~150MB available space
- **Internet**: Required for wallet sync and Lightning Network operations

#### Development
- **macOS**: Required for iOS development
- **RAM**: 8GB minimum, 16GB recommended
- **Disk Space**: 10GB for development tools and dependencies

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/bitnet/bitnet.git
   cd bitnet
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Download and add configuration files:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Enable required Firebase services:
     - Authentication
     - Cloud Firestore
     - Cloud Storage
     - Cloud Functions

4. **Run the application**:
   ```bash
   flutter run
   ```
   
5. **Configure Firebase App Check** (for debug mode):
   - Run the application and look for: "Enter this debug secret into the allow list in the Firebase Console for your project:" in the console
   - Add the debug secret to Firebase Console under App Check settings


#### Platform-Specific Setup

#### Android
- Minimum SDK: 23 (Android 6.0)
- Target SDK: 33 (Android 13)
- Required permissions are automatically configured

#### iOS
- Minimum iOS version: 12.0
- Configure signing in Xcode
- Run `pod install` in the `ios` directory

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct, development process, and how to submit pull requests.

### Quick Start for Contributors
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes using [Gitmoji](https://gitmoji.dev/) (`git commit -m '✨ feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Useful Commands
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

## Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test
```

## Troubleshooting

### Common Issues

1. **Build fails on Android**:
   - Ensure you have the correct Java version (11 or higher)
   - Run `flutter clean` and rebuild

2. **iOS build fails**:
   - Run `pod install` in the iOS directory
   - Ensure Xcode is up to date

3. **Firebase configuration issues**:
   - Verify configuration files are in the correct location
   - Check Firebase project settings match your app bundle ID

## License

This project is proprietary software. All rights reserved. See [LICENSE](LICENSE) for details.

## Support & Contact

- **Documentation**: [Project Wiki](https://github.com/bitnet/bitnet/wiki)
- **Issue Tracker**: [GitHub Issues](https://github.com/bitnet/bitnet/issues)
- **Project Manager**: Tobias Welti
- **Email**: weltitob@gmail.com
- **Phone**: +49 17636384058

## Acknowledgments

- Flutter team for the amazing framework
- Bitcoin and Lightning Network communities
- All our contributors and supporters

---

<p align="center">
  Made with ❤️ in Germany
  <br>
  © 2024 BitNet GmbH. All rights reserved.
</p>
