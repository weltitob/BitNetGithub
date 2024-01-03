import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:bitnet/pages/create/camerascreen.dart';
import 'package:bitnet/pages/create/create_post_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class CreatePage extends StatefulWidget {
  final String currentUserUID;
  @override
  const CreatePage({Key? key, required this.currentUserUID}) : super(key: key);

  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isReady = false;
  final postFiles = <PostFile>[];
  TextEditingController commentController = TextEditingController();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isLoading = false;
  String postId = Uuid().v4();
  late List<Widget> pages;
  int currentview = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      //when added in app doesnt work anymore completly redo the createpost screen step by step when know how it should look like!
      //CreatePostScreen(currentUserUID: widget.currentUserUID, onCameraButtonPressed: onCameraButtonPressed),
      CameraPage(onPostButtonPressed: onPostButtonPressed,)
    ];
    _setUpCamera();
  }

  void onCameraButtonPressed() {
    setState(() {
      currentview = 1;
    });
  }

  void onPostButtonPressed() {
    setState(() {
      currentview = 0;
    });
  }

  void _setUpCamera() async {
    try {
      // initialize cameras.
      _cameras = await availableCameras();
      // initialize camera controllers.
      // Current bug for high / medium with samsung devices.
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.medium,
      );

      await _controller.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  //for Audio recording and stop
  Future record() async {
    if (!isRecorderReady) return;

    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    print('Recorded audio: $audioFile');
    postFiles.add(PostFile(MediaType.audio, file: audioFile));
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: getFooter(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: getBody(),
    );
  }

  Widget cameraPreview() {
    return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    if (_isReady == false ||
        _controller == null ||
        !_controller.value.isInitialized) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        width: size.width,
        height: size.height,
        child: Center(
            child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))),
      );
    }
    return Container(
      width: size.width,
      height: size.height,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: cameraPreview()),
    );
  }

  Widget getFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: pages[currentview],
    );
  }
}
