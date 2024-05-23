
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/models/postmodels/media_model.dart';

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String postName;
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
    required this.postName,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postName: doc["postName"],
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
      'postName': postName,
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
        postName: this.postName,
      );
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final DateTime timestamp;
  final String postName;
  int rocketcount;
  Map rockets;
  final List<Media> medias;

  bool showheart = false;
  late bool isLiked;

  _PostState({
    required this.postId,
    required this.postName,
    required this.ownerId,
    required this.username,
    required this.timestamp,
    required this.medias,
    required this.rockets,
    required this.rocketcount,
  });

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = Auth().currentUser!.uid;

    isLiked = (rockets[currentUserId] == true);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
      child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.only(left: AppTheme.elementSpacing, right: AppTheme.elementSpacing,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PostHeader(ownerId: ownerId, postId: postId,),
                Text(postName, style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: AppTheme.elementSpacing),
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
                          child: ImageBuilder(encodedData: e.data));
                    }
                    if (type == "image_data" || type == "camera") {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: ImageBuilder(encodedData: e.data));
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
                SizedBox(height: AppTheme.elementSpacing),
                // buildPostFooter(),
              ],
            ),
          ),
      ),
    );
  }
}