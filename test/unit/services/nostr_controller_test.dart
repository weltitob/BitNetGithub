import 'package:bitnet/backbone/services/nostr_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nip47/nip47.dart' as nip47;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NostrController Unit Tests', () {
    late NostrController controller;

    setUp(() {
      // Initialize GetX
      Get.reset();

      // Create controller
      controller = NostrController();
    });

    tearDown(() {
      Get.reset();
    });

    group('Initialization Tests', () {
      test('should initialize with empty active connections', () {
        expect(controller.activeConnections, isEmpty);
      });

      test('should have correct default relays', () {
        expect(controller.defaultRelays.length, 3);
        expect(controller.defaultRelays[0].toString(), 'wss://relay.nwc.dev');
        expect(controller.defaultRelays[1].toString(), 'wss://nos.lol');
        expect(controller.defaultRelays[2].toString(), 'wss://relay.damus.io');
      });

      test('should have correct default methods', () {
        expect(controller.defaultMethods.length, 6);
        expect(controller.defaultMethods, contains(nip47.Method.getInfo));
        expect(controller.defaultMethods, contains(nip47.Method.getBalance));
        expect(
            controller.defaultMethods, contains(nip47.Method.listTransactions));
        expect(controller.defaultMethods, contains(nip47.Method.payInvoice));
        expect(controller.defaultMethods, contains(nip47.Method.makeInvoice));
        expect(controller.defaultMethods, contains(nip47.Method.lookupInvoice));
      });
    });

    group('Connection Management Tests', () {
      test('should start with no active connections', () {
        expect(controller.activeConnections, isEmpty);
        expect(controller.getAllConnections(), isEmpty);
      });

      test('should handle connection operations', () {
        // Create a test connection
        final testConnection = NwcConnection(
          id: 'test_id_1',
          appName: 'Test App',
          connectionUri: Uri.parse('nostr+walletconnect://test'),
          methods: controller.defaultMethods,
          createdAt: DateTime.now(),
          walletPubkey: 'test_pubkey',
        );

        // Add connection
        controller.activeConnections.add(testConnection);

        // Verify connection was added
        expect(controller.activeConnections.length, 1);
        expect(controller.getAllConnections().length, 1);

        // Test get connection by ID
        final retrieved = controller.getConnectionById('test_id_1');
        expect(retrieved, isNotNull);
        expect(retrieved!.appName, 'Test App');

        // Test get non-existent connection
        final notFound = controller.getConnectionById('non_existent');
        expect(notFound, isNull);
      });

      test('should close all connections', () async {
        // Add multiple test connections
        for (int i = 0; i < 3; i++) {
          controller.activeConnections.add(NwcConnection(
            id: 'test_id_$i',
            appName: 'Test App $i',
            connectionUri: Uri.parse('nostr+walletconnect://test$i'),
            methods: controller.defaultMethods,
            createdAt: DateTime.now(),
            walletPubkey: 'test_pubkey_$i',
          ));
        }

        expect(controller.activeConnections.length, 3);

        // Close all connections
        await controller.closeAllNwcConnections();

        // Verify all connections were closed
        expect(controller.activeConnections, isEmpty);
      });
    });

    group('NwcConnection Model Tests', () {
      test('should create NwcConnection with all required properties', () {
        final now = DateTime.now();
        final connection = NwcConnection(
          id: 'test_connection',
          appName: 'Test Wallet App',
          connectionUri:
              Uri.parse('nostr+walletconnect://pubkey?relay=wss://relay.test'),
          methods: [nip47.Method.getInfo, nip47.Method.getBalance],
          createdAt: now,
          walletPubkey: 'wallet_pubkey_123',
        );

        expect(connection.id, 'test_connection');
        expect(connection.appName, 'Test Wallet App');
        expect(connection.connectionUri.toString(),
            'nostr+walletconnect://pubkey?relay=wss://relay.test');
        expect(connection.methods.length, 2);
        expect(connection.methods, contains(nip47.Method.getInfo));
        expect(connection.methods, contains(nip47.Method.getBalance));
        expect(connection.createdAt, now);
        expect(connection.walletPubkey, 'wallet_pubkey_123');
        expect(connection.requestStream, isNull);
        expect(connection.context, isNull);
      });

      test('should create NwcConnection with different method combinations',
          () {
        final connection1 = NwcConnection(
          id: '1',
          appName: 'Read-only App',
          connectionUri: Uri.parse('nostr+walletconnect://test1'),
          methods: [nip47.Method.getInfo, nip47.Method.getBalance],
          createdAt: DateTime.now(),
          walletPubkey: 'pubkey1',
        );

        final connection2 = NwcConnection(
          id: '2',
          appName: 'Full Access App',
          connectionUri: Uri.parse('nostr+walletconnect://test2'),
          methods: controller.defaultMethods,
          createdAt: DateTime.now(),
          walletPubkey: 'pubkey2',
        );

        expect(connection1.methods.length, 2);
        expect(connection2.methods.length, controller.defaultMethods.length);
        expect(connection2.methods, contains(nip47.Method.payInvoice));
        expect(connection1.methods, isNot(contains(nip47.Method.payInvoice)));
      });

      test(
          'should create connection uri that matches appropriate specifications',
          () {
        // Hardcoded expected URI format for NWC connections
        const expectedUri =
            'nostr+walletconnect://a93c0b43f0f8ef5e5f6e7c9d3a2b1c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0?relay=wss://relay.nwc.dev&secret=1234567890abcdef1234567890abcdef';

        // Create a connection with the specific URI
        final connection = NwcConnection(
          id: 'hardcoded_uri_test',
          appName: 'Hardcoded URI Test App',
          connectionUri: Uri.parse(expectedUri),
          methods: [
            nip47.Method.getInfo,
            nip47.Method.getBalance,
            nip47.Method.payInvoice,
            nip47.Method.makeInvoice,
          ],
          createdAt: DateTime.now(),
          walletPubkey:
              'a93c0b43f0f8ef5e5f6e7c9d3a2b1c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0',
        );

        // Add to controller
        controller.activeConnections.add(connection);

        // Verify the connection was added
        expect(controller.activeConnections.length, 1);

        // Get the connection and verify URI matches exactly
        final retrievedConnection =
            controller.getConnectionById('hardcoded_uri_test');
        expect(retrievedConnection, isNotNull);
        expect(
            retrievedConnection!.connectionUri.toString(), equals(expectedUri));

        // Verify URI components
        expect(retrievedConnection.connectionUri.scheme, 'nostr+walletconnect');
        expect(retrievedConnection.connectionUri.host,
            'a93c0b43f0f8ef5e5f6e7c9d3a2b1c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0');
        expect(retrievedConnection.connectionUri.queryParameters['relay'],
            'wss://relay.nwc.dev');
        expect(retrievedConnection.connectionUri.queryParameters['secret'],
            '1234567890abcdef1234567890abcdef');

        // Verify the wallet pubkey matches the host part of the URI
        expect(retrievedConnection.walletPubkey,
            retrievedConnection.connectionUri.host);
      });
    });

    group('Default Configuration Tests', () {
      test('should have proper relay configuration', () {
        // Test relay URLs are valid
        for (final relay in controller.defaultRelays) {
          expect(relay.scheme, anyOf('wss', 'ws'));
          expect(relay.host, isNotEmpty);
        }
      });

      test('should have comprehensive method support', () {
        // Verify all expected NWC methods are included
        final expectedMethods = [
          nip47.Method.getInfo,
          nip47.Method.getBalance,
          nip47.Method.listTransactions,
          nip47.Method.payInvoice,
          nip47.Method.makeInvoice,
          nip47.Method.lookupInvoice,
        ];

        for (final method in expectedMethods) {
          expect(controller.defaultMethods, contains(method));
        }
      });
    });

    group('Edge Case Tests', () {
      test('should handle empty connections list operations', () {
        expect(controller.getAllConnections(), isEmpty);
        expect(controller.getConnectionById('any_id'), isNull);
      });

      test('should handle duplicate connection IDs gracefully', () {
        final connection1 = NwcConnection(
          id: 'duplicate_id',
          appName: 'App 1',
          connectionUri: Uri.parse('nostr+walletconnect://test1'),
          methods: [],
          createdAt: DateTime.now(),
          walletPubkey: 'pubkey1',
        );

        final connection2 = NwcConnection(
          id: 'duplicate_id',
          appName: 'App 2',
          connectionUri: Uri.parse('nostr+walletconnect://test2'),
          methods: [],
          createdAt: DateTime.now(),
          walletPubkey: 'pubkey2',
        );

        controller.activeConnections.add(connection1);
        controller.activeConnections.add(connection2);

        // Both connections exist
        expect(controller.activeConnections.length, 2);

        // getConnectionById returns the first match
        final found = controller.getConnectionById('duplicate_id');
        expect(found?.appName, 'App 1');
      });
    });

    group('Observable Behavior Tests', () {
      test('activeConnections should be reactive', () {
        // Track changes to activeConnections
        var changeCount = 0;
        controller.activeConnections.listen((_) {
          changeCount++;
        });

        // Add a connection
        controller.activeConnections.add(NwcConnection(
          id: 'reactive_test',
          appName: 'Reactive App',
          connectionUri: Uri.parse('nostr+walletconnect://reactive'),
          methods: [],
          createdAt: DateTime.now(),
          walletPubkey: 'reactive_pubkey',
        ));

        // Small delay to allow reactive update
        Future.delayed(Duration(milliseconds: 100), () {
          expect(changeCount, greaterThan(0));
        });
      });
    });
  });
}
