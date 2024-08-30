import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/post/comments.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
//UNCOMMENT
//import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

enum likeSpaceType { Post, News, Crypto }

class buildLikeSpace extends StatefulWidget {
  //Crypto, News, User
  final likeSpaceType type;
  final String targetId;
  final String ownerId;
  final dynamic rockets;
  final String username;
  final String postName;

  const buildLikeSpace({
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.username,
    required this.postName,
    required this.rockets,
  });

  int getLikeCount() {
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
        rocketcount: getLikeCount(),
      );
}

class _buildLikeSpaceState extends State<buildLikeSpace> {
  final likeSpaceType type;
  final String targetId;
  final String ownerId;

  int rocketcount;
  Map rocketsmap;
  bool showheart = false;
  RxBool isLiked = false.obs;
  bool isFollowed = false;

  _buildLikeSpaceState({
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.rocketcount,
    required this.rocketsmap,
  });

  //broken after new auth shit anyways dont want likes lol
  // removeLikeToAcitivityFeed() {
  //   final currentUser = Provider.of<UserData>(context, listen: false);
  //   bool isNotPostOwner = currentUser.did != ownerId;
  //
  //   if (isNotPostOwner) {
  //     activityFeedRef
  //         .doc(ownerId)
  //         .collection('feedItems')
  //         .doc(targetId)
  //         .get()
  //         .then((doc) {
  //       if (doc.exists) {
  //         doc.reference.delete();
  //       }
  //     });
  //   }
  // }

  // addLikeToAcitivityFeed() {
  //   //add a notifcation only for others likes not own
  //   final currentUser = Provider.of<UserData>(context, listen: false);
  //   bool isNotPostOwner = currentUser.did != ownerId;
  //
  //   if (isNotPostOwner) {
  //     activityFeedRef.doc(ownerId).collection('feedItems').doc(targetId).set({
  //       'type': 'like',
  //       'userId': currentUser.did,
  //       'userProfileImg': currentUser.profileImageUrl,
  //       'postId': targetId,
  //       'timestamp': datetime,
  //     });
  //   }
  // }
  final homeController = Get.find<HomeController>();

  handleLikePost() {
    //Provider of is broken after new auth need to use something else rewatch the
    //social media stuff after new auth
    final currentUser = Provider.of<UserData>(context, listen: false);
    final String currentUserId = currentUser.did;

    bool _isLiked = rocketsmap[currentUserId] == true;

    if (_isLiked) {
      postsCollection
          .doc(ownerId)
          .collection('userPosts')
          .doc(targetId)
          .update({'likes.$currentUserId': false});
      // removeLikeToAcitivityFeed();
      setState(() {
        rocketcount -= 1;
        isLiked.value = false;
        rocketsmap[currentUserId] = false;
      });
    } else if (!_isLiked) {
      postsCollection
          .doc(ownerId)
          .collection('userPosts')
          .doc(targetId)
          .update({'likes.$currentUserId': true});
      //NO ACTIVITYFEED ==> Make it a donation/ Transactionspage which everyone can see which is connected to the wallet
      // addLikeToAcitivityFeed;
      setState(() {
        rocketcount += 1;
        isLiked.value = true;
        rocketsmap[currentUserId] = true;
        showheart = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          showheart = false;
        });
      });
    }
  }

  void handleSharePost() {
    //auto redirect to web to the post if not logged in with create account at the bottom
    print(
        'Share Post cliked make a share function of the post here / gorouter will instantly route to the correct thing');
    //if app is given auto redirect user into the app when link clicked
  }

  void onCommentButtonPressed() {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.75,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          text: 'Comments',
        ),
        context: context,
        body: Comments(
          postId: targetId,
          postOwnerId: ownerId,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLikes();
  }

  getLikes() async {
    isLiked.value = (await homeController.fetchHasLiked(
        targetId, Auth().currentUser!.uid))!;
  }

  //looks similar to the "UPLOAD" Button on the create_post_screen
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        child: Container(
          width: AppTheme.cardPadding.h * 5.125,
          height: AppTheme.cardPadding.h * 1.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => onCommentButtonPressed(),
                child: const Icon(
                  FontAwesomeIcons.comment,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
              Obx(
                () => LikeButton(
                  isLiked: isLiked.value,
                  // likeCount: rocketcount,
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: AppTheme.colorBitcoin,
                    dotSecondaryColor: AppTheme.colorBitcoin,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked
                          ? AppTheme.colorBitcoin
                          : AppTheme.colorBitcoin,
                      size: 24,
                    );
                  },
                  countBuilder: (rocketcount, isLiked, text) {
                    final color = Colors.grey;
                    return Text(
                      rocketcount.toString(),
                      style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    );
                  },
                  onTap: (isLiked) async {
                    // final currentUser =
                    //     await Provider.of<UserData>(context, listen: false);
                    // final String currentUserId = currentUser!.did;
                    bool _isLiked = rocketsmap['did'] == true;
                    this.isLiked.value = !this.isLiked.value;

                    await homeController.toggleLike(targetId);
                    await homeController.createPost(targetId, true, true, true,
                        widget.username, widget.postName, '');
                    setState(() {
                      rocketcount -= 1;
                      // this.isLiked.value = false;
                      rocketsmap['did'] = false;
                    });

                    if (_isLiked) {
                      postsCollection
                          .doc(ownerId)
                          .collection('userPosts')
                          .doc(targetId)
                          .update(
                        {'likes.did': false},
                      );
                      // removeLikeToAcitivityFeed();
                    } else if (!_isLiked) {
                      setState(() {
                        rocketcount += 1;
                        // this.isLiked.value = true;
                        rocketsmap['did'] = true;
                        showheart = true;
                      });
                      postsCollection
                          .doc(ownerId)
                          .collection('userPosts')
                          .doc(targetId)
                          .update({'likes.did': true});
                      // addLikeToAcitivityFeed();

                      Timer(const Duration(milliseconds: 500), () {
                        setState(() {
                          showheart = false;
                          print('showheart false ');
                        });
                      });
                    }
                    return !isLiked;
                  },
                ),
              ),
              GestureDetector(
                onTap: handleSharePost,
                child: const Icon(
                  FontAwesomeIcons.share,
                  size: 22.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
