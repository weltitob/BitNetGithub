import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<String?> registerLitEcs(String userId) async {
  try {
    print("STARTING ECS REGISTRATION");

    try{
      final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      print("App Check Token: $appCheckToken");
      print("New App Check Token: $newAppCheckToken");
    } catch (e) {
      print("INAPP Error getting App Check tokens: $e");
    }

    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'register_user_for_litd',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),  // Increase the timeout duration
        limitedUseAppCheckToken: true,
      ),
    );

    final dynamic response = await callable.call(<String, dynamic>{
      'user_id': userId,  // Changed from 'userid' to 'user_id' to match Python function
    });

    print("Response FROM SERVER: ${response}");
    // Check if response.data is a Map, if not, wrap it in a Map
    Map<String, dynamic> responseData;
    if (response.data is Map) {
      responseData = deepMapCast(response.data as Map<Object?, Object?>);
    } else {
      responseData = {'message': response.data};
    }

    final RestResponse callback = RestResponse.fromJson(responseData);
    print("CloudfunctionCallback: ${callback.toString()}");

    // The Python function doesn't return a status code, so we'll assume it's successful if we get here
    print(callback.message);

    // The Python function doesn't return a customToken, so we'll return the message instead
    return callback.message;
  } catch (e) {
    print("Error calling start_ecs_task: $e  ");
    return null;
  }
}