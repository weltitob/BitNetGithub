import 'dart:async';
import 'dart:io';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/compression.dart';
import 'package:bitnet/backbone/services/file_picker_service.dart';

import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';

import 'package:bitnet/components/post/components/postfile_model.dart';

import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';


//THIS ONE HERE SEEMS TO BE TH EISSUE THIS IMPORT FUCKS EVERYTHING UP
//import 'package:bitnet/models/postmodels/post.dart';


class CreateAsset extends StatefulWidget {
  const CreateAsset({super.key});

  @override
  State<CreateAsset> createState() => _CreateAssetState();
}

class _CreateAssetState extends State<CreateAsset> {
  final postFiles = <PostFile>[];
  TextEditingController commentController = TextEditingController();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  bool isLoading = false;
  String postId = Uuid().v4();

  @override
  void initState() {
    super.initState();
    initRecorder();
    commentController.addListener(() {
      if (commentController.text.isEmpty || commentController.text.isNotEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  void _addMedia(MediaType mediaType) {
    if (mediaType == MediaType.text) {
      _addTextField();
    } else if (mediaType == MediaType.camera || mediaType == MediaType.image) {
      _pickImageFiles(mediaType);
    } else if (mediaType == MediaType.link) {
      _pickLink();
    } else {
      _pickFile(mediaType);
    }
  }

  //imagecopression
  _pickImageFiles(MediaType mediaType) async {
    print(mediaType);
    dynamic file = await FilePickerService(mediaType).pickFile();
    if (file == null) return;
    file = compressImage(file, postId);
    postFiles.add(PostFile(mediaType, file: file));
    setState(() {});
  }

  void _pickLink() {
    postFiles.add(PostFile(MediaType.link, text: ""));
    setState(() {});
  }

  _pickFile(MediaType mediaType) async {
    final file = await FilePickerService(mediaType).pickFile();
    if (file == null) return;
    postFiles.add(PostFile(mediaType, file: file));
    setState(() {});
  }

  void _addTextField() {
    postFiles.add(PostFile(MediaType.text, text: commentController.text));
    commentController.clear();
    setState(() {});
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

  Future<String?> uploadFile(File file, String path) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child(path)
          .child('${DateTime.now().millisecondsSinceEpoch} ${file.path}');
      UploadTask? uploadTask;
      uploadTask = storageReference.putFile(file);
      final completer = Completer<void>();
      final taskSnapshot = await uploadTask.whenComplete(completer.complete);
      await completer.future;
      final imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      body: Container(
          child: isLoading
              ? avatarGlow(context, Icons.upload_rounded)
              : Column(children: [
                  Expanded(
                      child: GlassContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(AppTheme.cardPadding),
                            child: Column(
                              children: [
                            buildCreatePostHeader(context),
                            Expanded(
                              child: postFiles.isNotEmpty
                                  ? ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ReorderableListView(
                                  //later remove expanded to only render the normal posts when something added
                                  shrinkWrap: true,
                                  onReorder: (oldIndex, newIndex) {
                                    setState(() {
                                      final item =
                                      postFiles.removeAt(oldIndex);
                                      postFiles.insert(newIndex, item);
                                    });
                                  },
                                  children:
                                  postFiles.asMap().entries.map((e) {
                                    final index = e.key;
                                    final post = e.value;
                                    return Dismissible(
                                      key: ValueKey(post.file ??
                                          post.text ??
                                          post.type.name),
                                      confirmDismiss: (value) async {
                                        final result = await showDialogue(
                                          context: context,
                                          title: "Remove?",
                                          image: "images/deletepost.png",
                                          leftAction: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          rightAction: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        );
                                        if (result == true)
                                          postFiles.removeAt(index);
                                        setState(() {});
                                        return Future.value(result);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0),
                                        child: _PostItem(postFile: post),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                                  : buildAddContent(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    SizedBox(
                                      width: AppTheme.cardPadding,
                                    ),

                                    SizedBox(
                                      width: AppTheme.cardPadding,
                                    ),
                                    //buildCameraButton()
                                  ],
                                ),
                              //buildUploadButton(),
                              ]),

                              ],),
                          ))),
                buildTextField(),
               // SizedBox(height: AppTheme.cardPadding * 4,),

                ]
          )),
      context: context,
    );
  }

  Widget commentsActive(){
    return GestureDetector(
      child: Container(
        height: 30,
        width: 40,
        child: Stack(
          children: <Widget>[
            Icon(
              Icons.comment,
              color: Theme.of(context)
                  .colorScheme
                  .secondary,
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Text(
                  "ON",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary),
                ))
          ],
        ),
      ),
      onTap: () {
        //show bottom sheet or window with diffrent time options
      },
    );
  }

  Widget timeOnline(){
    return  GestureDetector(
      child: Container(
        height: 30,
        width: 40,
        child: Stack(
          children: <Widget>[
            Icon(
              Icons.timer,
              color: Theme.of(context)
                  .colorScheme
                  .secondary,
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: Text(
                  "24h",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary),
                ))
          ],
        ),
      ),
      onTap: () {
        //show bottom sheet or window with diffrent time options
      },
    );
  }


  Widget buildAddContent() {
    return Text("Add Content");
  }

  Widget buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding / 2,
        vertical: AppTheme.cardPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          AppTheme.boxShadowProfile,
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppTheme.white60,
                  ),
                  color: AppTheme.glassMorphColor,
                  borderRadius: AppTheme.cardRadiusBigger,
                ),
                child: Row(
                  children: [
                    SizedBox(width: AppTheme.cardPadding / 4),
                    Expanded(
                      child: recorder.isRecording
                          ? StreamBuilder<RecordingDisposition>(
                              stream: recorder.onProgress,
                              builder: (context, snapshot) {
                                final duration = snapshot.hasData
                                    ? snapshot.data!.duration
                                    : Duration.zero;

                                String twoDigits(int n) =>
                                    n.toString().padLeft(2, '0');
                                final twoDigitMinutes =
                                    twoDigits(duration.inMinutes.remainder(60));
                                final twoDigitSeconds =
                                    twoDigits(duration.inSeconds.remainder(60));

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 15.0),
                                  child:
                                      Text('$twoDigitMinutes:$twoDigitSeconds',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                );
                              },
                            )
                          : TextField(
                              style: Theme.of(context).textTheme.bodyLarge,
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              controller: commentController,
                              decoration: AppTheme.textfieldDecoration(
                                  "Type message", context)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing / 2),
                    ),
                    buildMicrophoneOrTextPushButton(),
                  ],
                ),
              ),
            ),
            SizedBox(width: AppTheme.cardPadding / 2),
            // TextFieldButtonMorph(
            //   iconData: Icons.add_rounded,
            //   onTap: () {
            //     showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         builder: (builder) => AddContentWidget(controller: ,));
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Widget buildMicrophoneOrTextPushButton() {
    return InkWell(
      borderRadius: AppTheme.cardRadiusCircular,
      onTap: commentController.text.isEmpty
          ? () async {
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
              setState(() {});
            }
          : () {
              _addTextField();
            },
      child: Container(
        decoration: BoxDecoration(
          color: recorder.isRecording
              ? AppTheme.errorColor
              : Theme.of(context).colorScheme.onSecondary,
          borderRadius: AppTheme.cardRadiusCircular,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
              commentController.text.isEmpty
                  ? recorder.isRecording
                      ? Icons.stop_rounded
                      : Icons.mic_rounded
                  : Icons.arrow_upward_rounded,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
  //
  // //should look similar to likespace.dart
  // Widget buildUploadButton() {
  //   return InkWell(
  //     borderRadius: AppTheme.cardRadiusBig,
  //     child: Container(
  //       margin: EdgeInsets.only(top: 5.0),
  //       width: AppTheme.cardPadding * 4,
  //       height: AppTheme.cardPadding * 1.25,
  //       decoration: BoxDecoration(
  //           color: postFiles.isNotEmpty
  //               ? Theme.of(context).colorScheme.primary
  //               : Theme.of(context).primaryColorLight.withOpacity(0.6),
  //           borderRadius: AppTheme.cardRadiusBig),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Row(
  //             children: <Widget>[
  //               Text(
  //                 "POST",
  //                 style: Theme.of(context).textTheme.subtitle1,
  //               ),
  //               Icon(
  //                 postFiles.isNotEmpty
  //                     ? Icons.arrow_forward_ios_rounded
  //                     : Icons.lock_rounded,
  //                 color: Colors.white.withOpacity(0.8),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     onTap: postFiles.isNotEmpty
  //         ? () async {
  //             try {
  //               isLoading = true;
  //               setState(() {});
  //               final medias = <Media>[];
  //               await Future.forEach(postFiles, (PostFile file) async {
  //                 if (file.type == MediaType.text) {
  //                   medias
  //                       .add(Media(url: file.text ?? '', type: file.type.name));
  //                 } else if (file.type == MediaType.link) {
  //                   //later change url to link url
  //                   medias
  //                       .add(Media(url: file.text ?? '', type: file.type.name));
  //                 } else {
  //                   final url = await uploadFile(
  //                       file.file!, 'posts/'); //later change to currentuserid after posts/
  //                   if (url != null)
  //                     medias.add(Media(url: url, type: file.type.name));
  //                 }
  //               });
  //               final post = Post(
  //                 postId: postId,
  //                 ownerId: "currentuserid",
  //                 username: "createpostscreen",
  //                 medias: medias,
  //                 timestamp: datetime,
  //                 rockets: {},
  //               );
  //               await postsCollection
  //                   .doc("REPLACE_CREATE_asset_AcurrentUserID")
  //                   .collection('userPosts2')
  //                   .doc(postId)
  //                   .set(post.toMap());
  //               print('UPLOAD SUCESSFULL');
  //               //Push to profile is important
  //               // Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute(
  //               //       builder: (context) =>
  //               //           Profile(profileId: widget.currentUserUID)),
  //               // );
  //             } catch (e) {
  //               isLoading = false;
  //               setState(() {});
  //               showErrorDialog(
  //                   context: context,
  //                   title: e.toString(),
  //                   image: 'images/error.png');
  //             }
  //           }
  //         : () => print('show you need to provide some content dialog'),
  //   );
  // }

  Widget buildCameraButton() {
    return InkWell(
      onTap: () {
        setState(() {
          print("Camera button pressed");
        });
      },
      borderRadius: AppTheme.cardRadiusBig,
      child: Container(
        margin: EdgeInsets.only(top: 5.0),
        width: AppTheme.cardPadding * 4,
        height: AppTheme.cardPadding * 1.25,
        decoration: BoxDecoration(
            color: postFiles.isNotEmpty
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).primaryColorLight.withOpacity(0.6),
            borderRadius: AppTheme.cardRadiusBig),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: <Widget>[
                Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
class _PostItem extends StatelessWidget {
  final PostFile postFile;
  const _PostItem({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (postFile.type == MediaType.image || postFile.type == MediaType.camera) {
      return ImageBuilderLocal(postFile: postFile);
    }

    if (postFile.type == MediaType.link) {
      return LinkBuilder(url: postFile.text!);
    }

    if (postFile.type == MediaType.text) {
      return TextBuilderLocal(postFile: postFile);
    }

    if (postFile.type == MediaType.audio) {
      return AudioBuilderLocal(postfile: postFile);
    }

    // if (postFile.type == MediaType.pdf) {
    //   return _PdfBuilder(postFile: postFile);
    // }
    //
    // if (postFile.type == MediaType.document) {
    //   return _DocumentBuilder(postFile: postFile);
    // }

    return Container();
  }
}
