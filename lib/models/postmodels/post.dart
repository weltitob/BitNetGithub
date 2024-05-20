
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/likespace.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/models/postmodels/media_model.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final dynamic rockets;
  final List<Media> medias;
  final DateTime timestamp;

  Post({
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.rockets,
    required this.medias,
    required this.timestamp,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc["postId"],
      ownerId: doc['ownerId'],
      username: doc['username'],
      rockets: doc['rockets'],
      medias: List<Media>.from(doc['medias']?.map((x) => Media.fromMap(x))),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'ownerId': ownerId,
      'username': username,
      'rockets': rockets,
      'medias': medias.map((x) => x.toMap()).toList(),
      'timestamp': timestamp,
    };
  }

  //ist noch komplett verbuggt lol
  int getRocketCount() {
    //if no rockets, return 0
    if (rockets == null) {
      return 0;
    }
    int count = 0;
    //if key is set to true add like
    rockets.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        rockets: this.rockets,
        rocketcount: getRocketCount(),
        medias: this.medias,
        timestamp: this.timestamp,
      );
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final DateTime timestamp;
  int rocketcount;
  Map rockets;
  final List<Media> medias;

  bool showheart = false;
  late bool isLiked;

  _PostState({
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.timestamp,
    required this.medias,
    required this.rockets,
    required this.rocketcount,
  });

  //NOCHMAL GUCKEN DAS IWIE ABÄNDERN ZU GANZEM POST UND DANN AUTOMATISCH 5SATS SENDEN ODER SO
  buildPostImage() {
    return GestureDetector(
      onDoubleTap: () => print('handleLikePost implement'),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(margin: EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text('ALTES IMAGE NUR TEST')),
          showheart? Animator(
            duration: Duration(milliseconds: 300),
            tween: Tween(begin: 0.8, end: 1.4,),
            curve: Curves.elasticOut,
            cycles: 0, builder: (BuildContext context, AnimatorState<double> animatorState, Widget? child) {
            return Transform.scale(
              scale: animatorState.value,
              child: Icon(Icons.favorite,
                size: 60,
                color: Colors.red,),);
          },): Text(''),
        ],
      ),
    );
  }

  buildPostFooter() {
    return buildLikeSpace(
        type: 'Post',
        targetId: postId,
        ownerId: ownerId,
        rockets: rockets);
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = Auth().currentUser!.uid;

    isLiked = (rockets[currentUserId] == true);
    return RoundedBoxWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildPostHeader(context, ownerId, postId),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: medias.map((e) {
                final type = e.type;
                if (type == "text") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: TextBuilderNetwork(url: e.data));
                }
                if (type == "description") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: TextBuilderNetwork(url: e.data));
                }
                if (type == "external_link") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: LinkBuilder(url: 'haha'));
                }
                if (type == "image" || type == "camera") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: ImageBuilderNetwork(url: e.data));
                }
                if (type == "image_data" || type == "camera") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: ImageBuilderNetwork(url: e.data));
                }
                if (type == "audio") {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: AudioBuilderNetwork(url: e.data));
                }
                return Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: TextBuilderNetwork(url: e.data));
              }).toList(),
            ),
            buildPostFooter(),
          ],
        ),
    );
  }
}

class RoundedBoxWidget extends StatefulWidget {
  Widget child;
  RoundedBoxWidget({
    required this.child,});

  @override
  State<RoundedBoxWidget> createState() => _RoundedBoxWidgetState();
}

class _RoundedBoxWidgetState extends State<RoundedBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
      child: Container(
          padding: EdgeInsets.only(top: AppTheme.elementSpacing, bottom: AppTheme.elementSpacing, left: AppTheme.cardPadding, right: AppTheme.cardPadding),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
              boxShadow: [
                AppTheme.boxShadowProfile
              ],
              borderRadius: AppTheme.cardRadiusBig),
          child: widget.child
      ),
    );
  }
}