import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/widgets/webavatar.dart';
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
    final borderRadius = BorderRadius.circular(height / 2.5);

    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing),

      height: height,
      width:
          width, // If customWidth is null, Container will take up available width

      child: GlassContainer(
          borderThickness: 1.5,
          blur: 50,
          opacity: 0.1,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: AppTheme.cardRadiusBig,
            child: Row(
              children: [
                SizedBox(
                  width: AppTheme.elementSpacing * 0.75,
                ),
                WebAvatar(
                  size: AppTheme.cardPadding * 2 * widget.scaleRatio,
                  onTap: widget.onTap,
                  mxContent: widget.userData.profileImageUrl,
                  name: widget.userData.username,
                  profileId: widget.userData.did,
                ),
                SizedBox(width: AppTheme.elementSpacing),
                Container(
                  width: AppTheme.cardPadding * 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "@${widget.userData.username}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: AppTheme.elementSpacing / 4),
                      Text(
                        widget.userData.did,
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
