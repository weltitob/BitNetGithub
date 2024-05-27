import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/textfieldbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;

  Comments({
    required this.postId,
    required this.postOwnerId,
  });

  @override
  CommentsState createState() => CommentsState(
        postId: postId,
        postOwnerId: postOwnerId,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String postId;
  final String postOwnerId;

  CommentsState({
    required this.postId,
    required this.postOwnerId,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Expanded(
            child: buildComments(),
          ),
          buildTextField(),
        ],
      ),
    );
  }

  //broken after new auth and stuff probabally
  addComment() async {
    final currentUser = Auth().currentUser!.uid;
    bool isNotPostOwner = postOwnerId != currentUser;
    final getCurrentUserData = Provider.of<UserData>(context, listen: false);

      UserData user = getCurrentUserData;

      commentsRef.doc(postId).collection('comments').add({
        'username': user.username,
        'comment': commentController.text,
        'timestamp': DateTime.now(),
        'avatarUrl': user.profileImageUrl,
        'userId': user.did,
      });

      if (isNotPostOwner) {
        activityFeedRef.doc(postOwnerId).collection('feedItems').add({
          'type': 'comment',
          'commentData': commentController.text,
          'username': user.username,
          'userId': user.did,
          'userProfileImg': user.profileImageUrl,
          'postId': postId,
          'timestamp': DateTime.now(),
        });
      }

    commentController.clear();
  }

  buildComments() {
    return StreamBuilder<QuerySnapshot>(
      stream: commentsRef
          .doc(postId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return dotProgress(context);
        } else {
          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
          );
        }
      },
    );
  }

  Widget buildTextField() {
    final currentuseruid = Auth().currentUser!.uid;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppTheme.elementSpacing,
          horizontal: AppTheme.elementSpacing,
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
              Avatar(
                mxContent: Uri.parse(""),
                profileId: currentuseruid,
                size: AppTheme.cardPadding * 2,
                fontSize: 18,
                onTap: () => print('tapped'),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2 )),
              Expanded(
                child: GlassContainer(
                  child: Container(
                    height: AppTheme.cardPadding.h *  2,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: AppTheme.elementSpacing),
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: AppTheme.textfieldDecoration("Write a comment...", context)
                          ),
                        ),
                        TextFieldButton(iconData: Icons.arrow_upward_rounded,
                          onTap: () => addComment(),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comment({
    required this.username,
    required this.userId,
    required this.avatarUrl,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
      avatarUrl: doc['avatarUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: RichText(
            text: TextSpan(
                text: '@$username  ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '$comment',
                      style: Theme.of(context).textTheme.bodyMedium),
                ]),
          ),
          leading: Avatar(
              profileId: userId,
              mxContent: Uri.parse(avatarUrl),
          ),
          subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${timeago.format(timestamp.toDate(), locale: 'en_short')}     ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '193 Rockets     ',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  TextSpan(
                    text: 'Reply',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ]),
          ),
          trailing: buildCommentFooter(context),
        ),
        // Divider(color: Colors.white,),
      ],
    );
  }

  buildCommentFooter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => print('pressed'),
          child: Icon(
            LineAwesomeIcons.bitcoin,
            size: 20,
          ),
        ),
      ],
    );
  }
}
