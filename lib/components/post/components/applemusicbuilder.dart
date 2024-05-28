import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppleMusicBuilder extends StatelessWidget {
  final String applemusicUrl;
  const AppleMusicBuilder({
    Key? key,
    required this.applemusicUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppTheme.cardPadding * 2,
        child: Row(
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(FontAwesomeIcons.apple)),
            Container(
              width: AppTheme.cardPadding * 12,
              child: Text(
                "$applemusicUrl",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
