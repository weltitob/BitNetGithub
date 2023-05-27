import 'package:BitNet/backbone/helper/deepmapcast.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:cloud_functions/cloud_functions.dart';

createDID(String username) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createDID');
  print("Creating did...");
  final response = await callable.call(<String, dynamic>{
    //later pass entire user relevant info then create ION account
    // and get entire user as mydata back who is then registered
    'username': username,
  });
  print("Reponse: ${response.data}");

  // Use the deepMapCast utility function to recursively cast the data field
  final Map<String, dynamic> responseData = deepMapCast(response.data as Map<Object?, Object?>);

  final CloudfunctionCallback callback = CloudfunctionCallback.fromJson(responseData);

  // Print CloudfunctionCallback object using toString()
  print("CloudfunctionCallback: ${callback.toString()}");

  if (callback.statusCode == "200"){
    print("Cloudfunction Callbackmessage: ${callback.message}");
    final mydata = IONData.fromJson(callback.data);
    print("Mnemonic: ${mydata.mnemonic}");
    return mydata;
  } else{
    return;
  }
}
