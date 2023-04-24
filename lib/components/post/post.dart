//
// import 'package:BitNet/models/media.dart';
// import 'package:animator/animator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class Post extends StatefulWidget {
//   final String postId;
//   final String ownerId;
//   final String username;
//   final dynamic rockets;
//   final List<Media> medias;
//   final DateTime timestamp;
//
//   Post({
//     required this.postId,
//     required this.ownerId,
//     required this.username,
//     required this.rockets,
//     required this.medias,
//     required this.timestamp,
//   });
//
//   factory Post.fromDocument(DocumentSnapshot doc) {
//     return Post(
//       postId: doc["postId"],
//       ownerId: doc['ownerId'],
//       username: doc['username'],
//       rockets: doc['rockets'],
//       medias: List<Media>.from(doc['medias']?.map((x) => Media.fromMap(x))),
//       timestamp: DateTime.fromMillisecondsSinceEpoch(
//         (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
//       ),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'postId': postId,
//       'ownerId': ownerId,
//       'username': username,
//       'rockets': rockets,
//       'medias': medias.map((x) => x.toMap()).toList(),
//       'timestamp': timestamp,
//     };
//   }
//
//   //ist noch komplett verbuggt lol
//   int getRocketCount() {
//     //if no rockets, return 0
//     if (rockets == null) {
//       return 0;
//     }
//     int count = 0;
//     //if key is set to true add like
//     rockets.values.forEach((val) {
//       if (val == true) {
//         count += 1;
//       }
//     });
//     return count;
//   }
//
//   @override
//   _PostState createState() => _PostState(
//     postId: this.postId,
//     ownerId: this.ownerId,
//     username: this.username,
//     rockets: this.rockets,
//     rocketcount: getRocketCount(),
//     medias: this.medias,
//     timestamp: this.timestamp,
//   );
// }
//
// class _PostState extends State<Post> {
//   final String postId;
//   final String ownerId;
//   final String username;
//   final DateTime timestamp;
//   int rocketcount;
//   Map rockets;
//   final List<Media> medias;
//
//   bool showheart = false;
//   late bool isLiked;
//
//   _PostState({
//     required this.postId,
//     required this.ownerId,
//     required this.username,
//     required this.timestamp,
//     required this.medias,
//     required this.rockets,
//     required this.rocketcount,
//   });
//
//   //NOCHMAL GUCKEN DAS IWIE ABÄNDERN ZU GANZEM POST UND DANN AUTOMATISCH 5SATS SENDEN ODER SO
//   buildPostImage() {
//     return GestureDetector(
//       onDoubleTap: () => print('handleLikePost implement'),
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Container(margin: EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     offset: Offset(0, 2.5),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Text('ALTES IMAGE NUR TEST')),
//           showheart? Animator(
//             duration: Duration(milliseconds: 300),
//             tween: Tween(begin: 0.8, end: 1.4,),
//             curve: Curves.elasticOut,
//             cycles: 0, builder: (BuildContext context, AnimatorState<double> animatorState, Widget? child) {
//             return Transform.scale(
//               scale: animatorState.value,
//               child: Icon(Icons.favorite,
//                 size: 60,
//                 color: Colors.red,),);
//           },): Text(''),
//         ],
//       ),
//     );
//   }
//
//   buildPostFooter() {
//     return buildLikeSpace(
//         type: 'Post',
//         targetId: postId,
//         ownerId: ownerId,
//         rockets: rockets);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     UserRepository userRepo = locate<UserRepository>();
//     final String? currentUserId = userRepo.currentUserUID;
//
//     isLiked = (rockets[currentUserId] == true);
//     return RoundedBoxWidget(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           buildPostHeader(context, ownerId, postId),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: medias.map((e) {
//               final type = e.type;
//               if (type == "text") {
//                 return Container(
//                     margin: EdgeInsets.only(bottom: 10.0),
//                     child: TextBuilderNetwork(url: e.url));
//               }
//               if (type == "link") {
//                 return Container(
//                     margin: EdgeInsets.only(bottom: 10.0),
//                     child: LinkBuilder(url: 'haha'));
//               }
//               if (type == "image" || type == "camera") {
//                 return Container(
//                     margin: EdgeInsets.only(bottom: 10.0),
//                     child: ImageBuilderNetwork(url: e.url));
//               }
//               if (type == "audio") {
//                 return Container(
//                     margin: EdgeInsets.only(bottom: 10.0),
//                     child: AudioBuilderNetwork(url: e.url));
//               }
//               return Container(
//                   margin: EdgeInsets.only(bottom: 10.0),
//                   child: TextBuilderNetwork(url: e.url));
//             }).toList(),
//           ),
//           buildPostFooter(),
//         ],
//       ),
//     );
//   }
// }