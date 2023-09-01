import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage_view.dart';
import 'package:flutter/material.dart';

class WebsiteLandingPage extends StatefulWidget {
  const WebsiteLandingPage({super.key});

  @override
  State<WebsiteLandingPage> createState() => WebsiteLandingPageController();
}

class WebsiteLandingPageController extends State<WebsiteLandingPage> {
  @override
  Widget build(BuildContext context) {
    return WebsiteLandingPageView(controller: this,);
  }
}
