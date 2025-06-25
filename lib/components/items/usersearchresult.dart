import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:flutter/material.dart';

class UserSearchResult extends StatefulWidget {
  final UserData userData;
  final Future<void>? Function()? onTap;
  final double customHeight;
  final double customWidth;
  final double scaleRatio;

  const UserSearchResult({
    Key? key,
    required this.userData,
    required this.onTap,
    this.customHeight = AppTheme.cardPadding * 2.75,
    this.customWidth = AppTheme.cardPadding * 10,
    this.scaleRatio = 1,
  }) : super(key: key);

  @override
  State<UserSearchResult> createState() => _UserSearchResultState();
}

class _UserSearchResultState extends State<UserSearchResult> {
  @override
  Widget build(BuildContext context) {
    final height = widget.customHeight * widget.scaleRatio;
    final width = widget.customWidth * widget.scaleRatio;
    final borderRadius = BorderRadius.circular(height / 3);

    return Container(
      margin: const EdgeInsets.only(top: AppTheme.elementSpacing),

      height: height,
      width:
          width, // If customWidth is null, Container will take up available width

      child: GlassContainer(
          borderRadius: borderRadius,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusBig),
            child: Row(
              children: [
                const SizedBox(
                  width: AppTheme.elementSpacing * 0.75,
                ),
                Avatar(
                  size: AppTheme.cardPadding * 2 * widget.scaleRatio,
                  onTap: widget.onTap,
                  mxContent: widget.userData.profileImageUrl,
                  name: widget.userData.username,
                  profileId: widget.userData.did,
                  isNft: false,
                ),
                const SizedBox(width: AppTheme.elementSpacing),
                Container(
                  width: AppTheme.cardPadding * 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "@${widget.userData.username}",
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTheme.elementSpacing / 4),
                      Text(
                        widget.userData.displayName,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
