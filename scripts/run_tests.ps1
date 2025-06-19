# BitNET Local Test Runner (PowerShell)
# This script runs the same tests that GitHub Actions will run
# Use this before pushing to catch issues early

param(
    [switch]$SkipIntegration,
    [switch]$SkipBuild,
    [switch]$Quiet
)

$ErrorActionPreference = "Stop"

# Colors for output
$Red = "Red"
$Green = "Green"
$Yellow = "Yellow"
$Blue = "Cyan"

function Write-Status {
    param($Message)
    if (-not $Quiet) {
        Write-Host "📋 $Message" -ForegroundColor $Blue
    }
}

function Write-Success {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor $Green
}

function Write-Warning {
    param($Message)
    Write-Host "⚠️  $Message" -ForegroundColor $Yellow
}

function Write-Error-Custom {
    param($Message)
    Write-Host "❌ $Message" -ForegroundColor $Red
}

try {
    Write-Host "🚀 BitNET Local Test Runner" -ForegroundColor $Blue
    Write-Host "==========================" -ForegroundColor $Blue
    Write-Host ""

    # Check if Flutter is installed
    Write-Status "Checking Flutter installation..."
    try {
        $flutterVersion = flutter --version 2>&1
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter command failed"
        }
        Write-Success "Flutter is installed"
        if (-not $Quiet) {
            Write-Host $flutterVersion
        }
    }
    catch {
        Write-Error-Custom "Flutter is not installed or not in PATH"
        exit 1
    }
    Write-Host ""

    # Get dependencies
    Write-Status "Getting dependencies..."
    flutter pub get
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "Failed to get dependencies"
        exit 1
    }
    Write-Success "Dependencies retrieved successfully"
    Write-Host ""

    # Run code analysis
    Write-Status "Running code analysis..."
    flutter analyze
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "Code analysis failed"
        exit 1
    }
    Write-Success "Code analysis passed"
    Write-Host ""

    # Check code formatting
    Write-Status "Checking code formatting..."
    dart format --set-exit-if-changed .
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Code formatting issues found. Attempting to fix..."
        dart format .
        Write-Success "Code formatting fixed"
    }
    else {
        Write-Success "Code formatting is correct"
    }
    Write-Host ""

    # Run unit tests
    Write-Status "Running all unit tests..."
    flutter test test/run_all_unit_tests.dart
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "Unit tests failed"
        exit 1
    }
    Write-Success "All unit tests passed"
    Write-Host ""

    # Run individual test suites
    Write-Status "Running individual test suites..."
    $testSuites = @(
        @{File = "test/unit/currency/currency_converter_test.dart"; Name = "Currency Converter Tests"},
        @{File = "test/unit/bitcoin/bitcoin_validation_test.dart"; Name = "Bitcoin Validation Tests"},
        @{File = "test/unit/receive/lightning_receive_unit_test.dart"; Name = "Lightning Receive Tests"},
        @{File = "test/unit/receive/receive_logic_test.dart"; Name = "Receive Logic Tests"},
        @{File = "test/unit/models/bitcoin_models_test.dart"; Name = "Model Tests"}
    )

    $failedSuites = @()

    foreach ($suite in $testSuites) {
        Write-Status "Running $($suite.Name)..."
        flutter test $suite.File
        if ($LASTEXITCODE -eq 0) {
            Write-Success "$($suite.Name) passed"
        }
        else {
            Write-Error-Custom "$($suite.Name) failed"
            $failedSuites += $suite.Name
        }
        Write-Host ""
    }

    # Run integration tests (optional)
    if (-not $SkipIntegration) {
        Write-Status "Running integration tests..."
        $integrationTests = @(
            @{File = "test/integration/receive/lightning_receive_test.dart"; Name = "Lightning Receive Integration"},
            @{File = "test/integration/receive/onchain_receive_test.dart"; Name = "Onchain Receive Integration"}
        )

        foreach ($test in $integrationTests) {
            if (Test-Path $test.File) {
                Write-Status "Running $($test.Name)..."
                flutter test $test.File
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "$($test.Name) passed"
                }
                else {
                    Write-Warning "$($test.Name) failed (non-critical)"
                }
            }
            else {
                Write-Warning "$($test.Name) not found (skipping)"
            }
        }
        Write-Host ""
    }

    # Build verification
    if (-not $SkipBuild) {
        Write-Status "Verifying build..."
        flutter build apk --debug
        if ($LASTEXITCODE -ne 0) {
            Write-Error-Custom "Debug build failed"
            exit 1
        }
        Write-Success "Debug build successful"
        Write-Host ""
    }

    # Final summary
    Write-Host "==========================" -ForegroundColor $Blue
    Write-Host "🎯 Test Summary" -ForegroundColor $Blue
    Write-Host "==========================" -ForegroundColor $Blue

    if ($failedSuites.Count -eq 0) {
        Write-Success "All tests passed! Ready to push 🚀"
        Write-Host ""
        Write-Host "Next steps:"
        Write-Host "1. git add ."
        Write-Host "2. git commit -m 'Your commit message'"
        Write-Host "3. git push origin your-branch"
        Write-Host "4. Create pull request to main"
    }
    else {
        Write-Error-Custom "The following test suites failed:"
        foreach ($failed in $failedSuites) {
            Write-Host "  - $failed"
        }
        Write-Host ""
        Write-Error-Custom "Please fix the failing tests before pushing"
        exit 1
    }
}
catch {
    Write-Error-Custom "An unexpected error occurred: $($_.Exception.Message)"
    exit 1
}