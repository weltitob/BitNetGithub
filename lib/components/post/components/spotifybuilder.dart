import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpotifyBuilder extends StatelessWidget {
  final String spotifyUrl;
  const SpotifyBuilder({
    Key? key,
    required this.spotifyUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppTheme.cardPadding * 2,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.spotify)),
            Container(
              width: AppTheme.cardPadding * 12,
              child: Text(
                "$spotifyUrl", overflow: TextOverflow.ellipsis,),
            ),
          ],
        ));
  }
}

