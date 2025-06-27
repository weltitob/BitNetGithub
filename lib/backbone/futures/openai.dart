import 'dart:convert';
import 'package:bitnet/models/openai/openai_image.dart';
import 'package:flutter/material.dart';

callOpenAiApiPicture() async {
  print('START CALLING OPENAI...');
  try {
    const openAiApiKey = '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';
    final url = 'https://api.openai.com/v1/images/generations';
    final prompt =
        'hyperrealistic, hacker, dark, orange, epic, landscape, cyberpunk';

    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $openAiApiKey',
    //   },
    //   body: json.encode({
    //     'prompt': '$prompt',
    //     'size': '1024x1024',
    //     'n': 1,
    //   }),
    // );

    dynamic response = 200;

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final generatedimg = OpenAiCallback.fromJson(responseData);
      final networkimage = NetworkImage(generatedimg.imageurl);
      return networkimage;
    } else {
      return const AssetImage("assets/images/prison_background.png");
    }
  } catch (e) {
    print("An error occured at api request to openai $e");
    return const AssetImage("assets/images/prison_background.png");
  }
}
