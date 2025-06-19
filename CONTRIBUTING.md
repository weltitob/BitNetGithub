# Contributing to BitNet

Thank you for your interest in contributing to BitNet! This document provides guidelines and instructions for contributing to the project.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please read and follow our Code of Conduct:

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on what is best for the community
- Show empathy towards other community members

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/bitnet.git
   cd bitnet
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/bitnet/bitnet.git
   ```
4. **Install dependencies**:
   ```bash
   flutter pub get
   ```
5. **Create a branch** for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Process

1. **Keep your fork up to date**:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Make your changes**:
   - Write clean, readable code
   - Follow the existing code style
   - Add tests for new functionality
   - Update documentation as needed

3. **Test your changes**:
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes** (see Commit Guidelines below)

5. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** from your fork to the main repository

## Commit Guidelines

We use [Gitmoji](https://gitmoji.dev/) for our commit messages to make them more readable and organized. Each commit message should follow this format:

```
<gitmoji> <type>: <subject>

<body>

<footer>
```

### Gitmoji Commit Types

| Gitmoji | Code | Type | Description |
|---------|------|------|-------------|
| ✨ | `:sparkles:` | feat | New feature |
| 🐛 | `:bug:` | fix | Bug fix |
| 📚 | `:books:` | docs | Documentation changes |
| 💎 | `:gem:` | style | Code style changes (formatting, missing semi-colons, etc.) |
| ♻️ | `:recycle:` | refactor | Code refactoring |
| 🚀 | `:rocket:` | perf | Performance improvements |
| ✅ | `:white_check_mark:` | test | Adding tests |
| 🔧 | `:wrench:` | chore | Changes to build process or auxiliary tools |
| 🔥 | `:fire:` | remove | Removing code or files |
| 🚑 | `:ambulance:` | hotfix | Critical hotfix |
| 🎨 | `:art:` | ui | UI/UX improvements |
| 🔒 | `:lock:` | security | Security improvements |
| ⬆️ | `:arrow_up:` | upgrade | Upgrading dependencies |
| ⬇️ | `:arrow_down:` | downgrade | Downgrading dependencies |
| 📱 | `:iphone:` | mobile | Mobile specific changes |
| 💡 | `:bulb:` | comment | Adding or updating comments |
| 🌐 | `:globe_with_meridians:` | i18n | Internationalization and localization |
| ⚡ | `:zap:` | lightning | Lightning Network specific changes |
| 💰 | `:moneybag:` | bitcoin | Bitcoin specific changes |

### Commit Message Examples

```bash
# Adding a new feature
git commit -m "✨ feat: add QR code scanner for Lightning invoices"

# Fixing a bug
git commit -m "🐛 fix: resolve wallet balance display issue"

# Updating documentation
git commit -m "📚 docs: update README with installation instructions"

# Refactoring code
git commit -m "♻️ refactor: simplify transaction history logic"

# Adding tests
git commit -m "✅ test: add unit tests for Bitcoin address validation"

# UI improvements
git commit -m "🎨 ui: improve dark mode color scheme"

# Performance optimization
git commit -m "🚀 perf: optimize transaction list rendering"

# Security update
git commit -m "🔒 security: implement additional PIN validation"
```

### Commit Message Rules

1. **Use present tense** ("add feature" not "added feature")
2. **Use imperative mood** ("move cursor to..." not "moves cursor to...")
3. **Limit first line to 72 characters**
4. **Reference issues and pull requests** when applicable
5. **Be descriptive** but concise

## Pull Request Process

1. **Ensure your PR**:
   - Has a clear title and description
   - References any related issues
   - Includes tests for new functionality
   - Passes all CI checks
   - Has been tested on relevant platforms

2. **PR Title Format**:
   ```
   <gitmoji> <type>: <brief description>
   ```
   Example: `✨ feat: add support for Taproot addresses`

3. **PR Description Template**:
   ```markdown
   ## Description
   Brief description of the changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing
   - [ ] Unit tests pass
   - [ ] Manual testing completed
   - [ ] Tested on Android
   - [ ] Tested on iOS

   ## Screenshots (if applicable)
   Add screenshots here

   ## Checklist
   - [ ] My code follows the project's style guidelines
   - [ ] I have performed a self-review
   - [ ] I have commented my code where necessary
   - [ ] I have updated the documentation
   - [ ] My changes generate no new warnings
   ```

## Code Style

Please follow the Flutter and Dart style guides, and refer to [CLAUDE.md](CLAUDE.md) for project-specific conventions:

- Use `flutter format` to format your code
- Follow the project's naming conventions
- Use meaningful variable and function names
- Keep functions small and focused
- Comment complex logic

### Quick Style Guidelines

```dart
// GOOD
class BitcoinWallet {
  final String address;
  final int balance;
  
  BitcoinWallet({
    required this.address,
    required this.balance,
  });
}

// BAD
class bitcoin_wallet {
  String addr;
  int bal;
  
  bitcoin_wallet(this.addr, this.bal);
}
```

## Testing

- Write tests for all new features
- Maintain or increase code coverage
- Run tests before submitting PR:
  ```bash
  flutter test
  ```
- Test on both Android and iOS devices/emulators

### Test Structure

```dart
void main() {
  group('BitcoinWallet', () {
    test('should create wallet with valid address', () {
      // Test implementation
    });
    
    test('should calculate correct balance', () {
      // Test implementation
    });
  });
}
```

## Documentation

- Update README.md if you change setup or configuration
- Add inline documentation for complex functions
- Update CLAUDE.md for architectural changes
- Include examples for new features

### Documentation Example

```dart
/// Validates a Bitcoin address according to BIP standards.
/// 
/// Returns `true` if the address is valid, `false` otherwise.
/// 
/// Example:
/// ```dart
/// final isValid = validateBitcoinAddress('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh');
/// print(isValid); // true
/// ```
bool validateBitcoinAddress(String address) {
  // Implementation
}
```

## Questions?

If you have questions about contributing, feel free to:
- Open an issue for discussion
- Contact the maintainers
- Join our community chat

Thank you for contributing to BitNet! 🚀