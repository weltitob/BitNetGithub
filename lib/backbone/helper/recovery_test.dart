import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

/// Recovery Identity Test Functions
/// 
/// Quick tests to verify that recovery DID generation is deterministic
/// and works correctly across different scenarios.
class RecoveryTest {
  static LoggerService get _logger => Get.find<LoggerService>();

  /// Test that recovery DID generation is deterministic
  static void testDeterministicGeneration() {
    _logger.i("=== TESTING RECOVERY DID DETERMINISTIC GENERATION ===");

    // Test mnemonic (example)
    String testMnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    
    // Generate DID multiple times
    String did1 = RecoveryIdentity.generateRecoveryDid(testMnemonic);
    String did2 = RecoveryIdentity.generateRecoveryDid(testMnemonic);
    String did3 = RecoveryIdentity.generateRecoveryDid(testMnemonic);
    
    _logger.i("Test mnemonic: ${testMnemonic.substring(0, 30)}...");
    _logger.i("DID 1: $did1");
    _logger.i("DID 2: $did2");
    _logger.i("DID 3: $did3");
    
    // Verify they're all the same
    bool allMatch = (did1 == did2) && (did2 == did3);
    _logger.i("All DIDs match: $allMatch");
    
    if (allMatch) {
      _logger.i("✅ Recovery DID generation is deterministic");
    } else {
      _logger.e("❌ Recovery DID generation is NOT deterministic");
    }
  }

  /// Test normalization handling
  static void testMnemonicNormalization() {
    _logger.i("=== TESTING MNEMONIC NORMALIZATION ===");

    String baseMnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    
    // Test different formatting
    String normal = baseMnemonic;
    String extraSpaces = "abandon  abandon   abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String mixedCase = "Abandon ABANDON abandon Abandon abandon abandon abandon abandon abandon abandon abandon about";
    String withTabs = "abandon\tabandon\tabandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    
    String did1 = RecoveryIdentity.generateRecoveryDid(normal);
    String did2 = RecoveryIdentity.generateRecoveryDid(extraSpaces);
    String did3 = RecoveryIdentity.generateRecoveryDid(mixedCase);
    String did4 = RecoveryIdentity.generateRecoveryDid(withTabs);
    
    _logger.i("Normal: $did1");
    _logger.i("Extra spaces: $did2");
    _logger.i("Mixed case: $did3");
    _logger.i("With tabs: $did4");
    
    bool allNormalized = (did1 == did2) && (did2 == did3) && (did3 == did4);
    _logger.i("All normalized DIDs match: $allNormalized");
    
    if (allNormalized) {
      _logger.i("✅ Mnemonic normalization works correctly");
    } else {
      _logger.e("❌ Mnemonic normalization failed");
    }
  }

  /// Test DID validation
  static void testDidValidation() {
    _logger.i("=== TESTING DID VALIDATION ===");

    String testMnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String validDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);
    
    // Test valid DID
    bool isValid1 = RecoveryIdentity.isValidRecoveryDid(validDid);
    _logger.i("Valid DID '$validDid': $isValid1");
    
    // Test invalid DIDs
    bool isValid2 = RecoveryIdentity.isValidRecoveryDid("invalid_did");
    bool isValid3 = RecoveryIdentity.isValidRecoveryDid("did:lightning:abc123");
    bool isValid4 = RecoveryIdentity.isValidRecoveryDid("did:mnemonic:toolong123456789");
    bool isValid5 = RecoveryIdentity.isValidRecoveryDid("did:mnemonic:short");
    
    _logger.i("Invalid 'invalid_did': $isValid2");
    _logger.i("Wrong format 'did:lightning:abc123': $isValid3");
    _logger.i("Too long 'did:mnemonic:toolong123456789': $isValid4");
    _logger.i("Too short 'did:mnemonic:short': $isValid5");
    
    bool validationWorks = isValid1 && !isValid2 && !isValid3 && !isValid4 && !isValid5;
    
    if (validationWorks) {
      _logger.i("✅ DID validation works correctly");
    } else {
      _logger.e("❌ DID validation failed");
    }
  }

  /// Test QR code generation and parsing
  static void testQrCodeGeneration() {
    _logger.i("=== TESTING QR CODE GENERATION ===");

    String testMnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);
    
    // Generate QR data
    String qrData = RecoveryIdentity.generateRecoveryQrData(
      recoveryDid,
      hint: "Test account",
      createdAt: DateTime.now(),
    );
    
    _logger.i("Generated QR data: $qrData");
    
    // Test extraction
    try {
      String extractedDid = RecoveryIdentity.extractRecoveryDid(qrData);
      _logger.i("Extracted DID: $extractedDid");
      
      bool matches = extractedDid == recoveryDid;
      _logger.i("Extracted DID matches original: $matches");
      
      if (matches) {
        _logger.i("✅ QR code generation and extraction works");
      } else {
        _logger.e("❌ QR code extraction failed");
      }
    } catch (e) {
      _logger.e("❌ QR code extraction error: $e");
    }
  }

  /// Test mnemonic matching
  static void testMnemonicMatching() {
    _logger.i("=== TESTING MNEMONIC MATCHING ===");

    String mnemonic1 = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String mnemonic2 = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String mnemonic3 = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon above";
    
    bool match1 = RecoveryIdentity.mnemonicsMatch(mnemonic1, mnemonic2);
    bool match2 = RecoveryIdentity.mnemonicsMatch(mnemonic1, mnemonic3);
    
    _logger.i("Same mnemonics match: $match1");
    _logger.i("Different mnemonics match: $match2");
    
    if (match1 && !match2) {
      _logger.i("✅ Mnemonic matching works correctly");
    } else {
      _logger.e("❌ Mnemonic matching failed");
    }
  }

  /// Run all recovery tests
  static void runAllTests() {
    _logger.i("🧪 RUNNING ALL RECOVERY IDENTITY TESTS");
    _logger.i("=======================================");
    
    try {
      testDeterministicGeneration();
      _logger.i("");
      
      testMnemonicNormalization();
      _logger.i("");
      
      testDidValidation();
      _logger.i("");
      
      testQrCodeGeneration();
      _logger.i("");
      
      testMnemonicMatching();
      _logger.i("");
      
      _logger.i("🎉 ALL RECOVERY IDENTITY TESTS COMPLETED");
      _logger.i("=======================================");
      
    } catch (e) {
      _logger.e("❌ Recovery identity test failed: $e");
    }
  }

  /// Quick verification that a specific mnemonic generates expected DID
  static bool verifyMnemonicToDid(String mnemonic, String expectedDid) {
    String actualDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
    return actualDid == expectedDid;
  }

  /// Get sample recovery data for testing
  static Map<String, String> getSampleRecoveryData() {
    String sampleMnemonic = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
    String sampleDid = RecoveryIdentity.generateRecoveryDid(sampleMnemonic);
    
    return {
      'mnemonic': sampleMnemonic,
      'recovery_did': sampleDid,
      'qr_data': RecoveryIdentity.generateRecoveryQrData(sampleDid, hint: "Sample account"),
    };
  }
}