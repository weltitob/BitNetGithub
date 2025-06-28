import 'package:bitnet/backbone/cloudfunctions/taprootassets/burnasset.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostHeader extends StatelessWidget {
  final String ownerId;
  final String username;
  final String displayName;
  final String postId;
  final String timeAgo; // Time ago parameter

  const PostHeader({
    required this.ownerId,
    required this.postId,
    required this.username,
    required this.displayName,
    this.timeAgo = 'Just now', // Default value in English
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.elementSpacing / 1.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading - Avatar
          Avatar(
              profileId: ownerId,
              mxContent: Uri.parse(''),
              size: AppTheme.cardPadding * 1.75.h,
              fontSize: 18,
              onTap: () {},
              isNft: false),

          SizedBox(width: AppTheme.elementSpacing.w * 0.75),

          // Middle - Name und Username in einer Zeile, Zeit darunter
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name und Username in einer Zeile
                Row(
                  children: [
                    // Display Name
                    Flexible(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          displayName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),

                    SizedBox(width: AppTheme.elementSpacing.w * 0.5),

                    // Username
                    Text(
                      //avoid duplicate @ symbols
                      username.startsWith('@') ? username : '@$username',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.white70,
                          ),
                    ),
                  ],
                ),

                // Zeit als dritte Zeile
                Text(
                  timeAgo,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.color
                            ?.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),

          // Trailing - Delete Icon Button
          GestureDetector(
            onTap: () {
              BitNetBottomSheet(
                height: MediaQuery.of(context).size.height * 0.6,
                context: context,
                child: bitnetScaffold(
                    extendBodyBehindAppBar: true,
                    appBar: bitnetAppBar(
                      hasBackButton: false,
                      text: "Do you want to delete this post?",
                      context: context,
                    ),
                    body: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 220,
                            width: 220,
                            child: Image.asset("assets/images/trash.png"),
                          ),
                        ),
                        BottomButtons(
                            leftButtonTitle: "Yes, delete.",
                            rightButtonTitle: "No, keep.",
                            onLeftButtonTap: () {
                              Navigator.pop(context);
                            },
                            onRightButtonTap: () {
                              deletePost(ownerId, postId);
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    context: context),
              );
            },
            child: Icon(
              size: AppTheme.cardPadding * 0.75.w,
              Icons.more_horiz_rounded,
            ),
          )
        ],
      ),
    );
  }
}

//To delete a Post ownerid and currentuserid must be equal
deletePost(ownerId, postId) async {
  print("Trying to burn asset: $postId");

  dynamic responseAssetBurn = await burnAsset(postId);

  print("Response from burnAsset: $responseAssetBurn");
}
