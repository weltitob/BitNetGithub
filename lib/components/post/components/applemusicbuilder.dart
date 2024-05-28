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
    print("applemusicUrl should be displayed here: $applemusicUrl");

    return Container(
        height: AppTheme.cardPadding * 2,
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.apple)),
            Text("$applemusicUrl", overflow: TextOverflow.ellipsis,),
          ],
        ));
  }
}

