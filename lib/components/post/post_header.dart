import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


buildPostHeader(BuildContext context, ownerId, postId) {
  return FutureBuilder<DocumentSnapshot>(
    future: usersCollection.doc(ownerId).get(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return dotProgress(context);
      }
      UserData user = UserData.fromDocument(snapshot.data!);
      final currentUser = Auth().currentUser!.uid;
      bool isPostOwner = ownerId == currentUser;

      return ListTile(
        contentPadding: EdgeInsets.all(0.0),
        leading: Avatar(
          profileId: user.did,
          mxContent: Uri.parse(user.profileImageUrl),
          size: AppTheme.cardPadding * 2,
          fontSize: 18,
          onTap: () => context.go("/showprofile/:${user.did}"),
        ),
        title: GestureDetector(
          onTap: () => context.go("/showprofile/:${user.did}"),
          child: Text(
            '@${user.username}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        subtitle: Text(
          user.username,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: isPostOwner
            ? IconButton(
                onPressed: () => showDialogue(
                  title: "Remove this post?",
                  image: "images/deletepost.png",
                  leftAction: () {},
                  rightAction: () {
                    // Navigator.pop(context),
                    deletePost(ownerId, postId);
                  },
                  context: context,
                ),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              )
            : Container(),
      );
    },
  );
}

buildCreatePostHeader(BuildContext context) {
  final currentUser = Auth().currentUser!.uid;

  return ListTile(
    contentPadding: EdgeInsets.all(0.0),
    leading: Avatar(
      profileId: currentUser,
      size: AppTheme.cardPadding * 2,
      fontSize: 18,
      onTap: () => print('tapped'),
    ),
    title: Text(
      '@fixauth',
      style: Theme.of(context).textTheme.titleLarge,
    ),
    subtitle: Text(
      'fix die scheiss auth',
      style: Theme.of(context).textTheme.bodySmall,
    ),
    trailing: IconButton(
      onPressed: () => showDialogueMultipleOptions(
        isActives: [true, true, true, true],
        texts: ['Anonym.', 'Add location', 'Post as NFT', 'Delete'],
        images: [
          "images/ghost.png",
          "images/location.png",
          "images/chain.png",
          "images/deletepost.png"
        ],
        actions: [
          () {},
          () {},
          () {},
          () {},
        ],
        title: 'What do you want to do?',
        context: context,
      ),
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    ),
  );
}

buildPostHeaderShorts(BuildContext context) {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.all(0.0),
        leading: Avatar(
          profileId: Auth().currentUser!.uid,
          mxContent: Uri.parse(''),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '@fixauth',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.link,
              size: 20.0,
              color: Theme.of(context).primaryColorDark,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                height: 15.0,
                width: 15.0,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Youtube_shorts_icon.svg/483px-Youtube_shorts_icon.svg.png?20210811144940',
                  placeholder: (context, url) =>
                      avatarGlowProgressSmall(context),
                  errorWidget: (context, url, error) =>
                      avatarGlowProgressSmall(context),
                )),
            SizedBox(
              width: 5,
            ),
            Text(
              '@fixauth',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        subtitle: Text(
          'fix die scheiss auth',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: IconButton(
          onPressed: () => showDialogueMultipleOptions(
            isActives: [true, true, true, true],
            title: 'What do you want to do?',
            texts: ['Delete, Add location', 'text2', 'text3', 'text4'],
            actions: [
              () {},
              () {},
              () {},
              () {},
            ],
            images: [
              "images/deletepost.png",
              "images/location.png",
              "images/deletepost.png",
              "images/deletepost.png"
            ],
            context: context,
          ),
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

//To delete a Post ownerid and currentuserid must be equal
deletePost(ownerId, postId) async {
  //delte the Post itself
  postsCollection
      .doc(ownerId)
      .collection('userPosts2')
      .doc(postId)
      .get()
      .then((doc) {
    if (doc.exists) {
      doc.reference.delete();
    } else if (!doc.exists) {
      print('Post doesnt exist anymore');
    }
  });
  //delete uploaded Image for the Post
  storageRef.child('post_$postId.jpg').delete();

  //delte all activityFeed notfications
  QuerySnapshot activityFeedSnapshot = await activityFeedRef
      .doc(ownerId)
      .collection('feedItems')
      .where('postId', isEqualTo: postId)
      .get();

  activityFeedSnapshot.docs.forEach((doc) {
    if (doc.exists) {
      doc.reference.delete();
    } else if (!doc.exists) {
      print('ActivityItem doesnt exist anymore');
    }
  });

  //delte all comments
  QuerySnapshot commentsSnapshot =
      await commentsRef.doc(postId).collection('comments').get();
  commentsSnapshot.docs.forEach((doc) {
    if (doc.exists) {
      doc.reference.delete();
    } else if (!doc.exists) {
      print('Comment doesnt exist anymore');
    }
  });
}
