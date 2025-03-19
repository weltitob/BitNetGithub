# BitNET App Standards & Guidelines

This document outlines the design standards, code conventions, and folder structure for the BitNET application. It serves as a reference for maintaining consistency across the codebase.

## Table of Contents
- [Design Standards](#design-standards)
  - [Color Palette](#color-palette)
  - [Typography](#typography)
  - [Spacing & Sizing](#spacing--sizing)
  - [Border Radius](#border-radius)
  - [Shadows](#shadows)
  - [Animation](#animation)
- [Component Standards](#component-standards)
  - [Buttons](#buttons)
  - [Cards](#cards)
  - [Text Fields](#text-fields)
  - [Lists](#lists)
- [Folder Structure](#folder-structure)
  - [Main Directories](#main-directories)
  - [Component Organization](#component-organization)
  - [State Management](#state-management)
- [Development Guidelines](#development-guidelines)
  - [Naming Conventions](#naming-conventions)
  - [Code Style](#code-style)
  - [Testing](#testing)
- [Useful Commands](#useful-commands)

## Design Standards

### Color Palette

**IMPORTANT**: Always use `Theme.of(context)` to access colors instead of hardcoded values. This ensures proper theming support and dark/light mode compatibility.

```dart
// CORRECT usage:
Color primaryColor = Theme.of(context).colorScheme.primary;
Color backgroundColor = Theme.of(context).colorScheme.surface;
Color errorColor = Theme.of(context).colorScheme.error;

// INCORRECT usage:
Color primaryColor = Color(0xfff7931a); // Don't hardcode colors
```

Theme-defined colors:
- Primary: `Theme.of(context).colorScheme.primary` (Bitcoin Orange)
- Secondary: `Theme.of(context).colorScheme.secondary`
- Surface: `Theme.of(context).colorScheme.surface`
- Error: `Theme.of(context).colorScheme.error`
- Success: `AppTheme.successColor` (for specialized colors not in theme)

Standard BitNET colors (for reference):
- Bitcoin Orange: `AppTheme.colorBitcoin` (0xfff7931a)
- Primary Gradient: `AppTheme.colorPrimaryGradient` (0xfff25d00)
- Error: `AppTheme.errorColor` (0xFFFF6363)
- Success: `AppTheme.successColor` (0xFF5DE165)

### Typography

**IMPORTANT**: Always use `Theme.of(context).textTheme` to access text styles rather than creating new TextStyles. This ensures consistency across the app and proper theming support.

```dart
// CORRECT usage:
Text("Hello", style: Theme.of(context).textTheme.titleLarge);

// INCORRECT usage:
Text("Hello", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
```

BitNET uses the Inter font family with the following styles, all accessible via `Theme.of(context).textTheme`:

**Display Styles**:
- `displayLarge`: 52px, Weight 700, -0.5 letter spacing
- `displayMedium`: 40px, Weight 700, -0.5 letter spacing
- `displaySmall`: 28px, Weight 700, 0.0 letter spacing

**Headline Styles**:
- `headlineLarge`: 24px, Weight 700, 0.25 letter spacing
- `headlineMedium`: 22px, Weight 700, 0.25 letter spacing
- `headlineSmall`: 20px, Weight 700, 0.15 letter spacing

**Title Styles**:
- `titleLarge`: 17px, Weight 700, 0.15 letter spacing
- `titleMedium`: 17px, Weight 500, 0.0 letter spacing
- `titleSmall`: 15px, Weight 500, 0.0 letter spacing

**Body Styles**:
- `bodyLarge`: 17px, Weight 400, 0.15 letter spacing
- `bodyMedium`: 15px, Weight 400, 0.15 letter spacing
- `bodySmall`: 13px, Weight 400, 0.25 letter spacing

**Label Styles**:
- `labelLarge`: 12px, Weight 400, 0.25 letter spacing
- `labelMedium`: 12px, Weight 400, 0.25 letter spacing
- `labelSmall`: 12px, Weight 400, 0.25 letter spacing

### Spacing & Sizing

**IMPORTANT**: Always use `AppTheme` constants for spacing and sizing, combined with ScreenUtil extensions (.w, .h, .r) for responsive layouts.

```dart
// CORRECT usage:
Padding(
  padding: EdgeInsets.all(AppTheme.cardPadding),
  child: SizedBox(height: AppTheme.elementSpacing.h),
)

// INCORRECT usage:
Padding(
  padding: EdgeInsets.all(24),
  child: SizedBox(height: 12),
)
```

ScreenUtil extensions:
- `.w`: Scales width based on screen size
- `.h`: Scales height based on screen size
- `.r`: Scales radius based on screen size
- `.sp`: Scales text size based on screen size

Standard spacing units:
- `AppTheme.cardPadding`: 24.0
- `AppTheme.elementSpacing`: 12.0 (cardPadding * 0.5)
- `AppTheme.cardPaddingSmall`: 16.0
- `AppTheme.cardPaddingBig`: 28.0
- `AppTheme.cardPaddingBigger`: 32.0

Layout measurements:
- `AppTheme.columnWidth`: 336.0 (14 * cardPadding)
- `AppTheme.bottomNavBarHeight`: 64.0
- `AppTheme.iconSize`: 24.0 (cardPadding)
- `AppTheme.buttonHeight`: 50.0

### Border Radius

Always use `AppTheme` constants for border radius, combined with ScreenUtil's `.r` extension for responsive scaling when needed.

```dart
// CORRECT usage:
Container(
  decoration: BoxDecoration(
    borderRadius: AppTheme.cardRadiusMid,
    // or with ScreenUtil:
    // borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
  ),
)

// INCORRECT usage:
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
  ),
)
```

Available border radius constants:
- `AppTheme.cardRadiusSuperSmall` or `AppTheme.borderRadiusSuperSmall`: 10px
- `AppTheme.cardRadiusSmall` or `AppTheme.borderRadiusSmall`: 16px
- `AppTheme.cardRadiusMid` or `AppTheme.borderRadiusMid`: 24px
- `AppTheme.cardRadiusBig` or `AppTheme.borderRadiusBig`: 28px
- `AppTheme.cardRadiusBigger` or `AppTheme.borderRadiusBigger`: 32px
- `AppTheme.cardRadiusCircular` or `AppTheme.borderRadiusCircular`: 500px

For single corners, use:
- `AppTheme.cornerRadiusMid`: 24px
- `AppTheme.cornerRadiusBig`: 28px

### Shadows

- Default: opacity 0.25, offset (0, 2), blur radius 5
- Super Small: opacity 0.05, offset (0, 4), blur radius 15, spread radius 0.5
- Small: opacity 0.1, offset (0, 10), blur radius 80, spread radius 1.5
- Big: opacity 0.1, offset (0, 2.5), blur radius 40
- Button: opacity 0.6, offset (0, 2.5), blur radius 40
- Profile: opacity 0.1, offset (0, 2.5), blur radius 10

### Animation

- Standard Duration: 300ms
- Animation Curve: Curves.easeInOut

## Component Standards

### Buttons

BitNET uses several button types:
- `LongButtonWidget`: Standard wide button
- `RoundedButtonWidget`: Circular button with icon
- `BitNetImageWithTextButton`: Button with image and text
- `TimeChooserButton`: Specialized button for time period selection

Button types:
- `ButtonType.solid`: Filled background
- `ButtonType.transparent`: No background

### Cards

- Use `BitNetContainer` for standard cards
- Card padding should be consistent with the AppTheme spacing guidelines
- Apply appropriate border radius based on the card's purpose and size

### Text Fields

- Default text field style uses the `textfieldDecoration` function from AppTheme
- Content padding should be 0.25
- No border by default, use hint text styling with 0.4 opacity

### Lists

- Use `BitNetListTile` for consistent list items
- For transactions, use `TransactionItem` from the components/resultlist folder

## Folder Structure

### Main Directories

```
lib/
├── backbone/
│   ├── auth/          # Authentication-related functionality
│   ├── cloudfunctions/ # Backend cloud function implementations
│   ├── futures/       # Future-based operations
│   ├── helper/        # Helper utilities and functions
│   ├── services/      # Core services (Bitcoin, storage, etc.)
│   └── streams/       # Stream-based data providers
├── components/
│   ├── animations/    # Animation widgets
│   ├── appstandards/  # Standard app components (AppBar, etc.)
│   ├── buttons/       # Button components
│   ├── chart/         # Chart-related components
│   ├── container/     # Container components
│   ├── dialogsandsheets/ # Dialog and bottom sheet components
│   ├── fields/        # Input field components
│   ├── items/         # UI item components
│   ├── loaders/       # Loading indicators
│   └── resultlist/    # List result components
├── generated/         # Generated code (internationalization, assets)
├── intl/              # Internationalization resources
├── models/            # Data models
│   ├── bitcoin/       # Bitcoin-related models
│   ├── currency/      # Currency-related models
│   ├── firebase/      # Firebase models
│   └── user/          # User-related models
└── pages/             # App screens
    ├── auth/          # Authentication screens
    ├── feed/          # Feed screens
    ├── profile/       # Profile screens
    ├── secondpages/   # Secondary screens
    ├── transactions/  # Transaction-related screens
    └── wallet/        # Wallet screens
```

### Component Organization

Components are organized by their function:
- **appstandards**: Base components like AppBar, Scaffold, ListTile
- **buttons**: All button variants
- **chart**: Chart-related components
- **items**: Reusable UI items like cards, indicators
- **loaders**: Loading indicators and states
- **resultlist**: List-based UI components

### State Management

BitNET uses GetX for state management:
- Controllers are typically placed in a `controller` subfolder within feature folders
- Models define the data structures and are placed in the `models` directory
- Reactive state is managed using GetX's `Rx` types and `Obx` widgets

## Development Guidelines

### Naming Conventions

- **Files**: Use snake_case for file names (e.g., `wallet_controller.dart`)
- **Classes**: Use PascalCase for class names (e.g., `BitcoinController`)
- **Methods/Variables**: Use camelCase for methods and variables (e.g., `fetchOnchainWalletBalance()`)
- **Constants**: Use static constants in AppTheme for shared values

### Code Style

- Follow the Flutter and Dart style guide
- Use named parameters for widget constructors
- Organize imports with package imports first, followed by relative imports
- Keep methods focused on a single responsibility
- Use GetX controller injection for dependency management

### Testing

- Write unit tests for business logic in controllers
- Write widget tests for UI components
- Integration tests for critical user flows

## Useful Commands

**Run the app in debug mode**:
```bash
flutter run
```

**Build the app for release**:
```bash
flutter build apk --release
```

**Generate internationalization files**:
```bash
flutter gen-l10n
```

**Run tests**:
```bash
flutter test
```

**Analyze code**:
```bash
flutter analyze
```

**Get packages**:
```bash
flutter pub get
```

**Clean and rebuild**:
```bash
flutter clean && flutter pub get
```