import 'dart:convert';

import 'package:BitNet/models/openai_image.dart';
import 'package:flutter/material.dart';

Future<NetworkImage> callOpenAiApiPicture() async {
  print('START CALLING OPENAI...');
  try{
    const openAiApiKey = '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';
    final url = 'https://api.openai.com/v1/images/generations';
    final prompt = 'hyperrealistic, hacker, dark, orange, epic, landscape, cyberpunk';

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
      return NetworkImage("https://media.discordapp.net/attachments/1038329663187062804/1093248461060718645/wyattgirlwasted_None_ed39118d-d2fc-40c8-a5b4-e250e2969000.png?width=741&height=741");
    }
  } catch(e){
    print("An error occured at api request to openai $e");
    return NetworkImage("https://media.discordapp.net/attachments/1038329663187062804/1093248461060718645/wyattgirlwasted_None_ed39118d-d2fc-40c8-a5b4-e250e2969000.png?width=741&height=741");
  }
}