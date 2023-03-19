import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';

Future<CloudfunctionCallback>getTransactions(String walletAddress) async {
  try {
    print('CALL GET TRANSACTIONS...');
    HttpsCallable callable =
    FirebaseFunctions.instance.httpsCallable('getTransactions');
    final resp = await callable.call(<String, dynamic>{
      'address': walletAddress,
    });
    final mydata = CloudfunctionCallback.fromJson(resp.data);
    print(mydata.message);
    print(mydata.status);
    return mydata;
  } catch (e) {
    print("Wir konnten die Transaktionen der Wallet nicht aktualisieren: ${e}");
    return CloudfunctionCallback(
      status: 'error',
      message: 'Wir können aktuell unsere Server nicht erreichen.',
    );
  }
}