import 'dart:ui';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final VoidCallback onPostButtonPressed;
  const CameraPage({Key? key, required this.onPostButtonPressed}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();

}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return getFooter();
  }

  Widget getFooter() {
    final currentUser = Auth().currentUser!.uid;

    return Padding(
      padding: const EdgeInsets.only(
          left: AppTheme.cardPadding,
          bottom: 40,
          right: AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Avatar(
                    profileId: currentUser,
                    size: AppTheme.cardPadding * 2,
                    fontSize: 18,
                    onTap: () => print('tapped'),
                  ),
                  title: Text(
                    '@fixauth',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppTheme.white90
                    ),
                  ),
                  subtitle: Text(
                    'fix die scheiss auth',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.white70
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //can here remix post from other plattform
                    RoundedButtonWidget(iconData: Icons.link,
                        onTap: null,),
                    SizedBox(
                      width: AppTheme.elementSpacing,
                    ),
                    ClipRRect(
                      borderRadius: AppTheme.cardRadiusSmall,
                      child: BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: AppTheme.cardRadiusSmall,
                              color: AppTheme.glassMorphColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.refresh,
                                  color: AppTheme.white90,
                                ),
                                SizedBox(
                                  height: AppTheme.cardPadding * 0.75,
                                ),
                                Icon(
                                  Icons.flash_auto,
                                  color: AppTheme.white90,
                                ),
                                SizedBox(
                                  height: AppTheme.cardPadding * 0.75,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: AppTheme.white90,
                                ),
                                SizedBox(
                                  height: AppTheme.cardPadding * 0.75,
                                ),
                                Icon(
                                  Icons.timer,
                                  color: AppTheme.white90,
                                ),
                                SizedBox(
                                  height: AppTheme.cardPadding * 0.75,
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: AppTheme.white90,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButtonWidget(
                iconData: Icons.post_add,
                onTap: () =>
                  setState(() {
                    widget.onPostButtonPressed();
                  }),
                buttonType: ButtonType.transparent,
              ),
              SizedBox(
                width: AppTheme.cardPadding,
              ),
              Container(
                width: AppTheme.cardPadding * 3.5,
                height: AppTheme.cardPadding * 3.5,
                decoration: BoxDecoration(
                    borderRadius: AppTheme.cardRadiusBigger,
                    border: Border.all(width: 5, color: AppTheme.white90)),
              ),
              SizedBox(
                width: AppTheme.cardPadding,
              ),
              RoundedButtonWidget(
                  iconData: Icons.qr_code_rounded,
                onTap: () =>
                  setState(() {
                    widget.onPostButtonPressed();
                  }),
                  buttonType: ButtonType.transparent,
              ),
            ],
          )
        ],
      ),
    );
  }
}