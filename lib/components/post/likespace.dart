import 'dart:async';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/post/comments.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

enum likeSpaceType { Post, News, Crypto }

class buildLikeSpace extends StatefulWidget {
  final likeSpaceType type;
  final String targetId;
  final String ownerId;
  final dynamic rockets;
  final String username;
  final String postName;

  const buildLikeSpace({
    Key? key,
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.username,
    required this.postName,
    required this.rockets,
  }) : super(key: key);

  int getLikeCount() {
    if (rockets == null) {
      return 0;
    }
    int count = 0;
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
  final homeController = Get.find<HomeController>();
  Timer? _heartTimer;

  _buildLikeSpaceState({
    required this.type,
    required this.targetId,
    required this.ownerId,
    required this.rocketcount,
    required this.rocketsmap,
  });

  @override
  void initState() {
    super.initState();
    getLikes();
  }

  getLikes() async {
    isLiked.value = (await homeController.fetchHasLiked(
        targetId, Auth().currentUser!.uid))!;
  }

  void handleSharePost() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing post...'),
        duration: Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void onCommentButtonPressed() {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.75,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          hasBackButton: false,
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

  Future<bool> handleLikeAction(bool isLiked) async {
    // Return the new state immediately for animation
    bool newState = !isLiked;
    this.isLiked.value = newState;
    bool _isLiked = rocketsmap['did'] == true;

    // Process backend operations without waiting
    // so animation can complete smoothly
    Future.microtask(() async {
      try {
        // Toggle like in backend
        await homeController.toggleLike(targetId);
        await homeController.createPost(
          targetId,
          true,
          true,
          true,
          widget.username,
          widget.postName,
          '',
        );

        if (mounted) {
          setState(() {
            if (_isLiked) {
              rocketcount -= 1;
              rocketsmap['did'] = false;

              // Update Firestore
              postsCollection
                  .doc(ownerId)
                  .collection('userPosts')
                  .doc(targetId)
                  .update({'likes.did': false});
            } else {
              rocketcount += 1;
              rocketsmap['did'] = true;
              showheart = true;

              // Update Firestore
              postsCollection
                  .doc(ownerId)
                  .collection('userPosts')
                  .doc(targetId)
                  .update({'likes.did': true});

              _heartTimer?.cancel(); // Cancel any existing timer
              _heartTimer = Timer(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    showheart = false;
                  });
                }
                _heartTimer = null;
              });
            }
          });
        }
      } catch (e) {
        print("Error handling like action: $e");
      }
    });

    // Return new state immediately for animation
    return newState;
  }
  
  @override
  void dispose() {
    _heartTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Colors.grey.shade700;

    return Container(
      width: AppTheme.elementSpacing * 10.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Comment button
          _buildIconButton(
            icon: FontAwesomeIcons.comment,
            onTap: onCommentButtonPressed,
            color: iconColor,
          ),
      
          // Like button
          Obx(
                () => _buildLikeButton(iconColor),
          ),
      
          // Share button
          _buildIconButton(
            icon: FontAwesomeIcons.arrowUpFromBracket,
            onTap: handleSharePost,
            color: iconColor,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: FaIcon(
            icon,
            size: 18.sp,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildLikeButton(Color color) {
    return LikeButton(
      isLiked: isLiked.value,
      size: 18.sp,
      circleSize: 35.r,
      bubblesSize: 40.r,
      animationDuration: const Duration(milliseconds: 400),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
            ? AppTheme.colorBitcoin
            : Theme.of(context).colorScheme.primary,
        dotSecondaryColor: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
            ? AppTheme.colorPrimaryGradient
            : Theme.of(context).colorScheme.secondary,
      ),
      circleColor: CircleColor(
        start: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
            ? AppTheme.colorBitcoin
            : Theme.of(context).colorScheme.primary,
        end: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
            ? AppTheme.colorPrimaryGradient
            : Theme.of(context).colorScheme.secondary,
      ),
      likeBuilder: (bool isLiked) {
        return FaIcon(
          isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          color: isLiked
              ? Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
                  ? AppTheme.colorBitcoin
                  : Theme.of(context).colorScheme.primary
              : Theme.of(context).brightness == Brightness.light
                  ? AppTheme.black60
                  : Colors.grey.shade700,
          size: 18.sp,
        );
      },
      countBuilder: (_, __, ___) => const SizedBox.shrink(),
      onTap: handleLikeAction,
    );
  }
}