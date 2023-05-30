import 'package:BitNet/backbone/auth/storePrivateData.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/container/profilepicture.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserResult extends StatefulWidget {
  final UserData userData;
  final Future<void> Function() onTap;
  final VoidCallback onDelete;

  UserResult({
    required this.userData,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<UserResult> createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 2.75,
      child: Glassmorphism(
        blur: 75,
        opacity: 0.125,
        radius: AppTheme.cardPadding,
        child: InkWell(
          onTap: () {},
          borderRadius: AppTheme.cardRadiusBig,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
              ),
              Row(
                children: _loading
                    ? [
                        dotProgress(context),
                        SizedBox(
                          width: AppTheme.cardPadding,
                        )
                      ]
                    : [
                        InkWell(
                          onTap: () {
                            showDialogue(
                              context: context,
                              title: 'Delte saved account from device?',
                              image: 'assets/images/trash.png',
                              leftAction: () {},
                              rightAction: () {
                                widget.onDelete();
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
                                color: AppTheme.white70,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.elementSpacing),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _loading = true;
                              });
                              try {
                                await widget.onTap();
                              } catch(e) {
                                print(e);
                              } finally {
                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
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
                                  color: AppTheme.white70,
                                ),
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
