import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nexus_wallet/backbone/streams/gettransactionsstream.dart';
import 'package:nexus_wallet/models/transaction.dart';

// Mock FirebaseAuth and User objects
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}

void main() {
  group('TransactionsStream', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();

      // Return the mock user when currentUser is called
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    });

    test('getTransactionsStream should return a stream of BitcoinTransaction objects', () {
      // Create a mock collection reference and snapshot
      final mockCollectionReference = MockCollectionReference();
      final mockQuerySnapshot = MockQuerySnapshot();

      // Return the mock snapshot when snapshots is called on the mock collection reference
      when(mockCollectionReference.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));

      // Return a mock list of Transaction documents when docs is called on the mock snapshot
      when(mockQuerySnapshot.docs).thenReturn([
        MockQueryDocumentSnapshot(),
        MockQueryDocumentSnapshot(),
        MockQueryDocumentSnapshot(),
      ]);
      // Create a new TransactionsStream object
      final transactionsStream = TransactionsStream();

      // Call getTransactionsStream and listen for the emitted values
      final stream = transactionsStream.getTransactionsStream();
      expect(stream, emits(isA<List<BitcoinTransaction>>()));
    });
  });
}

// Mock classes
class MockCollectionReference extends Mock implements CollectionReference {}
class MockQuerySnapshot extends Mock implements QuerySnapshot {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}
class MockBitcoinTransaction extends Mock implements BitcoinTransaction {}