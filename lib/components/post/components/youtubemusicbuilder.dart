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
    print("spotifyUrl should be displayed here: $youtubeUrl");

    return Container(
        height: AppTheme.cardPadding * 2,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.youtube)),
            Text("$youtubeUrl", overflow: TextOverflow.ellipsis,),
          ],
        ));
  }
}

