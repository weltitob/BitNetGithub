import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Recovery Identity Generator
///
/// Generates deterministic DIDs from mnemonics for account recovery.
/// This solves the chicken-and-egg problem where we need to know which
/// Lightning node to connect to during recovery flows.
class RecoveryIdentity {
  /// Generate a deterministic recovery DID from a mnemonic
  ///
  /// This DID will ALWAYS be the same for the same mnemonic,
  /// allowing users to recover their accounts even when we don't
  /// know which Lightning node they're assigned to.
  ///
  /// Format: did:mnemonic:{16_char_hash}
  static String generateRecoveryDid(String mnemonic) {
    // Normalize the mnemonic for consistent hashing
    String normalizedMnemonic = _normalizeMnemonic(mnemonic);

    // Generate SHA256 hash
    var bytes = utf8.encode(normalizedMnemonic);
    var digest = sha256.convert(bytes);

    // Take first 16 characters of hash for DID
    String hash = digest.toString().substring(0, 16);

    return 'did:mnemonic:$hash';
  }

  /// Generate a lookup hash for mnemonic indexing
  ///
  /// This creates a searchable hash that doesn't expose the full mnemonic
  /// but allows us to index and find accounts during recovery.
  static String generateMnemonicHash(String mnemonic) {
    String normalizedMnemonic = _normalizeMnemonic(mnemonic);
    var bytes = utf8.encode(normalizedMnemonic);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Extract recovery DID from various input formats
  ///
  /// Supports:
  /// - Full mnemonic phrases
  /// - Pre-computed recovery DIDs
  /// - QR code data containing recovery info
  static String extractRecoveryDid(String input) {
    // If input is already a recovery DID, return it
    if (input.startsWith('did:mnemonic:')) {
      return input;
    }

    // If input looks like a mnemonic (multiple words), generate DID
    if (input.trim().split(' ').length >= 12) {
      return generateRecoveryDid(input);
    }

    // Try to extract from QR code data (JSON format)
    try {
      Map<String, dynamic> qrData = jsonDecode(input);
      if (qrData.containsKey('recovery_did')) {
        return qrData['recovery_did'];
      }
      if (qrData.containsKey('mnemonic')) {
        return generateRecoveryDid(qrData['mnemonic']);
      }
    } catch (e) {
      // Not JSON, continue with other methods
    }

    throw ArgumentError(
        'Unable to extract recovery DID from input: ${input.substring(0, 20)}...');
  }

  /// Validate that a recovery DID has the correct format
  static bool isValidRecoveryDid(String did) {
    // Must start with did:mnemonic: and have 16 hex characters
    RegExp didPattern = RegExp(r'^did:mnemonic:[a-f0-9]{16}$');
    bool isValid = didPattern.hasMatch(did);

    // Debug logging
    print('🔍 RecoveryIdentity.isValidRecoveryDid("$did"):');
    print('   Pattern: ^did:mnemonic:[a-f0-9]{16}\$');
    print('   Length: ${did.length}');
    print('   Starts with "did:mnemonic:": ${did.startsWith("did:mnemonic:")}');
    if (did.startsWith("did:mnemonic:")) {
      String hash = did.substring(13); // "did:mnemonic:".length = 13
      print('   Hash part: "$hash" (length: ${hash.length})');
      print('   Hash is hex: ${RegExp(r'^[a-f0-9]+$').hasMatch(hash)}');
    }
    print('   Result: $isValid');

    return isValid;
  }

  /// Normalize mnemonic for consistent hashing
  ///
  /// - Converts to lowercase
  /// - Trims whitespace
  /// - Normalizes word spacing
  /// - Removes extra characters
  static String _normalizeMnemonic(String mnemonic) {
    return mnemonic
        .trim()
        .toLowerCase()
        .replaceAll(
            RegExp(r'\s+'), ' ') // Normalize multiple spaces to single space
        .replaceAll(
            RegExp(r'[^\w\s]'), ''); // Remove non-word characters except spaces
  }

  /// Verify that two mnemonics generate the same recovery DID
  ///
  /// Useful for testing and validation
  static bool mnemonicsMatch(String mnemonic1, String mnemonic2) {
    return generateRecoveryDid(mnemonic1) == generateRecoveryDid(mnemonic2);
  }

  /// Generate QR code data for recovery
  ///
  /// Creates a JSON structure that can be embedded in QR codes
  /// for easy account recovery
  static String generateRecoveryQrData(
    String recoveryDid, {
    String? hint,
    DateTime? createdAt,
  }) {
    Map<String, dynamic> qrData = {
      'type': 'bitnet_recovery',
      'recovery_did': recoveryDid,
      'version': '1.0',
    };

    if (hint != null) {
      qrData['hint'] = hint;
    }

    if (createdAt != null) {
      qrData['created_at'] = createdAt.toIso8601String();
    }

    return jsonEncode(qrData);
  }
}
