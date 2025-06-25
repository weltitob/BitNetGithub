import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeezerBuilder extends StatelessWidget {
  final String deezerUrl;
  const DeezerBuilder({
    Key? key,
    required this.deezerUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppTheme.cardPadding * 1.5,
        child: Row(
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.deezer)),
            Container(
                width: AppTheme.cardPadding * 12,
                child: Text(
                  "$deezerUrl",
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ));
  }
}
