import 'package:bitnet/backbone/cloudfunctions/taprootassets/burnasset.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostHeader extends StatelessWidget {
  final String ownerId;
  final String username;
  final String displayName;
  final String postId;

  const PostHeader({required this.ownerId, required this.postId, required this.username, required this.displayName}) : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(0.0),
        leading: Avatar(
          profileId: ownerId,
          mxContent: Uri.parse(''),
          size: AppTheme.cardPadding * 2,
          fontSize: 18,
          onTap: () {},
          isNft: false
        ),
        title: GestureDetector(
          onTap: () {},
          child: Container(
            width: AppTheme.elementSpacing * 8.w,
            child: Text(
              '${displayName}',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        subtitle: Container(
          width: AppTheme.elementSpacing * 6.w,
          child: Text(
            '@${username}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            BitNetBottomSheet(
              context: context,
              child: bitnetScaffold(
                  extendBodyBehindAppBar: true,
                  appBar: bitnetAppBar(
                    text: "Do you want to delete this post?",
                    context: context,
                  ),
                  body: Container(
                    child: Column(
                      children: [
                        SizedBox(height: AppTheme.cardPadding * 4.h),
                        LongButtonWidget(
                            title: "Yes, delete this asset permanently.",
                            onTap: () {
                              deletePost(ownerId, postId);
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          height: AppTheme.cardPadding.h,
                        ),
                        LongButtonWidget(
                            title: "No, keep this asset.",
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  context: context),
            );
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ));
  }
}
//
// buildCreatePostHeader(BuildContext context) {
//   final currentUser = Auth().currentUser!.uid;
//
//   return ListTile(
//     contentPadding: EdgeInsets.all(0.0),
//     leading: Avatar(
//       profileId: currentUser,
//       size: AppTheme.cardPadding * 2,
//       fontSize: 18,
//       onTap: () => print('tapped'),
//     ),
//     title: Text(
//       '@fixauth',
//       style: Theme.of(context).textTheme.titleLarge,
//     ),
//     subtitle: Text(
//       'fix die scheiss auth',
//       style: Theme.of(context).textTheme.bodySmall,
//     ),
//     trailing: IconButton(
//       onPressed: () => showDialogueMultipleOptions(
//         isActives: [true, true, true, true],
//         texts: ['Anonym.', 'Add location', 'Post as NFT', 'Delete'],
//         images: [
//           "images/ghost.png",
//           "images/location.png",
//           "images/chain.png",
//           "images/deletepost.png"
//         ],
//         actions: [
//           () {},
//           () {},
//           () {},
//           () {},
//         ],
//         title: 'What do you want to do?',
//         context: context,
//       ),
//       icon: Icon(
//         Icons.more_vert,
//         color: Colors.white,
//       ),
//     ),
//   );
// }
//
// buildPostHeaderShorts(BuildContext context) {
//   return Column(
//     children: [
//       ListTile(
//         contentPadding: EdgeInsets.all(0.0),
//         leading: Avatar(
//           profileId: Auth().currentUser!.uid,
//           mxContent: Uri.parse(''),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               '@fixauth',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Icon(
//               Icons.link,
//               size: 20.0,
//               color: Theme.of(context).primaryColorDark,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//                 height: 15.0,
//                 width: 15.0,
//                 child: CachedNetworkImage(
//                   imageUrl:
//                       'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Youtube_shorts_icon.svg/483px-Youtube_shorts_icon.svg.png?20210811144940',
//                   placeholder: (context, url) =>
//                       avatarGlowProgressSmall(context),
//                   errorWidget: (context, url, error) =>
//                       avatarGlowProgressSmall(context),
//                 )),
//             SizedBox(
//               width: 5,
//             ),
//             Text(
//               '@fixauth',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ],
//         ),
//         subtitle: Text(
//           'fix die scheiss auth',
//           style: Theme.of(context).textTheme.bodySmall,
//         ),
//         trailing: IconButton(
//           onPressed: () => showDialogueMultipleOptions(
//             isActives: [true, true, true, true],
//             title: 'What do you want to do?',
//             texts: ['Delete, Add location', 'text2', 'text3', 'text4'],
//             actions: [
//               () {},
//               () {},
//               () {},
//               () {},
//             ],
//             images: [
//               "images/deletepost.png",
//               "images/location.png",
//               "images/deletepost.png",
//               "images/deletepost.png"
//             ],
//             context: context,
//           ),
//           icon: Icon(
//             Icons.more_vert,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ],
//   );
// }

//To delete a Post ownerid and currentuserid must be equal
deletePost(ownerId, postId) async {
  print("Trying to burn asset: $postId");

  dynamic responseAssetBurn = await burnAsset(postId);

  print("Response from burnAsset: $responseAssetBurn");
  // //delete the Post itself

  // //delte the Post itself
  // postsCollection
  //     .doc(ownerId)
  //     .collection('userPosts2')
  //     .doc(postId)
  //     .get()
  //     .then((doc) {
  //   if (doc.exists) {
  //     doc.reference.delete();
  //   } else if (!doc.exists) {
  //     print('Post doesnt exist anymore');
  //   }
  // });
  // //delete uploaded Image for the Post
  // storageRef.child('post_$postId.jpg').delete();
  //
  // //delte all activityFeed notfications
  // QuerySnapshot activityFeedSnapshot = await activityFeedRef
  //     .doc(ownerId)
  //     .collection('feedItems')
  //     .where('postId', isEqualTo: postId)
  //     .get();
  //
  // activityFeedSnapshot.docs.forEach((doc) {
  //   if (doc.exists) {
  //     doc.reference.delete();
  //   } else if (!doc.exists) {
  //     print('ActivityItem doesnt exist anymore');
  //   }
  // });
  //
  // //delte all comments
  // QuerySnapshot commentsSnapshot =
  //     await commentsRef.doc(postId).collection('comments').get();
  // commentsSnapshot.docs.forEach((doc) {
  //   if (doc.exists) {
  //     doc.reference.delete();
  //   } else if (!doc.exists) {
  //     print('Comment doesnt exist anymore');
  //   }
  // });
}
