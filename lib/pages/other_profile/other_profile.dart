//move the controller and all the functions here
import 'package:bitnet/pages/other_profile/other_profile_view.dart';
import 'package:flutter/material.dart';

class OtherProfile extends StatelessWidget {
  const OtherProfile({Key? key, required this.profileId}) : super(key: key);
  final String profileId;
  @override
  Widget build(BuildContext context) {
    return OtherProfileView(
      profileId: profileId,
    );
  }
}
