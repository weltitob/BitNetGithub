import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:BitNet/models/openai_image.dart';

// Create a StatefulWidget for the background animation
class BackgroundWithContent extends StatefulWidget {
  final Widget child;
  final double opacity;
  const BackgroundWithContent({Key? key, required this.child, required this.opacity}) : super(key: key);

  @override
  State<BackgroundWithContent> createState() => _BackgroundWithContentState();
}

// Create a State class for the background animation
class _BackgroundWithContentState extends State<BackgroundWithContent> {
  bool _visible = false; // Set initial visibility to false
  late final Future<LottieComposition> _composition;
  late final Future<NetworkImage> _networkimage;// Future to hold the Lottie animation

  @override
  void initState() {
    super.initState();
    _networkimage = _callOpenAiApi();
    //_composition = _loadComposition(); // Load the Lottie animation
    updatevisibility();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Update the visibility of the animation after a delay
  void updatevisibility() async {
    await _networkimage;
    setState(() {});
    //await _composition; // Wait for the animation to load
    Timer(Duration(seconds: 3), () {
      setState(() {
        _visible = true; // Set visibility to true
      });
    });
  }

  Future<NetworkImage> _callOpenAiApi() async {
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
        setState(() {});
        return networkimage;
      } else {
        return NetworkImage("https://media.discordapp.net/attachments/1038329663187062804/1093248461060718645/wyattgirlwasted_None_ed39118d-d2fc-40c8-a5b4-e250e2969000.png?width=741&height=741");
      }
    } catch(e){
      print("An error occured at api request to openai $e");
      return NetworkImage("https://media.discordapp.net/attachments/1038329663187062804/1093248461060718645/wyattgirlwasted_None_ed39118d-d2fc-40c8-a5b4-e250e2969000.png?width=741&height=741");
    }
  }


  // Load the Lottie animation from the asset file
  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottiefiles/background.json');
    dynamic mycomposition = await LottieComposition.fromByteData(assetData);
    return mycomposition;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: FutureBuilder(
            future: _networkimage,
              builder: (BuildContext context, AsyncSnapshot<NetworkImage> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    color: Colors.black,
                  );
                } else {
                  return FittedBox(
                    fit: BoxFit.fitHeight,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0, // Set opacity based on visibility
                      duration: Duration(milliseconds: 3000),
                      child: Image(
                        image: snapshot.data!,
                      ),
                      //Lottie(composition: composition)
                    ),
                  );
                }
            },
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(widget.opacity),
        ),
        widget.child,
      ],
    );
  }
}
