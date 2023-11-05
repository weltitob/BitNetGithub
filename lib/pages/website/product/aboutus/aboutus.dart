import 'package:bitnet/pages/website/product/aboutus/aboutus_view.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => AboutUsController();
}

class AboutUsController extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return AboutUsView(controller: this,);
  }
}
