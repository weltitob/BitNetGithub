// import 'package:bitnet/backbone/helper/databaserefs.dart';
// import 'package:bitnet/backbone/helper/loaders.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class PostsProfileTab extends StatefulWidget {
//   final String profileId;
//
//   const PostsProfileTab({Key? key,
//     required this.profileId
//
//   }) : super(key: key);
//
//   @override
//   State<PostsProfileTab> createState() => _PostsProfileTabState();
// }
//
// class _PostsProfileTabState extends State<PostsProfileTab> {
//
//   bool isLoading = false;
//   List<Post> posts = [];
//   int postCount = 0;
//
//   @override
//   void initState(){
//     super.initState();
//     getProfilePosts();
//   }
//
//   void getProfilePosts() async {
//     setState(() {
//       isLoading = true;
//     });
//     QuerySnapshot snapshot = await postsCollection
//         .doc(widget.profileId)
//         .collection('userPosts')
//         .orderBy('timestamp', descending: true)
//         .get();
//     setState(() {
//       isLoading = false;
//       postCount = snapshot.docs.length;
//       posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return buildProfilePosts();
//   }
//   Widget buildProfilePosts() {
//     if (isLoading) {
//       return dotProgress(context);
//     }
//     //if there are no Posts posted yet
//     else if (posts.isEmpty && isLoading) {
//       //hier noch design definitv ändern!!! irgendein 3d bild oder so
//       return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error,
//               color: Theme.of(context).errorColor,
//             ),
//             Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
//             Text(
//               'No posts found',
//               style: Theme.of(context).textTheme.headline2,
//             ),
//           ],
//         ),
//       );
//     }
//     return Column(
//       children: posts,
//     );
//   }
// }