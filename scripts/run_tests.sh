#!/bin/bash

# BitNET Local Test Runner
# This script runs the same tests that GitHub Actions will run
# Use this before pushing to catch issues early

set -e  # Exit on any error

echo "🚀 BitNET Local Test Runner"
echo "=========================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_status "Checking Flutter version..."
flutter --version
echo ""

# Get dependencies
print_status "Getting dependencies..."
if flutter pub get; then
    print_success "Dependencies retrieved successfully"
else
    print_error "Failed to get dependencies"
    exit 1
fi
echo ""

# Run code analysis
print_status "Running code analysis..."
if flutter analyze; then
    print_success "Code analysis passed"
else
    print_error "Code analysis failed"
    exit 1
fi
echo ""

# Check code formatting
print_status "Checking code formatting..."
if dart format --set-exit-if-changed .; then
    print_success "Code formatting is correct"
else
    print_warning "Code formatting issues found. Run 'dart format .' to fix"
    echo ""
    print_status "Attempting to fix formatting automatically..."
    dart format .
    print_success "Code formatting fixed"
fi
echo ""

# Run unit tests
print_status "Running all unit tests..."
if flutter test test/run_all_unit_tests.dart; then
    print_success "All unit tests passed"
else
    print_error "Unit tests failed"
    exit 1
fi
echo ""

# Run individual test suites for detailed feedback
print_status "Running individual test suites..."

test_suites=(
    "test/unit/currency/currency_converter_test.dart:Currency Converter Tests"
    "test/unit/bitcoin/bitcoin_validation_test.dart:Bitcoin Validation Tests"
    "test/unit/receive/lightning_receive_unit_test.dart:Lightning Receive Tests"
    "test/unit/receive/receive_logic_test.dart:Receive Logic Tests"
    "test/unit/models/bitcoin_models_test.dart:Model Tests"
)

failed_suites=()

for suite in "${test_suites[@]}"; do
    IFS=':' read -r test_file test_name <<< "$suite"
    print_status "Running $test_name..."
    
    if flutter test "$test_file"; then
        print_success "$test_name passed"
    else
        print_error "$test_name failed"
        failed_suites+=("$test_name")
    fi
    echo ""
done

# Run integration tests (optional)
print_status "Running integration tests..."
integration_tests=(
    "test/integration/receive/lightning_receive_test.dart:Lightning Receive Integration"
    "test/integration/receive/onchain_receive_test.dart:Onchain Receive Integration"
)

for suite in "${integration_tests[@]}"; do
    IFS=':' read -r test_file test_name <<< "$suite"
    if [ -f "$test_file" ]; then
        print_status "Running $test_name..."
        if flutter test "$test_file"; then
            print_success "$test_name passed"
        else
            print_warning "$test_name failed (non-critical)"
        fi
    else
        print_warning "$test_name not found (skipping)"
    fi
done
echo ""

# Build verification
print_status "Verifying build..."
if flutter build apk --debug; then
    print_success "Debug build successful"
else
    print_error "Debug build failed"
    exit 1
fi
echo ""

# Final summary
echo "=========================="
echo "🎯 Test Summary"
echo "=========================="

if [ ${#failed_suites[@]} -eq 0 ]; then
    print_success "All tests passed! Ready to push 🚀"
    echo ""
    echo "Next steps:"
    echo "1. git add ."
    echo "2. git commit -m 'Your commit message'"
    echo "3. git push origin your-branch"
    echo "4. Create pull request to main"
else
    print_error "The following test suites failed:"
    for failed in "${failed_suites[@]}"; do
        echo "  - $failed"
    done
    echo ""
    print_error "Please fix the failing tests before pushing"
    exit 1
fi