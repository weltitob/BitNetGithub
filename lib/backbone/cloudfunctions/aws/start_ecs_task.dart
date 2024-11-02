import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'dart:convert';

Future<dynamic> startEcsTask(String userId) async {
  final logger = Get.find<LoggerService>();
  final stopwatch = Stopwatch()..start(); // Track time for response

  try {
    // Attempt to retrieve App Check tokens
    try {
      final appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      logger.i("App Check Token: $appCheckToken");
      logger.i("New App Check Token: $newAppCheckToken");
    } catch (e) {
      logger.e("Error obtaining App Check tokens: $e");
    }

    // Prepare Firebase Cloud Function for starting ECS task
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'start_ecs_task',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Call the function with necessary parameters
    final dynamic response = await callable.call(<String, dynamic>{
      'user_id': userId,
    });

    logger.i("Response FROM SERVER: ${response}");

    // Ensure response data is parsed to a Map
    Map<String, dynamic> responseData;
    if (response.data is Map) {
      responseData = deepMapCast(response.data as Map<Object?, Object?>);
    } else {
      responseData = {'message': response.data};
    }

    // Parse response data into RestResponse model
    final RestResponse callback = RestResponse.fromJson(responseData);
    logger.i("Cloud Function Callback: ${callback.toString()}");
    logger.i("Callback Message: ${callback.message}");

    // Extract message and body
    Map<String, dynamic> messageMap = jsonDecode(callback.message);
    int statusCode = messageMap['statusCode'];
    Map<String, dynamic> bodyData = jsonDecode(messageMap['body']);

    // Process ECS task response
    EcsTaskStartResponse ecsResponse = EcsTaskStartResponse.fromJson(messageMap);
    if (statusCode != 200) {
      logger.e("Error starting ECS task: ${ecsResponse.details?.message}");
      return ecsResponse;
    } else {
      return ecsResponse;
    }
  } catch (e) {
    logger.e("Error in ECS task start: $e");
    return null;
  } finally {
    stopwatch.stop();
    logger.i('Time taken for response: ${stopwatch.elapsed}');
  }
}

// ECS Task Start Response Model
class EcsTaskStartResponse {
  final int? statusCode;
  final EcsTaskDetails? details;

  EcsTaskStartResponse({this.statusCode, this.details});

  factory EcsTaskStartResponse.fromJson(Map<String, dynamic> json) {
    return EcsTaskStartResponse(
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
  final String taskArn;
  final String taskDefinitionArn;
  final String publicIp;
  final String privateIp;
  final List<String> subnets;
  final String serviceArn;

  EcsTaskDetails({
    required this.message,
    required this.taskArn,
    required this.taskDefinitionArn,
    required this.publicIp,
    required this.privateIp,
    required this.subnets,
    required this.serviceArn,
  });

  factory EcsTaskDetails.fromJson(Map<String, dynamic> json) {
    return EcsTaskDetails(
      message: json['message'],
      taskArn: json['taskArn'],
      taskDefinitionArn: json['taskDefinitionArn'],
      publicIp: json['publicIp'],
      privateIp: json['privateIp'],
      subnets: List<String>.from(json['subnets']),
      serviceArn: json['serviceArn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'taskArn': taskArn,
      'taskDefinitionArn': taskDefinitionArn,
      'publicIp': publicIp,
      'privateIp': privateIp,
      'subnets': subnets,
      'serviceArn': serviceArn,
    };
  }
}
