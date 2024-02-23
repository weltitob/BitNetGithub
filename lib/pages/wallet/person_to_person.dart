import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';

class PersonToPersonWidget extends StatelessWidget {
  const PersonToPersonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Avatar(size: 20,),
        Icon(
          Icons.arrow_right,
          size: 20,
        ),
        Text('300USD'),
        Icon(
          Icons.arrow_right,
          size: 20,
        ),
        Avatar(size: 20,),
      ],
    );
  }
}
