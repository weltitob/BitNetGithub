import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';

class WebsiteLandingPageView extends StatelessWidget {

  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "TESSST",
              ),
            ],
          ),
        ),
        context: context
    );
  }
}

