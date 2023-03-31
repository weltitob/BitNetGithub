import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/helper/databaserefs.dart';
import 'package:nexus_wallet/models/transaction.dart';

/*
This class provides a stream of transaction data for the currently authenticated user.
 */
class TransactionsStream {

  // Get the currently authenticated user
  final User? currentuser = Auth().currentUser;

  Stream<List<BitcoinTransaction>> getTransactionsStream() {
    // Create a stream that listens to changes in the transactions collection
    return transactionCollection
        .doc(currentuser!.uid)
        .collection('all')
        .orderBy('timestampSent', descending: true)
        .snapshots()
        .map((snapshot) {
      // Convert each document in the snapshot to a Transaction object
      return snapshot.docs
          .map((doc) => BitcoinTransaction.fromDocument(doc))
          .toList();
    });
  }
}