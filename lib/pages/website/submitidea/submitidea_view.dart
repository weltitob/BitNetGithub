import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/pages/website/submitidea/submitidea.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';

class SubmitIdeaView extends StatelessWidget {
  final SubmitIdeaController controller;

  const SubmitIdeaView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetWebsiteAppBar(),
        body: Container(),
        context: context);
  }
}
