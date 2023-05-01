import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/container/profilepicture.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserResult extends StatelessWidget {
  final UserData userData;
  final VoidCallback onTap;

  UserResult({
    required this.userData,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppTheme.cardRadiusBig,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing / 2),
        height: AppTheme.cardPadding * 2.75,
        child: Glassmorphism(
          blur: 75,
          opacity: 0.125,
          radius: AppTheme.cardPadding,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppTheme.cardRadiusBig,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: AppTheme.elementSpacing,),
                    ProfilePictureSmall(
                      onTap: onTap,
                      profileImageURL: userData.profileImageUrl,
                      profileId: userData.did,
                    ),
                    SizedBox(width: AppTheme.elementSpacing),
                    Container(
                      width: AppTheme.cardPadding * 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${userData.username}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            userData.did,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                  child: Container(
                    height: AppTheme.cardPadding * 1.5,
                    width: AppTheme.cardPadding * 1.5,
                    child: Glassmorphism(
                      blur: 75,
                      opacity: 0.125,
                      radius: AppTheme.cardPadding * 10,
                      child: Icon(
                        FontAwesomeIcons.arrowRight,
                      color: AppTheme.white70,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
