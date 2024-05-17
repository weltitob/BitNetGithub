import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/post/comments.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:flutter/material.dart';
//UNCOMMENT
//import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class buildLikeSpace extends StatefulWidget {
  //Crypto, News, User
  final String type;
  final String targetId;
  final String ownerId;
  final dynamic rockets;

  buildLikeSpace({
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.rockets,
  });

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
  _buildLikeSpaceState createState() => _buildLikeSpaceState(
    type: this.type,
    targetId: this.targetId,
    ownerId: this.ownerId,
    rocketsmap: this.rockets,
    rocketcount: getRocketCount(),
  );
}

class _buildLikeSpaceState extends State<buildLikeSpace> {
  final String type;
  final String targetId;
  final String ownerId;

  int rocketcount;
  Map rocketsmap;
  bool showheart = false;
  bool isLiked = false;
  bool isFollowed = false;

  _buildLikeSpaceState({
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.rocketcount,
    required this.rocketsmap,
  });

  //broken after new auth shit anyways dont want likes lol
  removeLikeToAcitivityFeed() {
    final currentUser = Provider.of<UserData>(context, listen: false);
    bool isNotPostOwner = currentUser.did != ownerId;

    if (isNotPostOwner) {
      activityFeedRef.
      doc(ownerId).collection('feedItems').doc(targetId).get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }

  addLikeToAcitivityFeed(){
    //add a notifcation only for others likes not own
    final currentUser = Provider.of<UserData>(context, listen: false);
    bool isNotPostOwner = currentUser.did != ownerId;

    if (isNotPostOwner) {
      activityFeedRef.
      doc(ownerId).collection('feedItems').doc(targetId).
      set({
        'type': 'like',
        'userId': currentUser.did,
        'userProfileImg': currentUser.profileImageUrl,
        'postId': targetId,
        'timestamp': datetime,
      });
    }

  }

  handleLikePost(){
    //Provider of is broken after new auth need to use something else rewatch the
    //social media stuff after new auth
    final currentUser = Provider.of<UserData>(context, listen: false);
    final String currentUserId = currentUser.did;
    bool _isLiked = rocketsmap[currentUserId] == true;
    if(_isLiked) {
      postsCollection.doc(ownerId).
      collection('userPosts').doc(targetId).
      update({'likes.$currentUserId': false});
      removeLikeToAcitivityFeed();
      setState(() {
        rocketcount -= 1;
        isLiked = false;
        rocketsmap[currentUserId] = false;
      });
    }
    else if (!_isLiked) {
      postsCollection.doc(ownerId).collection('userPosts').
      doc(targetId).update({'likes.$currentUserId': true});
      //NO ACTIVITYFEED ==> Make it a donation/ Transactionspage which everyone can see which is connected to the wallet
      addLikeToAcitivityFeed;
      setState(() {
        rocketcount += 1;
        isLiked = true;
        rocketsmap[currentUserId] = true;
        showheart = true;
      });
      Timer(Duration(milliseconds: 500), (){
        setState(() {
          showheart = false;
        });
      });
    }
  }

  void onCommentButtonPressed() {
    BitNetBottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height * 0.75,
        title: "524 Comments",
        child: Comments(
          postId: targetId,
          postOwnerId: ownerId,
        ));
  }
  //looks similar to the "UPLOAD" Button on the create_post_screen
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 5.0),
          width: 120,
          height: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: ()=> onCommentButtonPressed(),
                child: Icon(
                  Icons.comment,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
              // LikeButton(
              //   isLiked: isLiked,
              //   // likeCount: rocketcount,
              //   bubblesColor: BubblesColor(
              //     dotPrimaryColor: Colors.orange,
              //     dotSecondaryColor: Colors.orangeAccent,
              //   ),
              //   likeBuilder: (bool isLiked) {
              //     return Icon(
              //       isLiked ? Icons.favorite : Icons.favorite_border,
              //       color: isLiked ? Colors.orangeAccent : Colors.orangeAccent,
              //       size: 24,
              //     );
              //   },
              //   // countBuilder: (rocketcount, isLiked, text){
              //   //   final color = Colors.grey;
              //   //   return Text(
              //   //     rocketcount.toString(),
              //   //     style: TextStyle(color: color,
              //   //         fontSize: 16,
              //   //         fontWeight: FontWeight.bold),
              //   //   );
              //   // },
              //   onTap: (isLiked) async {
              //     final currentUser = Provider.of<UserData>(context, listen: false);
              //     final String currentUserId = currentUser.did;
              //
              //     bool _isLiked = rocketsmap[currentUserId] == true;
              //
              //     if(_isLiked) {
              //       postsCollection.doc(ownerId).
              //       collection('userPosts').doc(targetId).
              //       update({'likes.$currentUserId': false});
              //       removeLikeToAcitivityFeed();
              //       setState(() {
              //         rocketcount -= 1;
              //         this.isLiked = false;
              //         rocketsmap[currentUserId] = false;
              //       });
              //     }
              //     else if (!_isLiked) {
              //       postsCollection.doc(ownerId).collection('userPosts').
              //       doc(targetId).update({'likes.$currentUserId': true});
              //       addLikeToAcitivityFeed();
              //       setState(() {
              //         rocketcount += 1;
              //         this.isLiked = true;
              //         rocketsmap[currentUserId] = true;
              //         showheart = true;
              //       });
              //
              //       Timer(Duration(milliseconds: 500), (){
              //         setState(() {
              //           showheart = false;
              //         });
              //       });
              //     }
              //     return !isLiked;
              //   },
              // ),
              // GestureDetector(
              //   onTap: handleLikePost,
              //   child: Icon(
              //     isLiked ? Icons.favorite : Icons.favorite_border,
              //     size: 22.5,
              //     color: Colors.greenAccent,
              //   ),
              // ),
            ],
          ),
        ),
      );
    }
}
