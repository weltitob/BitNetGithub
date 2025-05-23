import 'dart:convert';
import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bs58/bs58.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// Generates a deterministic DID from a BIP39 mnemonic
/// This replaces the old HDWallet.fromMnemonic(mnemonic).pubkey approach
/// while maintaining deterministic recovery capabilities
class Bip39DidGenerator {
  
  /// Generate a deterministic DID from a BIP39 mnemonic
  /// Uses the first 20 bytes of the BIP39 seed encoded in base58
  /// Format: did_{base58_encoded_20_bytes}
  static String generateDidFromMnemonic(String mnemonic) {
    // Validate mnemonic first
    if (!bip39.validateMnemonic(mnemonic)) {
      throw ArgumentError('Invalid BIP39 mnemonic provided');
    }
    
    // Generate BIP39 seed (512 bits / 64 bytes)
    Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    
    // Take first 20 bytes for DID (same as Bitcoin address hash160)
    Uint8List didBytes = seed.sublist(0, 20);
    
    // Encode as base58 (Bitcoin-style)
    String didHash = base58.encode(didBytes);
    
    return 'did_$didHash';
  }
  
  /// Verify that a mnemonic generates the expected DID
  /// Useful for recovery validation
  static bool verifyMnemonicForDid(String mnemonic, String expectedDid) {
    try {
      String generatedDid = generateDidFromMnemonic(mnemonic);
      return generatedDid == expectedDid;
    } catch (e) {
      return false;
    }
  }
  
  /// Extract the base58 hash from a DID
  /// Returns null if DID format is invalid
  static String? extractHashFromDid(String did) {
    if (did.startsWith('did_') && did.length > 4) {
      return did.substring(4);
    }
    return null;
  }
  
  /// Check if a DID follows the new BIP39-based format
  static bool isValidBip39Did(String did) {
    String? hash = extractHashFromDid(did);
    if (hash == null) return false;
    
    try {
      // Try to decode base58 - if successful, it's likely valid
      base58.decode(hash);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Generate master private key from BIP39 mnemonic (for signing)
  /// Returns the private key as hex string
  static String generatePrivateKeyFromMnemonic(String mnemonic) {
    if (!bip39.validateMnemonic(mnemonic)) {
      throw ArgumentError('Invalid BIP39 mnemonic provided');
    }
    
    // Generate BIP39 seed
    Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    
    // Take first 32 bytes as private key (secp256k1 key size)
    Uint8List privateKeyBytes = seed.sublist(0, 32);
    
    return hex.encode(privateKeyBytes);
  }
  
  /// Generate public key from private key hex
  /// Returns the compressed public key as hex string
  static String generatePublicKeyFromPrivateKey(String privateKeyHex) {
    // Decode private key
    Uint8List privateKeyBytes = Uint8List.fromList(hex.decode(privateKeyHex));
    
    // Create secp256k1 curve
    final ECDomainParameters secp256k1 = ECCurve_secp256k1();
    
    // Generate public key point
    ECPoint? publicKeyPoint = secp256k1.G * BigInt.parse(privateKeyHex, radix: 16);
    
    if (publicKeyPoint == null) {
      throw ArgumentError('Invalid private key');
    }
    
    // Get compressed public key (33 bytes: 02/03 prefix + 32 bytes X coordinate)
    Uint8List publicKeyBytes = publicKeyPoint.getEncoded(true);
    
    return hex.encode(publicKeyBytes);
  }
  
  /// Get both private and public keys from mnemonic
  /// Returns a map with 'privateKey' and 'publicKey' as hex strings
  static Map<String, String> generateKeysFromMnemonic(String mnemonic) {
    String privateKey = generatePrivateKeyFromMnemonic(mnemonic);
    String publicKey = generatePublicKeyFromPrivateKey(privateKey);
    
    return {
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }
  
  /// Generate deterministic DID from Lightning aezeed mnemonic
  /// This function ensures the same mnemonic always produces the same DID
  /// for recovery and login purposes with Lightning's native aezeed format
  static String generateDidFromLightningMnemonic(String mnemonic) {
    // Normalize the mnemonic (trim whitespace, convert to lowercase)
    String normalizedMnemonic = mnemonic.trim().toLowerCase();
    
    // Create SHA256 hash of the mnemonic
    var bytes = utf8.encode(normalizedMnemonic);
    var digest = sha256.convert(bytes);
    
    // Convert to hex and take first 16 characters for readability
    String hash = digest.toString().substring(0, 16);
    
    // Create deterministic DID with prefix
    return 'did:$hash';
  }
  
  /// Verify that a Lightning aezeed mnemonic generates the expected DID
  /// Useful for recovery validation
  static bool verifyLightningMnemonicForDid(String mnemonic, String expectedDid) {
    try {
      String generatedDid = generateDidFromLightningMnemonic(mnemonic);
      return generatedDid == expectedDid;
    } catch (e) {
      return false;
    }
  }
  
  /// Check if a DID follows the Lightning-based format
  static bool isValidLightningDid(String did) {
    return did.startsWith('did_lightning_') && did.length > 14;
  }
  
}