import 'package:BitNet/pages/profile.dart';
import 'package:flutter/material.dart';


showProfile(BuildContext context, {required String profileId}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
            profileId: profileId,
          )));
}