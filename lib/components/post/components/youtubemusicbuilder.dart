import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YoutubeMusicBuilder extends StatelessWidget {
  final String youtubeUrl;
  const YoutubeMusicBuilder({
    Key? key,
    required this.youtubeUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppTheme.cardPadding * 1.5,
        child: Row(
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.youtube)),
            Container(
                width: AppTheme.cardPadding * 12,
                child: Text(
                  "$youtubeUrl",
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ));
  }
}
