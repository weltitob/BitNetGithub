import 'package:BitNet/backbone/auth/storeIONdata.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/container/profilepicture.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserResult extends StatelessWidget {
  final UserData userData;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  UserResult({
    required this.userData,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 2.75,
      child: Glassmorphism(
        blur: 75,
        opacity: 0.125,
        radius: AppTheme.cardPadding,
        child: InkWell(
          onTap: (){},
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
                    width: AppTheme.cardPadding * 5,
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
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      showDialogue(context: context,
                        title: 'Delte saved account from device?',
                        image: 'assets/images/trash.png',
                        leftAction: (){},
                        rightAction: (){
                          onDelete();
                        },
                      );
                    },
                    child: Container(
                      height: AppTheme.cardPadding * 1.5,
                      width: AppTheme.cardPadding * 1.5,
                      child: Glassmorphism(
                        blur: 75,
                        opacity: 0.125,
                        radius: AppTheme.cardPadding * 10,
                        child: Icon(
                          FontAwesomeIcons.remove,
                        size: AppTheme.elementSpacing * 1.5,
                        color: AppTheme.white70,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        height: AppTheme.cardPadding * 1.5,
                        width: AppTheme.cardPadding * 1.5,
                        child: Glassmorphism(
                          blur: 75,
                          opacity: 0.125,
                          radius: AppTheme.cardPadding * 10,
                          child: Icon(
                            FontAwesomeIcons.key,
                            size: AppTheme.elementSpacing * 1.5,
                            color: AppTheme.white70,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
