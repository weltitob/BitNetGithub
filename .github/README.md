# BitNET CI/CD Setup

This directory contains the Continuous Integration and Continuous Deployment (CI/CD) configuration for the BitNET application.

## 📁 Files Overview

### `workflows/ci.yml`
Main CI/CD pipeline that runs on every push and pull request:
- **Unit Tests** - Runs comprehensive test suite
- **Code Analysis** - Flutter analyze with strict rules
- **Security Scanning** - Basic security checks
- **Build Verification** - Ensures app builds successfully
- **Integration Tests** - Full workflow testing

### `branch-protection.md`
Guidelines for setting up GitHub branch protection rules to ensure code quality.

## 🚀 Quick Start

### For Developers

#### Before Pushing Code:
```bash
# Option 1: Use provided script (Linux/Mac)
./scripts/run_tests.sh

# Option 2: Use PowerShell script (Windows)
./scripts/run_tests.ps1

# Option 3: Run manually
flutter pub get
flutter analyze
flutter test test/run_all_unit_tests.dart
flutter build apk --debug
```

#### Git Workflow:
1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes and test locally
3. Commit: `git commit -m "Add your feature"`
4. Push: `git push origin feature/your-feature`
5. Create pull request on GitHub
6. Wait for CI checks to pass
7. Request review from team member
8. Merge after approval

### For Repository Administrators

#### Setup Branch Protection:
1. Go to repository **Settings** → **Branches**
2. Add rule for `main` branch
3. Enable required status checks:
   - `test / Run Tests and Analysis`
   - `build / Build Application`
   - `security / Security Analysis`
4. Require pull request reviews
5. Save rule

## 🔄 CI/CD Pipeline Details

### Triggers
- **Push** to `main` or `develop` branches
- **Pull Request** to `main` or `develop` branches

### Jobs

#### 1. **Test** (Required)
- ✅ Code analysis (`flutter analyze`)
- ✅ Code formatting check
- ✅ Unit test execution
- ✅ Coverage report generation

#### 2. **Build** (Required)
- ✅ Debug APK build
- ✅ Release APK build  
- ✅ App Bundle build
- ✅ Artifact uploads

#### 3. **Security** (Required)
- ✅ Dependency audit
- ✅ Secret scanning
- ✅ Security pattern analysis

#### 4. **Integration Test** (Optional)
- ⚠️ Lightning receive tests
- ⚠️ Onchain receive tests
- ⚠️ Can continue on failure

### Artifacts
- Debug APK (`debug-apk`)
- Release APK (`release-apk`)
- App Bundle (`app-bundle`)

## 📊 Test Coverage

Current test suites:
- **Currency Converter** - Bitcoin/Satoshi conversions
- **Bitcoin Validation** - Address and transaction validation
- **Lightning Receive** - Lightning invoice functionality
- **Receive Logic** - Payment receive workflows
- **Model Tests** - Data structure validation
- **Cloud Functions** - Cryptographic operations

## 🛡️ Security Measures

### Automated Checks:
- Hardcoded secret detection
- Insecure HTTP usage detection
- Dependency vulnerability scanning
- Code pattern analysis

### Manual Reviews:
- All code changes require approval
- Security-focused code reviews
- Documentation updates

## 📈 Monitoring & Notifications

### Success Indicators:
- ✅ All tests pass
- ✅ Build completes successfully
- ✅ Security checks pass
- ✅ Code quality standards met

### Failure Handling:
- ❌ Automatic PR blocking
- ❌ Detailed error reporting
- ❌ Team notifications
- ❌ Rollback procedures

## 🔧 Customization

### Adding New Tests:
1. Create test file in appropriate directory
2. Update `test/run_all_unit_tests.dart`
3. Add to CI pipeline if needed
4. Update documentation

### Modifying CI Pipeline:
1. Edit `.github/workflows/ci.yml`
2. Test changes on feature branch
3. Update documentation
4. Get team approval

### Environment Variables:
Add sensitive configuration in GitHub repository settings:
- **Settings** → **Secrets and variables** → **Actions**

## 📞 Support

### Common Issues:

**Tests fail locally but pass in CI:**
- Check Flutter version differences
- Verify dependency versions
- Clear cache: `flutter clean && flutter pub get`

**CI pipeline fails:**
- Check logs in GitHub Actions tab
- Verify all required files exist
- Ensure dependencies are up to date

**Branch protection preventing merge:**
- Ensure all required checks pass
- Get required approvals
- Resolve all conversations

### Getting Help:
- Check GitHub Actions logs
- Review test output
- Ask team members for assistance
- Update this documentation for future reference

---

**Note**: This CI/CD setup ensures code quality while maintaining development velocity. It catches issues early and provides confidence in deployments.