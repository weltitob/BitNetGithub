import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'dart:core';

import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'dart:convert';
import 'dart:core';

dynamic stopUserTask(String userId) async {
  final stopwatch = Stopwatch()..start();

  try {
    print("STOPPING ECS TASK");

    // AppCheck-Token erhalten
    try {
      final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      print("App Check Token: $appCheckToken");
      print("New App Check Token: $newAppCheckToken");
    } catch (e) {
      print("INAPP Error getting App Check tokens: $e");
    }

    // Firebase Functions vorbereiten und Callable Funktion initialisieren
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'stop_ecs_task',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Funktion aufrufen mit user_id als Parameter
    final dynamic response = await callable.call(<String, dynamic>{
      'user_id': userId,
    });

    print("Response FROM SERVER: ${response}");
    Map<String, dynamic> responseData;
    if (response.data is Map) {
      responseData = deepMapCast(response.data as Map<Object?, Object?>);
    } else {
      responseData = {'message': response.data};
    }

    // RestResponse erzeugen und Logausgabe
    final RestResponse callback = RestResponse.fromJson(responseData);
    print("CloudfunctionCallback: ${callback.toString()}");

    // `message` aus Callback parsen und Statuscode extrahieren
    Map<String, dynamic> messageMap = jsonDecode(callback.message);
    int statusCode = messageMap['statusCode'];
    Map<String, dynamic> bodyData = jsonDecode(messageMap['body']);
    String stopMessage = bodyData['message'];
    String stoppedTaskArn = bodyData['stoppedTask'];

    print("Stop Task Message: $stopMessage");
    print("Stopped Task ARN: $stoppedTaskArn");

    // Erfolgreiche Rückgabe des Statuscodes
    if (statusCode != 200) {
      print("Error stopping user task: $stopMessage");
    }
    return statusCode;
  } catch (e) {
    print("Error calling stop_ecs_task: $e");
    return null;
  } finally {
    stopwatch.stop();
    print('Time taken for response: ${stopwatch.elapsed}');
  }
}
