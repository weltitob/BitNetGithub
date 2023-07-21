import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/appstandards/glassmorph.dart';
import 'package:BitNet/components/container/profilepicture.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:flutter/material.dart';

class UserSearchResult extends StatefulWidget {
  final UserData userData;
  final Future<void> Function() onTap;

  const UserSearchResult(
      {Key? key, required this.userData, required this.onTap})
      : super(key: key);

  @override
  State<UserSearchResult> createState() => _UserSearchResultState();
}

class _UserSearchResultState extends State<UserSearchResult> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing),
      height: AppTheme.cardPadding * 2.75,
      child: Glassmorphism(
        blur: 75,
        opacity: 0.125,
        radius: AppTheme.cardPadding,
        child: InkWell(
          onTap: () {},
          borderRadius: AppTheme.cardRadiusBig,
          child: Row(
            children: [
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              ProfilePictureSmall(
                onTap: widget.onTap,
                profileImageURL: widget.userData.profileImageUrl,
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
      ))),
    );
  }
}
