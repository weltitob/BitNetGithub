// import 'dart:async';
// import 'dart:io';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/components/loaders/loaders.dart';
// import 'package:bitnet/components/post/components/audiobuilder.dart';
// import 'package:bitnet/components/post/components/imagebuilder.dart';
// import 'package:bitnet/components/post/components/linkbuilder.dart';
// import 'package:bitnet/components/post/components/postfile_model.dart';
// import 'package:bitnet/components/post/components/textbuilder.dart';
// import 'package:bitnet/pages/create/create_post_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:uuid/uuid.dart';
//
// class CreatePostScreen_2 extends StatefulWidget {
//   final String currentUserUID;
//   const CreatePostScreen_2({Key? key, required this.currentUserUID})
//       : super(key: key);
//
//   @override
//   State<CreatePostScreen_2> createState() => _CreatePostScreenState();
// }
//
// class _CreatePostScreenState extends State<CreatePostScreen_2> {
//   final postFiles = <PostFile>[];
//   TextEditingController commentController = TextEditingController();
//   final recorder = FlutterSoundRecorder();
//   bool isRecorderReady = false;
//
//   bool isLoading = false;
//   String postId = Uuid().v4();
//
//   @override
//   void initState() {
//     super.initState();
//     initRecorder();
//     commentController.addListener(() {
//       if (commentController.text.isEmpty || commentController.text.isNotEmpty) {
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     recorder.closeRecorder();
//     super.dispose();
//   }
//
//   void _pickLink() {
//     postFiles.add(PostFile(MediaType.link, text: ""));
//     setState(() {});
//   }
//
//   //for Audio recording and stop
//   Future record() async {
//     if (!isRecorderReady) return;
//
//     await recorder.startRecorder(toFile: 'audio');
//   }
//
//   Future stop() async {
//     if (!isRecorderReady) return;
//
//     final path = await recorder.stopRecorder();
//     final audioFile = File(path!);
//
//     print('Recorded audio: $audioFile');
//   }
//
//   Future initRecorder() async {
//     final status = await Permission.microphone.request();
//
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }
//
//     await recorder.openRecorder();
//
//     isRecorderReady = true;
//     recorder.setSubscriptionDuration(
//       const Duration(milliseconds: 10),
//     );
//   }
//
//   Future<String?> uploadFile(File file, String path) async {
//     try {
//       final storageReference = FirebaseStorage.instance
//           .ref()
//           .child(path)
//           .child('${DateTime.now().millisecondsSinceEpoch} ${file.path}');
//       UploadTask? uploadTask;
//       uploadTask = storageReference.putFile(file);
//       final completer = Completer<void>();
//       final taskSnapshot = await uploadTask.whenComplete(completer.complete);
//       await completer.future;
//       final imageUrl = await taskSnapshot.ref.getDownloadURL();
//       return imageUrl;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: isLoading
//             ? avatarGlow(context, Icons.upload_rounded,)
//             : Column(
//             children: [
//               Expanded(
//                 child: BuildRoundedBoxWithoutPadding(
//                   child: YouTubeShort(),
//                 )
//             ),
//             buildTextField(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField() {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: AppTheme.cardPadding / 2,
//         vertical: AppTheme.cardPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 4),
//             blurRadius: 20,
//             color: Colors.black.withOpacity(0.1),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: AppTheme.cardPadding * 0.75,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(width: AppTheme.cardPadding / 4),
//                     Expanded(
//                       child: recorder.isRecording
//                           ? StreamBuilder<RecordingDisposition>(
//                         stream: recorder.onProgress,
//                         builder: (context, snapshot) {
//                           final duration = snapshot.hasData
//                               ? snapshot.data!.duration
//                               : Duration.zero;
//
//                           String twoDigits(int n) =>
//                               n.toString().padLeft(2, '0');
//                           final twoDigitMinutes =
//                           twoDigits(duration.inMinutes.remainder(60));
//                           final twoDigitSeconds =
//                           twoDigits(duration.inSeconds.remainder(60));
//
//                           return Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 14.0, bottom: 15.0),
//                             child:
//                             Text('$twoDigitMinutes:$twoDigitSeconds',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                           );
//                         },
//                       )
//                           : TextField(
//                         minLines: 1,
//                         maxLines: 5,
//                         keyboardType: TextInputType.multiline,
//                         controller: commentController,
//                         decoration: InputDecoration(
//                             hintText: "Type message",
//                             border: InputBorder.none,
//                             hintStyle: TextStyle(
//                                 color: Colors.white.withOpacity(0.4),
//                                 fontWeight: FontWeight.w500)),
//                       ),
//                     ),
//                     buildQuikShareButton(),
//                     Container(margin: EdgeInsets.symmetric(horizontal: 5.0),),
//                     buildMicrophoneOrTextPushButton(),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(width: AppTheme.cardPadding / 2),
//             InkWell(
//               borderRadius: BorderRadius.all(Radius.circular(40)),
//               onTap: () {
//                 showModalBottomSheet(
//                     backgroundColor: Colors.transparent,
//                     context: context,
//                     builder: (builder) => bottomSheet());
//               },
//               child: Ink(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.all(Radius.circular(40)),
//                   ),
//                   child: Container(
//                     margin: const EdgeInsets.all(10.0),
//                     child: Icon(
//                       Icons.add_rounded,
//                       color: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .color!
//                           .withOpacity(0.65),
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildQuikShareButton(){
//     return Container(
//       child: Icon(
//         Icons.camera_alt_rounded,
//         color: Theme.of(context)
//             .textTheme
//             .bodyText1!
//             .color!
//             .withOpacity(0.64),
//       ),
//     );
//   }
//
//   Widget buildMicrophoneOrTextPushButton() {
//     return InkWell(
//       borderRadius: BorderRadius.circular(40.0),
//       onTap: commentController.text.isEmpty
//           ? () async {
//         if (recorder.isRecording) {
//           await stop();
//         } else {
//           await record();
//         }
//         setState(() {});
//       }
//           : () {
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: recorder.isRecording
//               ? Colors.redAccent
//               : Colors.grey[600],
//           borderRadius: BorderRadius.circular(40.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Icon(
//             commentController.text.isEmpty
//                 ? recorder.isRecording
//                 ? Icons.stop_rounded
//                 : Icons.mic_rounded
//                 : Icons.arrow_upward_rounded,
//             color: Theme.of(context)
//                 .textTheme
//                 .bodyText1!
//                 .color!
//                 .withOpacity(0.64),
//           ),
//         ),
//       ),
//     );
//   }
//
//   //should look similar to likespace.dart
//   Widget buildUploadButton() {
//     return InkWell(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         margin: EdgeInsets.only(top: 5.0),
//         width: 120,
//         height: 35,
//         decoration: BoxDecoration(
//             color: postFiles.isNotEmpty
//                 ? Colors.orange
//                 : Theme.of(context).primaryColorLight.withOpacity(0.5),
//             borderRadius: BorderRadius.all(Radius.circular(20))),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               children: <Widget>[
//                 Icon(
//                   postFiles.isNotEmpty
//                       ? Icons.check_circle
//                       : Icons.lock_rounded,
//                   size: 20,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//                 Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                 Text(
//                   "POST",
//                   style: Theme.of(context).textTheme.subtitle1,
//                 )
//               ],
//             ),
//           ],
//         ),
//       ));
//   }
//
//   Widget bottomSheet() {
//     return Container(
//       height: 280,
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         color: Colors.grey[900],
//         margin: const EdgeInsets.all(18.0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   iconCreation(Icons.insert_drive_file, Colors.orange,
//                       "Document", MediaType.document),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.link_rounded, Colors.orange,
//                       "Link", MediaType.link),
//                   // iconCreation(Icons.camera_alt, Colors.orange, "Camera",
//                   //     MediaType.camera),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.insert_photo, Colors.orange, "Gallery",
//                       MediaType.image),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   iconCreation(Icons.headset, Colors.orange, "Audio", MediaType.audio),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.location_pin, Colors.orange, "Location",
//                       MediaType.text),
//                   SizedBox(
//                     width: 40,
//                   ),
//                   iconCreation(Icons.qr_code_rounded, Colors.orange, "Wallet",
//                       MediaType.text),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget iconCreation(
//       IconData icons, Color color, String text, MediaType mediaType) {
//     return InkWell(
//       onTap: () => _pickLink(),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: color,
//             child: Icon(
//               icons,
//               // semanticLabel: "Help",
//               size: 29,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 12,
//               // fontWeight: FontWeight.w100,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class _PostItem extends StatelessWidget {
//   final PostFile postFile;
//   const _PostItem({
//     Key? key,
//     required this.postFile,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (postFile.type == MediaType.image || postFile.type == MediaType.camera) {
//       return ImageBuilderLocal(postFile: postFile);
//     }
//
//     if (postFile.type == MediaType.text) {
//       return TextBuilderLocal(postFile: postFile);
//     }
//
//     if (postFile.type == MediaType.audio) {
//       return AudioBuilderLocal(postfile: postFile);
//     }
//     return Container();
//   }
// }
//
//
// // ignore: must_be_immutable
// class BuildRoundedBoxWithoutPadding extends StatefulWidget {
//   Widget child;
//   BuildRoundedBoxWithoutPadding({
//     required this.child,});
//
//   @override
//   State<BuildRoundedBoxWithoutPadding> createState() => _BuildRoundedBoxStatePaddingless();
// }
//
// class _BuildRoundedBoxStatePaddingless extends State<BuildRoundedBoxWithoutPadding> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
//       child: Container(
//           decoration: BoxDecoration(
//               boxShadow: [
//                 AppTheme.boxShadowProfile
//               ],
//               borderRadius: AppTheme.cardRadiusBig),
//           child: widget.child
//       ),
//     );
//   }
// }
