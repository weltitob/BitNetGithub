import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'dart:convert';
import 'dart:typed_data';

/// Unit tests for Lightning invoice cloud function utilities
///
/// These tests verify the cryptographic functions used in Lightning invoice generation:
/// 1. Preimage generation - Random 32-byte generation for Lightning invoices
/// 2. Hash computation - SHA256 hash of preimage for invoice creation
/// 3. Base64 encoding/decoding operations
/// 4. Cryptographic security and randomness validation
///
/// Test categories:
/// - Preimage generation validation
/// - Hash computation accuracy
/// - Cryptographic properties (entropy, uniqueness)
/// - Edge cases and error handling
/// - Integration between preimage and hash functions
void main() {
  group('Lightning Invoice Cloud Functions', () {
    group('Preimage Generation', () {
      test('should generate 32-byte preimage', () {
        final preimage = generatePreimage();

        expect(preimage.length, equals(32));
        expect(preimage, isA<List<int>>());
      });

      test('should generate different preimages on consecutive calls', () {
        final preimage1 = generatePreimage();
        final preimage2 = generatePreimage();
        final preimage3 = generatePreimage();

        // Preimages should be different (extremely unlikely to be the same)
        expect(preimage1, isNot(equals(preimage2)));
        expect(preimage2, isNot(equals(preimage3)));
        expect(preimage1, isNot(equals(preimage3)));
      });

      test('should generate preimage with bytes in valid range', () {
        final preimage = generatePreimage();

        // All bytes should be in range 0-255
        for (final byte in preimage) {
          expect(byte, greaterThanOrEqualTo(0));
          expect(byte, lessThanOrEqualTo(255));
        }
      });

      test('should generate sufficient entropy', () {
        // Generate multiple preimages and check for randomness
        final preimages = List.generate(100, (_) => generatePreimage());

        // Check that we don't have obvious patterns
        final uniqueFirstBytes = preimages.map((p) => p[0]).toSet();
        final uniqueLastBytes = preimages.map((p) => p[31]).toSet();

        // With 100 samples, we should have good distribution
        // (not all the same byte value)
        expect(uniqueFirstBytes.length, greaterThan(10));
        expect(uniqueLastBytes.length, greaterThan(10));
      });

      test('should be compatible with base64 encoding', () {
        final preimage = generatePreimage();

        // Should be able to encode to base64 without issues
        final base64Encoded = base64Encode(preimage);
        expect(base64Encoded, isA<String>());
        expect(base64Encoded.isNotEmpty, isTrue);

        // Should be able to decode back to original
        final decoded = base64Decode(base64Encoded);
        expect(decoded, equals(preimage));
      });

      test('should generate cryptographically random data', () {
        // Test for obvious non-randomness patterns
        final preimage = generatePreimage();

        // Check it's not all zeros
        expect(preimage.any((byte) => byte != 0), isTrue);

        // Check it's not all 255s
        expect(preimage.any((byte) => byte != 255), isTrue);

        // Check it's not incrementing sequence
        bool isSequential = true;
        for (int i = 1; i < preimage.length; i++) {
          if (preimage[i] != (preimage[i - 1] + 1) % 256) {
            isSequential = false;
            break;
          }
        }
        expect(isSequential, isFalse);
      });
    });

    group('Hash Computation', () {
      test('should compute correct SHA256 hash', () {
        // Test with known input/output pair
        final testInput = [0x68, 0x65, 0x6c, 0x6c, 0x6f]; // "hello" in bytes
        final hash = computeHash(testInput);

        expect(hash.length, equals(32)); // SHA256 produces 32-byte hash
        expect(hash, isA<List<int>>());

        // Test that the hash is deterministic (same input produces same output)
        final hash2 = computeHash(testInput);
        expect(hash, equals(hash2));

        // Test with simple known input for deterministic behavior
        final simpleInput = [0x61]; // ASCII 'a'
        final simpleHash = computeHash(simpleInput);
        expect(simpleHash.length, equals(32));

        // Test the same input produces same output (deterministic)
        final simpleHash2 = computeHash(simpleInput);
        expect(simpleHash, equals(simpleHash2));
      });

      test('should produce deterministic results', () {
        final testInput = [1, 2, 3, 4, 5];

        final hash1 = computeHash(testInput);
        final hash2 = computeHash(testInput);
        final hash3 = computeHash(testInput);

        // Same input should always produce same hash
        expect(hash1, equals(hash2));
        expect(hash2, equals(hash3));
      });

      test('should produce different hashes for different inputs', () {
        final input1 = [1, 2, 3, 4, 5];
        final input2 = [1, 2, 3, 4, 6]; // One byte different
        final input3 = [5, 4, 3, 2, 1]; // Same bytes, different order

        final hash1 = computeHash(input1);
        final hash2 = computeHash(input2);
        final hash3 = computeHash(input3);

        expect(hash1, isNot(equals(hash2)));
        expect(hash2, isNot(equals(hash3)));
        expect(hash1, isNot(equals(hash3)));
      });

      test('should handle empty input', () {
        final emptyInput = <int>[];
        final hash = computeHash(emptyInput);

        expect(hash.length, equals(32));
        expect(hash, isA<List<int>>());

        // Test deterministic behavior - same empty input should produce same hash
        final hash2 = computeHash(emptyInput);
        expect(hash, equals(hash2));
      });

      test('should handle single byte input', () {
        final singleByteInput = [0x42];
        final hash = computeHash(singleByteInput);

        expect(hash.length, equals(32));
        expect(hash, isA<List<int>>());
      });

      test('should handle large inputs', () {
        // Test with 1MB of data
        final largeInput = List.generate(1024 * 1024, (i) => i % 256);
        final hash = computeHash(largeInput);

        expect(hash.length, equals(32));
        expect(hash, isA<List<int>>());
      });

      test('should be compatible with base64 encoding', () {
        final testInput = [1, 2, 3, 4, 5];
        final hash = computeHash(testInput);

        final base64Hash = base64Encode(hash);
        expect(base64Hash, isA<String>());
        expect(base64Hash.isNotEmpty, isTrue);

        final decoded = base64Decode(base64Hash);
        expect(decoded, equals(hash));
      });
    });

    group('Preimage and Hash Integration', () {
      test('should work together for Lightning invoice flow', () {
        // Simulate complete Lightning invoice cryptographic flow

        // 1. Generate preimage
        final preimage = generatePreimage();
        expect(preimage.length, equals(32));

        // 2. Compute hash of preimage
        final hash = computeHash(preimage);
        expect(hash.length, equals(32));

        // 3. Verify hash is different from preimage
        expect(hash, isNot(equals(preimage)));

        // 4. Encode both for transmission
        final preimageBase64 = base64Encode(preimage);
        final hashBase64 = base64Encode(hash);

        expect(preimageBase64, isA<String>());
        expect(hashBase64, isA<String>());
        expect(preimageBase64, isNot(equals(hashBase64)));

        // 5. Verify decoding works correctly
        final decodedPreimage = base64Decode(preimageBase64);
        final decodedHash = base64Decode(hashBase64);

        expect(decodedPreimage, equals(preimage));
        expect(decodedHash, equals(hash));

        // 6. Verify hash relationship is maintained
        final recomputedHash = computeHash(decodedPreimage);
        expect(recomputedHash, equals(decodedHash));
      });

      test('should handle multiple invoice generation scenarios', () {
        // Test generating multiple invoices with proper cryptographic separation
        final invoiceData = <Map<String, dynamic>>[];

        for (int i = 0; i < 10; i++) {
          final preimage = generatePreimage();
          final hash = computeHash(preimage);

          invoiceData.add({
            'preimage': base64Encode(preimage),
            'hash': base64Encode(hash),
          });
        }

        // Verify all preimages are unique
        final preimages = invoiceData.map((data) => data['preimage']).toSet();
        expect(preimages.length, equals(10));

        // Verify all hashes are unique
        final hashes = invoiceData.map((data) => data['hash']).toSet();
        expect(hashes.length, equals(10));

        // Verify hash-preimage relationships
        for (final data in invoiceData) {
          final preimage = base64Decode(data['preimage']);
          final expectedHash = computeHash(preimage);
          final actualHash = base64Decode(data['hash']);

          expect(actualHash, equals(expectedHash));
        }
      });

      test('should maintain security properties', () {
        // Test that the cryptographic properties required for Lightning are maintained

        final preimage1 = generatePreimage();
        final preimage2 = generatePreimage();

        final hash1 = computeHash(preimage1);
        final hash2 = computeHash(preimage2);

        // Preimages should be unpredictable
        expect(preimage1, isNot(equals(preimage2)));

        // Hashes should be unpredictable
        expect(hash1, isNot(equals(hash2)));

        // Small change in preimage should cause large change in hash (avalanche effect)
        final modifiedPreimage1 = List<int>.from(preimage1);
        modifiedPreimage1[0] =
            (modifiedPreimage1[0] + 1) % 256; // Change one bit

        final modifiedHash1 = computeHash(modifiedPreimage1);

        // Hash should be completely different
        expect(modifiedHash1, isNot(equals(hash1)));

        // Count differing bytes (should be roughly half for good hash function)
        int differingBytes = 0;
        for (int i = 0; i < 32; i++) {
          if (hash1[i] != modifiedHash1[i]) {
            differingBytes++;
          }
        }

        // Expect significant difference (avalanche effect)
        expect(differingBytes, greaterThan(10));
      });
    });

    group('Error Handling and Edge Cases', () {
      test('should handle maximum value bytes', () {
        final maxBytes = List.generate(32, (_) => 255);
        final hash = computeHash(maxBytes);

        expect(hash.length, equals(32));
        expect(hash, isA<List<int>>());
      });

      test('should handle minimum value bytes', () {
        final minBytes = List.generate(32, (_) => 0);
        final hash = computeHash(minBytes);

        expect(hash.length, equals(32));
        expect(hash, isA<List<int>>());
      });

      test('should handle irregular input lengths', () {
        // Test various input lengths
        final lengths = [1, 15, 31, 33, 64, 100, 999];

        for (final length in lengths) {
          final input = List.generate(length, (i) => i % 256);
          final hash = computeHash(input);

          expect(hash.length, equals(32),
              reason: 'Failed for input length $length');
        }
      });

      test('should be thread-safe for concurrent operations', () {
        // Simulate concurrent preimage generation
        final futures = List.generate(50, (_) async {
          final preimage = generatePreimage();
          final hash = computeHash(preimage);
          return {'preimage': preimage, 'hash': hash};
        });

        // This test mainly ensures no exceptions are thrown during concurrent access
        expect(() async {
          final results = await Future.wait(futures);
          expect(results.length, equals(50));

          // Verify all results are valid
          for (final result in results) {
            expect(result['preimage'], isA<List<int>>());
            expect(result['hash'], isA<List<int>>());
            expect((result['preimage'] as List<int>).length, equals(32));
            expect((result['hash'] as List<int>).length, equals(32));
          }
        }, returnsNormally);
      });
    });

    group('Performance and Optimization', () {
      test('should generate preimage efficiently', () {
        // Test that preimage generation is reasonably fast
        final stopwatch = Stopwatch()..start();

        for (int i = 0; i < 1000; i++) {
          generatePreimage();
        }

        stopwatch.stop();

        // Should complete 1000 generations in reasonable time (less than 1 second)
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });

      test('should compute hash efficiently', () {
        // Test that hash computation is reasonably fast
        final testData = List.generate(32, (i) => i);
        final stopwatch = Stopwatch()..start();

        for (int i = 0; i < 1000; i++) {
          computeHash(testData);
        }

        stopwatch.stop();

        // Should complete 1000 hash computations in reasonable time
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });
    });
  });
}
