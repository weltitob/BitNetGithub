import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';

getWalletBalance() async {
  try {
    print('CALL GET BALANCE...');
    HttpsCallable callable =
    FirebaseFunctions.instance.httpsCallable('getWalletBalance');
    final resp = await callable.call();
    print('Response: ${resp.data}');
    //final mydata = CloudfunctionCallback.fromJson(resp.data);
    //return mydata;
  } catch (e) {
    print("Wir konnten die Balance nicht aktualisieren: ${e}");
    return CloudfunctionCallback(
      status: 'error',
      message: 'Wir können aktuell unsere Server nicht erreichen.',
    );
  }
}