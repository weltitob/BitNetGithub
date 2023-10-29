import 'package:bitnet/pages/website/submitidea/submitidea_view.dart';
import 'package:flutter/material.dart';

class SubmitIdea extends StatefulWidget {
  const SubmitIdea({super.key});

  @override
  State<SubmitIdea> createState() => SubmitIdeaController();
}

class SubmitIdeaController extends State<SubmitIdea> {
  @override
  Widget build(BuildContext context) {
    return SubmitIdeaView(controller: this);
  }
}
