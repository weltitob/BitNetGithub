import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'dart:convert';

dynamic registerUserWithEcsTask(String userId) async {
  final logger = Get.find<LoggerService>();
  try {
    try {
      final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      logger.i("App Check Token: $appCheckToken");
      logger.i("New App Check Token: $newAppCheckToken");
    } catch (e) {
      logger.e("Error obtaining App Check tokens: $e");
    }

    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'register_user_for_litd',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    final dynamic response = await callable.call(<String, dynamic>{
      'user_id': userId,  // Adapted to align with Python function expectations
    });

    print("Response FROM SERVER: ${response}");
    Map<String, dynamic> responseData;
    if (response.data is Map) {
      responseData = deepMapCast(response.data as Map<Object?, Object?>);
    } else {
      responseData = {'message': response.data};
    }
    try{
      final RestResponse restResponse = RestResponse.fromJson(responseData);
      logger.i("Cloud Function Callback: ${restResponse.toString()}");
      logger.i("Callback Message: ${restResponse.message}");

// Parse `message` as JSON first, then access `body` inside it
      Map<String, dynamic> messageMap = jsonDecode(restResponse.message);
      Map<String, dynamic> bodyData = jsonDecode(messageMap['body']);
      int statusCode = messageMap['statusCode'];

      EcsTaskRegistrationResponse ecsResponse = EcsTaskRegistrationResponse.fromJson(bodyData);
      if(statusCode != 200) {
        logger.e("Error registering user with ECS task: ${ecsResponse.details?.message}");
        return statusCode;
      }
      else{
        return statusCode;
      }
    } catch (e) {
      logger.e("Error parsing response data in registering ecs: $e");
    }
  } catch (e) {
    logger.i("Error calling ECS task registration: $e");
    return null;
  }
}


class EcsTaskRegistrationResponse {
  final int? statusCode;
  final EcsTaskDetails? details;

  EcsTaskRegistrationResponse({this.statusCode, this.details});

  factory EcsTaskRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return EcsTaskRegistrationResponse(
      statusCode: json['statusCode'],
      details: json['body'] != null ? EcsTaskDetails.fromJson(jsonDecode(json['body'])) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'details': details?.toJson(),
    };
  }
}

class EcsTaskDetails {
  final String message;
  final String taskDefinitionArn;
  final String efsId;
  final String accessPointId;
  final String serviceArn;

  EcsTaskDetails({
    required this.message,
    required this.taskDefinitionArn,
    required this.efsId,
    required this.accessPointId,
    required this.serviceArn,
  });

  factory EcsTaskDetails.fromJson(Map<String, dynamic> json) {
    return EcsTaskDetails(
      message: json['message'],
      taskDefinitionArn: json['taskDefinitionArn'],
      efsId: json['efsId'],
      accessPointId: json['accessPointId'],
      serviceArn: json['serviceArn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'taskDefinitionArn': taskDefinitionArn,
      'efsId': efsId,
      'accessPointId': accessPointId,
      'serviceArn': serviceArn,
    };
  }
}
