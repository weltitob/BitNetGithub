import 'package:cloud_functions/cloud_functions.dart';
import 'package:nexus_wallet/models/cloudfunction_callback.dart';

Future<CloudfunctionCallback> sendBitcoin({
    required String sender_private_key,
    required String sender_address,
    required String receiver_address,
    required String amount_to_send,
    required String fee_size}) async {
  try {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendBitcoin');
    final resp = await callable.call(<String, dynamic>{
      'sender_private_key': sender_private_key,
      'sender_address': sender_address,
      'receiver_address': receiver_address,
      'amount_to_send': amount_to_send,
      'fee_size': fee_size,
    });
    print("Das isch deine response: ${resp.data}");
    final mydata = CloudfunctionCallback.fromJson(resp.data);
    return mydata;
  } catch (e) {
    print('EIN FEHLR IST BEIM AUFRUF DER CLOUD FUNKTION AUFGETRETEN');
    print(e);
    return CloudfunctionCallback(
      status: 'error',
      message: 'Wir können aktuell unsere Server nicht erreichen.',
    );
  }
}
