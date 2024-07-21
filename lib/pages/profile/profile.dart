//move the controller and all the functions here
import 'package:bitnet/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  //String profileId = Auth().currentUser!.uid;
  //String? get profileId => VRouter.of(context).pathParameters['profileId'];

  @override
  Widget build(BuildContext context) {
    return ProfileView();
  }
}
